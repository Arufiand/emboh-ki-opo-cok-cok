import js from "@eslint/js";
import tseslint from "typescript-eslint";
import eslintConfigPrettier from "eslint-config-prettier";

export default tseslint.config(
  // 1. Global Ignores (wajib di objek tersendiri tanpa keys lain)
  {
    ignores: ["dist/**", "node_modules/**", "coverage/**"],
  },

  // 2. Base Recommended Configs
  js.configs.recommended,
  ...tseslint.configs.recommended,

  // 3. Project-specific Rules
  {
    files: ["src/**/*.ts"],
    rules: {
      "@typescript-eslint/no-unused-vars": [
        "error",
        {
          argsIgnorePattern: "^_",
          varsIgnorePattern: "^_",
          caughtErrorsIgnorePattern: "^_",
        },
      ],
    },
  },

  // 4. Prettier Reset (WAJIB selalu paling bawah)
  eslintConfigPrettier,
);
