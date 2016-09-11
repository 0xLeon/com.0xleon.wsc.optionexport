rwildcard=$(wildcard $1$2)$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

all: com.0xleon.wsc.optionexport.tar

com.0xleon.wsc.optionexport.tar: files.tar acptemplates.tar *.xml LICENSE language/*.xml
	tar cvf com.0xleon.wsc.optionexport.tar --numeric-owner --exclude-vcs  -- files.tar acptemplates.tar *.xml LICENSE language/*.xml

files.tar: $(call rwildcard,files/,*.*)
	tar cvf files.tar --exclude-vcs --transform='s,files/,,' -- files/*

acptemplates.tar: acptemplates/*.tpl
	tar cvf acptemplates.tar --exclude-vcs --transform='s,acptemplates/,,' -- acptemplates/*

clean:
	-rm -f files.tar
	-rm -f acptemplates.tar

distclean: clean
	-rm -f com.0xleon.wsc.optionexport.tar

.PHONY: distclean clean
