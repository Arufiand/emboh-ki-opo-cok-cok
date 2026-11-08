import type { NormalizedSignal } from "../types/ingestor.js";

export const PROMED_DEV_FIXTURES: NormalizedSignal[] = [
  {
    id: "promed-mock-1",
    source: "PROMED",
    sourceUrl: "https://promedmail.org/alert/mock-1",
    headline:
      "AVIAN INFLUENZA - INDONESIA (01): (JAWA TIMUR) POULTRY, SUSPECTED",
    snippet:
      "Kematian unggas mendadak dilaporkan di Blitar Jawa Timur dengan dugaan flu burung.",
    publishedAt: new Date().toISOString(),
    provinceCode: "ID-JI",
    provinceName: "Jawa Timur",
    regencyCity: "blitar",
    pathogen: { name: "Avian Influenza (H5N1)", family: "Orthomyxoviridae" },
    symptoms: [],
    severity: "HIGH",
    isKlb: false,
  },
  {
    id: "promed-mock-2",
    source: "PROMED",
    sourceUrl: "https://promedmail.org/alert/mock-2",
    headline: "RABIES - INDONESIA (02): (BALI) HUMAN, CANINE BITES",
    snippet: "Kasus gigitan anjing rabies dilaporkan di Buleleng Bali.",
    publishedAt: new Date().toISOString(),
    provinceCode: "ID-BA",
    provinceName: "Bali",
    regencyCity: "buleleng",
    pathogen: { name: "Rabies", family: "Rhabdoviridae" },
    symptoms: ["Demam Tinggi"],
    severity: "MEDIUM",
    isKlb: false,
  },
];
