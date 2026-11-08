import { XMLParser } from "fast-xml-parser";
import type { SignalIngestor, NormalizedSignal } from "../types/ingestor.js";
import { ExtractorService } from "../services/extractor.service.js";
import { PATHOGEN_LOOKUPS } from "../config/lookups.js";

export class GoogleNewsIngestor implements SignalIngestor {
  readonly name = "Google News RSS";
  private readonly parser = new XMLParser({ ignoreAttributes: false });

  // Dynamically assemble the query from your pathogen keywords
  private buildQuery(): string {
    // 1. Flatten all keywords from all pathogens
    // e.g. ['dbd', 'dengue', 'flu burung', 'polio', 'rabies', 'mpox']
    const virusTerms = PATHOGEN_LOOKUPS.flatMap((p) =>
      p.keywords.map((kw) => (kw.includes(" ") ? `"${kw}"` : kw)),
    ).join(" OR ");

    // 2. Combine with alert context terms and a 7-day rolling window
    // e.g. "(kasus OR wabah OR dinkes) AND (dbd OR dengue OR "flu burung" ...) when:7d"
    return `(kasus OR wabah OR KLB OR dinkes) AND (${virusTerms}) when:7d`;
  }

  async collect(): Promise<NormalizedSignal[]> {
    const rawQuery = this.buildQuery();
    console.log(`[${this.name}] Dynamically generated query: ${rawQuery}`);

    const encodedQuery = encodeURIComponent(rawQuery);
    const feedUrl = `https://news.google.com/rss/search?q=${encodedQuery}&hl=id&gl=ID&ceid=ID:id`;

    const res = await fetch(feedUrl);
    if (!res.ok) {
      throw new Error(`Failed to fetch RSS: ${res.statusText}`);
    }

    const xml = await res.text();
    const parsed = this.parser.parse(xml);
    const rawItems = parsed.rss?.channel?.item || [];

    const items = Array.isArray(rawItems) ? rawItems : [rawItems];
    const results: NormalizedSignal[] = [];

    for (const item of items) {
      const signal = ExtractorService.resolve(
        item.title || "",
        item.description || "",
        item.link || "",
        item.pubDate || new Date().toISOString(),
        "GOOGLE_NEWS",
      );

      if (signal) {
        results.push(signal);
      }
    }

    return results;
  }
}
