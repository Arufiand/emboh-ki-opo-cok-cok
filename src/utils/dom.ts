import { Page } from "playwright";

export const extractText = async (
  page: Page,
  selector: string,
  fallback = "",
): Promise<string> => {
  return page
    .$eval(selector, (el) => el.textContent?.trim() || "")
    .catch(() => fallback);
};

export const extractAllText = async (
  page: Page,
  selector: string,
  separator = "\n\n",
): Promise<string> => {
  return page
    .$$eval(selector, (nodes) =>
      nodes
        .map((n) => n.textContent?.trim() || "")
        .filter((text) => text.length > 0),
    )
    .then((paragraphs) => paragraphs.join(separator))
    .catch(() => "");
};
