       IDENTIFICATION DIVISION.
       PROGRAM-ID.    TOPACCTS.
       AUTHOR.        STUDENT.
      *
       ENVIRONMENT DIVISION.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRT-CUSTRECS  ASSIGN TO CUSTRECS.
           SELECT PRT-TOPACCTS  ASSIGN TO TOPACCTS.

       DATA DIVISION.
       FILE SECTION.
       FD  PRT-CUSTRECS RECORD CONTAINS 80 CHARACTERS RECORDING MODE F.
       01  PRT-CUST-REC.
           05  PRT-FIRST-NAME     PIC X(10)  VALUE SPACES.
           05  FILLER             PIC X(1)   VALUE SPACES.
           05  PRT-LAST-NAME      PIC X(21)  VALUE SPACES.
           05  FILLER             PIC X(29)  VALUE SPACES.
           05  PRT-BALANCE        PIC X(12)  VALUE SPACES.
           05  FILLER             PIC X(7)   VALUE SPACES.

       FD  PRT-TOPACCTS RECORD CONTAINS 80 CHARACTERS RECORDING MODE F.
       01  PRT-LINE-DONE          PIC X(80)  VALUE SPACES.
       01  PRT-REC-DONE.
           05 PRT-FN-DONE         PIC X(10)  VALUE SPACES.
           05 FILLER              PIC X(1)   VALUE SPACES.
           05 PRT-LN-DONE         PIC X(21)  VALUE SPACES.
           05 FILLER              PIC X(1)   VALUE SPACES.
           05 PRT-BALANCE-DONE    PIC X(12)  VALUE SPACES.
           05 FILLER              PIC X(35)  VALUE SPACES.


       WORKING-STORAGE SECTION.
       01  WRK-END-OF-FILE             PIC 9(1) VALUE ZEROS.
           88 WRK-EOF                  VALUE 1.
       77  WRK-BALANCE                 PIC 9(7).99.
       01  WRK-DATE.
           02 WRK-YEAR                 PIC 9(4).
           02 WRK-MONTH                PIC 9(2).
           02 WRK-DAY                  PIC 9(2).
       77  WRK-NAME-DATE               PIC X(40) VALUE SPACES.
       77  WRK-COUNT-ACC               PIC 9(4).
       77  WRK-COUNT-DONE              PIC Z(4).
       77  WRK-COUNT-FOOTER            PIC X(25) VALUE SPACES.


      ****************************************************************
      *                  PROCEDURE DIVISION                          *
      ****************************************************************
       PROCEDURE DIVISION.
      *
       A000-START.
           OPEN INPUT PRT-CUSTRECS.
           OPEN OUTPUT PRT-TOPACCTS.

           PERFORM A000-HEADER.
           PERFORM A000-READ UNTIL WRK-EOF.
           PERFORM A000-FOOTER.

           CLOSE PRT-CUSTRECS.
           CLOSE PRT-TOPACCTS.
           STOP RUN.
      *
       A000-HEADER.
           MOVE 'REPORT OF TOP ACCOUNT BALANCE HOLDERS'
            TO PRT-LINE-DONE.
           WRITE PRT-LINE-DONE.

           ACCEPT WRK-DATE FROM DATE YYYYMMDD.

           STRING 'PREPARED FOR LUCAS LOPES ON' SPACE WRK-MONTH '.'
            WRK-DAY '.' WRK-YEAR
            DELIMITED BY SIZE
            INTO WRK-NAME-DATE.

           MOVE WRK-NAME-DATE TO PRT-LINE-DONE.
           WRITE PRT-LINE-DONE.

           MOVE '======================================================'
            TO PRT-LINE-DONE.
           WRITE PRT-LINE-DONE.
      *
       A000-READ.
           READ PRT-CUSTRECS AT END MOVE 1 TO WRK-END-OF-FILE.

           MOVE SPACES TO PRT-REC-DONE.

           COMPUTE WRK-BALANCE = FUNCTION NUMVAL-C (PRT-BALANCE).

           IF WRK-BALANCE IS > 8500000

              ADD 1 TO WRK-COUNT-ACC

              MOVE PRT-FIRST-NAME  TO PRT-FN-DONE
              MOVE PRT-LAST-NAME   TO PRT-LN-DONE
              MOVE PRT-BALANCE     TO PRT-BALANCE-DONE

              WRITE PRT-REC-DONE

           END-IF.
      *
       A000-FOOTER.
           MOVE '------------------------------------------------------'
            TO PRT-LINE-DONE.
           WRITE PRT-LINE-DONE.

           MOVE WRK-COUNT-ACC TO WRK-COUNT-DONE.

           STRING '# OF RECORDS:' SPACE WRK-COUNT-DONE
            DELIMITED BY SIZE
            INTO WRK-COUNT-FOOTER.

           MOVE WRK-COUNT-FOOTER TO PRT-LINE-DONE.

           WRITE PRT-LINE-DONE.
