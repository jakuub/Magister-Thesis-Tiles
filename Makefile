default: pdf

main.dvi: */*/*.tex *.tex *.bib Makefile
	rm -f *.toc
	cslatex main
	bibtex main
	cslatex main
	cslatex main

main.ps: main.dvi
	dvips main.dvi

main.pdf: */*/*.tex *.tex *.bib Makefile
	rm -f *.toc
	pdfcslatex -shell-escape main
	bibtex main
	pdfcslatex -shell-escape main
	pdfcslatex -shell-escape main

dvi: main.dvi

ps: main.ps

pdf: main.pdf

all: ps pdf

clean: 
	rm -f *.{log,aux,toc,bbl,blg,slo,srs}

dist-clean:
	rm -f *.{log,aux,dvi,toc,bbl,blg,slo,srs} main.ps main.pdf

booklet: main.ps
	cat main.ps | psbook | psnup -2 >main-booklet.ps

