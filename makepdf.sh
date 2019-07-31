pandoc -s readme.md -o readme.pdf --pdf-engine=xelatex -f markdown+multiline_tables --filter pandoc-citeproc
