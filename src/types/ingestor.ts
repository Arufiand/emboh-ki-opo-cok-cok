export interface NormalizedSignal {
  id: string;
  source: "PROMED" | "NEWSDATA" | "GOOGLE_NEWS";
  sourceUrl: string;
  headline: string;
  snippet?: string;
  publishedAt: string;
  provinceCode: string;
  provinceName: string;
  regencyCity?: string;
  pathogen: {
    name: string;
    family: string;
  };
  symptoms: string[];
  severity: "LOW" | "MEDIUM" | "HIGH" | "CRITICAL_KLB";
  isKlb: boolean;
}

export interface SignalIngestor {
  readonly name: string;
  collect(): Promise<NormalizedSignal[]>;
}
