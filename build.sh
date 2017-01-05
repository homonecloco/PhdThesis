#!/bin/bash
file=Main
pdflatex $file.tex
bibtex $file
makeglossaries $file
pdflatex $file.tex
pdflatex $file.tex

