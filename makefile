NAME=Change Object Attributes
BIN_LIB=CHGOBJATTR
DBGVIEW=*SOURCE
TGTRLS=V7R1M0

#----------

all: CHGOBJATTR.cmd CHGOBJATTR.rpgle
	@echo "Built all"

#----------

%.cmd:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QCMDSRC) MBR($*) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('QSOURCE/$*.cmd') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QCMDSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QCMDSRC) SRCMBR($*) TEXT('$(NAME)')"
	-system -qi "DLTF FILE($(BIN_LIB)/QCMDSRC)"
	
%.rpgle:
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('QSOURCE/$*.rpgle') TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TGTRLS($(TGTRLS))"
	
clean:
	system "CLRLIB $(BIN_LIB)"