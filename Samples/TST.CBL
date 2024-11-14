
      ****************************************************************  00060000
      *                  PROGRAM DESCRIPTION                            00070000
      *-----------------------------------------------------------------00070100
      * THIS PROGRAM ATTACHES THE CHAIN INFO (BASED ON THE GROUP BUY    00070200
      * CUSTOMER NUMBER) AND MASTER INFO FOR MATCHING DOWN THE ROAD...  00070300
      ****************************************************************  00070400
                                                                        00070500
      ****************************************************************  00070600
      *                  RE-RUN INSTRUCTIONS                            00070700
      *-----------------------------------------------------------------00070800
      *   THIS PROGRAM DOES NOT UPDATE.                                 00070900
      ****************************************************************  00071000
                                                                        00072000
      ****************************************************************  00073000
      *               FILES AND TABLES USED                             00074000
      *-----------------------------------------------------------------00075000
      *  INPUT:   FILES: WORKIN   FLAT WORKIN FILE                      00076000
      *                  MASTER                                         00076100
      *          TABLES: CCR                                            00076200
      *                  CHN                                            00076300
      * OUTPUT:   FILES: WORKOUT  FLAT WORKIN WITH CHN INFO             00076400
      ****************************************************************  00076500
                                                                        00076600
      ****************************************************************  00076700
      *               MODIFICATIONS                                     00076800
      *-----------------------------------------------------------------00076900
      *   DATE  | INITS |               COMMENTS                        00077000
      *-----------------------------------------------------------------00078000
      * 03/16/11|TJS    | CREATED                                       00079000
      * 03/30/11|TJS    | GET DEST AND GL FROM MASTER AND PASS IN THE   00080000
      *         |       | WORKOUT FILE.                                 00090000
      * 10/23/12|SCOT   | ADDED DEBUG MESSAGES FOR T20120823.0092       00091000
      *         |       | FOR MISSING RECORDS ON THE OUTS REPORT        00092000
      ****************************************************************  00100000
                                                                        00110000
       ENVIRONMENT DIVISION.                                            00120000
                                                                        00130000
       INPUT-OUTPUT SECTION.                                            00140000
                                                                        00150000
       FILE-CONTROL.                                                    00160000
                                                                        00170000
           SELECT WORKIN                                                00180000
              ASSIGN       TO WORKIN                                    00190000
              FILE STATUS  IS FILEIO-WORKIN-STATUS.                     00200000
                                                                        00210000
           SELECT MASTER                                                00220000
              ASSIGN          MASTER                                    00230000
              ORGANIZATION    INDEXED                                   00240000
              ACCESS MODE     SEQUENTIAL                                00250000
              RECORD KEY      CODE-IN-M                                 00260000
              FILE STATUS     FILEIO-MASTER-STATUS.                     00270000
                                                                        00280000
           SELECT WORKOUT                                               00290000
              ASSIGN       TO WORKOUT                                   00300000
              FILE STATUS  IS FILEIO-WORKOUT-STATUS.                    00310000
                                                                        00311000
       DATA DIVISION.                                                   00312000
                                                                        00313000
       FILE SECTION.                                                    00314000
                                                                        00315000
       FD  WORKIN.                                                      00316000
       COPY GROUPIIF REPLACING F-GROUP-BUY-RECORD BY WORKIN-RECORD.     00317000
                                                                        00318000
       FD  MASTER.                                                      00319000
       COPY MASTREC.                                                    00320000
                                                                        00330000
       FD  WORKOUT                                                      00340000
           BLOCK 0.                                                     00350000
       01  WORKOUT-RECORD.                                              00360000
           05 WORKOUT-GROUPII-REC        PIC  X(300).                   00370000
           05 WORKOUT-GROUPII-START-CYMD PIC S9(08) COMP-3.             00380000
           05 WORKOUT-GROUPII-START-INT  PIC S9(07) COMP-3.             00390000
           05 WORKOUT-GROUPII-END-CYMD   PIC S9(08) COMP-3.             00400000
           05 WORKOUT-GROUPII-END-INT    PIC S9(07) COMP-3.             00410000
           05 WORKOUT-GROUPII-AD-LEN     PIC S9(05) COMP-3.             00420000
           05 WORKOUT-CHN-CHAIN-NUMBER   PIC S9(05) COMP-3.             00430000
           05 WORKOUT-CHN-SHORT-NAME     PIC  X(03).                    00440000
           05 WORKOUT-MASTER-DEST        PIC  9(4).                     00450000
           05 WORKOUT-MASTER-GL          PIC  9(4).                     00460000
                                                                        00470000
      ***************************************************************** 00480000
                                                                        00490000
       WORKING-STORAGE SECTION.                                         00500000
                                                                        00510000
       01  WS-HOLD-FIELDS.                                              00520000
           05 WS-HOLD-CHN-NMBR              PIC 9(5).                   00530000
           05 WS-HOLD-CHN-NAME              PIC X(03).                  00540000
           05 WS-START-DATE-CYMD            PIC S9(8).                  00550000
           05 WS-START-DATE-INT             PIC S9(7).                  00560000
           05 WS-END-DATE-CYMD              PIC S9(8).                  00570000
           05 WS-END-DATE-INT               PIC S9(7).                  00580000
           05 WS-AD-LENGTH                  PIC S9(7).                  00590000
                                                                        00600000
       01  WS-TABLES.                                                   00610000
           05 WS-CUST-TO-CHAIN.                                         00620000
              10 WS-CUST            PIC 9(7) COMP-3.                    00630000
              10 WS-CUSTOMER-CHAIN  PIC 9(3) COMP-3                     00640000
                                    OCCURS 100000 TIMES.                00650000
           05 WS-CHAIN-INFO.                                            00660000
              10 WS-CHAIN-SHORT-NAME  PIC X(3)                          00670000
                                      OCCURS 1000 TIMES.                00680000
                                                                        00690000
       COPY DATECHKW.                                                   00700000
                                                                        00710000
       COPY FILEIOW REPLACING ==:FILENAME:== BY ==WORKIN==              00720000
                                'FILENAME'   BY  'WORKIN'.              00730000
                                                                        00740000
       COPY FILEIOW REPLACING ==:FILENAME:== BY ==MASTER==              00750000
                                'FILENAME'   BY  'MASTER'.              00760000
                                                                        00770000
       COPY FILEIOW REPLACING ==:FILENAME:== BY ==WORKOUT==             00780000
                                'FILENAME'   BY  'WORKOUT'.             00790000
                                                                        00800000
       COPY DCCR112A.                                                   00810000
       COPY DCCRREQ  REPLACING ==:TAG:== BY ==R1==.                     00820000
                                                                        00830000
       COPY DBCHN01.                                                    00840000
       COPY DCHNREQ  REPLACING ==:TAG:== BY ==R1==.                     00850000
                                                                        00860000
       COPY DBIOW.                                                      00870000
                                                                        00880000
      ***************************************************************** 00890000
                                                                        00900000
       PROCEDURE DIVISION.                                              00910000
                                                                        00920000
           ENTRY 'DBMSCBL'                                              00930000
                                                                        00940000
           PERFORM 10000-INITIALIZATION                                 00950000
                                                                        00960000
           PERFORM 20000-PROCESS-WORKIN                                 00970000
                                                                        00980000
           PERFORM 30000-TERMINATION                                    00990000
                                                                        01000000
           GOBACK                                                       01010000
                                                                        01020000
           CONTINUE.                                                    01030000
                                                                        01040000
      ****************************************************************  01050000
                                                                        01060000
       10000-INITIALIZATION.                                            01070000
                                                                        01080000
           PERFORM FILEIO-WORKIN-SET-DEFAULTS                           01090000
           PERFORM FILEIO-MASTER-SET-DEFAULTS                           01091000
           PERFORM FILEIO-WORKOUT-SET-DEFAULTS                          01092000
                                                                        01093000
           PERFORM FILEIO-WORKIN-OPEN-INPUT                             01094000
           PERFORM FILEIO-MASTER-OPEN-INPUT                             01095000
           PERFORM FILEIO-WORKOUT-OPEN-OUTPUT                           01096000
                                                                        01097000
           INITIALIZE WS-TABLES                                         01098000
                                                                        01099000
           MOVE 'CBS121A' TO DBIO-USER-IDENTIFICATION                   01100000
                                                                        01110000
           PERFORM 14000-LOAD-CUST-TO-CHAIN-TBL                         01120000
           PERFORM 15000-LOAD-CHN-SHORT-NAME-TBL                        01130000
                                                                        01140000
           CONTINUE.                                                    01150000
                                                                        01160000
      ****************************************************************  01170000
      *  SET CUSTOMER TO CHAIN CONVERSTION TABLE BASED ON CCR           01180000
      ****************************************************************  01190000
                                                                        01200000
       14000-LOAD-CUST-TO-CHAIN-TBL.                                    01210000
                                                                        01220000
           MOVE 'CCR1L'              TO DBIO-ELEMENT                    01230000
           MOVE LOW-VALUES           TO R1-CCR-START-KEY                01240000
                                                                        01250000
           PERFORM DBIO-CCR-R1-GSETP                                    01260000
                                                                        01270000
           PERFORM UNTIL R1-CCR-RETURN-CODE NOT = SPACES                01280000
              PERFORM DBIO-CCR-R1-GETPS                                 01290000
              IF R1-CCR-RETURN-CODE = SPACES                            01300000
                 IF WCCR-BEGIN-RANGE < 1                                01310000
                    MOVE 1 TO WCCR-BEGIN-RANGE                          01320000
                 END-IF                                                 01330000
                 PERFORM VARYING WS-CUST FROM WCCR-BEGIN-RANGE BY 1     01340000
                       UNTIL WS-CUST > WCCR-END-RANGE                   01350000
                    MOVE WCCR-CHAIN-NUMBER TO WS-CUSTOMER-CHAIN(WS-CUST)01360000
                 END-PERFORM                                            01370000
              END-IF                                                    01380000
           END-PERFORM                                                  01390000
                                                                        01400000
           IF R1-CCR-RETURN-CODE NOT = '19'                             01410000
              CALL 'CSDBER' USING R1-REQUEST-AREA-CCR                   01420000
              CALL 'CANCEL'                                             01430000
           END-IF                                                       01440000
                                                                        01450000
           CONTINUE.                                                    01460000
                                                                        01470000
      ****************************************************************  01480000
      *  SET CHAIN SHORT NAME TABLE BASED ON CHN                        01490000
      ****************************************************************  01500000
                                                                        01510000
       15000-LOAD-CHN-SHORT-NAME-TBL.                                   01520000
                                                                        01530000
           MOVE 'CHN1L'    TO DBIO-ELEMENT                              01540000
           MOVE LOW-VALUES TO R1-CHN-START-KEY                          01550000
                                                                        01560000
           PERFORM DBIO-CHN-R1-GSETP                                    01570000
                                                                        01580000
           PERFORM UNTIL R1-CHN-RETURN-CODE NOT = SPACES                01590000
              PERFORM DBIO-CHN-R1-GETPS                                 01600000
              IF R1-CHN-RETURN-CODE = SPACES                            01610000
                 IF WCHN-CHAIN-NUMBER > 0                               01620000
                    MOVE WCHN-CHAIN-SHORT-NAME TO                       01630000
                                  WS-CHAIN-SHORT-NAME(WCHN-CHAIN-NUMBER)01640000
                 END-IF                                                 01650000
              END-IF                                                    01660000
           END-PERFORM                                                  01670000
                                                                        01680000
           IF R1-CHN-RETURN-CODE NOT = '19'                             01690000
              CALL 'CSDBER' USING R1-REQUEST-AREA-CHN                   01700000
              CALL 'CANCEL'                                             01710000
           END-IF                                                       01720000
                                                                        01730000
           CONTINUE.                                                    01740000
                                                                        01750000
      ****************************************************************  01760000
      * MAIN PROCESS LOOP                                               01770000
      ****************************************************************  01780000
                                                                        01790000
       20000-PROCESS-WORKIN.                                            01800000
           PERFORM FILEIO-MASTER-SEQ-READ                               01810000
           PERFORM UNTIL FILEIO-WORKIN-EOF                              01820000
              PERFORM FILEIO-WORKIN-SEQ-READ                            01830000
              IF FILEIO-WORKIN-OKAY                                     01840000
                 PERFORM FILEIO-MASTER-SEQ-READ                         01850000
                    UNTIL F-GBK-ITEM-CODE <= CODE-IN-M                  01860000
                       OR FILEIO-MASTER-EOF                             01870000
                 IF F-GBK-CUST-NO = 0                                   01880000
                    MOVE ZEROS  TO WS-HOLD-CHN-NMBR                     01890000
                    MOVE SPACES TO WS-HOLD-CHN-NAME                     01900000
                 ELSE                                                   01910000
                    MOVE WS-CUSTOMER-CHAIN(F-GBK-CUST-NO) TO            01920000
                                                       WS-HOLD-CHN-NMBR 01930000
                    IF WS-HOLD-CHN-NMBR > 0                             01940000
                       MOVE WS-CHAIN-SHORT-NAME(WS-HOLD-CHN-NMBR) TO    01950000
                                                        WS-HOLD-CHN-NAME01960000
                    ELSE                                                01970000
                       MOVE SPACES TO WS-HOLD-CHN-NAME                  01980000
                    END-IF                                              01990000
                 END-IF                                                 02000000
                 IF (F-GBD-RECAP-FLAG = 'A' OR 'B' OR 'D' OR 'F' OR     02010000
                                        'P' OR 'M' OR 'S' OR 'T')       02020000
                    PERFORM 21000-COMPUTE-AD-LENGTH                     02030000
                    MOVE WORKIN-RECORD    TO WORKOUT-RECORD             02040000
                    MOVE WS-START-DATE-CYMD TO                          02050000
                                             WORKOUT-GROUPII-START-CYMD 02060000
                    MOVE WS-START-DATE-INT  TO                          02070000
                                             WORKOUT-GROUPII-START-INT  02080000
                    MOVE WS-END-DATE-CYMD TO WORKOUT-GROUPII-END-CYMD   02090000
                    MOVE WS-END-DATE-INT  TO WORKOUT-GROUPII-END-INT    02100000
                    MOVE WS-AD-LENGTH     TO WORKOUT-GROUPII-AD-LEN     02110000
                    MOVE WS-HOLD-CHN-NMBR TO WORKOUT-CHN-CHAIN-NUMBER   02120000
                    MOVE WS-HOLD-CHN-NAME TO WORKOUT-CHN-SHORT-NAME     02130000
                    IF F-GBK-ITEM-CODE = CODE-IN-M                      02140000
                       MOVE DESTINATION-IN-M TO WORKOUT-MASTER-DEST     02150000
                       MOVE GL-IN-M          TO WORKOUT-MASTER-GL       02160000
                    ELSE                                                02170000
                       MOVE ZEROS            TO WORKOUT-MASTER-DEST     02171000
                                                WORKOUT-MASTER-GL       02171100
                    END-IF                                              02171200
                    PERFORM FILEIO-WORKOUT-WRITE                        02171300
102312           ELSE                                                   02171400
102312              DISPLAY 'RECORD SKIPPED BECAUSE F-GBD-RECAP-FLAG: ' 02171500
102312                       F-GBD-RECAP-FLAG                           02171600
102312                       ' | ' F-GBK-ITEM-CODE                      02171700
102312                       ' | ' F-GBK-CUST-NO                        02171800
102312                       ' | ' F-GBK-SEQ-NO                         02171900
                 END-IF                                                 02172900
              END-IF                                                    02173000
           END-PERFORM                                                  02173100
                                                                        02173200
           CONTINUE.                                                    02173300
                                                                        02173400
      ****************************************************************  02173500
                                                                        02173600
       21000-COMPUTE-AD-LENGTH.                                         02174000
                                                                        02175000
           MOVE ZEROS TO WS-START-DATE-CYMD                             02176000
                         WS-START-DATE-INT                              02177000
                         WS-END-DATE-CYMD                               02178000
                         WS-END-DATE-INT                                02179000
                                                                        02180000
           IF F-GB-START-DATE > 0                                       02190000
              MOVE F-GB-START-DATE      TO DATECHK-DATE-MDY             02200000
              PERFORM DATECHK-VALIDATE-MDY                              02210000
              IF DATECHK-VALID                                          02220000
                 MOVE DATECHK-DATE-CYMD TO WS-START-DATE-CYMD           02230000
                 COMPUTE WS-START-DATE-INT =                            02240000
                      FUNCTION INTEGER-OF-DATE (WS-START-DATE-CYMD)     02250000
              END-IF                                                    02260000
           END-IF                                                       02270000
                                                                        02280000
           IF F-GB-END-DATE > 0                                         02290000
              MOVE F-GB-END-DATE        TO DATECHK-DATE-MDY             02300000
              PERFORM DATECHK-VALIDATE-MDY                              02310000
              IF DATECHK-VALID                                          02320000
                 MOVE DATECHK-DATE-CYMD TO WS-END-DATE-CYMD             02330000
                 COMPUTE WS-END-DATE-INT =                              02340000
                      FUNCTION INTEGER-OF-DATE (WS-END-DATE-CYMD)       02350000
              END-IF                                                    02360000
           END-IF                                                       02370000
                                                                        02380000
           COMPUTE WS-AD-LENGTH = WS-END-DATE-INT - WS-START-DATE-INT   02390000
                                + 1                                     02400000
                                                                        02410000
           IF WS-AD-LENGTH > 1000                                       02420000
              MOVE 1000 TO WS-AD-LENGTH                                 02430000
           END-IF                                                       02440000
                                                                        02450000
           CONTINUE.                                                    02460000
                                                                        02470000
      ****************************************************************  02480000
                                                                        02490000
       30000-TERMINATION.                                               02500000
                                                                        02510000
           PERFORM FILEIO-WORKIN-CLOSE                                  02520000
           PERFORM FILEIO-MASTER-CLOSE                                  02530000
           PERFORM FILEIO-WORKOUT-CLOSE                                 02540000
                                                                        02550000
           CONTINUE.                                                    02560000
                                                                        02570000
      ***************************************************************** 02580000
                                                                        02590000
       COPY FILEIOPS REPLACING ==:FILENAME:== BY ==WORKIN==.            02600000
                                                                        02610000
       COPY FILEIOPS REPLACING ==:FILENAME:== BY ==MASTER==.            02620000
                                                                        02630000
       COPY FILEIOPS REPLACING ==:FILENAME:== BY ==WORKOUT==.           02640000
                                                                        02650000
       COPY DBIOP REPLACING ==:REQ:== BY ==R1==                         02660000
                            ==:TBL:== BY ==CHN==.                       02670000
                                                                        02680000
       COPY DBIOP REPLACING ==:REQ:== BY ==R1==                         02690000
                            ==:TBL:== BY ==CCR==.                       02700000
                                                                        02710000
       COPY DATECHKP.                                                   02720000
                                                                        02730000
