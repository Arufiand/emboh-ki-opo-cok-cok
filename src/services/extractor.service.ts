import { NormalizedSignal } from "../types/ingestor.js";
import {
  INDONESIA_PROVINCES,
  PATHOGEN_LOOKUPS,
  SYMPTOM_LOOKUPS,
} from "../config/lookups.js";
import { createHash } from "node:crypto";

export class ExtractorService {
  static resolve(
    headline: string,
    snipped: string,
    url: string,
    publishedAt: string,
    source: NormalizedSignal["source"],
  ): NormalizedSignal | null {
    const combined = `${headline}${snipped}`.toLowerCase();
    const pathogenMatch = PATHOGEN_LOOKUPS.find((p) =>
      p.keywords.some((kw) => combined.includes(kw)),
    );

    if (!pathogenMatch) return null;

    const matchedProvince = INDONESIA_PROVINCES.find((prov) =>
      prov.keywords.some((kw) => combined.includes(kw)),
    );

    let regencyCity: string | undefined;
    if (matchedProvince) {
      regencyCity = matchedProvince.keywords.find(
        (kw) =>
          kw !== matchedProvince!.name.toLowerCase() && combined.includes(kw),
      );
    }

    const provinceCode = matchedProvince?.code ?? "ID-UN";
    const provinceName = matchedProvince?.name ?? "Indonesia (Nasional)";

    const symptoms: string[] = [];
    for (const symptom of SYMPTOM_LOOKUPS) {
      if (symptom.keywords.some((kw) => combined.includes(kw))) {
        symptoms.push(symptom.name);
      }
    }

    const isKlb =
      combined.includes("klb") ||
      combined.includes("kejadian luar biasa") ||
      combined.includes("meninggal") ||
      combined.includes("tewas") ||
      combined.includes("kritis");

    let severity: NormalizedSignal["severity"] = "LOW";

    if (isKlb) {
      severity = "CRITICAL_KLB";
    } else if (
      combined.includes("wabah") ||
      combined.includes("lonjakan") ||
      combined.includes("darurat") ||
      combined.includes("positif")
    ) {
      severity = "HIGH";
    } else if (combined.includes("kasus") || combined.includes("waspada")) {
      severity = "MEDIUM";
    }

    const id = createHash("sha256").update(url).digest("hex");

    return {
      id,
      source,
      sourceUrl: url,
      headline: headline.trim(),
      snippet: snipped.trim(),
      publishedAt: new Date(publishedAt).toISOString(),
      provinceCode,
      provinceName,
      regencyCity,
      pathogen: { name: pathogenMatch.name, family: pathogenMatch.family },
      symptoms,
      severity,
      isKlb,
    };
  }
}
