import { Redis } from "ioredis";
import { redisConfig } from "../config/env.js";
import { NormalizedSignal } from "../types/ingestor.js";

export class DeduplicationService {
  private readonly redis: Redis;

  private readonly TTL_SECONDS = 14 * 24 * 60 * 60;

  constructor(config = redisConfig) {
    this.redis = new Redis({
      host: config.host,
      port: config.port,
      lazyConnect: true,
      maxRetriesPerRequest: 2,
    });
  }

  async connect(): Promise<void> {
    if (this.redis.status === "ready" || this.redis.status === "connecting") {
      return;
    }
    await this.redis.connect();
    console.log(`[Redis] connected successfully.`);
  }
  async filterNewSignals(
    signals: NormalizedSignal[],
  ): Promise<{ newSignals: NormalizedSignal[]; duplicateCount: number }> {
    const newSignals: NormalizedSignal[] = [];
    let duplicateCount = 0;

    for (const signal of signals) {
      const redisKey = `signal:seen:${signal.id}`;

      const wasSet = await this.redis.set(
        redisKey,
        signal.source,
        "EX",
        this.TTL_SECONDS,
        "NX",
      );

      if (wasSet === "OK") {
        newSignals.push(signal);
      } else {
        duplicateCount++;
      }
    }
    return { newSignals, duplicateCount };
  }

  async disconnect(): Promise<void> {
    await this.redis.quit();
    console.log(`[Redis] disconnected successfully.`);
  }
}
