
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd)) \
              $(patsubst %.md, %.html ,$(wildcard *.md))

all: clean html index


html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<', encoding = 'UTF-8')"

%.html: %.md
	R --slave -e "set.seed(100);rmarkdown::render('$<', encoding = 'UTF-8')"

.PHONY: clean index
clean:
	$(RM) $(HTML_FILES) index.html

index:
	Rscript generateIndex.R
