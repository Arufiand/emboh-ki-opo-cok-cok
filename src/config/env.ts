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
