// src/workers/crawler.worker.ts
import { Worker, Job } from "bullmq";
import { BrowserService } from "../services/browser.service.js";
import {
  CrawlTarget,
  CrawlResult,
  IContentParser,
} from "../interfaces/crawler.interface.js";
import { ConnectionOptions } from "bullmq";

export class CrawlerWorker {
  private worker: Worker | null = null;

  constructor(
    private readonly queueName: string,
    private readonly redisConfig: ConnectionOptions,
    private readonly browserService: BrowserService,
    private readonly parsers: IContentParser<unknown>[],
  ) {}

  start(): void {
    this.worker = new Worker<CrawlTarget, CrawlResult>(
      this.queueName,
      async (job: Job<CrawlTarget>) => {
        const { url } = job.data;
        console.log(`[Job ${job.id}] Executing crawl for: ${url}`);

        // Find the matching parser strategy (Open/Closed principle)
        const parser = this.parsers.find((p) => p.canParse(url));
        if (!parser) {
          throw new Error(`No compatible parser registered for URL: ${url}`);
        }

        const context = await this.browserService.createContext();
        const page = await context.newPage();

        try {
          await page.goto(url, {
            waitUntil: "domcontentloaded",
            timeout: 45000,
          });
          const extractedData = await parser.parse(page);

          const result: CrawlResult = {
            targetUrl: url,
            platform: parser.platform,
            extractedAt: new Date().toISOString(),
            data: extractedData,
          };

          // TODO: Forward to your Python/Rust pipeline or DB repository here
          console.log(
            `[Job ${job.id}] Successfully processed by ${parser.platform} parser.`,
          );
          return result;
        } finally {
          await context.close(); // Clean memory per job
        }
      },
      {
        connection: this.redisConfig,
        concurrency: 3, // Control active Chromium pages
      },
    );

    this.worker.on("failed", (job, err) => {
      console.error(`[Job ${job?.id}] Failed with error:`, err.message);
    });
  }

  async stop(): Promise<void> {
    if (this.worker) {
      await this.worker.close();
      this.worker = null;
    }
  }
}
