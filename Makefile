# generation_links
# http://dushoff.github.io/generation_links/

### Hooks for the editor to set the default target
current: target
target = Makefile
-include target.mk
target: $(target)

##################################################################

Sources = Makefile .gitignore README.md sub.mk LICENSE.md
include sub.mk
# include $(ms)/perl.def

##################################################################

## Content

products: interval.pdf.gp auto.html.pages

## MS
Sources += interval.tex
interval.pdf: interval.tex

## Refs

Sources += manual.bib auto.rmu
refs.bib: auto.bib manual.bib
	$(cat)

auto.html: auto.rmu

interval.bbl: auto.rmu

######################################################################

## Ref machinery

export autorefs = autorefs
-include autorefs/inc.mk
-include $(ms)/pandoc.mk

######################################################################

# Modules

dirs += Generation_distributions autorefs

dfiles: $(dirs:%=%/Makefile)
Sources += $(dirs) $(ms)

-include $(ms)/modules.mk

######################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/flextex.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
