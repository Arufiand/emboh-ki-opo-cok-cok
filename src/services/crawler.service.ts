import { IBrowserService } from "./browser.service.js";
import { ArticleContent, SiteScrapper } from "../types.js";

export class CrawlerService {
  constructor(private readonly browserService: IBrowserService) {}

  async run(scraper: SiteScrapper, limit = 5): Promise<ArticleContent[]> {
    console.log(`[Crawler] Running article ${scraper.sourceName}]`);

    const discoveryPage = await this.browserService.newPage();
    let discoveredArticles;
    try {
      discoveredArticles = await scraper.discovery(discoveryPage);
    } finally {
      await discoveryPage.close();
    }

    const targetArticles = discoveredArticles.slice(0, limit);
    const results: ArticleContent[] = [];

    for (const rawArticle of targetArticles) {
      const detailPage = await this.browserService.newPage();
      try {
        const fullArticle = await scraper.extract(detailPage, rawArticle);
        results.push(fullArticle);
      } catch (e) {
        console.error(`[Crawler] Failed to extract article: ${e}`);
      } finally {
        await discoveryPage.close();
      }
    }
    return results;
  }
}
