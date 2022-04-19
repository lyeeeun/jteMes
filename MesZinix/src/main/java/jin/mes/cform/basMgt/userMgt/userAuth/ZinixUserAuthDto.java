package jin.mes.cform.basMgt.userMgt.userAuth;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixUserAuthDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -6153624410922600137L;
	
	private String roleId;
	private String roleNm;
	private String descrition;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String updatorId;
	private String userId;
	
	// 권한 체크 용
	private String authId;
}
