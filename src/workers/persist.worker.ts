import { Worker } from "bullmq";
import { redisConfig } from "../config/env.js";
import { SignalRepository } from "../services/signal.repository.js";
import type { NormalizedSignal } from "../types/ingestor.js";

const signalRepository = new SignalRepository();

export function startPersistWorker() {
  const worker = new Worker<NormalizedSignal>(
    "persist-queue",
    async (job) => {
      await signalRepository.upsertSignal(job.data);
      return { id: job.data.id, sourceUrl: job.data.sourceUrl };
    },
    {
      connection: {
        host: redisConfig.host,
        port: redisConfig.port,
        maxRetriesPerRequest: null,
      },
      concurrency: 5,
    },
  );

  worker.on("completed", (job) => {
    console.log(
      `[PersistWorker] Saved signal ${job.data.id} (${job.data.source})`,
    );
  });

  worker.on("failed", (job, err) => {
    console.error(
      `[PersistWorker] Failed signal ${job?.data.id} (attempt ${job?.attemptsMade}):`,
      err,
    );
  });

  return worker;
}

// Allow running as a standalone worker process: `npx tsx src/workers/persist.worker.ts`
if (import.meta.url === `file://${process.argv[1]}`) {
  console.log("[PersistWorker] Listening for jobs on persist-queue...");
  const worker = startPersistWorker();

  const shutdown = async () => {
    console.log("[PersistWorker] Shutting down...");
    await worker.close();
    process.exit(0);
  };

  process.on("SIGINT", shutdown);
  process.on("SIGTERM", shutdown);
}
