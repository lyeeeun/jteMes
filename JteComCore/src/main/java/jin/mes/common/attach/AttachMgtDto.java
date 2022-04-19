package jin.mes.common.attach;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class AttachMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -5759054517431231732L;
	
	private String attachId;
	private String attachTarget;
	private String attachCode;
	private String attachPath;
	private String attachLocation;
	private String attachOrigin;
	private String attachFilename;
	private String attachExt;
	private float attachSize;
	
	//사용은 안하지만 임시로..
	private String attachCnt;
	
	//썸네일용
	private String imgYn;
	private float imgWidth;
	private float imgHeight;
	
	private String creatorId;
	private String createdAt;
	
	//첨부파일 신규저장 여부(NEW,OLD)
	private String attachStatus;
}
