rwildcard=$(wildcard $1$2)$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

all: build/com.0xleon.wsc.optionexport.tar.gz

build/com.0xleon.wsc.optionexport.tar.gz: build/com.0xleon.wsc.optionexport.tar
	gzip -kv9 build/com.0xleon.wsc.optionexport.tar

build/com.0xleon.wsc.optionexport.tar: build/files.tar build/acptemplates.tar *.xml LICENSE language/*.xml
	tar cvf build/com.0xleon.wsc.optionexport.tar --numeric-owner --exclude-vcs --transform='s,build/,,' -- build/files.tar build/acptemplates.tar *.xml LICENSE language/*.xml

build/files.tar: $(call rwildcard,files/,*.*)
	tar cvf build/files.tar --exclude-vcs --transform='s,files/,,' -- files/*

build/acptemplates.tar: acptemplates/*.tpl
	tar cvf build/acptemplates.tar --exclude-vcs --transform='s,acptemplates/,,' -- acptemplates/*

clean:
	-rm -f build/files.tar
	-rm -f build/acptemplates.tar

distclean: clean
	-rm -f build/com.0xleon.wsc.optionexport.tar
	-rm -f build/com.0xleon.wsc.optionexport.tar.gz

.PHONY: distclean clean
