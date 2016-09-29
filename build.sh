#!/bin/bash
file=Main
pdflatex $file.tex
makeglossaries $file
pdflatex $file.tex
pdflatex $file.tex
