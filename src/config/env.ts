export interface ScraperConfig {
  sourceName: string;
  listingUrl: string;
}

export const antaraConfig: ScraperConfig = {
  sourceName: process.env.A_SOURCE_NAME ?? "antaranews.com",
  listingUrl:
    process.env.A_LISTING_URL ?? "https://www.antaranews.com/kesehatan",
};
