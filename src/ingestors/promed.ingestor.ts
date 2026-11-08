import type { Page } from "playwright";
import type { SignalIngestor, NormalizedSignal } from "../types/ingestor.js";
import type { IBrowserService } from "../services/browser.service.js";
import { ExtractorService } from "../services/extractor.service.js";
import { promedConfig } from "../config/env.js";
import { PROMED_DEV_FIXTURES } from "../fixtures/promed.fixture.js";

export class ProMedIngestor implements SignalIngestor {
  // Public property satisfying the SignalIngestor interface contract
  readonly name: string;
  private readonly listingUrl: string;

  constructor(
    private readonly browserService: IBrowserService,
    config = promedConfig,
  ) {
    this.name = config.sourceName;
    this.listingUrl = config.listingUrl;
  }

  async collect(): Promise<NormalizedSignal[]> {
    console.log(`[${this.name}] Inspecting surveillance feed...`);
    const page: Page = await this.browserService.newPage();
    const signals: NormalizedSignal[] = [];

    if (process.env.USE_MOCK_PROMED === "true") {
      console.log(
        `[${this.name}] 🟡 Using local offline fixtures (skipping live browser hit).`,
      );
      return PROMED_DEV_FIXTURES;
    }
    console.log(`[${this.name}] 🔴 Launching live browser...`);
    try {
      // ✅ Corrected: closing parenthesis wraps both the URL and options object
      await page.goto(this.listingUrl, {
        waitUntil: "domcontentloaded",
        timeout: 45000,
      });

      await page.waitForTimeout(3000);

      const rawPosts = await page.$$eval("a, div", (elements) => {
        return elements
          .map((el) => {
            const text = el.textContent?.trim() || "";
            const link = (el as HTMLAnchorElement).href || "";
            return { text, link };
          })
          .filter(
            (item) => /INDONESIA/i.test(item.text) && item.text.length > 25,
          );
      });

      console.log(
        `[${this.name}] Matched ${rawPosts.length} posts mentioning Indonesia.`,
      );

      for (const post of rawPosts) {
        const resolved = ExtractorService.resolve(
          post.text,
          post.text,
          post.link || this.listingUrl,
          new Date().toISOString(),
          "PROMED",
        );

        if (resolved) {
          signals.push(resolved);
        }
      }
    } catch (error) {
      console.error(`[${this.name}] Extraction error:`, error);
    } finally {
      await page.close();
    }

    return signals;
  }
}
