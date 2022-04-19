package jin.mes.form.basMgt.codMgt.baseCodeMgt;

import java.util.List;

import javax.persistence.Transient;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BaseCodeMgtDto extends BaseVo {
	
	private static final long serialVersionUID = -7223763972842869911L;
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	/** row number */
	String rownum;
	// 로그인 ID
	private String loginId;
	// 코드 ID
	private String cdId;
	// 생성자 ID
	private String creatorId;
	// 수정자 ID
	private String updatorId;
	// 코드명
	private String cdNm;
	// 코드값(string)
	private String cdVal;
	// 예비값
	private String cdReserve01;
	// 예비값
	private String cdReserve02;
	// 예비값
	private String cdReserve03;
	// 예비값
	private String cdReserve04;
	// 설명
	private String description;
	// 생성일시
	private String createdAt;
	// 수정일시
	private String updatedAt;
	// 상위코드(Parent Code)
	private String upCdId;
	// 정렬
	private String sortNum;
	// 사용여부
	private String useYn;
	
	// 코드 리스트
	@Transient
	private List<BaseCodeMgtDto> baseCodeList;
	
	private List<MsgViewModel> msgList;
}