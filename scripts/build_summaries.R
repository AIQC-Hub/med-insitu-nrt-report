#!/usr/bin/env Rscript
#
# Build this site's profile-level summary parquet from the seastamp
# observation-level files. The work lives in reportlib::build_summaries();
# this only names the datasets.
#
suppressPackageStartupMessages(library(reportlib))

args <- commandArgs(trailingOnly = TRUE)

build_summaries(
  datasets = list(
    list(src = "nrt_mo_mo", out = "netcdf_nrt_mo_2_summary"),
    list(src = "nrt_mo_gl", out = "netcdf_nrt_mo_gl_2_summary"),
    list(src = "cora_mo",   out = "netcdf_cora_mo_2_summary")
  ),
  src_dir    = Sys.getenv("SEASTAMP_DIR", unset = "/scratch/data/aiqc/seastamp/stamped/depth"),
  out_dir    = Sys.getenv("SUMMARY_DIR",  unset = "/scratch/data/aiqc/merged"),
  chunk_rows = as.numeric(Sys.getenv("CHUNK_ROWS", unset = "15000000")),
  force      = "--force" %in% args,
  only       = setdiff(args, "--force")
)
message("done")
