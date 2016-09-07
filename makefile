all: com.0xleon.wsc.optionexport.tar

com.0xleon.wsc.optionexport.tar: files.tar acptemplates.tar *.xml language/*.xml
	tar cvf com.0xleon.wsc.optionexport.tar --numeric-owner --exclude com.0xleon.wsc.optionexport.tar --exclude-vcs --exclude=files --exclude=acptemplates --exclude=makefile -- *

files.tar: files/*
	tar cvf files.tar --exclude-vcs --transform='s,files/,,' -- files/*

acptemplates.tar: acptemplates/*.tpl
	tar cvf acptemplates.tar --exclude-vcs --transform='s,acptemplates/,,' -- acptemplates/*

clean:
	-rm -f files.tar
	-rm -f acptemplates.tar

distclean: clean
	-rm -f com.0xleon.wsc.optionexport.tar

.PHONY: distclean clean com.0xleon.wsc.optionexport.tar files.tar acptemplates.tar
