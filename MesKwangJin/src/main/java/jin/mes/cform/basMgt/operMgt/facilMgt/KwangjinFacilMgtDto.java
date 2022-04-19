package jin.mes.cform.basMgt.operMgt.facilMgt;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinFacilMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -4059437695397381975L;
	
	//설비상세
	private String eqmtMgtId;
	private String eqmtMgtGbn;
	private int eqmtMgtMtnc;
	private String eqmtMgtNm;
	private String eqmtMgtPurchase;
	private String eqmtMgtVerif;
	private String eqmtMgtDesc;
	private String eqmtMgtFile;
	private boolean isUse;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String placeId;
	private String placeNm;
	private String compId;
	private String compNm;
	private String compStdStr02;
	private String compNumber; 
	
	//정비이력
	private String eqmtMtncId;
	private String eqmtMtncStart;
	private String eqmtMtncEnd;
	private String eqmtMtncUser;
	private int eqmtMtncCost;
	private String eqmtMtncDesc;

	//가동이력
	private String eqmtWorkStart;
	private String eqmtWorkEnd;
	private String eqmtWorkTotal;
	private String eqmtWorkTemp;
	
	//다국어
	private List<MsgViewModel> msgList;
	
	//defaultYN (Routing 별)
	private boolean defaultYn;
	
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
	
	//예비
	private float eqmtMgtStd01;
	private float eqmtMgtStd02;
	private float eqmtMgtStd03;
	private float eqmtMgtStd04;
	private float eqmtMgtStd05;
	private String eqmtMgtStdStr01;
	private String eqmtMgtStdStr02;
	private String eqmtMgtStdStr03;
	private String eqmtMgtStdStr04;
	private String eqmtMgtStdStr05;
}
