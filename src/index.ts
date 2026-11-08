import "dotenv/config";
import { PlaywrightBrowserService } from "./services/browser.service.js";
import { GoogleNewsIngestor } from "./ingestors/google-news.ingestor.js";
import { ProMedIngestor } from "./ingestors/promed.ingestor.js";
import type { SignalIngestor, NormalizedSignal } from "./types/ingestor.js";

async function bootstrap() {
  const browserService = new PlaywrightBrowserService();
  const allCapturedSignals: NormalizedSignal[] = [];

  try {
    // 1. Initialize the shared Playwright context
    await browserService.init();

    // 2. Register all active signal ingestors
    const ingestors: SignalIngestor[] = [
      new GoogleNewsIngestor(),
      new ProMedIngestor(browserService),
    ];

    console.log(
      `Starting multi-source ingestion (${ingestors.length} sources registered)...\n`,
    );

    // 3. Harvest signals sequentially
    for (const ingestor of ingestors) {
      try {
        console.log(`--- Running ${ingestor.name} ---`);
        const signals = await ingestor.collect();
        allCapturedSignals.push(...signals);
        console.log(
          `✓ [${ingestor.name}] Collected ${signals.length} valid signals.\n`,
        );
      } catch (ingestorError) {
        console.error(
          `✗ [${ingestor.name}] Failed during collection:`,
          ingestorError,
        );
      }
    }

    // 4. Summary output
    console.log("====================================");
    console.log(
      `Total Outbreak Signals Captured: ${allCapturedSignals.length}`,
    );
    console.log("====================================\n");

    // Display a quick preview of captured events
    allCapturedSignals.slice(0, 5).forEach((item, idx) => {
      console.log(
        `[${idx + 1}] ${item.pathogen.name} (${item.pathogen.family})`,
      );
      console.log(`    Source   : ${item.source}`);
      console.log(
        `    Location : ${item.provinceName} ${item.regencyCity ? `(${item.regencyCity})` : ""} [${item.provinceCode}]`,
      );
      console.log(`    Severity : ${item.severity} | KLB: ${item.isKlb}`);
      console.log(
        `    Symptoms : ${item.symptoms.length ? item.symptoms.join(", ") : "None extracted"}`,
      );
      console.log(`    Headline : ${item.headline}`);
      console.log(`    URL      : ${item.sourceUrl}\n`);
    });
  } catch (fatalError) {
    console.error("Fatal pipeline execution error:", fatalError);
  } finally {
    // 5. Always cleanly shut down browser instances
    await browserService.close();
    console.log("Browser service closed. Pipeline idle.");
  }
}

bootstrap();
