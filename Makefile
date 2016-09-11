include buildconfig

rwildcard=$(wildcard $1$2)$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

all: $(BUILDDIR)$(PACKAGENAME).tar.gz

$(BUILDDIR)$(PACKAGENAME).tar.gz: $(BUILDDIR)$(PACKAGENAME).tar
	gzip -kvf9 $<

$(BUILDDIR)$(PACKAGENAME).tar: $(BUILDDIR)files.tar $(BUILDDIR)acptemplates.tar *.xml LICENSE language/*.xml
	tar cvf $@ --numeric-owner --exclude-vcs --transform='s,$(BUILDDIR),,' -- $^

$(BUILDDIR)files.tar: $(call rwildcard,files/,*.*)
	tar cvf $@ --exclude-vcs --transform='s,^[^/]*/,,' --show-transformed-names -- $^

$(BUILDDIR)%.tar: %/*
	tar cvf $@ --exclude-vcs --transform='s,^[^/]*/,,' --show-transformed-names -- $^

clean:
	-rm -f $(BUILDDIR)files.tar
	-rm -f $(BUILDDIR)acptemplates.tar

distclean: clean
	-rm -f $(BUILDDIR)$(PACKAGENAME).tar
	-rm -f $(BUILDDIR)$(PACKAGENAME).tar.gz

.PHONY: all distclean clean
