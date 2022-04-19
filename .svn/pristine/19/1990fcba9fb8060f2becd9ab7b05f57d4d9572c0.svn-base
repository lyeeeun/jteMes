DROP TABLE IF EXISTS `TB_COMCDGRP`;
CREATE TABLE `TB_COMCDGRP`
(
   `GRP_CD`             VARCHAR (100) NOT NULL COMMENT '그룹코드' ,
   `GRP_NM`             VARCHAR (400) COMMENT '그룹명' ,
   `USE_YN`             INT (1) COMMENT '사용여부' ,
   `SND_YN`             VARCHAR (1) COMMENT '전송여부' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   PRIMARY KEY (`GRP_CD`),
   UNIQUE INDEX `TB_COMCDGRP_IDX01`(`GRP_CD`)
)
COMMENT = '공통코드그룹 '
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_COMCDINF`;
CREATE TABLE `TB_COMCDINF`
(
   `GRP_CD`             VARCHAR (100) NOT NULL COMMENT '그룹코드' ,
   `COM_CD`             VARCHAR (100) NOT NULL COMMENT '상세코드' ,
   `COM_NM`             VARCHAR (100) COMMENT '상세코드명' ,
   `DUMY1_NM`           VARCHAR (100) COMMENT '더미1명칭' ,
   `DUMY1_VALUE`        VARCHAR (100) COMMENT '더미1값' ,
   `DUMY2_NM`           VARCHAR (100) COMMENT '더미2명칭' ,
   `DUMY2_VALUE`        VARCHAR (100) COMMENT '더미2값' ,
   `USE_YN`             VARCHAR (1) COMMENT '사용여부' ,
   `REMARK`             VARCHAR (200) COMMENT '특기사항' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `SND_YN`             CHAR (1) COMMENT '전송여부' ,
   PRIMARY KEY (`GRP_CD`, `COM_CD`),
   UNIQUE INDEX `TB_COMCDINF_IDX01`(`GRP_CD`, `COM_CD`)
)
COMMENT = '공통코드상세'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_CUSTOMER`;
CREATE TABLE `TB_CUSTOMER`
(
   `CUSTOMERID`         VARCHAR (20) NOT NULL COMMENT '고객사ID' ,
   `CUSTOMERNAME`       VARCHAR (200) COMMENT '고객사명' ,
   `CUSTOMERDESC`       VARCHAR (400) COMMENT '고객사설명' ,
   `CUSTOMERIUSE`       VARCHAR (2) COMMENT '사용여부' ,
   `BIZ_GBN`            VARCHAR (2) COMMENT '업체구분' ,
   `BIZ_KND`            VARCHAR (50) COMMENT '업종' ,
   `CUSTOMER_STAT`      VARCHAR (50) COMMENT '업태' ,
   `EST_YMD`            VARCHAR (8) COMMENT '설립일자' ,
   `REG_YMD`            VARCHAR (8) COMMENT '등록일자' ,
   `REP_NM`             VARCHAR (50) COMMENT '대표자명' ,
   `BIZ_REG_NO`         VARCHAR (30) COMMENT '사업자등록번호' ,
   `ADDR`               VARCHAR (200) COMMENT '주소' ,
   `FAX_NO`             VARCHAR (20) COMMENT '팩스번호' ,
   `CHR_NM`             VARCHAR (50) COMMENT '담당자명' ,
   `CHR_TEL_NO`         VARCHAR (20) COMMENT '담당자 연락처' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`CUSTOMERID`),
   UNIQUE INDEX `TB_CUSTOMER_IDX01`(`CUSTOMERID`)
)
COMMENT = '고객사'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_SUPPLIER`;
CREATE TABLE `TB_SUPPLIER`
(
   `SUPPLIERID`         VARCHAR (20) NOT NULL COMMENT '납품업체ID' ,
   `SUPPLIERNAME`       VARCHAR (200) COMMENT '납품업체명' ,
   `SUPPLIERDESC`       VARCHAR (400) COMMENT '납품업체설명' ,
   `SUPPLIERIUSE`       VARCHAR (2) COMMENT '사용여부' ,
   `BIZ_GBN`            VARCHAR (2) COMMENT '업체구분' ,
   `BIZ_KND`            VARCHAR (50) COMMENT '업종' ,
   `CUSTOMER_STAT`      VARCHAR (50) COMMENT '업태' ,
   `EST_YMD`            VARCHAR (8) COMMENT '설립일자' ,
   `REG_YMD`            VARCHAR (8) COMMENT '등록일자' ,
   `REP_NM`             VARCHAR (50) COMMENT '대표자명' ,
   `BIZ_REG_NO`         VARCHAR (30) COMMENT '사업자등록번호' ,
   `ADDR`               VARCHAR (200) COMMENT '주소' ,
   `FAX_NO`             VARCHAR (20) COMMENT '팩스번호' ,
   `CHR_NM`             VARCHAR (50) COMMENT '담당자명' ,
   `CHR_TEL_NO`         VARCHAR (20) COMMENT '담당자 연락처' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`SUPPLIERID`),
   UNIQUE INDEX `TB_SUPPLIER_IDX01`(`SUPPLIERID`)
)
COMMENT = '공급사'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MATERIAL`;
CREATE TABLE `TB_MATERIAL`
(
   `MTRLID`             VARCHAR (100) NOT NULL COMMENT '자재ID' ,
   `MTGRID`             VARCHAR (100) COMMENT '자재군ID' ,
   `MTRLNAME`           VARCHAR (200) COMMENT '자재명칭' ,
   `MTRLUNIT_CD`        VARCHAR (2) COMMENT '자재단위코드' ,
   `MTRLDESC`           VARCHAR (400) COMMENT '자재설명(특기사항)' ,
   `MTRLTYPE`           VARCHAR (2) COMMENT '자재유형' ,
   `MTRLSPEC`           VARCHAR (100) COMMENT '자재사양' ,
   `PRD_LEN`            INT (9) COMMENT '규격.길이' ,
   `PRD_WTH`            INT (9) COMMENT '규격.폭' ,
   `PRD_HIG`            INT (9) COMMENT '규격.두께' ,
   `MTRLCMPT`           VARCHAR (100) COMMENT '자재재질' ,
   `MTRLIUSE`           VARCHAR (2) COMMENT '자재사용여부' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`MTRLID`),
   UNIQUE INDEX `TB_MATERIAL_IDX01`(`MTRLID`)
)
COMMENT = '자재코드'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_PRODUCT`;
CREATE TABLE `TB_PRODUCT`
(
   `PRODID`             VARCHAR (100) NOT NULL COMMENT '제품ID' ,
   `MODLID`             VARCHAR (100) COMMENT '제품모델ID' ,
   `PRODNAME`           VARCHAR (200) COMMENT '제품명칭' ,
   `PRODUNIT_CD`        VARCHAR (2) COMMENT '제품단위코드' ,
   `PRODDESC`           VARCHAR (400) COMMENT '제품설명' ,
   `PRODTYPE`           VARCHAR (100) COMMENT '제품유형' ,
   `PRODMTRL`           VARCHAR (100) COMMENT '제품재질(product material)' ,
   `PRODSPEC`           VARCHAR (100) COMMENT '제품사양(specification)' ,
   `PRD_LEN`            INT (9) COMMENT '규격.길이' ,
   `PRD_WTH`            INT (9) COMMENT '규격.폭' ,
   `PRD_HIG`            INT (9) COMMENT '규격.두께' ,
   `PRODIUSE`           VARCHAR (2) COMMENT '제품사용여부' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`PRODID`),
   UNIQUE INDEX `TB_PRODUCT_IDX01`(`PRODID`)
)
COMMENT = '제품코드'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESORDER`;
CREATE TABLE `TB_MESORDER`
(
   `ORDER_NO`           VARCHAR (14) NOT NULL COMMENT '주문번호' ,
   `ORDER_DATE`         DATETIME COMMENT '주문일자' ,
   `DELIVERY_DATE`      DATETIME COMMENT '납기일자' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사ID' ,
   `CUST_USER`          VARCHAR (100) COMMENT '고객사 당담자' ,
   `PRODID`             VARCHAR (100) COMMENT '제품코드' ,
   `QTY`                INT (6) COMMENT '수량(주문수량)' ,
   `SHOPFLOOR_TOT_QTY`  INT (6) COMMENT '총지시량' ,
   `OUT_TOT_QTY`        INT (6) COMMENT '총합격량(정품)' ,
   `DEFECT_TOT_QTY`     INT (6) COMMENT '총불량량' ,
   `PROD_IN_TOT_QTY`    INT (6) COMMENT '총입고량' ,
   `PROD_OUT_TOT_QTY`   INT (6) COMMENT '총출고량' ,
   `RTN_IN_QTY`         INT (6) COMMENT '반품입고량' ,
   `RTN_OUT_QTY`        INT (6) COMMENT '반품출고량' ,
   `DIS_OUT_QTY`        INT (6) COMMENT '폐기출고량' ,
   `PRODUNIT_CD`        VARCHAR (2) COMMENT '단위코드' ,
   `DESTINATION`        VARCHAR (100) COMMENT '도착지' ,
   `REMARK`             VARCHAR (400) COMMENT '특기사항' ,
   `ORDER_GBN`          VARCHAR (4) COMMENT '주문구분' ,
   `OR_NO_ORIGINAL`     VARCHAR (14) COMMENT '원주문번호' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`ORDER_NO`),
   UNIQUE INDEX `TB_MESORDER_IDX01`(`ORDER_NO`)
)
COMMENT = '주문정보'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESMTRLIN`;
CREATE TABLE `TB_MESMTRLIN`
(
   `MTRL_IN_NO`         VARCHAR (14) NOT NULL COMMENT '자재입고번호' ,
   `MTRL_IN_DATE`       DATETIME COMMENT '자재입고일자' ,
   `SUPPLIERID`         VARCHAR (100) COMMENT '매입처코드(납품업체ID)' ,
   `MTRLID`             VARCHAR (100) COMMENT '자재코드' ,
   `MTRL_IN_QTY`        INT (6) COMMENT '자재입고수량' ,
   `MTRL_OUT_TOT_QTY`   INT (6) COMMENT '자재출고총수량' ,
   `UNIT_CD`            VARCHAR (100) COMMENT '단위코드' ,
   `WHU_LOC`            VARCHAR (6) COMMENT '적재위치' ,
   `WHU`                VARCHAR (2) COMMENT '창고' ,
   `REMARK`             VARCHAR (400) COMMENT '특기사항' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`MTRL_IN_NO`),
   UNIQUE INDEX `TB_MESMTRLIN_IDX01`(`MTRL_IN_NO`)
)
COMMENT = '자재입고'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESMTROUT`;
CREATE TABLE `TB_MESMTROUT`
(
   `MTRL_OUT_NO`        VARCHAR (14) NOT NULL COMMENT '자재출고번호' ,
   `MTRL_OUT_DATE`      DATETIME COMMENT '자재출고일자' ,
   `SUPPLIERID`         VARCHAR (100) COMMENT '매입처코드(납품업체ID)' ,
   `MTRLID`             VARCHAR (100) COMMENT '자재코드' ,
   `MTRL_OUT_QTY`       INT (6) COMMENT '자재출고수량' ,
   `MTRL_IN_NO`         VARCHAR (14) COMMENT '자재입고번호' ,
   `UNIT_CD`            VARCHAR (100) COMMENT '단위코드' ,
   `REMARK`             VARCHAR (400) COMMENT '특기사항' ,
   `MTRL_OUT_GBN`       CHAR (1) COMMENT '자재출고구분' ,
   `WOID`               VARCHAR (14) COMMENT '제조지시번호' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`MTRL_OUT_NO`),
   UNIQUE INDEX `TB_MESMTROUT_IDX01`(`MTRL_OUT_NO`)
)
COMMENT = '자재출고'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESPLAN`;
CREATE TABLE `TB_MESPLAN`
(
   `WO_PLAN_YYYYMM`     VARCHAR (14) NOT NULL COMMENT '생산계획 년' ,
   `PRODID`             VARCHAR (14) NOT NULL COMMENT '제품 코드' ,
   `JAN`                VARCHAR (14) COMMENT '1월 계획 수량' ,
   `FEB`                VARCHAR (14) COMMENT '2월 계획 수량' ,
   `MAR`                VARCHAR (14) COMMENT '3월 계획 수량' ,
   `APR`                VARCHAR (14) COMMENT '4월 계획 수량' ,
   `MAY`                VARCHAR (14) COMMENT '5월 계획 수량' ,
   `JUN`                VARCHAR (14) COMMENT '6월 계획 수량' ,
   `JULY`               VARCHAR (14) COMMENT '7월 계획 수량' ,
   `AUG`                VARCHAR (14) COMMENT '8월 계획 수량' ,
   `SEP`                VARCHAR (14) COMMENT '9월 계획 수량' ,
   `OCT`                VARCHAR (14) COMMENT '10월 계획 수량' ,
   `NOV`                VARCHAR (14) COMMENT '11월 계획 수량' ,
   `DEC`                VARCHAR (14) COMMENT '12월 계획 수량' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`WO_PLAN_YYYYMM`, `PRODID`),
   UNIQUE INDEX `TB_MESPLAN_IDX01`(`WO_PLAN_YYYYMM`, `PRODID`)
)
COMMENT = '생산계획'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESWORKORDER`;
CREATE TABLE `TB_MESWORKORDER`
(
   `WOID`               nvarchar (14) NOT NULL COMMENT '제조지시번호' ,
   `WO_DATE`            datetime COMMENT '제조지시일자' ,
   `CUSTOMERID`         nvarchar (100) COMMENT '고객사' ,
   `PRODID`             nvarchar (100) COMMENT '제품코드' ,
   `ORDER_NO`           nvarchar (14) COMMENT '주문번호' ,
   `UNIT_CD`            nvarchar (100) COMMENT '단위코드' ,
   `SHOPFLOOR_QTY`      INT (6) COMMENT '제조지시량' ,
   `OUT_TOT_QTY`        INT (6) COMMENT '총합격량' ,
   `DEFECT_TOT_QTY`     INT (6) COMMENT '총불량량' ,
   `PACK_TOT_QTY`       INT (6) COMMENT '총포장량' ,
   `REMARK`             nvarchar (400) COMMENT '비고(특기사항)' ,
   `DEL_GBN`            char (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        nvarchar (100) COMMENT '생성자' ,
   `REG_PGM_ID`         nvarchar (100) COMMENT '생성프로그램' ,
   `REG_DT`             datetime COMMENT '생성일시' ,
   `UPD_USER_ID`        nvarchar (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         nvarchar (100) COMMENT '수정프로그램' ,
   `UPD_DT`             datetime COMMENT '수정일시' ,
   PRIMARY KEY (`WOID`),
   UNIQUE INDEX `TB_MESWORKORDER_IDX01`(`WOID`)
)
COMMENT = '제조지시'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESWORKORDEROUT`;
CREATE TABLE `TB_MESWORKORDEROUT`
(
   `WO_OUT_NO`          VARCHAR (14) NOT NULL COMMENT '생산실적번호' ,
   `WO_OUT_DATE`        DATETIME COMMENT '생산일자' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사' ,
   `PRODID`             VARCHAR (100) COMMENT '제품코드' ,
   `WOID`               VARCHAR (14) COMMENT '제조지시번호' ,
   `ORDER_NO`           VARCHAR (14) COMMENT '주문번호' ,
   `UNIT_CD`            VARCHAR (14) COMMENT '단위코드' ,
   `SHOPFLOOR_OUT_QTY`  VARCHAR (14) COMMENT '합격량' ,
   `DEFECT_CAUSE_CD`    VARCHAR (100) COMMENT '불량원인코드' ,
   `DEFECT_QTY`         INT (6) COMMENT '불량량' ,
   `PROD_IN_TOT_QTY`    INT (6) COMMENT '총 입고량' ,
   `PACK_TOT_QTY`       INT (6) COMMENT '총포장량' ,
   `REMARK`             VARCHAR (400) COMMENT '생산특기사항' ,
   `QM_REMARK`          VARCHAR (400) COMMENT '품질특기사항' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`WO_OUT_NO`),
   UNIQUE INDEX `TB_MESWORKORDEROUT_IDX01`(`WO_OUT_NO`)
)
COMMENT = '생산실적'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `MESPACKCOMM`;
CREATE TABLE `MESPACKCOMM`
(
   `PACK_NO`            VARCHAR (14) NOT NULL COMMENT '포장번호' ,
   `PACK_UNIT`          VARCHAR (100) COMMENT '포장단위' ,
   `DETL_PACK_QTY`      INT (6) COMMENT '상세포장량' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`PACK_NO`),
   UNIQUE INDEX `MESPACKCOMM_IDX01`(`PACK_NO`)
)
COMMENT = '포장실적공통 '
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `MESPACKDETL`;
CREATE TABLE `MESPACKDETL`
(
   `PACK_NO`            VARCHAR (14) NOT NULL COMMENT '포장번호' ,
   `PACK_NO_SEQ`        INT (6) NOT NULL COMMENT '포장상세순번' ,
   `PACK_DATE`          DATETIME COMMENT '포장일자' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사ID' ,
   `WO_OUT_NO`          VARCHAR (14) COMMENT '생산실적번호' ,
   `PRODID`             VARCHAR (100) COMMENT '제품코드' ,
   `ORDER_NO`           VARCHAR (14) COMMENT '주문번호' ,
   `UNIT_CD`            VARCHAR (100) COMMENT '단위코드' ,
   `PACK_QTY`           INT (6) COMMENT '포장량' ,
   `PROD_IN_QTY`        INT (6) COMMENT '제품입고량' ,
   `PRODSTS`            CHAR (1) COMMENT '제품상태(A:포장,B:입고,C:출고,D:반품)' ,
   `INVOICE_PRT_CNT`    INT (6) COMMENT '송장발행횟수' ,
   `LABEL_PRT_CNT`      INT (6) COMMENT '라벨발행횟수' ,
   `PC_REMARK`          VARCHAR (400) COMMENT '포장특기사항' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`PACK_NO`, `PACK_NO_SEQ`),
   UNIQUE INDEX `MESPACKDETL_IDX01`(`PACK_NO`, `PACK_NO_SEQ`)
)
COMMENT = '포장실적상세'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESPRODIN`;
CREATE TABLE `TB_MESPRODIN`
(
   `PROD_IN_NO`         VARCHAR (14) NOT NULL COMMENT '제품입고번호' ,
   `PROD_IN_DATE`       DATETIME COMMENT '제품입고일자' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사' ,
   `PRODID`             VARCHAR (100) COMMENT '제품코드' ,
   `PROD_IN_QTY`        INT (6) COMMENT '제품입고수량' ,
   `PROD_OUT_TOT_QTY`   INT (6) COMMENT '제품출고총수량' ,
   `ORDER_NO`           VARCHAR (14) COMMENT '주문번호' ,
   `WO_OUT_NO`          VARCHAR (14) COMMENT '생산실적번호' ,
   `PACK_NO`            VARCHAR (14) COMMENT '포장번호' ,
   `UNIT_CD`            VARCHAR (100) COMMENT '단위코드' ,
   `WHU_LOC`            VARCHAR (6) COMMENT '적재위치' ,
   `WHU`                VARCHAR (2) COMMENT '창고' ,
   `PROD_IN_GBN`        CHAR (1) COMMENT '입고구분' ,
   `REMARK`             VARCHAR (400) COMMENT '특기사항' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`PROD_IN_NO`),
   UNIQUE INDEX `TB_MESPRODIN_IDX01`(`PROD_IN_NO`)
)
COMMENT = '제품입고실적'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESPRODOUT`;
CREATE TABLE `TB_MESPRODOUT`
(
   `PROD_OUT_NO`        VARCHAR (14) NOT NULL COMMENT '제품출고번호' ,
   `CAR_OUT_DATE`       DATETIME COMMENT '차량편성일자' ,
   `CAR_NO`             VARCHAR (50) COMMENT '차량번호' ,
   `CAR_DRIV_NAME`      VARCHAR (50) COMMENT '운전자' ,
   `CAR_DRIV_TEL`       VARCHAR (50) COMMENT '운전자연락처' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사ID' ,
   `DESTINATION`        VARCHAR (100) COMMENT '목적지' ,
   `VEHICLETYPE`        VARCHAR (2) COMMENT '차량종류' ,
   `CARRIER`            VARCHAR (20) COMMENT '운송사' ,
   `PROD_OUT_GBN`       VARCHAR (100) COMMENT '제품출고구분' ,
   `REMARK`             VARCHAR (400) COMMENT '특기사항' ,
   `INVOICE_PRT_CNT`    INT (6) COMMENT '송장발행횟수' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`PROD_OUT_NO`),
   UNIQUE INDEX `TB_MESPRODOUT_IDX01`(`PROD_OUT_NO`)
)
COMMENT = '제품출고실적공통'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESPRODOUTDELT`;
CREATE TABLE `TB_MESPRODOUTDELT`
(
   `PROD_OUT_NO`        VARCHAR (14) NOT NULL COMMENT '제품출고번호' ,
   `PROD_OUT_NO_SEQ`    INT (14) NOT NULL COMMENT '제품출고순번' ,
   `PROD_OUT_DATE`      DATETIME COMMENT '제품출고일자' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사' ,
   `PROD_IN_NO`         VARCHAR (14) COMMENT '제품입고번호' ,
   `ORDER_NO`           VARCHAR (14) COMMENT '주문번호' ,
   `PRODID`             VARCHAR (100) COMMENT '제품코드' ,
   `PROD_OUT_QTY`       INT (6) COMMENT '제품출고수량' ,
   `UNIT_CD`            VARCHAR (100) COMMENT '단위코드' ,
   `PACK_NO`            VARCHAR (14) COMMENT '포장번호' ,
   `RTN_TOT_QTY`        INT (6) COMMENT '총반품수량' ,
   `CAR_NO`             VARCHAR (50) COMMENT '차량번호' ,
   `CAR_DRIV_NAME`      VARCHAR (50) COMMENT '운전자' ,
   `CAR_DRIV_TEL`       VARCHAR (50) COMMENT '운전자연락처' ,
   `PROD_OUT_GBN`       VARCHAR (100) COMMENT '제품출고구분(공통:정상출고,폐기출고)' ,
   `REMARK`             VARCHAR (400) COMMENT '특기사항' ,
   `INVOICE_PRT_CNT`    INT (6) COMMENT '송장발행횟수' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`PROD_OUT_NO`, `PROD_OUT_NO_SEQ`),
   UNIQUE INDEX `TB_MESPRODOUTDELT_IDX01`(`PROD_OUT_NO`, `PROD_OUT_NO_SEQ`)
)
COMMENT = '제품출고실적상세'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MESPRODRETURN`;
CREATE TABLE `TB_MESPRODRETURN`
(
   `RTN_NO`             VARCHAR (14) NOT NULL COMMENT '반품번호' ,
   `RTN_DATE`           DATETIME COMMENT '반품일자' ,
   `CUSTOMERID`         VARCHAR (100) COMMENT '고객사코드' ,
   `PRODID`             VARCHAR (100) COMMENT '제품코드' ,
   `RTN_QTY`            INT (6) COMMENT '반품량' ,
   `ORDER_NO`           VARCHAR (14) COMMENT '주문번호' ,
   `PROD_OUT_NO`        VARCHAR (14) COMMENT '제품출고번호' ,
   `UNIT_CD`            VARCHAR (100) COMMENT '단위코드' ,
   `RETURN_CAUSE_CD`    CHAR (1) COMMENT '불량원인' ,
   `PACK_NO`            VARCHAR (14) COMMENT '포장번호' ,
   `PROD_IN_NO`         VARCHAR (14) COMMENT '입고번호' ,
   `RT_REMARK`          VARCHAR (400) COMMENT '반품특기사항' ,
   `DEL_GBN`            CHAR (1) COMMENT '삭제구분' ,
   `REG_USER_ID`        VARCHAR (100) COMMENT '생성자' ,
   `REG_PGM_ID`         VARCHAR (100) COMMENT '생성프로그램' ,
   `REG_DT`             DATETIME COMMENT '생성일시' ,
   `UPD_USER_ID`        VARCHAR (100) COMMENT '수정자' ,
   `UPD_PGM_ID`         VARCHAR (100) COMMENT '수정프로그램' ,
   `UPD_DT`             DATETIME COMMENT '수정일시' ,
   PRIMARY KEY (`RTN_NO`),
   UNIQUE INDEX `TB_MESPRODRETURN_IDX01`(`RTN_NO`)
)
COMMENT = '반품실적'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_MEMBINF`;
CREATE TABLE `TB_MEMBINF`
(
   `MEMB_NO`            VARCHAR (10) NOT NULL COMMENT '회원번호' ,
   `MEMB_NM`            VARCHAR (50) COMMENT '회원명' ,
   `CTR_CD`             VARCHAR (20) COMMENT '센터코드' ,
   `DONG`               VARCHAR (5) COMMENT '동' ,
   `HO`                 VARCHAR (5) COMMENT '호' ,
   `WEB_ID`             VARCHAR (50) COMMENT 'webID' ,
   `WEB_PW`             VARCHAR (255) COMMENT 'webPW' ,
   `UPD_DT`             DATE COMMENT '수정일자' ,
   `UPD_USER_ID`        VARCHAR (10) COMMENT '수정자ID' ,
   `UPD_PMG_ID`         VARCHAR (40) COMMENT '수정프로그램ID' ,
   PRIMARY KEY (`MEMB_NO`),
   UNIQUE INDEX `TB_MEMBINF_IDX01`(`MEMB_NO`)
)
COMMENT = '회원정보'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_ADMININF`;
CREATE TABLE `TB_ADMININF`
(
   `CTR_CD`             VARCHAR (20) NOT NULL COMMENT '센터코드' ,
   `ADMIN_ID`           VARCHAR (8) NOT NULL COMMENT '운영자ID' ,
   `ADMIN_NM`           VARCHAR (50) COMMENT '운영자명' ,
   `MASTER`             VARCHAR (1) COMMENT '이지빌관리자' ,
   `WD_YN`              VARCHAR (1) COMMENT '탈퇴여부' ,
   PRIMARY KEY (`CTR_CD`, `ADMIN_ID`),
   UNIQUE INDEX `TB_ADMININF_IDX01`(`CTR_CD`, `ADMIN_ID`)
)
COMMENT = '운영자정보'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_AUTHINF`;
CREATE TABLE `TB_AUTHINF`
(
   `CTR_CD`             VARCHAR (20) NOT NULL COMMENT '센터코드' ,
   `COMP_CD`            VARCHAR (20) NOT NULL COMMENT '단지코드' ,
   `AUTH_GRP_CD`        VARCHAR (5) NOT NULL COMMENT '권한그룹코드' ,
   `PGM_ID`             VARCHAR (40) COMMENT '프로그램ID' ,
   `INPUT_AUTH`         VARCHAR (1) COMMENT '입력권한' ,
   `SEARCH_AUTH`        VARCHAR (1) COMMENT '조회권한' ,
   `PRINT_AUTH`         VARCHAR (1) COMMENT '출력권한' ,
   `DELETE_AUTH`        VARCHAR (1) COMMENT '삭제권한' ,
   `SND_YN`             VARCHAR (1) COMMENT '전송여부' ,
   `SND_DT`             DATE COMMENT '전송일자' ,
   `SND_PGM_ID`         VARCHAR (40) COMMENT '전송프로그램ID' ,
   `REG_DT`             DATE COMMENT '생성일자' ,
   `REG_USER_ID`        VARCHAR (10) COMMENT '생성자ID' ,
   `REG_PGM_ID`         VARCHAR (40) COMMENT '생성프로그램ID' ,
   `UPD_DT`             DATE COMMENT '수정일자' ,
   `UPD_USER_ID`        VARCHAR (10) COMMENT '수정자ID' ,
   `UPD_PGM_ID`         VARCHAR (40) COMMENT '수정프로그램ID' ,
   PRIMARY KEY (`CTR_CD`, `COMP_CD`, `AUTH_GRP_CD`),
   UNIQUE INDEX `TB_AUTHINF_IDX01`(`CTR_CD`, `COMP_CD`, `AUTH_GRP_CD`)
)
COMMENT = '권한정보'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS `TB_AUTHGRPINF`;
CREATE TABLE `TB_AUTHGRPINF`
(
   `CTR_CD`             VARCHAR (20) NOT NULL COMMENT '센터코드' ,
   `COMP_CD`            VARCHAR (20) NOT NULL COMMENT '단지코드' ,
   `AUTH_GRP_CD`        VARCHAR (5) NOT NULL COMMENT '권한그룹코드' ,
   `AUTH_GRP_NM`        VARCHAR (50) COMMENT '명칭' ,
   `USE_YN`             VARCHAR (1) COMMENT '사용여부' ,
   `SND_YN`             VARCHAR (1) COMMENT '전송여부' ,
   `SND_DT`             DATE COMMENT '전송일자' ,
   `SND_PGM_ID`         VARCHAR (40) COMMENT '전송프로그램ID' ,
   `REG_DT`             DATE COMMENT '생성일자' ,
   `REG_USER_ID`        VARCHAR (10) COMMENT '생성자ID' ,
   `REG_PGM_ID`         VARCHAR (40) COMMENT '생성프로그램ID' ,
   `UPD_DT`             DATE COMMENT '수정일자' ,
   `UPD_USER_ID`        VARCHAR (10) COMMENT '수정자ID' ,
   `UPD_PGM_ID`         VARCHAR (40) COMMENT '수정프로그램ID' ,
   PRIMARY KEY (`CTR_CD`, `COMP_CD`, `AUTH_GRP_CD`),
   UNIQUE INDEX `TB_AUTHGRPINF_IDX01`(`CTR_CD`, `COMP_CD`, `AUTH_GRP_CD`)
)
COMMENT = '권한그룹'
COLLATE='utf8_general_ci'
ENGINE = InnoDB
;
DROP TABLE IF EXISTS TB_BPINF;
CREATE TABLE TB_BPINF (
 CTR_CD VARCHAR(20) NOT NULL COMMENT '센터코드',
 COMP_CD VARCHAR(20) NOT NULL COMMENT '단지코드',
 BP_CD VARCHAR(5) NOT NULL COMMENT '업장코드',
 BP_NM VARCHAR(50) COMMENT '업장명',
 BP_DIV_CD VARCHAR(3) COMMENT '업장종류코드',
 BP_TEL VARCHAR(30) COMMENT '전화번호',
 BP_LOC_CD VARCHAR(3) COMMENT '업장위치코드',
 ADMIN_ID VARCHAR(10) COMMENT '관리자ID',
 POS_YN VARCHAR(1) DEFAULT 'Y' COMMENT '포스사용여부',
 KO_YN VARCHAR(1) DEFAULT 'Y' COMMENT '키오스크사용여부',
 MO_YN VARCHAR(1) DEFAULT 'Y' COMMENT '모바일사용여부',
 WP_YN VARCHAR(1) DEFAULT 'Y' COMMENT '웰패드사용여부',
 WEB_YN VARCHAR(1) DEFAULT 'Y' COMMENT '웹사용여부',
 REMARK VARCHAR(500) COMMENT '비고사항',
 PIC_LOC VARCHAR(255) COMMENT '사진경로',
 ENTR_GENDER VARCHAR(1) COMMENT '입장가능성별',
 USE_YN VARCHAR(1) DEFAULT 'Y' COMMENT '사용여부',
 SND_YN VARCHAR(1) DEFAULT 'N' COMMENT '전송여부',
 SND_DT DATE COMMENT '전송일자',
 SND_PGM_ID VARCHAR(40) COMMENT '전송프로그램ID',
 REG_DT DATE COMMENT '생성일자',
 REG_USER_ID VARCHAR(10) COMMENT '생성자ID',
 REG_PGM_ID VARCHAR(40) COMMENT '생성프로그램ID',
 UPD_DT DATE COMMENT '수정일자',
 UPD_USER_ID VARCHAR(10) COMMENT '수정자ID',
 UPD_PGM_ID VARCHAR(40) COMMENT '수정프로그램ID'
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=INNODB;


DROP TABLE IF EXISTS TB_CTRINF;
CREATE TABLE TB_CTRINF (
 CTR_CD VARCHAR(20) NOT NULL COMMENT '센터코드',
 COMP_CD VARCHAR(20) NOT NULL COMMENT '단지코드',
 CTR_NM VARCHAR(50) COMMENT '센터명',
 BLD_DT DATE COMMENT '설립일자',
 POST_NO VARCHAR(5) COMMENT '우편번호',
 ADDR VARCHAR(255) COMMENT '주소',
 BC_CD VARCHAR(3) COMMENT '업태',
 SPORTS_CD VARCHAR(3) COMMENT '종목',
 ADMIN_ID VARCHAR(10) COMMENT '관리자',
 TOT_HHLD_CNT INT(6) DEFAULT 0 COMMENT '총세대수',
 PIC_LOC VARCHAR(255) COMMENT '사진경로',
 URL VARCHAR(50) COMMENT 'L2_URL',
 AREA_CD VARCHAR(3) COMMENT '지역코드',
 SND_YN VARCHAR(1) DEFAULT 'N' COMMENT '전송여부',
 SND_DT DATE COMMENT '전송일자',
 SND_PGM_ID VARCHAR(40) COMMENT '전송프로그램ID',
 REG_DT DATE COMMENT '생성일자',
 REG_USER_ID VARCHAR(10) COMMENT '생성자ID',
 REG_PGM_ID VARCHAR(40) COMMENT '생산프로그램ID',
 UPD_DT DATE COMMENT '수정일자',
 UPD_USER_ID VARCHAR(10) COMMENT '수정자ID',
 UPD_PGM_ID VARCHAR(40) COMMENT '수정프로그램ID',
 XPERP_APT_CD VARCHAR(5), 
 OPRCO_CD VARCHAR(3) COMMENT '운영업체',
 CTR_HP VARCHAR(30) COMMENT '센터전화번호'
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=INNODB;

DROP TABLE IF EXISTS TB_ENVINF;
CREATE TABLE TB_ENVINF (
 CTR_CD VARCHAR(20) NOT NULL COMMENT '센터코드',
 COMP_CD VARCHAR(20) NOT NULL COMMENT '단지코드',
 PG_VAN_NM VARCHAR(10) COMMENT 'PGVAN사',
 SMS_CD VARCHAR(3) COMMENT 'SMS코드',
 ROUND_CD VARCHAR(3) COMMENT '반올림코드',
 DAY_AMT_CD VARCHAR(3) COMMENT '일단가계산코드',
 BASE_DAYS INT(6) DEFAULT 30 COMMENT '일단가기준일수',
 PENFEE_RATE INT(6) DEFAULT 0 COMMENT '위약금비율',
 REP_CNT INT(6) DEFAULT 0 COMMENT '영수증출력매수',
 KO_REP_CNT INT(6) DEFAULT 0 COMMENT '키오스크영수증출력매수',
 POS_REP_CNT INT(6) DEFAULT 0 COMMENT '포스영수증출력매수',
 PW_INIT VARCHAR(255) COMMENT 'PW초기화',
 GOLF_BASE_M INT(6) DEFAULT 0 COMMENT '골프기본이용시간',
 GOLF_ADD_M INT(6) DEFAULT 0 COMMENT '골프추가이용시간',
 RD_BK_DD VARCHAR(2) COMMENT '독서실정기예약일자',
 RD_BK_TIME VARCHAR(4) COMMENT '독서실정기예약시간',
 LESN_AUTODT VARCHAR(1) DEFAULT 'N' COMMENT '레슨자동기간연장여부',
 KIOSK_LOS INT(6) DEFAULT 0 COMMENT '키오스크로그아웃',
 ALLOC_RTN_DIV VARCHAR(3) COMMENT '배정반납구분',
 L2_IP VARCHAR(20) COMMENT 'L2 IP',
 L2_PORT VARCHAR(20) COMMENT 'L2 PORT',
 CALC_STD VARCHAR(3) COMMENT '정산기준',
 GOLF_CONTROLL_YN VARCHAR(1) DEFAULT 'Y' COMMENT '골프타석연동사용여부',
 MID_RCT_YN VARCHAR(1) DEFAULT 'Y' COMMENT '중도접수사용여부',
 SCR_GOLF_BRK_TIME INT(6) DEFAULT 0 COMMENT '스크린골프청소시간',
 SCR_GOLF_LIMIT_TIME INT(6) DEFAULT 0 COMMENT '스크린골프인당제한시간',
 ID_YN VARCHAR(1) DEFAULT 'Y' COMMENT '본인인증여부',
 ALLOC_PF VARCHAR(3) COMMENT '좌석배정',
 ALLOC_MAX INT(6) DEFAULT 0 COMMENT '인원',
 PT_CALC INT(6) DEFAULT 0 COMMENT 'PT기준일',
 DAY_ALLOC_YN VARCHAR(1) DEFAULT 'Y' COMMENT '일일배정사용여부',
 HOME_LINKAGE_YN VARCHAR(1) DEFAULT 'Y' COMMENT '홈페이지연동여부',
 LESN_APP_WAY VARCHAR(3) COMMENT '단체레슨신청방식',
 REER_NEWAPP_YN VARCHAR(1) DEFAULT 'Y' COMMENT '재등록대상자신규신청여부',
 LESN_PRE_ENTR_TIME INT(6) DEFAULT 0 COMMENT '레슨시작전입장가능시간',
 RT_DAY INT(6) DEFAULT 0 COMMENT '대여일수',
 RT_REP_CNT INT(6) DEFAULT 0 COMMENT '대여영수증출력매수',
 NEXT_MONTH_LESN_REG INT(6) DEFAULT 0 COMMENT '익월레슨등록일',
 HANDKEY_YN VARCHAR(1) DEFAULT 'N' COMMENT '핸드키사용여부',
 DUTYMAX_PF VARCHAR(3) DEFAULT '001' COMMENT '의무부과한도체크 개인별/세대별',
 DUTYMAX_CG VARCHAR(3) DEFAULT '001' COMMENT '의무부과한도체크 센터별/게이트별',
 SND_YN VARCHAR(1) DEFAULT 'N' COMMENT '전송여부',
 SND_DT DATE COMMENT '전송일자',
 SND_PGM_ID VARCHAR(40) COMMENT '전송프로그램ID',
 REG_DT DATE COMMENT '생성일자',
 REG_USER_ID VARCHAR(10) COMMENT '생성자ID',
 REG_PGM_ID VARCHAR(40) COMMENT '생성프로그램ID',
 UPD_DT DATE COMMENT '수정일자',
 UPD_USER_ID VARCHAR(10) COMMENT '수정자ID',
 UPD_PGM_ID VARCHAR(40) COMMENT '수정프로그램ID',
 OVERDUE_YN VARCHAR(1) DEFAULT 'N',
 LOK_END_DT_STD VARCHAR(1) DEFAULT 'Y',
 CU_AGREE_YN VARCHAR(1) DEFAULT 'N',
 CU_AGREE_CONTENT VARCHAR(1000),
 VISIT_USE_TIME INT(6) DEFAULT 0 ,
 GF_TIME_YN VARCHAR(1) DEFAULT 'N',
 ROOM_APP_WAY VARCHAR(3) DEFAULT '001',
 DAYTERM_YN VARCHAR(1) DEFAULT 'N' ,
 ROOM_DAY_BK_CNT INT(6) DEFAULT 0 ,
 GOLF_PAY_YN VARCHAR(1) DEFAULT 'Y',
 ROOM_BK_PF VARCHAR(3) DEFAULT '001',
 ROOM_BK_MAXDAY INT(6) DEFAULT 0,
 ROOM_BK_BASE VARCHAR(3) DEFAULT '001',
 ROOM_BK_MON INT(6) DEFAULT 1,
 ENTRINF_YN VARCHAR(1) DEFAULT 'N',
 KO_ENTR_YN VARCHAR(1) DEFAULT 'Y'
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=INNODB;

DROP TABLE IF EXISTS TB_FAVORITE;
CREATE TABLE TB_FAVORITE (
 CTR_CD VARCHAR(20) NOT NULL COMMENT '센터코드',
 COMP_CD VARCHAR(20) NOT NULL COMMENT '단지코드',
 ADMIN_ID VARCHAR(10) NOT NULL COMMENT '관리자코드',
 PGM_ID VARCHAR(40) NOT NULL COMMENT '프로그램ID',
 MENU_ID VARCHAR(20) COMMENT '메뉴ID',
 PGM_NM VARCHAR(50) COMMENT '프로그램명',
 ORDER_NO INT(6) DEFAULT 0 COMMENT '정렬순서',
 SND_YN VARCHAR(1) DEFAULT 'N' COMMENT '전송여부',
 SND_DT DATE COMMENT '전송일자',
 SND_PGM_ID VARCHAR(40) COMMENT '전송프로그램ID',
 REG_DT DATE COMMENT '생성일자',
 REG_USER_ID VARCHAR(10) COMMENT '생성자ID',
 REG_PGM_ID VARCHAR(40) COMMENT '생성프로그램ID',
 UPD_DT DATE COMMENT '수정일자',
 UPD_USER_ID VARCHAR(10) COMMENT '수정자ID',
 UPD_PGM_ID VARCHAR(40) COMMENT '수정프로그램ID'
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

DROP TABLE IF EXISTS TB_LESNINF;
CREATE TABLE TB_LESNINF (
 CTR_CD VARCHAR(20) NOT NULL COMMENT '센터코드',
 COMP_CD VARCHAR(20) NOT NULL COMMENT '단지코드',
 SPORTS_CD VARCHAR(3) NOT NULL COMMENT '종목코드',
 LESN_CD VARCHAR(5) NOT NULL COMMENT '레슨코드',
 BP_CD VARCHAR(5) NOT NULL COMMENT '업장코드',
 LESN_NM VARCHAR(50) COMMENT '레슨명칭',
 LESN_STR_DT VARCHAR(8) COMMENT '레슨시작일자',
 LESN_END_DT VARCHAR(8) COMMENT '레슨종료일자',
 LESN_STR_TIME VARCHAR(4) COMMENT '레슨시작시간',
 LESN_END_TIME VARCHAR(4) COMMENT '레슨종료시간',
 LESN_DAY VARCHAR(7) COMMENT '레슨요일',
 TCR_ID VARCHAR(10) COMMENT '강사ID',
 REPE_SYS INT(6) DEFAULT 0 COMMENT '횟수',
 LESN_CAPA INT(6) DEFAULT 0 COMMENT '정원',
 KIND_CD VARCHAR(3) COMMENT '종류코드',
 USE_YN VARCHAR(1) DEFAULT 'Y' COMMENT '사용여부',
 REMARK VARCHAR(500) COMMENT '비고사항',
 PT_YN VARCHAR(1) DEFAULT 'Y' COMMENT 'PT레슨여부',
 SND_YN VARCHAR(1) DEFAULT 'N' COMMENT '전송여부',
 SND_DT DATE COMMENT '전송일자',
 SND_PGM_ID VARCHAR(40) COMMENT '전송프로그램ID',
 REG_DT DATE COMMENT '생성일자',
 REG_USER_ID VARCHAR(10) COMMENT '생성자ID',
 REG_PGM_ID VARCHAR(40) COMMENT '생성프로그램ID',
 UPD_DT DATE COMMENT '수정일자',
 UPD_USER_ID VARCHAR(10) COMMENT '수정자ID',
 UPD_PGM_ID VARCHAR(40) COMMENT '수정프로그램ID',
 MON_TICKET_YN VARCHAR(1) DEFAULT 'N',
 PACK_YN VARCHAR(1) DEFAULT 'N',
 MEMB_DISP_YN VARCHAR(1) DEFAULT 'Y',
 MON_TICKET_TYPE VARCHAR(3) DEFAULT '001',
 DAY_ENTR_CNT INT(6) DEFAULT 0,
 MON_TICKET_END_DT_STD VARCHAR(1) DEFAULT 'N',
 ONLINE_CAPA INT(6) DEFAULT 0,
 USE_PF VARCHAR(3) DEFAULT '001',
 ACC_REPE_SYS_YN VARCHAR(1) DEFAULT 'N' COMMENT '누적횟수여부',
 DUPL_YN VARCHAR(1) DEFAULT 'N'
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

DROP TABLE IF EXISTS TB_MENUINF_NEW;
CREATE TABLE TB_MENUINF_NEW (
 AUTH_CODE VARCHAR(20) DEFAULT '000' NOT NULL,
 MENU_ID VARCHAR(20) NOT NULL,
 MENU_NAME VARCHAR(50) NOT NULL,
 PGM_ID VARCHAR(40) DEFAULT NULL,
 APT_CD VARCHAR(50) NOT NULL,
 COMP_CD INT(6) NOT NULL,
 MENU_DIV VARCHAR(1) DEFAULT 'F' NOT NULL,
 UP_MENU_ID VARCHAR(20) DEFAULT NULL,
 MENU_ORDER INT(6),
 USE_YN VARCHAR(1) DEFAULT 'Y' NOT NULL,
 REG_DT DATE NOT NULL,
 REG_USER_NO VARCHAR(20) NOT NULL,
 REG_PGM_ID VARCHAR(20) NOT NULL,
 UPD_DT DATE DEFAULT NULL,
 UPD_USER_NO VARCHAR(20),
 UPD_PGM_ID VARCHAR(20),
 TASK_DIV VARCHAR(3),
 SEARCH_AUTH VARCHAR(1) DEFAULT 'Y',
 PRINT_AUTH VARCHAR(1) DEFAULT 'Y',
 INPUT_AUTH VARCHAR(1) DEFAULT 'Y'
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

DROP TABLE IF EXISTS TB_PGMINF_NEW;
CREATE TABLE TB_PGMINF_NEW (
 PGM_ID VARCHAR(40) NOT NULL,
 SCR_ID VARCHAR(50) NOT NULL,
 PGM_NAME VARCHAR(50) NOT NULL,
 USE_YN VARCHAR(1) DEFAULT 'Y',
 REG_DT DATE DEFAULT NULL,
 REG_USER_NO VARCHAR(20),
 REG_PGM_ID VARCHAR(20),
 UPD_DT DATE DEFAULT NULL,
 UPD_USER_NO VARCHAR(20) DEFAULT NULL,
 UPD_PGM_ID VARCHAR(20) 
)
COMMENT='환경정보'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;
