import { Button } from "@nous-research/ui/ui/components/button";
import { Typography } from "@/components/NouiTypography";
import { useI18n, ALL_LOCALES } from "@/i18n/context";
import type { Locale } from "@/i18n/types";

const LOCALE_META: Record<Locale, { flag: string; label: string }> = {
  "pt-BR": { flag: "🇧🇷", label: "PT-BR" },
  en: { flag: "🇬🇧", label: "EN" },
  zh: { flag: "🇨🇳", label: "中文" },
};

/**
 * Compact language toggle — cycles through supported locales.
 * Persists choice to localStorage.
 */
export function LanguageSwitcher() {
  const { locale, setLocale, t } = useI18n();

  const cycle = () => {
    const idx = ALL_LOCALES.indexOf(locale);
    const next = ALL_LOCALES[(idx + 1) % ALL_LOCALES.length];
    setLocale(next);
  };

  const meta = LOCALE_META[locale];

  return (
    <Button
      ghost
      onClick={cycle}
      title={t.language.switchTo}
      aria-label={t.language.switchTo}
      className="px-2 py-1 normal-case tracking-normal font-normal text-xs text-muted-foreground hover:text-foreground"
    >
      <span className="inline-flex items-center gap-1.5">
        <span className="text-base leading-none">
          {meta.flag}
        </span>

        <Typography
          mondwest
          className="hidden sm:inline tracking-wide uppercase text-[0.65rem]"
        >
          {meta.label}
        </Typography>
      </span>
    </Button>
  );
}
