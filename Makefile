SHELL := /bin/bash

MAIN=main
TEXSRC=$(wildcard *.tex)
BIBSRC=$(wildcard *.bib)
DIR_BUILD=build
OPT= --interaction=nonstopmode

all: $(DIR_BUILD)/$(MAIN).pdf

$(DIR_BUILD)/$(MAIN).pdf: $(TEXSRC) $(BIBSRC)
	@pdflatex -interaction=nonstopmode  $(MAIN).tex
	@makeindex -s $(MAIN).ist -t $(MAIN).glg -o $(MAIN).gls $(MAIN).glo
	@biber $(MAIN)
	@pdflatex -interaction=nonstopmode  $(MAIN).tex
	@pdflatex -interaction=nonstopmode $(MAIN).tex
	latexmk -pdf -auxdir=$(DIR_BUILD) -outdir=$(DIR_BUILD) -pvc -pdflatex="pdflatex $(OPT)" $(MAIN)

clean:
	rm -f $(MAIN).{log,aux,bcf,fdb_latexmk,fls,lof,lot,run.xml,synctex.gz,toc,upa,upd,ubp,bbl,blg}

.PHONY: clean all 
