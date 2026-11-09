import { PlaywrightBrowserService } from "./services/browser.service.js";
import { GoogleNewsIngestor } from "./ingestors/google-news.ingestor.js";
import { ProMedIngestor } from "./ingestors/promed.ingestor.js";
import { NewsDataIngestor } from "./ingestors/newsdata.ingestor.js";
import type { SignalIngestor, NormalizedSignal } from "./types/ingestor.js";

async function bootstrap() {
  const browserService = new PlaywrightBrowserService();
  await browserService.init();

  // Register all 3 gatherers
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

    // Grouping by source for quick verification
    const bySource = aggregatedSignals.reduce(
      (acc, s) => {
        acc[s.source] = (acc[s.source] || 0) + 1;
        return acc;
      },
      {} as Record<string, number>,
    );

    console.log("Breakdown by Source:", bySource);
  } finally {
    await browserService.close();
    console.log("Browser service closed. Data gathering complete.");
  }
}

bootstrap();
