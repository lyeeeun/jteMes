package jin.mes.form.prcesMgt.gantChtMgt;

import java.sql.Date;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GantChtMgtDto extends BaseVo{
	private static final long serialVersionUID = -7733682245248182119L;
	
	private String title;
	
	private java.util.Date start;
	private java.util.Date end;
	
	private int orderId;
	
	private String id;
	private String parentId;
	private Boolean summary;
	private Boolean expanded;
	private float percentComplete;
	
	// 검색 조건
	private String lotId;
}
