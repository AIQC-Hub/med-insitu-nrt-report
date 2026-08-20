# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]
### Added
- `scripts/build_summaries.R` and `scripts/dump_frames.R`, thin wrappers over
  `reportlib::build_summaries()` and `reportlib::fingerprint_frames()`.

### Changed
- Input data now comes from `ctddump` + `seastamp` instead of the R-built summaries published as
  release assets. Figures change accordingly and are not reconciled against the previous site:
  MO 1,560 profiles, GL 73,028 profiles, CORA 71,816 profiles.
- The site is now built with **Quarto** instead of Distill. Pages are `.qmd`, `_site.yml` became
  `content/_quarto.yml`, and xaringanExtra panelsets became Quarto `::: {.panel-tabset}`.
- The shared functions and templates moved to the **`reportlib`** package. This repo now holds
  only its pages, `_func/common_site.Rmd`, its region files and `_quarto.yml`.

### Removed
- Pressure pages and the NRT vs CORA comparison pages.
- Four sections from every summary page: "Profile level QC flags", "Location Filtering",
  "Duplicate Profiles Within Platforms" and "Duplicate Profiles Across Platforms".


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
