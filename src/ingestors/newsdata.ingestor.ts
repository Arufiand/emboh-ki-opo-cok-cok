import type { SignalIngestor, NormalizedSignal } from "../types/ingestor.js";
import { ExtractorService } from "../services/extractor.service.js";
import { PATHOGEN_LOOKUPS } from "../config/lookups.js";
import { newsDataConfig } from "../config/env.js";

interface NewsDataArticle {
  article_id: string;
  title: string;
  link: string;
  description?: string;
  pubDate: string;
  country: string[];
}

interface NewsDataResponse {
  status: string;
  totalResults: number;
  results?: NewsDataArticle[];
}

export class NewsDataIngestor implements SignalIngestor {
  readonly name = "NewsData.io";
  private readonly apiKey: string;
  private readonly listingUrl: string;

  constructor(config = newsDataConfig) {
    this.apiKey = config.apiKey;
    this.listingUrl = config.listingUrl;
  }

  private buildQuery(): string {
    // Generate simple search keywords suitable for NewsData API
    const primaryKeywords = PATHOGEN_LOOKUPS.flatMap((p) =>
      p.keywords.slice(0, 2),
    );
    return `wabah OR kasus OR ${primaryKeywords.slice(0, 5).join(" OR ")}`;
  }

  async collect(): Promise<NormalizedSignal[]> {
    // 1. Guard against empty keys during initial testing
    if (!this.apiKey) {
      console.log(
        `[${this.name}] ⚠️ No API key set in .env. Skipping remote request.`,
      );
      return [];
    }

    console.log(`[${this.name}] Querying Indonesian health syndication API...`);

    const query = encodeURIComponent(this.buildQuery());
    // Query parameters: Indonesia (id), Category Health, Indonesian language (in)
    const url = `${this.listingUrl}?apikey=${this.apiKey}&country=id&category=health&q=${query}`;

    const res = await fetch(url);
    if (!res.ok) {
      console.error(
        `[${this.name}] HTTP Error ${res.status}: ${res.statusText}`,
      );
      return [];
    }

    const data: NewsDataResponse = await res.json();
    const articles = data.results || [];
    console.log(
      `[${this.name}] Received ${articles.length} syndicated news items.`,
    );

    const signals: NormalizedSignal[] = [];

    for (const article of articles) {
      const signal = ExtractorService.resolve(
        article.title || "",
        article.description || "",
        article.link || "",
        article.pubDate || new Date().toISOString(),
        "NEWSDATA",
      );

      if (signal) {
        signals.push(signal);
      }
    }

    return signals;
  }
}
