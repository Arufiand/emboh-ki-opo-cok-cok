import { db } from "../prisma/db.js";
import type { NormalizedSignal } from "../types/ingestor.js";

export class SignalRepository {
  async upsertSignal(signal: NormalizedSignal): Promise<void> {
    const parsedDate = new Date(signal.publishedAt);
    const publishedAt = Number.isNaN(parsedDate.getTime())
      ? new Date()
      : parsedDate;

    const existing = await db.orm.public.OutbreakSignal.where({
      sourceUrl: signal.sourceUrl,
    }).first();

    const payload = {
      source: signal.source,
      sourceUrl: signal.sourceUrl,
      headline: signal.headline,
      snippet: signal.snippet ?? null,
      publishedAt,
      provinceCode: signal.provinceCode,
      provinceName: signal.provinceName,
      regencyCity: signal.regencyCity ?? null,
      pathogenName: signal.pathogen.name,
      pathogenFam: signal.pathogen.family,
      symptoms: signal.symptoms,
      severity: signal.severity,
      isKlb: signal.isKlb,
    };

    if (existing) {
      await db.orm.public.OutbreakSignal.where({
        sourceUrl: signal.sourceUrl,
      }).update(payload);
    } else {
      await db.orm.public.OutbreakSignal.create({
        id: signal.id,
        ...payload,
      });
    }
  }
}
