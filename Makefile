all: alfa.pdf

alfa.pdf: alfa.latex
	latexmk -pdf $<

alfa.png: alfa.pdf
	convert -density 150 -flatten $< $@

clean: alfa.latex
	latexmk -CA $<

.PHONY: all clean alfa.pdf alfa.png
