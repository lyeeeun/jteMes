package jin.mes.cform.basMgt.userMgt.userInfo;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewUserInfoDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 8084090909235422659L;
	
	private String userId;
	private String password;
	private String passwordPrev;
	private String pwChangeAt;
	private String userNm;
	private String langCd; 
	private boolean isLock;
	private boolean isDel;
	private int failCnt;
	private String description;
	private String creatorId;
	private String createdAt; 
	private String updatorId;
	private String updatedAt ;
	private String deptId;
	private String deptNm;
	private String positionId;
	private String positionNm;
	
	private String[] role;
}
