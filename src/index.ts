import { PlaywrightBrowserService } from "./services/browser.service.js";
import { CrawlerService } from "./services/crawler.service.js";
import { AntaraHealthScraper } from "./scrapers/antara.scraper.js";
import { antaraConfig } from "./config/env.js";

const browserService = new PlaywrightBrowserService();
const crawler = new CrawlerService(browserService);

async function main(): Promise<void> {
  try {
    await browserService.init();

    const antaraScraper = new AntaraHealthScraper(antaraConfig);

    const articles = await crawler.run(antaraScraper, 3);

    console.log("\n--- Extraction Complete ---");
    console.log(`Successfully extracted ${articles.length} articles:\n`);
    console.dir(articles, { depth: null });
  } catch (error) {
    console.error(`Fatal error while trying to extract ${error}`);
  } finally {
    await browserService.close();
  }
}

main();
