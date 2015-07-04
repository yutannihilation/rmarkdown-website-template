local({
  md_tmp <- tempfile(tmpdir = ".", fileext = ".md")
  on.exit(file.remove(md_tmp))

  cat('---
title: "Index"
output: html_document
---
', file = md_tmp)

  rmd_pages  <- list.files(pattern = "*.Rmd")
  html_pages <- sub(".Rmd", ".html", rmd_pages)
  mtimes     <- file.mtime(rmd_pages)
  page_list  <- sort(sprintf("* %s [%s](%s)", mtimes, html_pages, html_pages))
  cat(paste0(page_list, collapse = "\n"),
      file = md_tmp, append = TRUE)

  rmarkdown::render(md_tmp, output_file = "index.html")
})
