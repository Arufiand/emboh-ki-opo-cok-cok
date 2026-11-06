import { Page } from "playwright";

export interface CrawlTarget {
  url: string;
  platform: string;
  metadata?: Record<string, unknown>;
}

export interface CrawlResult<T = unknown> {
  targetUrl: string;
  platform: string;
  extractedAt: string;
  data: T;
}

export interface IContentParser<T> {
  platform: string;
  canParse(url: string): boolean;
  parse(page: Page): Promise<T>;
}
