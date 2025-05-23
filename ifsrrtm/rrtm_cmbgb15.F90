!***************************************************************************
SUBROUTINE RRTM_CMBGB15
!***************************************************************************

!     BAND 15:  2380-2600 cm-1 (low - N2O,CO2; high - nothing)
!     ABozzo 2001306 updated to rrtmg v4.85
!     band 15:  2380-2600 cm-1 (low - n2o,co2; low minor - n2)
!                              (high - nothing)
!***************************************************************************

! Parameters
USE PARKIND1  ,ONLY : JPIM     ,JPRB
USE YOMHOOK   ,ONLY : LHOOK,   DR_HOOK, JPHOOK

USE YOERRTO15, ONLY : KAO     ,KAO_MN2,SELFREFO,FORREFO   ,FRACREFAO
USE YOERRTA15, ONLY : KA      ,KA_MN2,SELFREF,FORREF    ,FRACREFA
USE YOERRTRWT, ONLY : RWGT
USE YOERRTFTR, ONLY : NGC      ,NGS      ,NGN      

IMPLICIT NONE

INTEGER(KIND=JPIM) :: IGC, IPR, IPRSM, JN, JP, JT

REAL(KIND=JPRB) :: Z_SUMF, Z_SUMK
REAL(KIND=JPHOOK) :: ZHOOK_HANDLE

IF (LHOOK) CALL DR_HOOK('RRTM_CMBGB15',0,ZHOOK_HANDLE)
DO JN = 1,9
  DO JT = 1,5
    DO JP = 1,13
      IPRSM = 0
      DO IGC = 1,NGC(15)
        Z_SUMK = 0.0_JPRB
        DO IPR = 1, NGN(NGS(14)+IGC)
          IPRSM = IPRSM + 1

          Z_SUMK = Z_SUMK + KAO(JN,JT,JP,IPRSM)*RWGT(IPRSM+224)
        ENDDO

        KA(JN,JT,JP,IGC) = Z_SUMK
      ENDDO
    ENDDO
  ENDDO
ENDDO

DO JN = 1,9
   DO JT = 1,19
      IPRSM = 0
      DO IGC = 1,NGC(15)
        Z_SUMK = 0.0_JPRB
         DO IPR = 1, NGN(NGS(14)+IGC)
            IPRSM = IPRSM + 1
            Z_SUMK = Z_SUMK + KAO_MN2(JN,JT,IPRSM)*RWGT(IPRSM+224)
         ENDDO
         KA_MN2(JN,JT,IGC) = Z_SUMK
      ENDDO
   ENDDO
ENDDO

DO JT = 1,10
  IPRSM = 0
  DO IGC = 1,NGC(15)
    Z_SUMK = 0.0_JPRB
    DO IPR = 1, NGN(NGS(14)+IGC)
      IPRSM = IPRSM + 1

      Z_SUMK = Z_SUMK + SELFREFO(JT,IPRSM)*RWGT(IPRSM+224)
    ENDDO

    SELFREF(JT,IGC) = Z_SUMK
  ENDDO
ENDDO

DO JT = 1,4
   IPRSM = 0
   DO IGC = 1,NGC(15)
      Z_SUMK = 0.0_JPRB
      DO IPR = 1, NGN(NGS(14)+IGC)
         IPRSM = IPRSM + 1
         Z_SUMK = Z_SUMK + FORREFO(JT,IPRSM)*RWGT(IPRSM+224)
      ENDDO
      FORREF(JT,IGC) = Z_SUMK
   ENDDO
ENDDO

DO JP = 1,9
  IPRSM = 0
  DO IGC = 1,NGC(15)
    Z_SUMF = 0.0_JPRB
    DO IPR = 1, NGN(NGS(14)+IGC)
      IPRSM = IPRSM + 1

      Z_SUMF = Z_SUMF + FRACREFAO(IPRSM,JP)
    ENDDO

    FRACREFA(IGC,JP) = Z_SUMF
  ENDDO
ENDDO

 
IF (LHOOK) CALL DR_HOOK('RRTM_CMBGB15',1,ZHOOK_HANDLE)
END SUBROUTINE RRTM_CMBGB15
