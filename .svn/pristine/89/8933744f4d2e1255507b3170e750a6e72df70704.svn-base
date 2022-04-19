
SELECT lang_cd, A.* FROM mb_user_info A;
SELECT * FROM mb_rtl_user_role;
SELECT * FROM mb_role_info;
SELECT * FROM mb_rtl_role_auth;
SELECT * FROM mb_auth_bas;

SELECT * FROM cw_menu_bas ORDER BY menu_seq;
SELECT * FROM cw_menu_view;



-- DELETE FROM mb_auth_bas;
SELECT * FROM mb_auth_bas;
-- 권한 기본리스트
INSERT INTO mb_auth_bas(auth_id, created_at, updated_at, creator_id, updator_id, req_svc_uri, DESCRIPTION)

    SELECT 'auth.home' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/home' AS req_svc_uri, 'HOME' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.basMgt.codeMgt.bas' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/basMgt/codeMgt' AS req_svc_uri, '공통코드조회' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.basMgt.codeMgt.cud' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/basMgt/codeMgt/setCode' AS req_svc_uri, '공통코드 생성/수정/삭제' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.operMgt.altBoard.bas' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/operMgt/altBoard' AS req_svc_uri, '게시판 글 조회' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.operMgt.altBoard.cud' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/operMgt/altBoard/setBoard' AS req_svc_uri, '게시판 글 생성/수정/삭제' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.sysMgt.roleMgt.bas' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/sysMgt/roleMgt' AS req_svc_uri, '권한그룹관리' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.sysMgt.menuMgt.bas' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/sysMgt/menuMgt' AS req_svc_uri, '메뉴관리' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.sysLog.sysCtrl.bas' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/sysLog/sysCtrl' AS req_svc_uri, '운영시스템서버FS조회' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'auth.sysLog.sysCtrl.download' AS auth_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '/form/sysLog/sysCtrl/delete' AS req_svc_uri, '운영시스템서버FS 삭제' AS DESCRIPTION FROM DUAL
;

DELETE FROM mb_role_info;
SELECT * FROM mb_role_info;
-- 권한그룹"
INSERT INTO mb_role_info(role_id, role_nm, created_at, updated_at, creator_id, updator_id, DESCRIPTION)
    SELECT 'admin' AS role_id, '전체권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '전체권한(admin)그룹-고객관리자그룹과는별개' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '관리자권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '관리자권한그룹' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '1공장권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '1공장 권한그룹' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '2공장권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '2공장 권한그룹' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, '1사무실권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '1사무실 권한그룹' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, '본사권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '본사 권한그룹' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, '일반사용자권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '일반사용자-일반직원- 권한그룹' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, '손님권한그룹' AS role_nm, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '손님 권한그룹' AS DESCRIPTION FROM DUAL
; -- "





-- DELETE FROM mb_rtl_role_auth;
SELECT * FROM mb_rtl_role_auth;
-- 권한그룹과 권한기본리스트와의 맵핑.
INSERT INTO mb_rtl_role_auth (role_id, auth_id)
  SELECT 'admin' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.basMgt.codeMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.basMgt.codeMgt.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.operMgt.altBoard.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.operMgt.altBoard.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.sysMgt.roleMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.sysMgt.menuMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.sysLog.sysCtrl.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, 'auth.sysLog.sysCtrl.download' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.basMgt.codeMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.basMgt.codeMgt.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.operMgt.altBoard.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.operMgt.altBoard.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.sysMgt.roleMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.sysMgt.menuMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, 'auth.sysLog.sysCtrl.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, 'auth.basMgt.codeMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, 'auth.operMgt.altBoard.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, 'auth.sysMgt.menuMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, 'auth.basMgt.codeMgt.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, 'auth.operMgt.altBoard.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, 'auth.sysMgt.roleMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, 'auth.basMgt.codeMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, 'auth.operMgt.altBoard.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, 'auth.sysMgt.roleMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, 'auth.sysMgt.menuMgt.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, 'auth.sysLog.sysCtrl.bas' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, 'auth.basMgt.codeMgt.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, 'auth.operMgt.altBoard.cud' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, 'auth.home' AS auth_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, 'auth.basMgt.codeMgt.cud' AS auth_id FROM DUAL
; -- "


INSERT INTO cw_menu_bas ;
						SELECT 'basMgt_codeMgt' AS menu_id, FALSE AS is_del, FALSE is_lock, '공통코드관리' AS menu_nm, 'menu.basMgt.codeMgt' AS msg_id, '/form/basMgt/codeMgt' AS svc_url, '/form/basMgt/codeMgt' AS view_url, '기본관리/공통코드관리' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
	UNION ALL	SELECT 'operMgt_altBoard' AS menu_id, FALSE AS is_del, FALSE is_lock, '알림게시판' AS menu_nm, 'menu.operMgt.altBoard' AS msg_id, '/form/operMgt/codeMgt' AS svc_url, '/form/operMgt/altBoard' AS view_url, '운영관리/알림게시판' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
	UNION ALL	SELECT 'sysLog_sysCtrl' AS menu_id, FALSE AS is_del, FALSE is_lock, '서버조회' AS menu_nm, 'menu.sysLog.sysCtrl' AS msg_id, '/form/sysLog/sysCtrl' AS svc_url, '/form/sysLog/sysCtrl' AS view_url, '시스템로그/서버조회' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
;
INSERT INTO CW_MSG_VIEW ;;; -- ( MSG_ID, LANG_CD, Created_at, updated_at, creator_id, updator_id, msg_view) ;;;;
						SELECT 'menu.basMgt.codeMgt' AS MSG_ID, 'en' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 'Code Management' AS msg_view FROM DUAL
	UNION ALL	SELECT 'menu.basMgt.codeMgt' AS MSG_ID, 'ko' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '코드관리' AS msg_view FROM DUAL
	UNION ALL	SELECT 'menu.operMgt.altBoard' AS MSG_ID, 'en' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 'Alert Board' AS msg_view FROM DUAL
	UNION ALL	SELECT 'menu.operMgt.altBoard' AS MSG_ID, 'ko' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '알림 게시판' AS msg_view FROM DUAL
	UNION ALL	SELECT 'menu.sysLog.sysCtrl' AS MSG_ID, 'en' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 'Server View' AS msg_view FROM DUAL
	UNION ALL	SELECT 'menu.sysLog.sysCtrl' AS MSG_ID, 'ko' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, '서버조회' AS msg_view FROM DUAL
;



;
SELECT * FROM cw_comn_code;

SELECT * FROM jte_memb_info;
-- DROP TABLE cw_menu_view;

SELECT * FROM jte_auth_group;
SELECT * FROM jte_auth_info;

COMMIT;



SELECT * FROM CW_MSG_VIEW;

INSERT INTO CW_MSG_VIEW ( MSG_ID, LANG_CD, Created_at, updated_at, creator_id, updator_id, msg_view) ;;;;
					SELECT 'fmcs.logoutMsg' AS MSG_ID, 'en' AS LANG_CD, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 'Are you sure you want to logout?' AS msg_view FROM DUAL
;
-- VALUES ('fmcs.logoutMsg', 'en', SYSDATE(), SYSDATE(), 'SYSTEM', 'SYSTEM', 'Are you sure you want to logout?');
-- VALUES ('fmcs.logoutMsg', 'ko', SYSDATE(), SYSDATE(), 'SYSTEM', 'SYSTEM', '로그아웃 하시겠습니까?');
-- VALUES ('fmcs.wellcome', 'en', SYSDATE(), SYSDATE(), 'SYSTEM', 'SYSTEM', 'Hello world~~~!!!');
-- VALUES ('fmcs.wellcome', 'ko', SYSDATE(), SYSDATE(), 'SYSTEM', 'SYSTEM', '어서오세요. 안녕하신가요?');
;

SELECT * FROM CW_MSG_VIEW msg WHERE msg.lang_cd = 'ko';







SELECT * FROM cw_menu_bas ORDER BY menu_seq;
DELETE FROM cw_menu_bas;
-- 메뉴기본정보"

INSERT INTO cw_menu_bas(menu_id, created_at, updated_at, creator_id, updator_id, menu_seq, is_del, is_lock, menu_nm, msg_id, svc_url, view_url, DESCRIPTION)

    SELECT 'home' AS menu_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 1 AS menu_seq, FALSE AS is_del, FALSE AS is_lock, 'HOME' AS menu_nm, 'menu.home' AS msg_id, '/form/home' AS svc_url, '/form/home' AS view_url, '홈화면' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'basMgt_codeMgt' AS menu_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 2 AS menu_seq, FALSE AS is_del, FALSE AS is_lock, '공통코드관리' AS menu_nm, 'menu.basMgt.codeMgt' AS msg_id, '/form/basMgt/codeMgt' AS svc_url, '/form/basMgt/codeMgt' AS view_url, '기본관리/공통코드관리' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'operMgt_altBoard' AS menu_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 3 AS menu_seq, FALSE AS is_del, FALSE AS is_lock, '알림게시판' AS menu_nm, 'menu.operMgt.altBoard' AS msg_id, '/form/operMgt/codeMgt' AS svc_url, '/form/operMgt/altBoard' AS view_url, '운영관리/알림게시판' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'operMgt_roleMgt' AS menu_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 4 AS menu_seq, FALSE AS is_del, FALSE AS is_lock, '권한그룹관리' AS menu_nm, 'menu.operMgt.roleMgt' AS msg_id, '/form/operMgt/roleMgt' AS svc_url, '/form/operMgt/roleMgt' AS view_url, '권한그룹관리' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'operMgt_menuMgt' AS menu_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 5 AS menu_seq, FALSE AS is_del, FALSE AS is_lock, '메뉴관리' AS menu_nm, 'menu.operMgt.menuMgt' AS msg_id, '/form/operMgt/menuMgt' AS svc_url, '/form/operMgt/menuMgt' AS view_url, '메뉴관리(권한별)' AS DESCRIPTION FROM DUAL
  UNION ALL SELECT 'sysLog_sysCtrl' AS menu_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id, 6 AS menu_seq, FALSE AS is_del, FALSE AS is_lock, '서버조회' AS menu_nm, 'menu.sysLog.sysCtrl' AS msg_id, '/form/sysLog/sysCtrl' AS svc_url, '/form/sysLog/sysCtrl' AS view_url, '시스템로그/서버조회' AS DESCRIPTION FROM DUAL
; -- "



SELECT * FROM cw_menu_view;
DELETE FROM cw_menu_view;
-- 권한별 메뉴VIEW정보"

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- admin 권한메뉴(모든메뉴삽입되며, 추가메뉴)
    SELECT 'admin' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '004' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.operMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '005' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_altBoard' AS menu_id, 1 AS menu_seq, 'menu.operMgt.altBoard' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '006' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_roleMgt' AS menu_id, 2 AS menu_seq, 'menu.operMgt.roleMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '007' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_menuMgt' AS menu_id, 3 AS menu_seq, 'menu.operMgt.menuMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '008' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.sysLog' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'admin' AS role_id, '009' AS view_id, '008' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'sysLog_sysCtrl' AS menu_id, 1 AS menu_seq, 'menu.sysLog.sysCtrl' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_admin 권한메뉴
    SELECT 'role_admin' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '004' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.operMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '005' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_altBoard' AS menu_id, 1 AS menu_seq, 'menu.operMgt.altBoard' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '006' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_roleMgt' AS menu_id, 2 AS menu_seq, 'menu.operMgt.roleMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '007' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_menuMgt' AS menu_id, 3 AS menu_seq, 'menu.operMgt.menuMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '008' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.sysLog' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_admin' AS role_id, '009' AS view_id, '008' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'sysLog_sysCtrl' AS menu_id, 1 AS menu_seq, 'menu.sysLog.sysCtrl' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_factory01 권한메뉴
    SELECT 'role_factory01' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '008' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.sysLog' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '009' AS view_id, '008' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'sysLog_sysCtrl' AS menu_id, 1 AS menu_seq, 'menu.sysLog.sysCtrl' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_factory01 권한메뉴
    SELECT 'role_factory01' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '008' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.sysLog' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory01' AS role_id, '009' AS view_id, '008' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'sysLog_sysCtrl' AS menu_id, 1 AS menu_seq, 'menu.sysLog.sysCtrl' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_factory02 권한메뉴
    SELECT 'role_factory02' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '004' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.operMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '005' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_altBoard' AS menu_id, 1 AS menu_seq, 'menu.operMgt.altBoard' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_factory02' AS role_id, '007' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_menuMgt' AS menu_id, 3 AS menu_seq, 'menu.operMgt.menuMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_office01 권한메뉴
    SELECT 'role_office01' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, '004' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.operMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_office01' AS role_id, '006' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_roleMgt' AS menu_id, 2 AS menu_seq, 'menu.operMgt.roleMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_head_office 권한메뉴
    SELECT 'role_head_office' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, '004' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.operMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, '007' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_menuMgt' AS menu_id, 3 AS menu_seq, 'menu.operMgt.menuMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, '008' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.sysLog' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_head_office' AS role_id, '009' AS view_id, '008' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'sysLog_sysCtrl' AS menu_id, 1 AS menu_seq, 'menu.sysLog.sysCtrl' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_bas_user 권한메뉴
    SELECT 'role_bas_user' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, '004' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.operMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_bas_user' AS role_id, '005' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_altBoard' AS menu_id, 1 AS menu_seq, 'menu.operMgt.altBoard' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 

INSERT INTO cw_menu_view(role_id, view_id, up_view_id, is_lock, menu_cd, menu_id, menu_seq, msg_id, created_at, updated_at, creator_id, updator_id)
 -- role_guest 권한메뉴
    SELECT 'role_guest' AS role_id, '000' AS view_id, NULL AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, 'main' AS menu_id, 1 AS menu_seq, 'menu.main' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, '001' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'home' AS menu_id, 1 AS menu_seq, 'menu.home' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, '002' AS view_id, '000' AS up_view_id, FALSE AS is_lock, 'M' AS menu_cd, NULL AS menu_id, 1 AS menu_seq, 'menu.basMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, '003' AS view_id, '002' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'basMgt_codeMgt' AS menu_id, 1 AS menu_seq, 'menu.basMgt.codeMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, '006' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_roleMgt' AS menu_id, 2 AS menu_seq, 'menu.operMgt.roleMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'role_guest' AS role_id, '007' AS view_id, '004' AS up_view_id, FALSE AS is_lock, 'F' AS menu_cd, 'operMgt_menuMgt' AS menu_id, 3 AS menu_seq, 'menu.operMgt.menuMgt' AS msg_id, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 


SELECT * FROM CW_MSG_VIEW;
SELECT userinfovo0_.user_id AS user_id1_8_, userinfovo0_.created_at AS created_2_8_, userinfovo0_.updated_at AS updated_3_8_, userinfovo0_.creator_id AS creator_4_8_, userinfovo0_.updator_id AS updator_5_8_, userinfovo0_.description AS descript6_8_, userinfovo0_.fail_cnt AS fail_cnt7_8_, userinfovo0_.is_del AS is_del8_8_, userinfovo0_.is_lock AS is_lock9_8_, userinfovo0_.lang_cd AS lang_cd10_8_, userinfovo0_.part_code AS part_co11_8_, userinfovo0_.part_name AS part_na12_8_, userinfovo0_.password AS passwor13_8_, userinfovo0_.test_column AS test_co14_8_, userinfovo0_.user_nm AS user_nm15_8_
 FROM mb_user_info userinfovo0_
 WHERE userinfovo0_.user_id='khaeng'
 AND userinfovo0_.is_lock=0
 AND userinfovo0_.is_del=0
; 
UPDATE mb_user_info SET is_lock = FALSE, is_del = FALSE WHERE user_id = 'khaeng';
COMMIT;

SELECT view.view_id, view.up_view_id, view.menu_cd, view.lvl, view.id_path, view.menu_id, view.menu_seq, view.msg_id, menu.svc_url, menu.view_url, msg.lang_cd, msg_view
FROM (
	-- 특정권한에 대한 소속메뉴 VIEW 출력하기(DEPTH구조로)
	WITH RECURSIVE menu_view AS 
	( 
		SELECT view_id, menu_cd, up_view_id, 0 AS lvl, CAST(view_id AS CHAR(100) CHARACTER SET utf8) id_path, menu_id, menu_seq, msg_id 
			FROM cw_menu_view WHERE up_view_id IS NULL AND is_lock = FALSE AND role_id IN ('admin', 'role_admin')
		UNION ALL 
		SELECT p.view_id, p.menu_cd, p.up_view_id, 1+lvl AS lvl, CONCAT(menu_view.id_path, ',', p.view_id) id_path, p.menu_id, p.menu_seq, p.msg_id FROM cw_menu_view p 
		INNER JOIN menu_view ON p.up_view_id = menu_view.view_id AND is_lock = FALSE AND role_id IN ('admin', 'role_admin')
	) 
	SELECT DISTINCT view_id, up_view_id,menu_cd, lvl, id_path, menu_id, menu_seq, msg_id FROM menu_view  -- IFNULL( up_view_id, '000') AS up_view_id
	-- ORDER BY id_path, menu_seq
) VIEW LEFT JOIN cw_menu_bas menu ON view.menu_id = menu.menu_id AND menu.is_lock = FALSE AND menu.is_del = FALSE
		LEFT JOIN cw_msg_view msg ON view.msg_id = msg.msg_id AND msg.lang_cd = 'ko'
-- WHERE view.up_view_id is not null
ORDER BY view.id_path, view.menu_seq
;

     SELECT view.view_id, view.up_view_id, view.menu_cd, view.lvl, view.id_path, view.menu_id, view.menu_seq, view.msg_id, menu.svc_url, menu.view_url, msg.lang_cd, msg_view, view.msg_path, view.dupl_yn
FROM (
	-- 특정권한에 대한 소속메뉴 VIEW 출력하기(DEPTH구조로)
	WITH RECURSIVE menu_view AS 
	( 
		SELECT view_id, menu_cd, up_view_id, 0 AS lvl, CAST(view_id AS CHAR(100) CHARACTER SET utf8) id_path, menu_id, menu_seq, msg_id, CAST('' AS CHAR(500) CHARACTER SET utf8) msg_path, dupl_yn
			FROM cw_menu_view WHERE up_view_id IS NULL AND is_lock = FALSE AND role_id IN ('admin', 'role_bas_user', 'role_head_office', 'role_factory02')
		UNION ALL 
		SELECT p.view_id, p.menu_cd, p.up_view_id, 1+lvl AS lvl, CONCAT(menu_view.id_path, ',', p.view_id) id_path, p.menu_id, p.menu_seq, p.msg_id, CONCAT(menu_view.msg_path, ',', p.msg_id) msg_path, p.dupl_yn FROM cw_menu_view p
		INNER JOIN menu_view ON p.up_view_id = menu_view.view_id AND is_lock = FALSE AND role_id IN ('admin', 'role_bas_user', 'role_head_office', 'role_factory02')
	) 
	SELECT DISTINCT view_id, up_view_id,menu_cd, lvl, id_path, menu_id, menu_seq, msg_id, RIGHT(msg_path, LENGTH(msg_path)-1) msg_path, dupl_yn FROM menu_view
) VIEW LEFT JOIN cw_menu_bas menu ON view.menu_id = menu.menu_id AND menu.is_lock = FALSE AND menu.is_del = FALSE
		LEFT JOIN cw_msg_view msg ON view.msg_id = msg.msg_id AND msg.lang_cd = 'ko'
ORDER BY view.id_path, view.menu_seq
;

SELECT * FROM cw_menu_view WHERE role_id = 'role_admin' AND is_lock = FALSE -- up_view_id IS NULL 
;




SELECT * FROM CW_MSG_VIEW;
DELETE FROM CW_MSG_VIEW;
-- 메시지 표시테이블"
-- cw_msg_view for [en]
INSERT INTO CW_MSG_VIEW (msg_id, lang_cd, msg_view, created_at, updated_at, creator_id, updator_id)
    SELECT 'menu.main' AS msg_id, 'en' AS lang_cd, 'MANU' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.home' AS msg_id, 'en' AS lang_cd, 'HOME' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.basMgt' AS msg_id, 'en' AS lang_cd, 'Basic Manage' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.basMgt.codeMgt' AS msg_id, 'en' AS lang_cd, 'Code Manage' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt' AS msg_id, 'en' AS lang_cd, 'Operation Manage' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt.altBoard' AS msg_id, 'en' AS lang_cd, 'Alert Board' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt.roleMgt' AS msg_id, 'en' AS lang_cd, 'Role Group Manage' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt.menuMgt' AS msg_id, 'en' AS lang_cd, 'Menu Manage' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.sysLog' AS msg_id, 'en' AS lang_cd, 'System Log' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.sysLog.sysCtrl' AS msg_id, 'en' AS lang_cd, 'Server Control' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 
-- cw_msg_view for [ko]
INSERT INTO CW_MSG_VIEW (msg_id, lang_cd, msg_view, created_at, updated_at, creator_id, updator_id)
    SELECT 'menu.main' AS msg_id, 'ko' AS lang_cd, '메뉴' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.home' AS msg_id, 'ko' AS lang_cd, '홈메뉴' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.basMgt' AS msg_id, 'ko' AS lang_cd, '기본관리' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.basMgt.codeMgt' AS msg_id, 'ko' AS lang_cd, '코드관리' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt' AS msg_id, 'ko' AS lang_cd, '운영관리' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt.altBoard' AS msg_id, 'ko' AS lang_cd, '알림게시판' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt.roleMgt' AS msg_id, 'ko' AS lang_cd, '권한그룹관리' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.operMgt.menuMgt' AS msg_id, 'ko' AS lang_cd, '메뉴관리' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.sysLog' AS msg_id, 'ko' AS lang_cd, '시스템로그' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'menu.sysLog.sysCtrl' AS msg_id, 'ko' AS lang_cd, '서버관리' AS msg_view, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 




DROP TABLE  CW_COMN_CODE;
SELECT * FROM CW_COMN_CODE;
DELETE FROM CW_COMN_CODE ;-- WHERE cd_id = 'sys.flag';
-- 공통코드 테이블"
-- cw_comn_code
INSERT INTO cw_comn_code (cd_id, cd_nm, rel_cd_ids, sort_num, svc_link, up_cd_id, use_yn, view_cd, view_nm, cd_num, cd_val, DESCRIPTION, created_at, updated_at, creator_id, updator_id)
    SELECT 'sys' AS cd_id, 'sys' AS cd_nm, NULL AS rel_cd_ids, '1' AS sort_num, NULL AS svc_link, NULL AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, NULL AS cd_val, '시스템관련 코드 ROOT' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'sys.flag' AS cd_id, 'sys.flag' AS cd_nm, NULL AS rel_cd_ids, '1' AS sort_num, NULL AS svc_link, 'sys' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, NULL AS cd_val, '시스템관련 - 플래그종류선언' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'sys.flag.reflash' AS cd_id, 'sys.flag.reflash' AS cd_nm, NULL AS rel_cd_ids, '1' AS sort_num, NULL AS svc_link, 'sys.flag' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '600' AS cd_num, '600' AS cd_val, '리로드타임(캐쉬/메시지등의 재검색 기준) - 초단위지정' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'biz' AS cd_id, 'biz' AS cd_nm, NULL AS rel_cd_ids, '1' AS sort_num, NULL AS svc_link, NULL AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, NULL AS cd_val, '업무관련' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'biz.altBoardCd' AS cd_id, 'biz.altBoardCd' AS cd_nm, NULL AS rel_cd_ids, '1' AS sort_num, NULL AS svc_link, 'biz' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, NULL AS cd_val, '게시판관련' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'biz.altBoardCd.alt' AS cd_id, 'biz.altBoardCd.alt' AS cd_nm, NULL AS rel_cd_ids, '1' AS sort_num, NULL AS svc_link, 'biz.altBoardCd' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, '공지게시판' AS cd_val, '공지게시판' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'biz.altBoardCd.pop' AS cd_id, 'biz.altBoardCd.pop' AS cd_nm, NULL AS rel_cd_ids, '2' AS sort_num, NULL AS svc_link, 'biz.altBoardCd' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, '팝업게시판' AS cd_val, '팝업게시판' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'biz.altBoardCd.board' AS cd_id, 'biz.altBoardCd.board' AS cd_nm, NULL AS rel_cd_ids, '3' AS sort_num, NULL AS svc_link, 'biz.altBoardCd' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, '일반게시판' AS cd_val, '일반게시판' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
  UNION ALL SELECT 'biz.altBoardCd.down' AS cd_id, 'biz.altBoardCd.down' AS cd_nm, NULL AS rel_cd_ids, '3' AS sort_num, NULL AS svc_link, 'biz.altBoardCd' AS up_cd_id, 'Y' AS use_yn, NULL AS view_cd, 'NULL' AS view_nm, '0' AS cd_num, '자료게시판' AS cd_val, '자료게시판' AS DESCRIPTION, SYSDATE() AS created_at, SYSDATE() AS updated_at, 'SYSTEM' AS creator_id, 'SYSTEM' AS updator_id FROM DUAL
; -- 


