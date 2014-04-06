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

flat: main.flt.tex

main.flt.tex: */*/*.tex *.tex *.bib Makefile
	flatex main.tex
	mv main.flt main.flt.tex

compare: 
	flatex main.tex
	mv main.flt main.flt.tex
	latexdiff ../oldtext/main.flt.tex main.flt.tex > main.diff.tex
	rm -f *.toc
	pdfcslatex -shell-escape main.diff
	pdfcslatex -shell-escape main.diff
	rm main.diff.aux
	# rm main.diff.bbl
	# rm main.diff.blg
	rm main.diff.lof
	rm main.diff.log
	rm main.diff.out
	rm main.diff.toc
	rm main.diff.tex

