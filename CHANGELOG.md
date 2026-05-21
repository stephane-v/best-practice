# Changelog

All notable changes to this repository are documented in this file.

## 2026-05-21

Major refresh of the navigation, internationalization and interactive tools.

### Added

- **L1, global navigation** : shared `<bp-header>` and `<bp-footer>` Web
  Components injected on every page, client-side search over
  `assets/search-index.json` with Fuse.js, clickable topic filters with URL
  state, reading-time badges and a recently-updated section driven by
  `assets/recent.json`.
- **L2, internationalization** : an i18n module loading `i18n/<lang>.json`,
  with `data-i18n` and `data-i18n-attr` support, browser language detection
  and live EN/FR switching. Home page, header and footer fully translated.
- **L3, Docker Compose Security Validator** : a client-side tool
  (`TOOLS/docker-compose-validator.html`) that parses a docker-compose file
  and reports 14 security checks sorted by severity, with a score and an
  exportable report.
- **L4, LLM Prompt Injection Tester** : a fully offline tool
  (`TOOLS/prompt-injection-tester.html`) scoring a prompt against 6 regex
  categories and 5 heuristics, with an allow/flag/block verdict.
- **L5, RAG Cost Estimator** : an offline calculator
  (`TOOLS/rag-cost-estimator.html`) estimating the monthly cost of a RAG
  system and comparing an EU sovereign setup with a US cloud setup.
- **L6, Sovereign LLM Infrastructure Guide** : a French guide
  (`SOVEREIGN-LLM-INFRASTRUCTURE/sovereign-llm-infrastructure-guide.md`)
  covering the regulatory context, a reference architecture, gateway
  routing, model choices, vector store, security and a 36 month TCO.
- **L7, Stack and Convictions page** : a personal `stack.html` page with the
  current production stack, four engineering convictions and three flagship
  projects.

### Changed

- The interactive tools now share a unified theme storage key.
- The home page stats and structure reflect the new tools and guides.
- `README.md` updated with the new structure and links.

### Removed

- The legacy AI Prompt Library section and the `PROMPT/` directory.
