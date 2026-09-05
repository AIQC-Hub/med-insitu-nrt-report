# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [0.3.0] - 2026-09-06

Everything below was re-rendered end to end against `reportlib` v0.1.10 on 2026-09-06, from an
empty `content/_freeze/` and `content/docs/`: 22 pages and 124 figures in 263s, no chunk error and
no unresolved link or image on any page, and `scripts/dump_frames.R --check` clean against the
committed fingerprints. `mo_pres.qmd` is the one page that reaches the empty-flag notice below --
`nrt_mo` has no QC 4 pressure observation -- and it prints the sentence rather than `Inf`/`NaN`.

### Added
- `scripts/build_summaries.R` and `scripts/dump_frames.R`, thin wrappers over
  `reportlib::build_summaries()` and `reportlib::fingerprint_frames()`.
- A **Source on GitHub** link in the navbar, pointing at this repo.
- `freeze: auto` in `content/_quarto.yml`: a page is re-run only when it changes, so a rebuild
  that touches nothing costs 16s instead of ~5min. Quarto hashes only the `.qmd`, and almost
  nothing that decides what a page shows lives there, so `build.sh` stamps the installed
  `reportlib`, `content/_func/`, `config.yml` and the parquet, and clears `content/_freeze/`
  when any of them moves. The freeze directory is git-ignored.
- **The pressure pages are back**: `mo_pres.qmd`, `mo_gl_pres.qmd`, `mo_cora_pres.qmd` and their
  `_qc` counterparts, with a **Pressure** menu restored to the navbar between Profile Summary
  and Temperature, and a **Pressure** group in the home page's Contents list. Each is its
  temperature page with the variable swapped.

### Changed
- Input data now comes from `ctddump` + `seastamp` instead of the R-built summaries published as
  release assets. Figures change accordingly and are not reconciled against the previous site:
  MO 1,560 profiles, GL 73,028 profiles, CORA 71,816 profiles.
- The site is now built with **Quarto** instead of Distill. Pages are `.qmd`, `_site.yml` became
  `content/_quarto.yml`, and xaringanExtra panelsets became Quarto `::: {.panel-tabset}`.
- The shared functions and templates moved to the **`reportlib`** package. This repo now holds
  only its pages, `_func/common_site.Rmd`, its region files and `_quarto.yml`.
- The QC tabs now open on **Good (QC == 1)**, followed by **Bad (QC == 4)** and then
  **All**, so a section leads with the QC-1 data rather than the unfiltered mixture.
  The order lives in `reportlib`; the pin moves to v0.1.10.
- The multi-panel figures on the Profile Summary pages became tabsets with one image per
  tab: the location maps, the longitude and latitude histograms, the four time spans, and
  the observation-count histograms and maps. Each panel is now its own PNG rather than one
  cell of a tall composite. The page call sites drop `plot_nrow`, and `plot_height` now
  means the height of a single plot. Needs `reportlib` v0.1.10.
- Page rendering no longer re-groups the summaries by profile. `netcdf_summary_1()` and the
  location filters were written for observation-level input, where a profile spans many rows;
  the summaries have had one row per platform x profile since `build_summaries.R`, so the
  grouping was a no-op costing 15s and 6s per call. A whole-site render drops from 393s to
  179s, with every figure byte-identical and every page identical apart from
  the random htmlwidget element ids. Needs `reportlib` v0.1.10.
- The region maps use their own shape instead of the figure's. A degree of longitude is
  cos(latitude) of a degree of latitude, and stretching the panel to the device drew them
  the same length; the maps are now fixed at that ratio, with the unused part of the
  device left as margin. The Baltic and Mediterranean maps change most -- they were being
  stretched to a square figure. The colour bar is also 5cm wide now, which stops its
  labels running together ("500 100015002000"). Needs `reportlib` v0.1.10.
- The summary parquet dropped the `_2_` from its name (`netcdf_<src>_summary*`, a leftover from
  the retired R pipeline) and lost the 24 columns nothing reads: every `pres_*` column, which
  went with the pressure pages, and the six `observation_no_*` statistics beyond `_count`.
  A base file goes from 68 to 44 columns and about a fifth smaller. Verified column by column
  against the fingerprint baselines: 1,664 kept columns unchanged, 384 dropped, row and
  platform counts identical. Needs `reportlib` v0.1.8, and a new release of the data assets
  before CI can build.
- The summaries carry `pres` again — the 18 `pres_*` columns in the base file (62 columns now)
  and, new, its QC 1 / QC 4 subsets, which the pages' Good/Bad tabs read and the old pipeline
  never built. All eight datasets were rebuilt from the observation-level parquet and checked
  column by column: 1,652 existing columns unchanged, 288 new. Needs `reportlib` v0.1.10.

### Removed
- Pressure pages and the NRT vs CORA comparison pages.
- Four sections from every summary page: "Profile level QC flags", "Location Filtering",
  "Duplicate Profiles Within Platforms" and "Duplicate Profiles Across Platforms".

### Fixed
- The navbar title linked to the AIQC portal instead of this site's home page, so nothing in the
  menu bar led back to the index. Quarto folds the logo and the title into a single brand link,
  which `logo-href` then claimed in full; Distill kept the two apart. The title is now an ordinary
  nav item pointing at `index.qmd`, and the logo keeps the portal link and gains `AIQC` alt text
  (it had none, and the image is white on transparent).
- A QC tab with no observations behind it now says so instead of printing `Inf`, `NaN` and a
  stray dash for its four headline numbers. `nrt_mo` has no QC 4 pressure observation at all,
  which is how this surfaced. Needs `reportlib` v0.1.10.


## [0.2.2] - 2025-11-17
### Added
- NRT vs CORA pages

## [0.2.1] - 2025-11-15
### Fixed
- Link to the main repot site

## [0.2.0] - 2025-11-15
### Changed
- Repository name to med-report

### Added
- Profile-level QC filtering

## [0.1.1] - 2025-11-15
### Added
- Default usage of filtering data frames in all pages
- AIQC logo to menu

## [0.1.0] - 2025-11-14
### Added
- Import Mediterranean Sea pages form bal-insitu-nrt-report
