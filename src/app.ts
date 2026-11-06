// src/app.ts
import { BrowserService } from "./services/browser.service.js";
import { TiktokParser } from "./parsers/tiktok.parser.js";
import { CrawlerWorker } from "./workers/crawler.worker.js";

const App = async (): Promise<void> => {
  console.log("Initializing Crawler Service...");

  const redisConfig = {
    host: process.env.REDIS_HOST || "localhost",
    port: Number(process.env.REDIS_PORT) || 6379,
    maxRetriesPerRequest: null,
  };

  // 1. Initialize Browser singleton
  const browserService = new BrowserService();
  await browserService.init();

  // 2. Register parser strategies (add more platforms here easily)
  const parsers = [new TiktokParser()];

  // 3. Initialize and start worker
  const crawlerWorker = new CrawlerWorker(
    "crawl-queue",
    redisConfig,
    browserService,
    parsers,
  );
  crawlerWorker.start();

  console.log("Crawler Worker is active and listening for jobs.");

  // Graceful shutdown
  const handleShutdown = async () => {
    console.log("\nGracefully stopping worker...");
    await crawlerWorker.stop();
    await browserService.close();
    process.exit(0);
  };

  process.on("SIGINT", handleShutdown);
  process.on("SIGTERM", handleShutdown);
};

export default App;
