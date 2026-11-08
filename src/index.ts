import { GoogleNewsIngestor } from "./ingestors/google-news.ingestor.js";

async function bootstrap() {
  try {
    const ingestor = new GoogleNewsIngestor();
    const signals = await ingestor.collect();

    console.log(`\n=== Ingestion Complete ===`);
    console.log(
      `Captured ${signals.length} verified Indonesian outbreak signals:\n`,
    );

    signals.slice(0, 5).forEach((item, index) => {
      console.log(
        `[${index + 1}] ${item.pathogen.name} (${item.pathogen.family})`,
      );
      console.log(
        `    Location : ${item.provinceName} ${item.regencyCity ? `(${item.regencyCity})` : ""} [${item.provinceCode}]`,
      );
      console.log(`    Severity : ${item.severity} | KLB: ${item.isKlb}`);
      console.log(
        `    Symptoms : ${item.symptoms.length ? item.symptoms.join(", ") : "None extracted"}`,
      );
      console.log(`    Headline : ${item.headline}`);
      console.log(`    Source   : ${item.sourceUrl}\n`);
    });
  } catch (error) {
    console.log(`Bootstrap Error: ${error}`);
  }
}

bootstrap();
