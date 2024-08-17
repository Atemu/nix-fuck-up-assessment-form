all: form.pdf

form.pdf: form.tex
	latexmk -pdf -shell-escape $<

form.png: form.pdf
	convert -density 150 -flatten $< $@

clean: form.tex
	latexmk -CA $<

.PHONY: all clean form.pdf
