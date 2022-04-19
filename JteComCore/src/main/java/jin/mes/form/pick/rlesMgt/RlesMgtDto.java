package jin.mes.form.pick.rlesMgt;

import java.util.List;

import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RlesMgtDto extends BaseVo{
	
	private static final long serialVersionUID = 1285233245643841468L;

	
	//출고계획 ID
	private String rlesPlanId;
	//Order ID
	private String orderId;
	//수주명
	private String orderNm;
	//Lot ID
	private String lotId;
	//Lot명
	private String lotNm;
	//Lot 수량
	private String lotQty;
	//개별 품목 ID(Lot ID와 동일)
	private String itemMgtId;
	//품목 ID
	private String itemId;
	//품목 명
	private String itemNm;
	//품목 재고
	private int itemStock;
	//출고 계획량
	private int rlesPlanQty;
	//출고 상태
	private String rlesPlanState;
	//출고 예정일
	private String rlesPlanDate;
	//출고 계획 비고
	private String rlesPlanDesc;
	//생성일
	private String createdAt;
	//생성자
	private String creatorId;
	//수정일
	private String updatedAt;
	//수정자
	private String updatorId;
	//출고 작업 코드
	private String rlesMgtId;
	//출고 작업 수량
	private int rlesMgtQty;
	//출고 작업 시작 시간
	private String rlesWorkStart;
	//출고 작업 종료 시간
	private String rlesWorkEnd;
	//출고 작업자
	private String rlesWorker;
	//출고  비고
	private String rlesMgtDesc;
	
}
