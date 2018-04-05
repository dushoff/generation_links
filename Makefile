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
# include $(ms)/perl.def

## Why is this here? Where should it be?
-include $(ms)/repos.def

##################################################################

## Content

Sources += todo.mkd

## https://dushoff.github.io/generation_links/auto.html
products: interval.pdf.gp auto.html.pages

## MS
Sources += interval.tex appendix.tex appwrap.tex
interval.pdf: interval.tex

## appendix.pdf is no longer a thing … rolled it into the MS
## appwrap.tex contains most of the stuff trimmed from appendix; in case we need to make it stand alone someday
## appendix.pdf: appendix.tex

interval.tex.1f6db5.oldfile:
compare.pdf: compare.tex
compare.tex: interval.tex* makestuff/latexdiff.pl
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

interval.bbl: auto.rmu

######################################################################

## Ref machinery

export autorefs = $(realpath autorefs)
-include autorefs/inc.mk
-include $(ms)/pandoc.mk

######################################################################

## Set up

setup:
	$(MAKE)
	$(MAKE) dfiles
	$(MAKE) interval.pdf
	$(MAKE) interval.pdf.go

######################################################################

# Modules

mdirs += Generation_distributions autorefs link_calculations
# mdirs += Generation_distributions autorefs
dirs += $(mdirs)

dfiles: $(dirs:%=%/Makefile)
Sources += $(dirs) $(ms)

-include $(ms)/modules.mk

######################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/texdeps.mk
-include $(ms)/hybrid.mk

# -include $(ms)/wrapR.mk
