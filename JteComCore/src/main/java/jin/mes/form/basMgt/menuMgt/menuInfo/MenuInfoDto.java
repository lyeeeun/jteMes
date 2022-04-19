package jin.mes.form.basMgt.menuMgt.menuInfo;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MenuInfoDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -1178733686796572565L;
	
	private String menuId; 
	private String duplYn; 
	private boolean isDel;
	private boolean isLock; 
	private String menuCd;
	private String menuNm; 
	private String menuSeq; 
	private String msgId;
	private String svcUrl;
	private String ReportsTo;
	private String upMenuId;
	private String viewUrl;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String updatorId;
	private String description;
	private boolean hasChildren;
	private boolean expanded;
	
	private List<MenuInfoDto> items;
	
	private String roleId;
	
	private List<MsgViewModel> msgList;
	
	
	//예비
	private float menuStd01;
	private float menuStd02;
	private float menuStd03;
	private float menuStd04;
	private float menuStd05;
	private String menuStdStr01;
	private String menuStdStr02;
	private String menuStdStr03;
	private String menuStdStr04;
	private String menuStdStr05;
}
