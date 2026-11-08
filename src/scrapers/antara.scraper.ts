import { ArticleContent, RawArticle, SiteScrapper } from "../types.js";
import { ScraperConfig } from "../config/env.js";
import { Page } from "playwright";

export class AntaraHealthScraper implements SiteScrapper {
  readonly sourceName: string;
  readonly listingUrl: string;

  constructor(config: ScraperConfig) {
    this.sourceName = config.sourceName;
    this.listingUrl = config.listingUrl;
  }

  async discovery(page: Page): Promise<RawArticle[]> {
    await page.goto(this.listingUrl, { waitUntil: "domcontentloaded" });

    return page.$$eval(
      "" + "article.simple-post, .latest-news .post-item",
      (items) => {
        return items
          .map((item) => {
            const anchor =
              item.querySelector<HTMLAnchorElement>(".post-date, time");
            const time = item.querySelector<HTMLTimeElement>(".post-date");
            if (!anchor?.href) return null;

            return {
              title: anchor.textContent?.trim() || "",
              url: anchor.href,
              publishedAt: time?.textContent?.trim() || "",
            };
          })
          .filter((article): article is RawArticle =>
            Boolean(article && article.title),
          );
      },
      this.sourceName,
    );
  }

  async extract(page: Page, article: RawArticle): Promise<ArticleContent> {
    await page.goto(article.url, { waitUntil: "domcontentloaded" });

    const headline = await page
      .$eval("h1.post-title, h1", (el) => el.textContent?.trim() || "")
      .catch(() => "Unknown");

    const author = await page
      .$eval(".post-author, .author-name", (el) => el.textContent?.trim() || "")
      .catch(() => "Unknown");

    const body = await page
      .$$eval(".post-content p, article p", (paragraphs) =>
        paragraphs
          .map((p) => p.textContent?.trim() || "")
          .filter((text) => text.length > 0)
          .join("\n\n"),
      )
      .catch(() => "");

    return {
      ...article,
      title: headline || article.title,
      author,
      body,
      crawledAt: new Date().toISOString(),
    };
  }
}
