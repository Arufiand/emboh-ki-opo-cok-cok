import { PlaywrightBrowserService } from "./services/browser.service.js";
import { GoogleNewsIngestor } from "./ingestors/google-news.ingestor.js";
import { ProMedIngestor } from "./ingestors/promed.ingestor.js";
import { NewsDataIngestor } from "./ingestors/newsdata.ingestor.js";
import type { SignalIngestor, NormalizedSignal } from "./types/ingestor.js";
import { DeduplicationService } from "./services/dedup.service.js";
import { persistQueue } from "./infra/queues.js";

async function bootstrap() {
  const browserService = new PlaywrightBrowserService();
  const deduplicationService = new DeduplicationService();

  await browserService.init();
  await deduplicationService.connect();

  const ingestors: SignalIngestor[] = [
    new GoogleNewsIngestor(),
    new ProMedIngestor(browserService),
    new NewsDataIngestor(),
  ];

  console.log(
    `Starting multi-source ingestion (${ingestors.length} sources registered)...\n`,
  );
  const aggregatedSignals: NormalizedSignal[] = [];

  try {
    for (const ingestor of ingestors) {
      try {
        console.log(`--- Running ${ingestor.name} ---`);
        const signals = await ingestor.collect();
        aggregatedSignals.push(...signals);
        console.log(
          `✓ [${ingestor.name}] Harvested ${signals.length} valid signals.\n`,
        );
      } catch (err) {
        console.error(`✗ [${ingestor.name}] Error during collection:`, err);
      }
    }

    console.log("====================================");
    console.log(
      `Total Outbreak Signals Harvested: ${aggregatedSignals.length}`,
    );
    console.log("====================================\n");

    const bySource = aggregatedSignals.reduce(
      (acc, s) => {
        acc[s.source] = (acc[s.source] || 0) + 1;
        return acc;
      },
      {} as Record<string, number>,
    );

    console.log("Breakdown by Source:", bySource);

    const { newSignals, duplicateCount } =
      await deduplicationService.filterNewSignals(aggregatedSignals);

    console.log(`====================================`);
    console.log(`New Unseen Signals : ${newSignals.length}`);
    console.log(`Duplicates Dropped : ${duplicateCount}`);
    console.log(`====================================\n`);

    if (newSignals.length > 0) {
      await persistQueue.addBulk(
        newSignals.map((signal) => ({
          name: "upsert-signal",
          data: signal,
          opts: { jobId: signal.id }, // Prevents duplicate jobs in BullMQ
        })),
      );
      console.log(`Enqueued ${newSignals.length} signals to persist-queue.`);
    } else {
      console.log(`No new events to enqueue.`);
    }
  } finally {
    await browserService.close();
    await deduplicationService.disconnect();
    await persistQueue.close();
    console.log("Browser, Redis, and Queue connections closed.");
  }
}

bootstrap();
