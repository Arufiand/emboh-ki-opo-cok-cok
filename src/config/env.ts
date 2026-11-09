export interface IngestorConfig {
  sourceName: string;
  listingUrl: string;
}

function getEnv(key: string): string {
  const value = process.env[key];
  if (!value) {
    throw new Error(
      `[Config Error] Missing required environment variable: ${key}`,
    );
  }
  return value;
}

export const promedConfig: IngestorConfig = {
  sourceName: getEnv("PROMED_SOURCE_NAME"),
  listingUrl: getEnv("PROMED_BASE_URL"),
};

export interface NewsDataConfig extends IngestorConfig {
  apiKey: string;
}

export const newsDataConfig: NewsDataConfig = {
  apiKey: getEnv("NEWS_API_KEY"),
  listingUrl: getEnv("NEWS_BASE_URL"),
  sourceName: getEnv("NEWS_SOURCE_NAME"),
};
