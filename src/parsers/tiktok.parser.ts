import { Page } from "playwright";
import { IContentParser } from "../interfaces/crawler.interface.js";

export interface TiktokData {
  title: string;
  author: string;
  description: string;
}

export class TiktokParser implements IContentParser<TiktokData> {
  readonly platform = "tiktok";

  canParse(url: string): boolean {
    return url.includes("tiktok.com");
  }

  async parse(page: Page): Promise<TiktokData> {
    await page.waitForLoadState("domcontentloaded");

    const title = (await page.title()) || "";

    const author = await page
      .locator("h1[data-e2e='user-title'], [data-e2e='browse-username']")
      .first()
      .textContent()
      .catch(() => "Unknown");
    const description = await page
      .locator("[data-e2e='browse-video-desc']")
      .first()
      .textContent()
      .catch(() => "");

    return {
      title: title.trim(),
      author: author ? author.trim() : "Unknown",
      description: description ? description.trim() : "",
    };
  }
}
