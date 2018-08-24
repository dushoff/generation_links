# generation_links
# This is a working repo, not yet converted in any way for the hybrid paradigm
# It has the first generation links paper

### Hooks for the editor to set the default target
current: target
-include target.mk
target: $(target)

##################################################################

Sources = Makefile .gitignore .ignore README.md sub.mk LICENSE.md
include sub.mk
include $(ms)/perl.def

## Why is this here? Where should it be?
-include $(ms)/repos.def

##################################################################

## Content

Sources += todo.mkd

## https://dushoff.github.io/generation_links/auto.html
products: interval.pdf.gp auto.html.pages

Ignore += abstract.txt
abstract.txt: interval.tex abstract.pl
	$(PUSH)

Ignore += *synctex*

## MS
Ignore += pages
Sources += interval.tex appendix.tex appwrap.tex
interval.pdf: interval.tex
interval.deps:

interval.count: interval.tex
	texcount $< > $@

Ignore += park_main.pdf park_supp_text.pdf
park_main.pdf: interval.pdf
	pdfjam -o $@ $< 1-18

park_supp_text.pdf: interval.pdf
	pdfjam -o $@ $< 19-

## cover leter
Sources += letter.txt
Sources += reviewers.txt

## letter.pdf: letter.tex ## This is in JD correspondence

## appendix.pdf is no longer a thing … rolled it into the MS
## appwrap.tex contains most of the stuff trimmed from appendix; in case we need to make it stand alone someday
## appendix.pdf: appendix.tex

interval.tex.899946.oldfile:
## make interval.tex.HEAD~1.oldfile ##
compare.pdf: compare.tex

Ignore += compare.tex
compare.tex: interval.tex.* interval.tex makestuff/latexdiff.pl
	$(PUSH)

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
