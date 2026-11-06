import { Browser, type BrowserContext, chromium } from "playwright";

export class BrowserService {
  private browser: Browser | null = null;

  async init(): Promise<void> {
    if (!this.browser) {
      this.browser = await chromium.launch({
        headless: true,
        args: ["--no-sandbox", "--disable-setuid-sandbox"],
      });
    }
  }

  async createContext(): Promise<BrowserContext> {
    if (!this.browser) {
      throw new Error(
        "Browser instance has not been initialized. Call Init() first",
      );
    }

    const context = await this.browser.newContext({
      userAgent:
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    });

    await context.route("**/*", (route) => {
      const type = route.request().resourceType();
      if (["image", "media", "font"].includes(type)) {
        return route.abort();
      }
      return route.continue();
    });
    return context;
  }

  async close(): Promise<void> {
    if (this.browser) {
      await this.browser.close();
      this.browser = null;
    }
  }
}
