package jin.mes.form.basMgt.altBoard;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import kr.co.itcall.jte.common.mvc.BaseVo;

public class AltBoardDto extends BaseVo {

	private static final long serialVersionUID = -1779978953498196262L;

	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	/** row number */
	private String rownum;
	/** 사용자ID 검색조건 **/
	private String searchUserId;
	/** 권한그룹ID 검색조건 **/
	private String searchAuthId;

	// 조회조건 : 작성자(bdOwnerNm), 글번호(bdSeq), 글제목(bdTitle), 글본문(bdBody), 날짜범위(cretDt)

	private long bdSeq;	             // '게시판 일련번호';
	private String bdDelYn;          // '삭제여부 기본값(N)';
	private String bdUseYn;          // '사용여부 기본값(Y)';
	private String firstCretTrtrId;  // '생성자ID';
	private String lastChgTrtrId;    // '수정자ID';
	private Date cretDt;             // '생성일자';
	private Date chgDt;              // '수정일자';
	private Date efctStDt;           // '유효시작일자 기본값(생성일)';
	private Date efctFnsDt;          // '유효종료일자 기본값(생성일로부터 365일 후)';
	private String bdOwnerNm;        // '게시글 작성자';
	private String bdEditorNm;       // '게시글 수정자';
	private long bdBfSeq;            // '수정전(원본)게시글 일련번호 기본값(0) 0보다 큰 경우 수정된 글임.';
	private long bdUpSeq;            // '상위게시글 일련번호 기본값(0) 0보다 큰 경우 댓글임.';
	private String bdSttusCd;        // '게시글 진행상태값(접수/진행중/완료/취소) : ALT인경우 접수 -> 진행중 및 취소 -> 완료 : 그룹코드 70003';   
	private String bdTitle;          // '게시글 제목';
	private String bdBody;           // '게시글 본문';
	private String bdDivCd;          // '게시글 종류 기본값(ALT - 공지알림)';
	private int bdUrlsCnt;           // '참조경로 개수 기본값(0)';
	private String bdUrlsNm;         // '참조경로 이름들. 콤마(,)로 구분.'
	private String bdUrlsAddr;       // '참조경로들, 콤마(,)로 구분하여 여러개의 경로를 저장함.';
	private int bdFilesCnt;          // '업로드파일 개수 기본값(0)';
	private String bdFilesNm;        // '업로드파일명들, 콤마(,)로 구분하여 여러개의 파일명을 저장함.';
	private String bdFilesPath;      // '서버에 저장된 파일들의 실제 Full경로, 콤마(,)로 구분하여 여러개의 파일경로를 저장함. 수정에 의해서 동일한 파일 FullPath을 여러 게시판이 공유할 수도 있음. - 수정에 의해서 가능하므로 화면에 보여지는것은 최종게시글만 표시됨.';
	private String bdTgtAuthIds;     // '게시글을 보여줄 대상자의 권한그룹ID들, 콤마(,)로 구분하여 해당 권한그룹ID들에게만 조회됨. 없으면 모두가 대상임.';
	private String bdTgtIds;         // '게시글을 보여줄 대상자의 ID들, 콤마(,)로 구분하여 해당 사용자들에게만 조회됨. 없으면 모두가 대상임.';

	private boolean isOperAuth;      // AUTH_OPERMGT_ALTBOARD_ABLECUD권한이 있는경우 true를 셋팅해준다.
	private List<String> listBdFileNm; // bdFilesNm와 함께 setter시 데이터 공유.
	private List<String> listBdFilePath; // bdFilesPath와 함께 setter시 데이터 공유.
	private List<String> listBdUrlNm; // bdUrlsNm와 함께 setter시 데이터 공유.
	private List<String> listBdUrlAddr; // bdUrlsAddr와 함께 setter시 데이터 공유.
	private List<String> listBdTgtAuthId; // bdTgtAuthIds와 함께 setter시 데이터 공유.
	private List<String> listBdTgtId; // bdTgtIds와 함께 setter시 데이터 공유.
	private String[] removeFilesPath; // 삭제요청이 들어온 실제 저장 위치 경로.

	private List<AltBoardDto> subBoardList; // 댓글유무에 따라 사용됨.

	public int getFirstIndex() {
		return firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public String getRownum() {
		return rownum;
	}

	public String getSearchUserId() {
		return searchUserId;
	}

	public String getSearchAuthId() {
		return searchAuthId;
	}

	public long getBdSeq() {
		return bdSeq;
	}

	public String getBdDelYn() {
		return bdDelYn;
	}

	public String getBdUseYn() {
		return bdUseYn;
	}

	public String getFirstCretTrtrId() {
		return firstCretTrtrId;
	}

	public String getLastChgTrtrId() {
		return lastChgTrtrId;
	}

	public Date getCretDt() {
		return cretDt;
	}

	public Date getChgDt() {
		return chgDt;
	}

	public Date getEfctStDt() {
		return efctStDt;
	}

	public Date getEfctFnsDt() {
		return efctFnsDt;
	}

	public String getBdOwnerNm() {
		return bdOwnerNm;
	}

	public String getBdEditorNm() {
		return bdEditorNm;
	}

	public long getBdBfSeq() {
		return bdBfSeq;
	}

	public long getBdUpSeq() {
		return bdUpSeq;
	}

	public String getBdSttusCd() {
		return bdSttusCd;
	}

	public String getBdTitle() {
		return bdTitle;
	}

	public String getBdBody() {
		return bdBody;
	}

	public String getBdDivCd() {
		return bdDivCd;
	}

	public int getBdFilesCnt() {
		return bdFilesCnt;
	}

	public String getBdFilesNm() {
		return bdFilesNm;
	}

	public String getBdFilesPath() {
		return bdFilesPath;
	}

	public int getBdUrlsCnt() {
		return bdUrlsCnt;
	}

	public String getBdUrlsNm() {
		return bdUrlsNm;
	}

	public String getBdUrlsAddr() {
		return bdUrlsAddr;
	}

	public String getBdTgtAuthIds() {
		return bdTgtAuthIds;
	}

	public String getBdTgtIds() {
		return bdTgtIds;
	}

	public List<String> getListBdFileNm() {
		return listBdFileNm;
	}

	public boolean isOperAuth() {
		return isOperAuth;
	}

	public List<String> getListBdFilePath() {
		return listBdFilePath;
	}

	public List<String> getListBdUrlNm() {
		return listBdUrlNm;
	}

	public List<String> getListBdUrlAddr() {
		return listBdUrlAddr;
	}

	public List<String> getListBdTgtAuthId() {
		return listBdTgtAuthId;
	}

	public List<String> getListBdTgtId() {
		return listBdTgtId;
	}

	public String[] getRemoveFilesPath() {
		return removeFilesPath;
	}

	public List<AltBoardDto> getSubBoardList() {
		return subBoardList;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	public void setSearchUserId(String searchUserId) {
		this.searchUserId = searchUserId;
	}

	public void setSearchAuthId(String searchAuthId) {
		this.searchAuthId = searchAuthId;
	}

	public void setBdSeq(long bdSeq) {
		this.bdSeq = bdSeq;
	}

	public void setBdDelYn(String bdDelYn) {
		this.bdDelYn = bdDelYn;
	}

	public void setBdUseYn(String bdUseYn) {
		this.bdUseYn = bdUseYn;
	}

	public void setFirstCretTrtrId(String firstCretTrtrId) {
		this.firstCretTrtrId = firstCretTrtrId;
	}

	public void setLastChgTrtrId(String lastChgTrtrId) {
		this.lastChgTrtrId = lastChgTrtrId;
	}

	public void setCretDt(Date cretDt) {
		this.cretDt = cretDt;
	}

	public void setChgDt(Date chgDt) {
		this.chgDt = chgDt;
	}

	public void setEfctStDt(Date efctStDt) {
		this.efctStDt = efctStDt;
	}

	public void setEfctFnsDt(Date efctFnsDt) {
		this.efctFnsDt = efctFnsDt;
	}

	public void setBdOwnerNm(String bdOwnerNm) {
		this.bdOwnerNm = bdOwnerNm;
	}

	public void setBdEditorNm(String bdEditorNm) {
		this.bdEditorNm = bdEditorNm;
	}

	public void setBdBfSeq(long bdBfSeq) {
		this.bdBfSeq = bdBfSeq;
	}

	public void setBdUpSeq(long bdUpSeq) {
		this.bdUpSeq = bdUpSeq;
	}

	public void setBdSttusCd(String bdSttusCd) {
		this.bdSttusCd = bdSttusCd;
	}

	public void setBdTitle(String bdTitle) {
		this.bdTitle = bdTitle;
	}

	public void setBdBody(String bdBody) {
		this.bdBody = bdBody;
	}

	public void setBdDivCd(String bdDivCd) {
		this.bdDivCd = bdDivCd;
	}

	public void setBdFilesCnt(int bdFilesCnt) {
		this.bdFilesCnt = bdFilesCnt;
	}

	public void setBdFilesNm(String bdFilesNm) {
		this.bdFilesNm = bdFilesNm;
		this.listBdFileNm = changeCommaToList(bdFilesNm);
	}

	public void setBdFilesPath(String bdFilesPath) {
		this.bdFilesPath = bdFilesPath;
		this.listBdFilePath = changeCommaToList(bdFilesPath);
	}

	public void setBdUrlsCnt(int bdUrlsCnt) {
		this.bdUrlsCnt = bdUrlsCnt;
	}

	public void setBdUrlsNm(String bdUrlsNm) {
		this.bdUrlsNm = bdUrlsNm;
		this.listBdUrlNm = changeCommaToList(bdUrlsNm);
	}

	public void setBdUrlsAddr(String bdUrlsAddr) {
		this.bdUrlsAddr = bdUrlsAddr;
		this.listBdUrlAddr = changeCommaToList(bdUrlsAddr);
	}

	public void setBdTgtAuthIds(String bdTgtAuthIds) {
		this.bdTgtAuthIds = bdTgtAuthIds;
		this.listBdTgtAuthId = changeCommaToList(bdTgtAuthIds);
	}

	public void setBdTgtIds(String bdTgtIds) {
		this.bdTgtIds = bdTgtIds;
		this.listBdTgtId = changeCommaToList(bdTgtIds);
	}

	public void setOperAuth(boolean isOperAuth) {
		this.isOperAuth = isOperAuth;
	}

	public void setListBdFileNm(List<String> listBdFileNm) {
		this.listBdFileNm = listBdFileNm;
		this.bdFilesNm = changeListToComma(listBdFileNm);
	}

	public void setListBdFilePath(List<String> listBdFilePath) {
		this.listBdFilePath = listBdFilePath;
		this.bdFilesPath = changeListToComma(listBdFilePath);
	}

	public void setListBdUrlNm(List<String> listBdUrlNm) {
		this.listBdUrlNm = listBdUrlNm;
		this.bdUrlsNm = changeListToComma(listBdUrlNm);
	}

	public void setListBdUrlAddr(List<String> listBdUrlAddr) {
		this.listBdUrlAddr = listBdUrlAddr;
		this.bdUrlsAddr = changeListToComma(listBdUrlAddr);
	}

	public void setListBdTgtAuthId(List<String> listBdTgtAuthId) {
		this.listBdTgtAuthId = listBdTgtAuthId;
		this.bdTgtAuthIds = changeListToComma(listBdTgtAuthId);
	}

	public void setListBdTgtId(List<String> listBdTgtId) {
		this.listBdTgtId = listBdTgtId;
		this.bdTgtIds = changeListToComma(listBdTgtId);
	}

	public void setRemoveFilesPath(String[] removeFilesPath) {
		this.removeFilesPath = removeFilesPath;
	}

	public void setSubBoardList(List<AltBoardDto> subBoardList) {
		this.subBoardList = subBoardList;
	}

	/**
	 * List Member변수에 셋팅할 때 연관된 콤마(,) 구분 문자열 Member변수에도 동일하게 Overwrite해준다.
	 * @param list
	 * @return
	 */
	private String changeListToComma(List<String> list) {
		StringBuffer sb = new StringBuffer();
		if(list!=null&&list.size()>0) {
			sb.append(list.get(0));
			for (int i = 1; i < list.size(); i++) {
				sb.append(",").append(list.get(i));
			}
			return sb.toString();
		} else {
			return "";
		}
	}

	/**
	 * 콤마(,) 구분 문자열 Member변수에 셋팅할 때 연관된 List Member변수에도 동일하게 Overwirte해준다.
	 * @param comma
	 * @return
	 */
	private List<String> changeCommaToList(String comma){
		if(StringUtils.isEmpty(comma)) {
			return null;
		}
		List<String> result = new ArrayList<String>();
		for (String item : comma.split(",")) {
			result.add(item);
		}
		return result;
	}

}
