package jin.mes.form.mtrl.sparePartsMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SparePartsMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 8122587812095601337L;

	
	private String toolId; 
	private String toolNm;
	private String toolDc;
	private String toolType; 
	private int toolPrice; 
	private int toolLimit; 
	private String toolDesc;
	private boolean isUse;
	private String creatorId;
	private String createdAt; 
	private String updatorId;
	private String updatedAt;
	private int toolCount;
	
	private List<MsgViewModel> msgList;	
	
}
