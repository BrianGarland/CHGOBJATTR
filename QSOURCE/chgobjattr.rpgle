**FREE



CTL-OPT DFTACTGRP(*NO) ACTGRP(*NEW) MAIN(main);



// --- Data Structure ---
DCL-DS APIError;
     Provided INT(10) INZ(%SIZE(APIError));
     Avail    INT(10) INZ(0);
     MsgID    CHAR(7) INZ(*BLANKS);
     Reserved CHAR(1) INZ(*BLANKS);
     MsgDta   CHAR(256) INZ(*BLANKS);
END-DS;



// --- Stand Alone Variables ---
DCL-S inSrcFile CHAR(10);
DCL-S inSrcLib  CHAR(10);
DCL-S Library   CHAR(10);
DCL-S Object    CHAR(10);
DCL-S SrcDat    CHAR(7);
DCL-S SrcFile   CHAR(10);
DCL-S SrcLib    CHAR(10);
DCL-S SrcMbr    CHAR(10);
DCL-S SrcTim    CHAR(6);
DCL-S Text      CHAR(50);



// --- Main ---
DCL-PROC main;
    DCL-PI *N EXTPGM;
        qObject    CHAR(20);
        ObjType    CHAR(10);
        inText     CHAR(50);
        inQSrcFile CHAR(20);
        inSrcMbr   CHAR(10);
        inSrcDat   CHAR(7);
        inSrcTim   CHAR(6);
    END-PI;



    *INLR = *ON;

    Object = %SUBST(qObject:01:10);
    Library = %SUBST(qObject:11:10);

    inSrcFile = %SUBST(inQSrcFile:01:10);
    inSrcLib = %SUBST(inQSrcFile:11:10);


    // Get current values
    RtvObjD(Object:Library:ObjType:Text:SrcFile:SrcLib:SrcMbr:
            SrcDat:srcTim);


    // Set new values based on parameters
    IF inText <> '*SAME';
        Text = InText;
    ENDIF;

    IF inSrcFile <> '*SAME';
        SrcFile = InSrcFile;
    ENDIF;

    IF inSrcLib <> '*SAME';
        SrcLib = InSrcLib;
    ENDIF;

    IF inSrcMbr <> '*SAME';
        SrcMbr = InSrcMbr;
    ENDIF;

    IF inSrcDat <> *ZEROS;
        SrcDat = inSrcDat;
    ENDIF;

    IF inSrcTim <> *ZEROS;
        SrcTim = inSrcTim;
    ENDIF;


    // Set the new values on the object and in the table
    SetObjD(Object:Library:ObjType:Text:SrcFile:SrcLib:SrcMbr:
            SrcDat:SrcTim);

    RETURN;

END-PROC;



DCL-PROC RtvObjD;
    DCL-PI *N;
        Object  CHAR(10) CONST;
        Library CHAR(10) CONST;
        ObjType CHAR(10) CONST;
        Text    CHAR(50);
        SrcFile CHAR(10);
        SrcLib  CHAR(10);
        SrcMbr  CHAR(10);
        SrcDat  CHAR(7);
        SrcTim  CHAR(6);
    END-PI;

    DCL-PR QUSROBJD EXTPGM('QUSROBJD');
        Receiver   CHAR(32765) OPTIONS(*VARSIZE);
        Length     INT(10) CONST;
        Format     CHAR(8) CONST;
        qObject    CHAR(20) CONST;
        ObjType    CHAR(10) CONST;
        ErrorCode  CHAR(32765) OPTIONS(*VARSIZE);
    END-PR;

    DCL-DS QUSD0400 QUALIFIED;
        Buffer    CHAR(666);
        Text      CHAR(50) OVERLAY(Buffer:101);
        SrcFile   CHAR(10) OVERLAY(Buffer:151);
        SrcLib    CHAR(10) OVERLAY(Buffer:161);
        SrcMbr    CHAR(10) OVERLAY(Buffer:171);
        SrcDatTim CHAR(13) OVERLAY(Buffer:181);
    END-DS;



    qUsrObjD(QUSD0400:%SIZE(QUSD0400):'OBJD0400':Object+Library:ObjType:APIError);

    Text    = QUSD0400.Text;
    SrcFile = QUSD0400.SrcFile;
    SrcLib  = QUSD0400.SrcLib;
    SrcMbr  = QUSD0400.SrcMbr;
    SrcDat  = %SUBST(QUSD0400.SrcDatTim:1:7);
    SrcTim  = %SUBST(QUSD0400.SrcDatTim:8:6);

    RETURN;

END-PROC;



DCL-PROC SetObjD;
    DCL-PI *N;
        Object  CHAR(10) CONST;
        Library CHAR(10) CONST;
        ObjType CHAR(10) CONST;
        Text    CHAR(50) CONST;
        SrcFile CHAR(10) CONST;
        SrcLib  CHAR(10) CONST;
        SrcMbr  CHAR(10) CONST;
        SrcDat  CHAR(7) CONST;
        SrcTim  CHAR(6) CONST;
    END-PI;


    DCL-PR QLICOBJD EXTPGM('QLICOBJD');
        RtnLib     CHAR(10);
        qObject    CHAR(20) CONST;
        ObjType    CHAR(10) CONST;
        ChangeInfo CHAR(32765) OPTIONS(*VARSIZE);
        ErrorCode  CHAR(32765) OPTIONS(*VARSIZE);
    END-PR;

    DCL-DS Keys;
        NumKeys        INT(10) INZ(3);
        // Text
        TextKey        INT(10) INZ(10);
        TextLen        INT(10) INZ(%SIZE(TextValue));
        TextValue      CHAR(52);
        // Source File
        SrcFileKey     INT(10) INZ(1);
        SrcFileLen     INT(10) INZ(%SIZE(SrcFileValue));
        SrcFileValue   CHAR(32);
        // Source Date & Time
        SrcDatTimKey   INT(10) INZ(2);
        SrcDatTimLen   INT(10) INZ(%SIZE(SrcDatTimValue));
        SrcDatTImValue CHAR(16);
    END-DS;

    DCL-S RtnLib CHAR(10);

    TextValue = Text;
    SrcFileValue = SrcFile + SrcLib + SrcMbr;
    SrcDatTimValue = SrcDat + SrcTim;

    qLicObjD(RtnLib:Object+Library:ObjType:Keys:APIError);

    RETURN;

END-PROC;

