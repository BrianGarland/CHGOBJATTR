NAME=Change Object Attributes
BIN_LIB=CHGOBJATTR
DBGVIEW=*SOURCE
TGTRLS=V7R1M0

#----------

all: chgobjattr.rpgle chgobjattr.cmd
	@echo "Built all"

#----------

%.rpgle:
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('QSOURCE/$*.rpgle') TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TGTRLS($(TGTRLS))"
	
%.cmd:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QCMDSRC) MBR($*) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('QSOURCE/$*.cmd') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QCMDSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QCMDSRC) SRCMBR($*) TEXT('$(NAME)')"
	-system -qi "DLTF FILE($(BIN_LIB)/QCMDSRC)"
	
clean:
	system "CLRLIB $(BIN_LIB)"