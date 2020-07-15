
      SUBROUTINE DEMAND(DYNAMIC, CONTROL,
     &  AGRLF, AGRRT, AGRSH2, AGRSTM, CROP, DRPP, DXR57,
     &  FILECC, FILEGC, FILEIO, FNINSH, FRACDN, LAGSD,
     &  LNGPEG, NDLEAF, NSTRES, PAR, PCNL, PCNRT, PCNST,
     &  PGAVL, PUNCSD, PUNCTR, PLTPOP, RPROAV, RTWT,
     &  SDDES, SDNO, SDVAR, SHELN, SHVAR, STMWT, SWFAC,
     &  TAVG, TDUMX, TDUMX2, TGRO, TURFAC, VSTAGE, WCRLF,
     &  WCRRT, WCRST, WNRLF, WNRRT, WNRSH, WNRST, WTLF,
     &  WTSD, WTSHE, XPOD, NVEG0, NR1, NR2, NR5, NR7,

     &  AGRSD1, AGRSD2, AGRVG, AGRVG2, CDMREP, F, FNINL,
     &  FNINR, FNINS, FNINSD, FRLF, FRRT, FRSTM, GDMSD,
     &  GRRAT1, NDMNEW,  NDMOLD, NDMREP, NDMSDR, NDMTOT,
     &  NDMVEG, NMINEP, NMOBR, PHTIM, PNTIM, POTCAR,
     &  POTLIP, SDGR, TURADD, XFRT, YREND)

      USE ModuleDefs
      USE ModuleData
      IMPLICIT NONE
      SAVE

      CHARACTER*2 CROP
      CHARACTER*3 TYPSDT
      CHARACTER*6   ERRKEY
      PARAMETER (ERRKEY = 'DEMAND')
      CHARACTER*30 FILEIO
      CHARACTER*78 MSG(2)
      CHARACTER*92 FILECC, FILEGC

      INTEGER DYNAMIC
      INTEGER NPP, I, NAGE, DAS
      INTEGER NDLEAF, NR1, NR2, NR5, NR7, NVEG0, YREND

      REAL FRLFM, FRSTMM, YY, XX, TMPFAC
      REAL REDPUN,TMPFCS,PAGE,REDSHL,SDMAX,CDMSH,GDMSH,ADDSHL
      REAL TEMXFR,CAVTOT,GDMSDO,CNOLD
      REAL NVSTL,NVSTS,NVSTR,FRNLFT
      REAL TABEX,CURV
      REAL POTLIP, POTCAR

      REAL TPHFAC,PARSLA,FFVEG
      REAL GROYES,GAINNW,GAINWT
      REAL SLAVAR, SLAREF, FINREF
      REAL SLAMAX, SLAMIN, THRESH
      REAL AGRSH2, AGRRT, AGRSTM, FRLFF, FRSTMF
      REAL CARMIN, LIPOPT, LIPTB, SLOSUM

      REAL AGRLF, AGRSD1, AGRSD2, AGRVG, AGRVG2,
     &  CDMREP, CDMSD, CDMSDR, CDMTOT,
     &  CDMVEG, DRPP, DUMFAC, DXR57, F,
     &  FNINL, FNINR, FNINS, FNINSD, FNINSH,
     &  FRACDN, FRLF, FRLFMX,
     &  FRRT, FRSTM, FVEG,
     &  GDMSD, GDMSDR,
     &  GROMAX, GRRAT1, LAGSD, LNGPEG, LNGSH,
     &  NDMNEW, NDMOLD, NDMREP,
     &  NDMSD, NDMSDR, NDMSH, NDMTOT, NDMVEG,
     &  NMINEP, NMOBMX, NMOBR, NRCVR, NSTRES,
     &  NVSMOB,
     &  PAR, PCNL, PCNRT, PCNST,
     &  PGAVL, PLIGSD, PLTPOP, PMINSD, POASD,
     &  PROLFF, PROLFI,
     &  PRORTF, PRORTI, PROSTF, PROSTI, RCH2O,
     &  RLIG, RLIP, RMIN, RNO3C,
     &  ROA, RPRO, RPROAV, RTWT, SDGR,
     &  SDLIP, SDPRO, SDVAR, SHLAG, SHVAR,
     &  SIZELF, SIZREF, SLAMN, SLAMX, SLAPAR,
     &  SRMAX, STMWT, SWFAC, TAVG, TDUMX,
     &  SIZRAT, TDUMX2,
     &  TURADD, TURFAC, TURSLA, TURXFR,
     &  VSSINK, VSTAGE, WCRLF, WCRRT, WCRST, WNRLF,
     &  WNRRT, WNRSH, WNRST, WTLF, XFRMAX,
     &  XFRT, XFRUIT, XPOD

      REAL FNSDT(4)
      REAL XVGROW(6), YVGROW(6), YVREF(6)
      REAL XSLATM(10), YSLATM(10), XTRFAC(10), YTRFAC(10),
     &         XXFTEM(10), YXFTEM(10)
      REAL XLEAF(25), YLEAF(25), YSTEM(25)
      REAL TGRO(TS)
      REAL SDDES(NCOHORTS), SDNO(NCOHORTS), SHELN(NCOHORTS) 
      REAL WTSD(NCOHORTS), WTSHE(NCOHORTS)
      REAL PHTIM(NCOHORTS), PNTIM(NCOHORTS)

      REAL TURFSL

 - puncture variables, not functional
      REAL PUNCSD, PUNCTR, RPRPUN

      TYPE (ControlType) CONTROL

      IF (DYNAMIC .EQ. RUNINIT) THEN
      CALL IPDMND(
     &  FILECC, FILEGC, FILEIO,
     &  CARMIN, FINREF, FNSDT, FRLFF, FRLFMX,
     &  FRSTMF, LIPOPT, LIPTB, LNGSH, NMOBMX,
     &  NRCVR, NVSMOB, PLIGSD, PMINSD, POASD,
     &  PROLFF, PROLFI, PRORTF, PRORTI, PROSTF, PROSTI,
     &  RCH2O, RLIG, RLIP, RMIN, RNO3C, ROA,
     &  RPRO, SDLIP, SDPRO, SHLAG, SLAMAX, SLAMIN,
     &  SLAPAR, SLAREF, SLAVAR, SLOSUM, SIZELF, SIZREF,
     &  SRMAX, THRESH, TURSLA, TYPSDT, VSSINK, XFRMAX,
     &  XFRUIT, XLEAF, XSLATM, XTRFAC, XVGROW, XXFTEM,
     &  YLEAF, YSLATM, YSTEM, YTRFAC, YVREF, YXFTEM)

      ELSEIF (DYNAMIC .EQ. SEASINIT) THEN
      CDMSDR = 0.0
      GDMSDR = 0.0
      FNINSD = 0.0
      NDMNEW = 0.0
      NDMREP = 0.0
      NDMSD  = 0.0
      NDMSH  = 0.0
      NDMSDR = 0.0
      NDMVEG = 0.0
      NMOBR  = 0.0
      SDGR   = 0.0
      FNINL  = 0.0
      FNINS  = 0.0
      FNINR  = 0.0
      NMINEP = 0.0

      RPRPUN = 1.0 
      TMPFAC = 1.0

      IF (CROP .NE. 'FA') THEN
        DUMFAC = SLAVAR / SLAREF
        F      = DUMFAC * FINREF
        FVEG   = DUMFAC * SLAMAX
        SLAMN  = DUMFAC * SLAMIN
        SLAMX  = DUMFAC * SLAMAX
        GROMAX = 0.0
        SIZRAT = SIZELF / SIZREF

        DO I = 1,6
          YVGROW(I) = SIZRAT * YVREF(I)
        ENDDO

        FRLF = TABEX(YLEAF,XLEAF,0.0,8)
        FRSTM = TABEX(YSTEM,XLEAF,0.0,8)
        FRRT = 1.0 - FRLF - FRSTM

      ENDIF

      ELSEIF (DYNAMIC .EQ. EMERG) THEN
        XFRT   = XFRUIT
        ADDSHL = 0.0
        TURXFR = 0.0
        GDMSD  = 0.0
        CDMSD  = 0.0
        NDMSD  = 0.0
        GDMSDR = 0.0
        CDMSDR = 0.0
        NDMSDR = 0.0
        CDMREP = 0.0
        NAGE   = 0
        DO NPP = 1,NCOHORTS
          PHTIM(NPP) = 0.
          PNTIM(NPP) = 0.
        END DO
        FNINSD = SDPRO * 0.16   
        FNINL  = PROLFI * 0.16  
        FNINS  = PROSTI * 0.16  
        FNINR  = PRORTI * 0.16  

      ELSEIF (DYNAMIC .EQ. INTEGR) THEN
      CALL GET(CONTROL)
      DAS = CONTROL % DAS
      NMOBR  = NVSMOB * NMOBMX * TDUMX
      IF (DAS .GT. NR5) THEN
        NMOBR = NMOBMX * TDUMX2 * (1.0 + 0.5*(1.0 - SWFAC))
     &      * (1.0 + 0.3*(1.0 - NSTRES)) * (NVSMOB + (1. - NVSMOB)
     &      * MAX(XPOD,DXR57**2.))
      ENDIF
      NMINEP = NMOBR * (WNRLF + WNRST + WNRRT + WNRSH)

      IF (DAS .GE. NR1) THEN
        IF (DAS - NR1 + 1 > NCOHORTS) THEN
          WRITE(MSG(1),'(A,I5)')
     &      'Number of flower cohorts exceeds maximum limit of',NCOHORTS
          CALL WARNING(1,ERRKEY,MSG)
          CALL ErrorCode(CONTROL, 100, ERRKEY, YREND)
          RETURN
        ENDIF

        IF (DAS .EQ. NR1) THEN
          PNTIM(1) = 0.0
        ELSE
          PNTIM(DAS - NR1 + 1) = PNTIM(DAS - NR1) + TDUMX
        ENDIF

        IF (DAS .LE. NR2) THEN
          PHTIM(1) = 0.0
        ELSE
          PHTIM(DAS - NR2 + 1) = PHTIM(DAS - NR2) + TDUMX
        ENDIF

        TMPFAC = 0.
        TMPFCS = 0.
        DO I = 1,TS
          TMPFAC =CURV(TYPSDT,FNSDT(1),FNSDT(2),FNSDT(3),FNSDT(4),
     &                  TGRO(I))
        TMPFCS = TMPFCS + TMPFAC
        ENDDO
        TMPFAC = TMPFCS /REAL(TS)
C 24 changed to TS on 3Jul17 by Bruce Kimball

        IF (PUNCSD .GT. 0.001) THEN
          REDPUN = 1.0 - (PUNCTR/PUNCSD) * RPRPUN
          REDPUN = MAX(0.0,REDPUN)
        ELSE
          REDPUN = 1.0
        ENDIF
        TURADD = TABEX (YTRFAC,XTRFAC,TURFAC,4)
        SDGR = SDVAR * TMPFAC * REDPUN * (1.-(1.-DRPP)*SRMAX) *
     &       (1. + TURADD)
        GDMSD  = 0.0
        CDMSD  = 0.0
        NDMSD  = 0.0
        GDMSDR = 0.0
        CDMSDR = 0.0
        NDMSDR = 0.0
        IF (DAS .GT. NR2) THEN
          DO NPP = 1, DAS - NR2
            PAGE = PHTIM(DAS - NR2 + 1) - PHTIM(NPP)
            IF (PAGE .GE. LAGSD) THEN
              REDSHL = 0
              IF (SDDES(NPP).GT.0) THEN
                REDSHL = WTSHE(NPP)*SDDES(NPP)/(SDDES(NPP)+SDNO(NPP))
              ENDIF
              SDMAX = (WTSHE(NPP)-REDSHL)*THRESH/(100.-THRESH)-WTSD(NPP)
              SDMAX = MAX(0.0,SDMAX)
              GDMSD  = GDMSD  + MIN(SDGR*SDNO(NPP)*REDPUN, SDMAX)
            ENDIF
          ENDDO
          CALL SDCOMP(
     &      CARMIN, LIPOPT, LIPTB, PLIGSD, PMINSD, POASD,
     &      RCH2O, RLIG, RLIP, RMIN, RNO3C, ROA, SDLIP,
     &      SDPRO, SLOSUM, TAVG,
     &      AGRSD1, AGRSD2, FNINSD, POTCAR, POTLIP)

          NDMSD  = FNINSD * GDMSD
          IF (NDMSD .GT. NMINEP) THEN
            NDMSDR = NMINEP
          ELSE
            NDMSDR = NDMSD
          ENDIF
          GDMSDR = NDMSDR/FNINSD
          CDMSDR = GDMSDR * (AGRSD1 + FNINSD*6.25 * RPRO)
          CDMSD = (MAX(0.0,(GDMSD - GDMSDR))) * AGRSD2 + CDMSDR
        ENDIF
      ENDIF
      GRRAT1 = SHVAR * TMPFAC * (1.- (1.-DRPP) * SRMAX)
     & * (1.0 + TURADD)
      GDMSH = 0.0
      NDMSH = 0.0
      CDMSH = 0.0
      IF (DAS .GT. NR2) THEN
        DO NPP = 1,DAS - NR2
          NAGE = DAS - NR2 + 1 - NPP   not used - chp
          PAGE = PHTIM(DAS - NR2 + 1) - PHTIM(NPP)
          IF (PAGE .LE. LNGSH .AND. SHELN(NPP) .GE. 0.001 .AND.
     &       GRRAT1 .GE. 0.001) THEN
            IF (PAGE .GE. LNGPEG) THEN
               between LNGPEG and LNGSH
              ADDSHL = GRRAT1 * SHELN(NPP)
            ELSE
               < LNGPEG
              ADDSHL = GRRAT1 * SHELN(NPP) * SHLAG
            ENDIF
          ENDIF
          GDMSH  = GDMSH + ADDSHL
        ENDDO
        CDMSH = GDMSH * AGRSH2
      ENDIF
      TEMXFR = 0.
      DO I = 1,TS
        TEMXFR = TEMXFR + TABEX(YXFTEM,XXFTEM,TGRO(I),6)
      ENDDO
      TEMXFR = TEMXFR/REAL(TS)
C 24 changed to TS by Bruce Kimball on 3Jul17

      TURXFR = XFRMAX * (1. - TURFAC)
      TURXFR = MIN(TURXFR,1.0)
      TURXFR = MAX(TURXFR,0.0)
      XFRT = XFRUIT * TEMXFR + XFRUIT * TURXFR
      XFRT = MIN(XFRT,1.0)
      XFRT = MAX(XFRT,0.0)
      CAVTOT = PGAVL * XFRT
      CDMREP = CDMSH + CDMSD
      GDMSDO = GDMSD
      IF (CDMREP .GT. CAVTOT) THEN
        IF (CDMSD .GT. CAVTOT) THEN
          CDMSH = 0.0
          GDMSH = 0.0
          CDMSD = CAVTOT
          IF (CDMSDR .GT. CAVTOT) THEN
            CDMSDR = CAVTOT
          ENDIF
          GDMSD = (MAX(0.0,(CDMSD-CDMSDR)))/AGRSD2 +
     &    CDMSDR/(AGRSD1+FNINSD*6.25*RPRO)
          NDMSDR = GDMSDR * FNINSD
        ELSE
          CDMSH = CAVTOT - CDMSD
          GDMSH = CDMSH/AGRSH2
        ENDIF
        CDMREP = CDMSD + CDMSH
      ENDIF
      NDMSD  = GDMSD * FNINSD
      NDMSH  = GDMSH * FNINSH
      NDMREP = NDMSD + NDMSH

      CDMVEG = MAX(0.0,(1.-XFRT)*PGAVL)
      NDMVEG = 0.0
      CDMVEG = (PGAVL * XFRT - CDMREP) + CDMVEG


      IF (DAS .EQ. NR1) THEN
        FRLFM  = TABEX (YLEAF, XLEAF, VSTAGE, 8)
        FRSTMM = TABEX (YSTEM, XLEAF, VSTAGE, 8)
        YY = FRLFM - FRLFF 
        XX = FRSTMM - FRSTMF
      ENDIF
      IF (DAS .LT. NR1) THEN
        FRLF  = TABEX(YLEAF,XLEAF,VSTAGE,8)
        FRSTM = TABEX(YSTEM,XLEAF,VSTAGE,8)
      ELSE
        FRLF = FRLFM - YY * FRACDN
        FRSTM = FRSTMM - XX * FRACDN
        IF ( DAS .GE. NDLEAF) THEN
          FRLF = FRLFF
          FRSTM = FRSTMF
        ENDIF
      ENDIF

      FRRT = 1. - FRLF - FRSTM

      TPHFAC = 0.
      DO I = 1,TS
        TPHFAC = TPHFAC + TABEX (YSLATM,XSLATM,TGRO(I),5)
      ENDDO
      TPHFAC = TPHFAC/REAL(TS)
C 24 changed to TS by Bruce Kimball on 3Jul17

      PARSLA = (SLAMN+(SLAMX-SLAMN)*EXP(SLAPAR*PAR))/SLAMX
      TURFSL = MAX(0.1, (1.0 - (1.0 - TURFAC)*TURSLA))
      FFVEG = FVEG * TPHFAC * PARSLA * TURFSL

      F = FFVEG
      IF (XFRT*FRACDN .GE. 0.05) F = FFVEG * (1.0 - XFRT * FRACDN)
      IF (XFRUIT .GT. 0.9999 .AND. DAS .GE. NDLEAF) F = 0.0

      IF (VSTAGE .LT. VSSINK) THEN
        GROYES = GROMAX
        GROMAX = TABEX(YVGROW,XVGROW,VSTAGE,6) * SIZELF/SIZREF
        GAINNW = (GROMAX - GROYES) * PLTPOP
        IF (F .GT. 1.E-5) THEN
          GAINWT = GAINNW/F
        ELSE
          GAINWT = 0.0
        ENDIF
        FRLF = (AGRLF*GAINWT)/(CDMVEG + 0.0001)
        IF (FRLF .GT. FRLFMX) THEN
          GAINWT = (CDMVEG/AGRLF) * FRLFMX
          GAINNW = GAINWT * F
          FRLF = FRLFMX
        ENDIF
        FRSTM = (1. - FRLF) * FRSTM / (FRSTM + FRRT)
        FRRT  = 1. - FRLF - FRSTM
      ENDIF
      AGRVG = AGRLF * FRLF + AGRRT * FRRT + AGRSTM * FRSTM
      AGRVG2 = AGRVG + (FRLF*PROLFI+FRRT*PRORTI+FRSTM*PROSTI)*RPROAV
      NDMVEG = (CDMVEG/AGRVG2) * (FRLF*FNINL+FRSTM*FNINS+
     &   FRRT*FNINR)
      NDMNEW = NDMREP + NDMVEG
      CNOLD = MAX(0.0,PGAVL-CDMREP)
      NDMOLD = 0.0
      IF (DAS .GT. NVEG0 .AND. DAS .LT. NR7 .AND.
     &          CNOLD .GT. 0.0) THEN
        NVSTL = FNINL
        NVSTS = FNINS
        NVSTR = FNINR
        IF (DXR57 .GT.0.0) THEN
           FRNLFT = (NRCVR + (1. - NRCVR) * (1. - DXR57**2))
           NVSTL = PROLFF*0.16 + (FNINL-PROLFF*0.16) * FRNLFT
           NVSTS = PROSTF*0.16 + (FNINS-PROSTF*0.16) * FRNLFT
           NVSTR = PRORTF*0.16 + (FNINR-PRORTF*0.16) * FRNLFT
        ENDIF
        NDMOLD = (WTLF  - WCRLF) * MAX(0.0,(NVSTL - PCNL /100.))
     &         + (STMWT - WCRST) * MAX(0.0,(NVSTS - PCNST/100.))
     &         + (RTWT  - WCRRT) * MAX(0.0,(NVSTR - PCNRT/100.))
        IF (NDMOLD .GT. (CNOLD/RNO3C*0.16)) THEN
          NDMOLD = CNOLD/RNO3C*0.16
        ENDIF
      ENDIF
      NDMTOT = NDMREP + NDMVEG + NDMOLD
      CDMTOT = CDMREP + CDMVEG + NDMOLD*RNO3C/0.16 
      GDMSD = GDMSDO

      ENDIF

      RETURN
      END SUBROUTINE DEMAND

      SUBROUTINE IPDMND(
     &  FILECC, FILEGC, FILEIO,
     &  CARMIN, FINREF, FNSDT, FRLFF, FRLFMX,
     &  FRSTMF, LIPOPT, LIPTB, LNGSH, NMOBMX,
     &  NRCVR, NVSMOB, PLIGSD, PMINSD, POASD,
     &  PROLFF, PROLFI, PRORTF, PRORTI, PROSTF, PROSTI,
     &  RCH2O, RLIG, RLIP, RMIN, RNO3C, ROA,
     &  RPRO, SDLIP, SDPRO, SHLAG, SLAMAX, SLAMIN,
     &  SLAPAR, SLAREF, SLAVAR, SLOSUM, SIZELF, SIZREF,
     &  SRMAX, THRESH, TURSLA, TYPSDT, VSSINK, XFRMAX,
     &  XFRUIT, XLEAF, XSLATM, XTRFAC, XVGROW, XXFTEM,
     &  YLEAF, YSLATM, YSTEM, YTRFAC, YVREF, YXFTEM)

      IMPLICIT NONE
      CHARACTER*3   TYPSDT
      CHARACTER*6   ERRKEY
      PARAMETER (ERRKEY = 'DEMAND')
      CHARACTER*6   SECTION
      CHARACTER*6   ECOTYP, ECONO
      CHARACTER*30  FILEIO
      CHARACTER*80  C80
      CHARACTER*92  FILECC, FILEGC
      CHARACTER*255 C255

      INTEGER LUNCRP, LUNIO, LUNECO, ERR, LINC, LNUM, FOUND, ISECT
      INTEGER I, II

      REAL CARMIN, FINREF, FRLFF, FRLFMX, FRSTMF,
     &  LIPOPT, LIPTB, NMOBMX, NRCVR, NVSMOB,
     &  PLIGSD, PMINSD, POASD, PROLFF,
     &  PROLFI, PRORTF, PRORTI, PROSTF, PROSTI,
     &  RCH2O, RLIG, RLIP, RMIN, RNO3C, ROA,
     &  RPRO, SHLAG, SLAMAX, SLAMIN, SLAPAR,
     &  SLAREF, SLAVAR, SLOSUM, SIZELF, SIZREF,
     &  SRMAX, TURSLA, VSSINK, XFRMAX, XFRUIT
        REAL LNGSH, THRESH, SDPRO, SDLIP

        REAL FNSDT(4)
        REAL XVGROW(6), YVREF(6)
        REAL XSLATM(10), YSLATM(10), XTRFAC(10), YTRFAC(10),
     &                  XXFTEM(10), YXFTEM(10)
        REAL XLEAF(25), YLEAF(25), YSTEM(25)

      CALL GETLUN('FILEIO', LUNIO)
      OPEN (LUNIO, FILE = FILEIO,STATUS = 'OLD',IOSTAT=ERR)
      IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILEIO,0)
      LNUM = 0
      SECTION = '*CULTI'
      CALL FIND(LUNIO, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILEIO, LNUM)
      ENDIF
      CALL FIND(LUNIO, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILEIO, LNUM)
      ELSE
        READ(LUNIO,'(24X,A6,48X,3F6.0,24X,3F6.0)',IOSTAT=ERR) 
     &      ECONO, SLAVAR, SIZELF, XFRUIT, THRESH, SDPRO, SDLIP
        LNUM = LNUM + 1
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILEIO,LNUM)
      ENDIF

      CLOSE (LUNIO)

      CALL GETLUN('FILEC', LUNCRP)
      OPEN (LUNCRP,FILE = FILECC, STATUS = 'OLD',IOSTAT=ERR)
      LNUM = 0
      IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(F6.0,6X,F6.0)',IOSTAT=ERR) RNO3C, RPRO
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(5F6.0)',IOSTAT=ERR)RCH2O,RLIP,RLIG,ROA,RMIN
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      ENDIF

      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(F6.0,6X,2F6.0,6X,F6.0)',IOSTAT=ERR)
     &          PROLFI, PROLFF, PROSTI, PROSTF
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(F6.0,6X,F6.0)',IOSTAT=ERR) PRORTI, PRORTF
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(24X,F6.0)',IOSTAT=ERR) PLIGSD
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(24X,F6.0)',IOSTAT=ERR) POASD
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(24X,F6.0)',IOSTAT=ERR) PMINSD
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      ENDIF

      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(4F6.0)',IOSTAT=ERR) LIPTB, LIPOPT, SLOSUM, CARMIN
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
          SLOSUM = SLOSUM / 100.0
      ENDIF

      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(18X,3F6.0)',IOSTAT=ERR) NMOBMX, NVSMOB, NRCVR
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      ENDIF

      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(8F6.0)',IOSTAT=ERR)(XLEAF(II),II=1,8)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(8F6.0)',IOSTAT=ERR)(YLEAF(II),II=1,8)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(8F6.0)',IOSTAT=ERR)(YSTEM(II),II=1,8)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(12X,2F6.0)',IOSTAT=ERR) FRSTMF, FRLFF
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(F6.0)',IOSTAT=ERR) FRLFMX
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      ENDIF

      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(4F6.0)',IOSTAT=ERR) FINREF, SLAREF, SIZREF, VSSINK
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(4F6.0)',IOSTAT=ERR) SLAMAX, SLAMIN, SLAPAR, TURSLA
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(6F6.0)',IOSTAT=ERR)(XVGROW(II),II=1,6)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(6F6.0)',IOSTAT=ERR)(YVREF(II),II=1,6)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(5F6.0)',IOSTAT=ERR)(XSLATM(II),II = 1,5)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(5F6.0)',IOSTAT=ERR)(YSLATM(II),II = 1,5)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      ENDIF

      SECTION =
      CALL FIND(LUNCRP, SECTION, LINC, FOUND) ; LNUM = LNUM + LINC
      IF (FOUND .EQ. 0) THEN
        CALL ERROR(SECTION, 42, FILECC, LNUM)
      ELSE
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(6X,F6.0)',IOSTAT=ERR) SRMAX
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(6X,2F6.0)',IOSTAT=ERR) XFRMAX, SHLAG
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(4(1X,F5.2),3X,A3)',IOSTAT=ERR)
     &          (FNSDT(II),II=1,4), TYPSDT
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(6F6.0)',IOSTAT=ERR)(XXFTEM(II),II = 1,6)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(6F6.0)',IOSTAT=ERR)(YXFTEM(II),II = 1,6)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        DO I=1,5
            CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
          ENDDO
        READ(C80,'(4F6.0)',IOSTAT=ERR)(XTRFAC(II),II = 1,4)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)

        CALL IGNORE(LUNCRP,LNUM,ISECT,C80)
        READ(C80,'(4F6.0)',IOSTAT=ERR)(YTRFAC(II),II = 1,4)
        IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILECC,LNUM)
      ENDIF
      CLOSE(LUNCRP)

      CALL GETLUN('FILEE', LUNECO)
      OPEN (LUNECO,FILE = FILEGC,STATUS = 'OLD',IOSTAT=ERR)
      IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILEGC,0)
      ECOTYP = '      '
      LNUM = 0
      DO WHILE (ECOTYP .NE. ECONO)
        CALL IGNORE(LUNECO, LNUM, ISECT, C255)
        IF ((ISECT .EQ. 1) .AND. (C255(1:1) .NE. ' ') .AND.
     &        (C255(1:1) .NE. '*')) THEN
          READ (C255,'(A6,66X,F6.0,30X)',IOSTAT=ERR) ECOTYP, LNGSH
          IF (ERR .NE. 0) CALL ERROR(ERRKEY,ERR,FILEGC,LNUM)
          IF (ECOTYP .EQ. ECONO) THEN
            EXIT
          ENDIF

        ELSE IF (ISECT .EQ. 0) THEN
          IF (ECONO .EQ. 'DFAULT') CALL ERROR(ERRKEY,35,FILEGC,LNUM)
          ECONO = 'DFAULT'
          REWIND(LUNECO)
          LNUM = 0
        ENDIF
      ENDDO

      CLOSE (LUNECO)

      RETURN
      END  SUBROUTINE IPDMND
