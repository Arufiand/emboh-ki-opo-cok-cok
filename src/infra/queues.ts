import { redisConfig } from "../config/env";
import { Queue } from "bullmq";
import { NormalizedSignal } from "../types/ingestor";

export interface FetchJobPayload {
  source: NormalizedSignal["source"];
}

const bullConnection = {
  host: redisConfig.host,
  port: redisConfig.port,
  maxRetriesPerRequest: null,
};

export const fetchQueue = new Queue<FetchJobPayload>("fetch-queue", {
  connection: bullConnection,
  defaultJobOptions: {
    attempts: 3,
    backoff: { type: "exponential", delay: 5000 },
    removeOnComplete: 100,
    removeOnFail: 500,
  },
});

export const persistQueue = new Queue<NormalizedSignal>("persist-queue", {
  connection: bullConnection,
  defaultJobOptions: {
    attempts: 3,
    backoff: { type: "exponential", delay: 2000 },
    removeOnComplete: 500,
    removeOnFail: 1000,
  },
});
