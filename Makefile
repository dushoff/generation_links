# Park et al. generation links

### Hooks for the editor to set the default target
current: target
-include target.mk
target: $(target)

##################################################################

Sources = Makefile README.md LICENSE.md

ms = makestuff
-include local.mk
-include $(ms)/os.mk
-include $(ms)/perl.def

Sources += $(ms)

$(ms)/%.mk: $(ms)/Makefile
	touch $@

$(ms)/Makefile:
	git submodule init $(ms) 
	git submodule update $(ms) 
	touch $@

##################################################################

## Content

Sources += todo.mkd proof.txt

## https://dushoff.github.io/generation_links/auto.html
products: interval.pdf.gp epiResponse.pdf.gp auto.html.pages

Ignore += abstract.txt
Sources += abstract.pl
abstract.txt: interval.tex abstract.pl
	$(PUSH)

Ignore += *synctex*

######################################################################

## MS
Ignore += pages
Sources += interval.tex appendix.tex appwrap.tex
interval.pdf: interval.tex
interval.deps:

interval.count: interval.tex
	texcount $< > $@

Ignore += park_main.pdf park_supp_text.pdf
park_main.pdf: interval.pdf
	pdfjam -o $@ $< 1-22

park_supp_text.pdf: interval.pdf
	pdfjam -o $@ $< 23-

## Added to resolve reference discrepancies
Sources += supp_only.tex headers.tex
## supp_only.pdf: supp_only.tex

######################################################################

## Draft response to Epidemics
Sources += epiResponse.tex
epiResponse.pdf: epiResponse.tex
epiDiff.pdf: epiResponse.tex

Ignore += epiDiff.tex
epiDiff.tex: epiResponse.??.tex epiResponse_rev.tex
	$(latexdiff)

## cover leter
Sources += letter.tex
letter.pdf: letter.tex
Sources += reviewers.txt

## Requested by Goldstein
## editor letter to eLife
## Now edited for Epidemics
Sources += edlet.txt highlights.txt

## appendix.pdf is no longer a thing … rolled it into the MS
## appwrap.tex contains most of the stuff trimmed from appendix; in case we need to make it stand alone someday
## appendix.pdf: appendix.tex

## make interval.tex.HEAD~1.oldfile ##
interval.tex.518696.oldfile: ## Oct 2018 submission
interval.tex.8287422c02.oldfile: ## Dec co-authors #1
compare.pdf: interval.tex

Ignore += compare.tex
compare.tex: interval.tex.* interval.tex
	latexdiff $^ > $@

## This should not be necessary, but don't waste Daniel's time!
Generation_distributions/%:
	cd Generation_distributions && $(MAKE) $*

######################################################################

Ignore += *.eps elsevier.tgz
elsevier.tgz: interval.tex appendix.tex interval.bbl
	tar czf $@ $^

fig1.eps: link_calculations/steps.pdf
fig2.eps: link_calculations/genExp.pdf
fig3.eps: link_calculations/ebola.pdf Makefile
fig4.eps: link_calculations/measles.pdf Makefile
fig5.eps: link_calculations/rabies.pdf
figS1.eps: link_calculations/ebola_gamma.pdf
figS2.eps: link_calculations/ebola_normal.pdf
figS3.eps: link_calculations/ebola_sample.pdf

%.eps:
 

%.othereps:
	inkscape $< --export-eps=$@
	pdftops -level3 -eps -origpagesizes $< $@
	gs -q -dNOCACHE -dNOPAUSE -dBATCH -dSAFER -sDEVICE=eps2write -sOutputFile=$@ $<
	convert $< $@ ## Weird error?


######################################################################

## Refs

perl = $(wildcard *.pl)
Sources += $(perl)
Ignore += $(perl:.pl=.out)

Sources += manual.bib auto.rmu

Ignore += refs.bib
refs.bib: manual.bib manbib.pl auto.bib autbib.pl
	perl -wf manbib.pl manual.bib > $@
	perl -wf autbib.pl auto.bib >> $@

Ignore += auto.html
auto.html: auto.rmu
auto.bib: auto.rmu

nish.html: nish.rmu

interval.bbl: auto.rmu

######################################################################
## New refs

## Very little progress, but some promise 2018 Dec 13 (Thu)

## Started from from https://www.ncbi.nlm.nih.gov/books/NBK25498/
refs.out: refs.pl
	$(PUSH)

## https://metacpan.org/pod/BibTeX::Parser
bib.out: manual.bib bib.pl
	$(PUSH)

######################################################################

# Modules
## HOT
## Need to think about constructing modules from makestuff
## also stuff about hotdirs and colddirs, and what-all else

mdirs += Generation_distributions link_calculations
# mdirs += Generation_distributions autorefs


## Deprecated
hotdirs += $(mdirs)
-include $(ms)/modules.mk

######################################################################

Drop = ~/Dropbox

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/texdeps.mk
-include $(ms)/hybrid.mk
-include $(ms)/autorefs.mk
-include $(ms)/pandoc.mk

######################################################################

# -include $(ms)/wrapR.mk
