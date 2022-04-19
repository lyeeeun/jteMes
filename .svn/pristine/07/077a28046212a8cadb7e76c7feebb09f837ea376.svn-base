package kr.co.itcall.jte.common.mvc;

import java.io.Serializable;

import lombok.Data;

@Data
public class BaseVo implements Serializable {

	private static final long serialVersionUID = 5299773707725560525L;

	/** PageSize */
	private int rows = 1;
	
	/** row number */
	private int RNUM = 1;
	
	/** 현재페이지 */
	private int page = 1;
	
	/**  */
	private int take = 0;
	
	/* 페이징 start 인덱스 (limit)*/
	private int limitIndex = (page-1) * rows;
	
	/** 목록 조회 첫번째 row */
	private int firstIndex;

	/** 목록 조회 마지막 row */
	private int lastIndex;
	
	/** 검색구분 */
	private String searchType = null;
	
	private String searchType2 = null;
	
	private String searchType3 = null;
	
	private String searchType4 = null;
	
	private String searchType5 = null;
	
	/** 검색구분 라벨*/
	private String searchTypeLabel = null;
	
	private String searchTypeLabel2 = null;
	
	private String searchTypeLabel3 = null;
	
	private String searchTypeLabel4 = null;
	
	private String searchTypeLabel5 = null;
	
	/**
	 * 1: default search page(initial page), not 1: not default
	 */
	private int initFlag = 1;
	
	/** 검색어(키워드) */
	private String searchValue = null;
	/** 검색어(키워드) */
	private String searchValue2 = null;
	/** 검색어(키워드) */
	private String searchValue3 = null;
	
	/** 기간 검색 시작일 */
	private String searchStartDate = null;
	
	/** 기간 검색 종료일 */
	private String searchEndDate = null;
	
	/** 기간 검색 구분 */
	private String searchPeriod = "d";
	
	/** 검색 시간 */
	private String searchHour = "00";
	
	/** 검색 분 */
	private String searchMin = "00";
	
	/** 검색 시간 */
	private String searchHour1 = "00";
	
	/** 검색 분 */
	private String searchMin1 = "00";
	
	/** 등록/수정/삭제 Flag */
	private String action = "C";
	
	/** API 연동 결과 메시지 */
	private String systemMessage;
	
	/** API 연동 결과 코드 */
	private String systemCode;
	
	/** API 연동 결과 Parameter : 전체 목록수 */
	private String totalCount;
	
	/** 파일 다운로드 Parameter */
	private String fileName;

	// 해당 직번에 대한 데이터 필터링용
	private String megboEmpnoStr;

	// Safe DB Key
	private String safeDbKey;
	
	// order by
	private String sort;
	
	// 검색
	private String searchGubun;
	private String searchText;
	
	private String langCd;
	
	private String pagingYN = "Y";
	
	//현재 메뉴 아이디
	private String currentMenuId;
	
	public int getLimitIndex() {
		return (page-1) * rows;
	}
}
