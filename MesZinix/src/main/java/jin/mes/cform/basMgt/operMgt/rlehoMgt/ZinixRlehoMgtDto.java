package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixRlehoMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -2734621624328928452L;
	
	private String placeId;
	private String placeNm;
	private String placeParent;
	private String placeManager;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String updatorId;
	private String description;
	private boolean isUse;
	private String placeManagerNm;
	
	//예비
		private float placeStd01; 
		private float placeStd02;
		private float placeStd03;
		private float placeStd04;
		private float placeStd05;
		private float placeStdStr01;
		private float placeStdStr02;
		private float placeStdStr03;
		private float placeStdStr04;
		private float placeStdStr05;
	
	private boolean hasChildren;
	
	private List<MsgViewModel> msgList;
}
