#!/bin/bash

echo "Initializing Document..."

pdflatex report.tex

wait $!

echo "Adding Bibliography..."

bibtex report.tex

wait $!

echo "Dotting i\'s and crossing t\'s..."

pdflatex report.tex

wait $!

pdflatex report.tex

wait $!

cp report.pdf ..

echo "Compilation Complete"
