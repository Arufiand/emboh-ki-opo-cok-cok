import { NormalizedSignal, SignalIngestor } from "../types/ingestor.js";
import { XMLParser } from "fast-xml-parser";
import { ExtractorService } from "../services/extractor.service.js";

export class GoogleNewsIngestor implements SignalIngestor {
  readonly name: string = "Google News RSS";
  private readonly parser = new XMLParser({ ignoreAttributes: false });

  async collect(): Promise<NormalizedSignal[]> {
    console.log(`[${this.name}] Fetching regional feeds...`);

    const query = encodeURIComponent(
      'kasus OR wabah dbd OR "flu burung" OR polio OR rabies OR mpox when:7d',
    );

    const feedUrl = `https://news.google.com/rss/search?q=${query}&hl=id&gl=ID&ceid=ID:id`;

    const res = await fetch(feedUrl);
    if (!res.ok) {
      throw new Error(`Failed to fetch rss feeds for ${query}`);
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
