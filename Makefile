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

Sources += $(ms)

$(ms)/%.mk: $(ms)/Makefile
	touch $@

$(ms)/Makefile:
	git submodule init $(ms) 
	git submodule update $(ms) 
	touch $@

##################################################################

## Content

Sources += todo.mkd

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
## Oct 2018 submission
interval.tex.518696.oldfile: 
compare.pdf: compare.tex

Ignore += compare.tex
compare.tex: interval.tex.* interval.tex
	latexdiff $^ > $@

## This should not be necessary, but don't waste Daniel's time!
Generation_distributions/%:
	cd Generation_distributions && $(MAKE) $*

## Refs

Sources += manual.bib auto.rmu
Ignore += refs.bib
refs.bib: auto.bib manual.bib
	$(cat)

Ignore += auto.html
auto.html: auto.rmu
auto.bib: auto.rmu

nish.html: nish.rmu

interval.bbl: auto.rmu

######################################################################

# Modules
## HOT
## Need to think about constructing modules from makestuff
## also stuff about hotdirs and colddirs, and what-all else

mdirs += Generation_distributions link_calculations
# mdirs += Generation_distributions autorefs

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
