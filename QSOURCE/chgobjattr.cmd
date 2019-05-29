             CMD        PROMPT('Change Object Attributes')

             PARM       KWD(OBJ) TYPE(QUAL1) RSTD(*NO) MIN(1) MAX(1) +
                          PROMPT('Object')

             PARM       KWD(OBJTYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          VALUES(*ALRTBL *AUTL *BNDDIR *CFGL *CHTFMT *CLD +
                          *CLS *CMD *CNNL *COSD *CRG *CRQD *CSI *CSPMAP +
                          *CSPTBL *CTLD *DEVD *DTAARA *DTADCT *DTAQ *EDTD +
                          *EXITRG *FCT *FILE *FNTRSC *FNTTBL *FORMDF *FTR +
                          *GSS *IGCDCT *IGCSRT *IGCTBL *IMGCLG *IPXD *JOBD +
                          *JOBQ *JOBSCD *JRN *JRNRCV *LIB *LIND *LOCALE +
                          *MEDDFN *MENU *MGTCOL *MODD *MODULE *MSGF *MSGQ +
                          *M36 *M36CFG *NODGRP *NODL *NTBD *NWID *NWSCFG +
                          *NWSD *OUTQ *OVL *PAGDFN *PAGSEG *PDFMAP *PDG +
                          *PGM *PNLGRP *PRDAVL *PRDDFN *PRDLOD *PSFCFG +
                          *QMFORM *QMQRY *QRYDFN *RCT *SBSD *SCHIDX +
                          *SPADCT *SQLPKG *SQLUDT *SQLXSR *SRVPGM *SSND +
                          *SVRSTG *S36 *TBL *TIMZON *USRIDX *USRPRF *USRQ +
                          *USRSPC *VLDL *WSCST) PROMPT('Object type')

             PARM       KWD(TEXT) TYPE(*CHAR) LEN(50) DFT(*SAME) +
                          SPCVAL((*SAME *SAME)) PROMPT('Text +
                          ''description''')

             PARM       KWD(SRCFILE) TYPE(QUAL2) RSTD(*NO) PROMPT('Source +
                          file')

             PARM       KWD(SRCMBR) TYPE(*NAME) RSTD(*NO) DFT(*SAME) +
                          SPCVAL((*SAME *SAME)) PROMPT('Source member')

             PARM       KWD(SRCDATE) TYPE(*DATE) RSTD(*NO) DFT(*SAME) +
                          SPCVAL((*SAME 0000000)) PROMPT('Source change +
                          date')

             PARM       KWD(SRCTIME) TYPE(*TIME) RSTD(*NO) DFT(*SAME) +
                          SPCVAL((*SAME 000000)) PROMPT('Source change +
                          time')

 QUAL1:      QUAL       TYPE(*NAME) LEN(10) RSTD(*NO) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) RSTD(*NO) DFT(*LIBL) +
                          SPCVAL((*LIBL *LIBL)) MIN(0) PROMPT('Library')

 QUAL2:      QUAL       TYPE(*NAME) LEN(10) RSTD(*NO) DFT(*SAME) +
                          SPCVAL((*SAME *SAME)) MIN(0)
             QUAL       TYPE(*NAME) LEN(10) RSTD(*NO) DFT(*SAME) +
                          SPCVAL((*SAME *SAME)) MIN(0) PROMPT('Library')

