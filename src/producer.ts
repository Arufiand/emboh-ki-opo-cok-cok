// src/producer.ts
import { Queue } from "bullmq";
import { CrawlTarget } from "./interfaces/crawler.interface.js";

const redisConfig = {
  host: process.env.REDIS_HOST || "localhost",
  port: Number(process.env.REDIS_PORT) || 6379,
  maxRetriesPerRequest: null,
};

// Queue name must match the one passed to CrawlerWorker in app.ts ("crawl-queue")
const queue = new Queue<CrawlTarget>("crawl-queue", {
  connection: redisConfig,
});

async function dispatchJobs() {
  console.log("Enqueuing test crawl jobs...");

  const targets: CrawlTarget[] = [
    {
      url: "https://www.tiktok.com/@tiktok/video/7106594312292453678",
      platform: "tiktok",
      metadata: { priority: "high", category: "trending" },
    },
  ];

  for (const target of targets) {
    const job = await queue.add("scrape-task", target, {
      attempts: 3,
      backoff: {
        type: "exponential",
        delay: 3000, // Retry after 3s, 6s, 12s on error
      },
      removeOnComplete: true,
      removeOnFail: 50,
    });

    console.log(`Dispatched Job ID: ${job.id} for ${target.url}`);
  }

  await queue.close();
  console.log("All jobs dispatched successfully.");
}

dispatchJobs().catch((err) => {
  console.error("Failed to dispatch jobs:", err);
  process.exit(1);
});
