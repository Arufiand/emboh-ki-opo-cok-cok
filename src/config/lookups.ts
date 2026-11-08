export interface ProvinceLookup {
  code: string;
  name: string;
  keywords: string[];
}

export interface PathogenLookup {
  name: string;
  family: string;
  keywords: string[];
}

export interface SymptomLookup {
  name: string;
  keywords: string[];
}

export const INDONESIA_PROVINCES: ProvinceLookup[] = [
  {
    code: "ID-JK",
    name: "DKI Jakarta",
    keywords: [
      "jakarta",
      "dki",
      "jaksel",
      "jakbar",
      "jaktim",
      "jakpus",
      "jakut",
    ],
  },
  {
    code: "ID-JB",
    name: "Jawa Barat",
    keywords: [
      "jawa barat",
      "jabar",
      "bandung",
      "bogor",
      "bekasi",
      "depok",
      "cirebon",
      "tasikmalaya",
      "sukabumi",
    ],
  },
  {
    code: "ID-JI",
    name: "Jawa Timur",
    keywords: [
      "jawa timur",
      "jatim",
      "surabaya",
      "malang",
      "sidoarjo",
      "gresik",
      "banyuwangi",
      "kediri",
      "jember",
    ],
  },
  {
    code: "ID-JT",
    name: "Jawa Tengah",
    keywords: [
      "jawa tengah",
      "jateng",
      "semarang",
      "solo",
      "surakarta",
      "banyumas",
      "magelang",
      "cilacap",
    ],
  },
  {
    code: "ID-BA",
    name: "Bali",
    keywords: ["bali", "denpasar", "badung", "buleleng", "gianyar", "tabanan"],
  },
  {
    code: "ID-YO",
    name: "DI Yogyakarta",
    keywords: [
      "yogyakarta",
      "jogja",
      "sleman",
      "bantul",
      "kulon progo",
      "gunungkidul",
    ],
  },
  {
    code: "ID-BT",
    name: "Banten",
    keywords: [
      "banten",
      "serang",
      "tangerang",
      "cilegon",
      "lebak",
      "pandeglang",
    ],
  },
  {
    code: "ID-SU",
    name: "Sumatera Utara",
    keywords: [
      "sumatera utara",
      "sumut",
      "medan",
      "deli serdang",
      "asahan",
      "simalungun",
    ],
  },
  {
    code: "ID-SN",
    name: "Sumatera Selatan",
    keywords: [
      "sumatera selatan",
      "sumsel",
      "palembang",
      "banyuasin",
      "ogan ilir",
    ],
  },
  {
    code: "ID-RI",
    name: "Riau",
    keywords: ["riau", "pekanbaru", "dumai", "kampar"],
  },
  {
    code: "ID-SS",
    name: "Sulawesi Selatan",
    keywords: [
      "sulawesi selatan",
      "sulsel",
      "makassar",
      "gowa",
      "maros",
      "bone",
    ],
  },
  {
    code: "ID-KI",
    name: "Kalimantan Timur",
    keywords: [
      "kalimantan timur",
      "kaltim",
      "samarinda",
      "balikpapan",
      "kutai kartanegara",
      "ikn",
      "nusantara",
    ],
  },
  // Add NTB, NTT, Aceh, etc. to INDONESIA_PROVINCES in src/config/lookups.ts
  {
    code: "ID-NB",
    name: "Nusa Tenggara Barat",
    keywords: [
      "nusa tenggara barat",
      "ntb",
      "mataram",
      "lombok",
      "sumbawa",
      "bima",
      "suarantb",
    ],
  },
  {
    code: "ID-NT",
    name: "Nusa Tenggara Timur",
    keywords: [
      "nusa tenggara timur",
      "ntt",
      "kupang",
      "flores",
      "sumba",
      "labuan bajo",
    ],
  },
  {
    code: "ID-AC",
    name: "Aceh",
    keywords: ["aceh", "banda aceh", "lhokseumawe", "aceh besar", "pidie"],
  },
  {
    code: "ID-KI",
    name: "Kalimantan Timur",
    keywords: [
      "kalimantan timur",
      "kaltim",
      "samarinda",
      "balikpapan",
      "kukar",
      "kutai kartanegara",
      "bontang",
      "ikn",
      "nusantara",
    ],
  },
];

export const PATHOGEN_LOOKUPS: PathogenLookup[] = [
  {
    name: "Dengue (DBD)",
    family: "Flaviviridae",
    keywords: ["dbd", "dengue", "demam berdarah"],
  },
  {
    name: "Avian Influenza (H5N1)",
    family: "Orthomyxoviridae",
    keywords: ["flu burung", "h5n1", "avian influenza"],
  },
  {
    name: "Mpox",
    family: "Poxviridae",
    keywords: ["mpox", "cacar monyet", "monkeypox"],
  },
  {
    name: "Polio",
    family: "Picornaviridae",
    keywords: ["polio", "lumpuh layu", "afp"],
  },
  {
    name: "Rabies",
    family: "Rhabdoviridae",
    keywords: ["rabies", "anjing gila", "gigitan hpr"],
  },
  {
    name: "COVID-19",
    family: "Coronaviridae",
    keywords: ["covid", "sars-cov-2", "coronavirus"],
  },
];

export const SYMPTOM_LOOKUPS: SymptomLookup[] = [
  {
    name: "Demam Tinggi",
    keywords: ["demam", "panas tinggi", "febris", "suhu tinggi"],
  },
  {
    name: "Ruam Kulit",
    keywords: ["ruam", "bintik merah", "lesi", "lepuh", "bercak"],
  },
  {
    name: "Sesak Napas",
    keywords: ["sesak", "sulit bernapas", "dispnea", "oksigen"],
  },
  {
    name: "Trombositopenia",
    keywords: ["trombosit turun", "trombosit rendah", "trombositopenia"],
  },
  {
    name: "Nyeri Sendi & Otot",
    keywords: ["nyeri sendi", "pegal", "mialgia", "artralgia"],
  },
  {
    name: "Lumpuh Layu",
    keywords: ["lumpuh layu", "lemas otot", "kelumpuhan"],
  },
];
