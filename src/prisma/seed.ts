import "dotenv/config";
import { INDONESIA_PROVINCES } from "../config/lookups.js";
import { db } from "./db.js";

const PROVINCE_COORDINATES: Record<
  string,
  { latitude: number; longitude: number }
> = {
  "ID-00": { latitude: -2.5489, longitude: 118.0149 }, // Nasional fallback
  "ID-AC": { latitude: 4.6951, longitude: 96.7494 },
  "ID-SU": { latitude: 2.1154, longitude: 99.5451 },
  "ID-SB": { latitude: -0.7399, longitude: 100.8 },
  "ID-RI": { latitude: 0.2933, longitude: 101.7068 },
  "ID-JA": { latitude: -1.4852, longitude: 102.4381 },
  "ID-SS": { latitude: -3.3194, longitude: 103.9144 },
  "ID-BE": { latitude: -3.5778, longitude: 102.3464 },
  "ID-LA": { latitude: -4.5586, longitude: 105.4068 },
  "ID-BB": { latitude: -2.7411, longitude: 106.4406 },
  "ID-KR": { latitude: 3.9457, longitude: 108.1429 },
  "ID-JK": { latitude: -6.2088, longitude: 106.8456 },
  "ID-JB": { latitude: -6.9175, longitude: 107.6191 },
  "ID-JT": { latitude: -7.151, longitude: 110.1403 },
  "ID-YO": { latitude: -7.7956, longitude: 110.3695 },
  "ID-JI": { latitude: -7.5361, longitude: 112.2384 },
  "ID-BT": { latitude: -6.4058, longitude: 106.064 },
  "ID-BA": { latitude: -8.4095, longitude: 115.1889 },
  "ID-NB": { latitude: -8.6529, longitude: 117.3616 },
  "ID-NT": { latitude: -8.6574, longitude: 121.0794 },
  "ID-KB": { latitude: -0.2788, longitude: 111.4753 },
  "ID-KT": { latitude: -1.6815, longitude: 113.3824 },
  "ID-KS": { latitude: -3.0926, longitude: 115.2838 },
  "ID-KI": { latitude: 0.5387, longitude: 116.4194 },
  "ID-KU": { latitude: 3.0731, longitude: 116.0414 },
  "ID-SA": { latitude: 0.6247, longitude: 123.975 },
  "ID-ST": { latitude: -1.43, longitude: 121.4456 },
  "ID-SN": { latitude: -3.6688, longitude: 119.9741 },
  "ID-SG": { latitude: -4.1449, longitude: 122.1746 },
  "ID-GO": { latitude: 0.6999, longitude: 122.4467 },
  "ID-SR": { latitude: -2.8441, longitude: 119.2321 },
  "ID-MA": { latitude: -3.2385, longitude: 130.1453 },
  "ID-MU": { latitude: 1.5709, longitude: 127.8088 },
  "ID-PA": { latitude: -4.2699, longitude: 138.0804 },
  "ID-PB": { latitude: -1.3361, longitude: 133.1747 },
  "ID-PS": { latitude: -7.7523, longitude: 139.673 },
  "ID-PT": { latitude: -3.9964, longitude: 136.3738 },
  "ID-PE": { latitude: -4.1833, longitude: 138.9439 },
  "ID-PD": { latitude: -0.9167, longitude: 131.2833 },
};

async function seed() {
  const uniqueProvinces = Array.from(
    new Map(INDONESIA_PROVINCES.map((p) => [p.code, p])).values(),
  );

  if (!uniqueProvinces.some((p) => p.code === "ID-00")) {
    uniqueProvinces.unshift({
      code: "ID-00",
      name: "Nasional",
      keywords: ["indonesia", "nasional", "kemenkes"],
    });
  }

  console.log(`Seeding ${uniqueProvinces.length} provinces from lookups.ts...`);

  for (const prov of uniqueProvinces) {
    const coords = PROVINCE_COORDINATES[prov.code] ?? {
      latitude: -2.5489,
      longitude: 118.0149,
    };

    const existing = await db.orm.public.ProvinceMaster.where({
      code: prov.code,
    }).first();

    if (existing) {
      await db.orm.public.ProvinceMaster.where({ code: prov.code }).update({
        name: prov.name,
        latitude: coords.latitude,
        longitude: coords.longitude,
      });
    } else {
      await db.orm.public.ProvinceMaster.create({
        code: prov.code,
        name: prov.name,
        latitude: coords.latitude,
        longitude: coords.longitude,
      });
    }
  }

  console.log("ProvinceMaster seed completed.");
  process.exit(0);
}

seed().catch((err) => {
  console.error("Seed failed:", err);
  process.exit(1);
});
