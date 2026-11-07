import type { Page } from "playwright";

export interface RawArticle {
  title: string;
  url: string;
  publishedAt: string;
  source: string;
}

export interface ArticleContent extends RawArticle {
  author?: string;
  location?: string;
  content?: string;
  crawledAt?: string;
}

export interface SiteScrapper {
  readonly sourceName: string;
  readonly listingUrl: string;

  discovery(page: Page): Promise<RawArticle[]>;
  extract(page: Page, article: RawArticle): Promise<ArticleContent>;
}
