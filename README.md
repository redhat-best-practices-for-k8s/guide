# Introduction

This repo is a scratch pad for a GDoc > Docx > AsciiDoc conversion workflow using a number of conversion steps.

Tools used: Libre Office, Pandoc, Nebel, AsciiDoctor.

**NOTE: This repo is a scratch pad only, content is not final or production ready, do not share**

## Gdoc > Docx steps

The GDoc file I reviewed had some mismatches in formatting which I tidied up. The pandoc conversion uses Document styles to apply formatting. Consistent Styles in GDoc mean the conversion is more consistent.

* Download the [CNF GDoc](https://docs.google.com/document/d/1NmqbdTHll4kMamcaarCBagN7ZYlHysVtaRlolAu56R8/edit) as .docx > "Save as ... docx"
* Open the downloaded docx in libre Office, and clean up codeblocks (apply "Source Code" style to codeblocks), and definition list elements, etc using reference.docx as a formatting guide.  
* Save docx updates as "Word docx 2007 compatible". 

## Pandoc conversion

```cmd
pandoc -t asciidoc  -f docx cnf-reqs_1.3.docx -o cnf-reqs_1.3.adoc --extract-media ./images --wrap=none
```

##  Split single AsciiDoc file into topic modules + assembly

```cmd
nebel split --legacybasedir ./ cnf-reqs_1.3_single.adoc
```

## Description of demo files

* `cnf-reqs_1.3.docx` is a minimally modified docx version of the cnf-reqs GDoc. Main change is tidying up codeblocks using "Source Code" paragraph style.
* `cnf-reqs_1.3_single.adoc` is a cleaned up version of the pandoc conversion of `cnf-reqs_1.3.docx`
* `out/` contains a chunked version of the AsciiDoc files. **This is close to what the final conversion should look like.** 
* `reference.docx` shows the supported styles for pandoc conversions.
* `reference.adoc` generated from `reference.docx`
* Single file is cut to assembly + out file using [nebel](https://github.com/fbolton/nebel#splitting-content)  

## AsciiDoc-side cleanup

TODO: write a grep n replace script that does the following: 

* `____` > ``
* ` {blank}\n+\n` > ` `
* Optional: `....\n` > `----\n`
* Fix xrefs
* Fix section titles, bullets, dl formatting
* Run output through choppy/nebel - make sensible length topics  
