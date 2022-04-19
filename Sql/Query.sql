DROP TABLE IF EXISTS cw_comn_code;
drop table mb_rtl_user_role; 
drop table mb_role_info;
drop table mb_user_info;

DROP SEQUENCE IF EXISTS sq_pms_tech_order_hist_seq;
DROP TABLE IF EXISTS pms_tech_order_part_dtl_list;
drop table IF EXISTS pms_rtl_part_tech_order;
drop table IF EXISTS pms_tech_order_hist;
drop table IF EXISTS pms_part_dtl;
drop table IF EXISTS pms_tech_order;



SELECT * FROM cw_comn_code;
SELECT * FROM MB_ROLE_INFO;
SELECT * FROM MB_USER_INFO;
SELECT * FROM MB_RTL_USER_ROLE;

SELECT * FROM MB_USER_INFO 
	WHERE CREATED_AT IN (SELECT MAX(CREATED_AT) FROM MB_USER_INFO GROUP BY USER_ID )
;





-- 히스토리
INSERT INTO pms_tech_order_hist (seq_no, nation_id, company_id, area_id, engine_model, engine_id, pms_cd_01, pms_cd_02, pms_cd_03, pms_cd_04, pms_cd_05, 
  created_at, creator_id, work_noti, at_fixed_date, at_fixed_hour)
SELECT nextval('sq_pms_tech_order_hist_seq'), 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'engine01', 'DFE', 'FIV', '003', '14', 'H', now(), 'DBA', 'work_noti : 교체테스트', now(), 4210
UNION ALL SELECT nextval('sq_pms_tech_order_hist_seq'), 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'engine09', 'DFE', 'FUS', '001', '14', 'H', now(), 'DBA', 'work_noti : 교체테스트 LDFV53000-012', now(), 2300
SELECT nextval('sq_pms_tech_order_hist_seq')
SELECT * FROM pms_tech_order_hist;

-- 정비주기
INSERT INTO pms_tech_order(nation_id, company_id, area_id, engine_model, pms_cd_01, pms_cd_02, pms_cd_03, pms_cd_04, pms_cd_05, 
            created_at, updated_at, creator_id, updator_id, 
            desc_tech, desc_order, gap_run_hour, desc_etc, need_plate_count, need_plate_info_json, need_plate_no_arr)
SELECT 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'DFE', 'FIV', '003', '14', 'H', now(), now(), 'DBA', 'DBA', 'Fuel Injection Valve', 'Expected life time', 4000, '', 2
, '[{"plateNo":"LDFV52000-102","drawNo":"B9901260820","descPlate":"DOWEL PIN(M69231280)","reqQuty":4,"unitCd":"Cyl","addPart":""}
,{"plateNo":"LDFV52000-111","drawNo":"B9310873230","descPlate":"ATOMIZER ASS''Y(F6961103F,MDHLM,521253)","reqQuty":1,"unitCd":"Cyl","addPart":""}]', ARRAY['LDFV52000-102','LDFV52000-111']
UNION ALL SELECT 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'DFE', 'FUS', '001', '14', 'H', now(), now(), 'DBA', 'DBA', 'Fuel Oil Shock Absorber', 'Overhaul inspection', 4000, '', 2
, '[{"plateNo":"LDFV53000-012","drawNo":"A1416534510","descPlate":"WEARING RING","reqQuty":40,"unitCd":"Eng.","addPart":""}
,{"plateNo":"LDFV53000-013","drawNo":"B9408572808","descPlate":"SEALING RING","reqQuty":40,"unitCd":"Eng.","addPart":""}]', ARRAY['LDFV53000-012','LDFV53000-013']
;
SELECT * FROM pms_tech_order;
/**************
LDFV52000-102
LDFV52000-111
LDFV53000-012
LDFV53000-013 */
-- 장비파트 상세

INSERT INTO pms_part_dtl(nation_id, company_id, area_id, engine_model, plate_no
		, created_at, updated_at, creator_id, updator_id, plate_part, site_cd, draw_no, type_cd, material_no, u_code, prod_std, engine_amt, amt_unit, stock_yn, limit_time
		, amt_count, part_unit, desc_etc)
SELECT 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'LDFV52000-102', now(), now(), 'DBA', 'DBA', 'FUEL INJECTION VALVE ASSEMBLY', 'COF001', 'B9901260820', '대응', 'KB9901260820', 'U32221H0070', 'DOWEL PIN(M69231280)', 80, 'EA', 'Y', 105, 0, '', ''
UNION ALL SELECT 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'LDFV52000-111', now(), now(), 'DBA', 'DBA', 'FUEL INJECTION VALVE ASSEMBLY', 'COF001', 'B9310873230', '표준', 'KB9310873230', 'U32H5211107', 'ATOMIZER ASS''Y(F6961103F,MDHLM,521253)', 20, 'ST', 'Y', 75, 0, '', ''
;
SELECT * FROM pms_part_dtl;



-- 관계테이블.
INSERT INTO pms_tech_order_relate_part_dtl(nation_id, company_id, area_id, engine_model, pms_cd_01, pms_cd_02, pms_cd_03, pms_cd_04, pms_cd_05
            , part_nation_id, part_company_id, part_area_id, part_engine_model, plate_no)
SELECT 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'DFE', 'FIV', '003', '14', 'H', 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'LDFV52000-102'
UNION ALL SELECT 'Columbia', 'Axia', 'Termonorte', '20H35DFV', 'DFE', 'FIV', '003', '14', 'H','Columbia', 'Axia', 'Termonorte', '20H35DFV', 'LDFV52000-111'

