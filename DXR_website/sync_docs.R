#script: sync_docs.R
#purpose: Syncs built HTML/Figure folders from DXR_website to the root docs/
#usage: Run this script from the DXR_website directory

files_to_copy <- c(
  "QC.Rmd", "RUVs.Rmd",
  "Figure1.Rmd", "Figure2.Rmd",
  "Figure3.Rmd", "Figure4.Rmd",
  "Figure5.Rmd", "Figure6.Rmd",
  "Figure7.Rmd"
)

#ensure the root figure directory exists
if (!dir.exists("../docs/figure")) {
  dir.create("../docs/figure", recursive = TRUE)
}

#iterate and sync
for (f in files_to_copy) {
  base_name <- tools::file_path_sans_ext(f)

  #1. sync html files from DXR_website into root directory
  html_src <- paste0("docs/", base_name, ".html")
  html_dest <- paste0("../docs/", base_name, ".html")

  if (file.exists(html_src)) {
    file.copy(html_src, html_dest, overwrite = TRUE)
  }

  #2. sync figure folder the same way into the root directory
  fig_src <- paste0("docs/figure/", f)
  fig_dest <- "../docs/figure/"

  if (dir.exists(fig_src)) {
    file.copy(fig_src, fig_dest, recursive = TRUE, overwrite = TRUE)
  }
}

cat("Sync complete! All HTML and figure folders have been moved to ../docs/ \n")
