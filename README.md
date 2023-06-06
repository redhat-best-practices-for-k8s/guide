
This document provides guidance and information for developing OpenShift applications in compliance with commonly recognized industry standards and best practices for Cloud Native Functions (CNFs).

To build the HTML, install `asciidoctor` and run: 

```cmd
asciidoctor -a stylesheet="assets/css/redhat.css" -a toc -a toc-placement=left \
-a icons=font -a docinfodir="assets" -a docinfo=shared \
-a source-highlighter=rouge -a rouge-style=github \
-a favicon="assets/images/favicon.ico" \
-a iconsdir="assets/images" -a icon-set=fab -a icons="font" \
-a sectlinks main.adoc -o index.html
```

To build the PDF, install `asciidoctor-pdf` and run:

```cmd
asciidoctor-pdf -a pdf-themesdir=pdf -a pdf-theme=redhat -a toc-title="" -a doctype=book -a source-highlighter="rouge"  main.adoc -o verizon-cnf-best-practices.pdf
```
