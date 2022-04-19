package jin.mes.cform.mfgMgt.mfgplanMgt.mrplanMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewMrplanMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -2907612194375862677L;
	
	
	private String orderId;		//수주 코드
	private String orderNm;		//수주명
	private String lotId;		//lot 코드
	private String lotNm;		//lot 이름
	private String itemNm;		//제품명
	private String itemId;		//제품 코드
	private int lotQty;			//주문 수량
	private String mtrlId;		//자재코드
	private String mtrlNm;		//자재명
	private int bomTargetCnt;	//표준량
	private int mtrlNeed;		//필요량
	private int mtrlMgtCnt;		//자재재고량
	private int mtrlOrderQty;	//입고예정
	private int mtrlUseNeed;	//사용예정량
	private int mtrlCanUse;		//가용량
	private int mtrlOdCnt;		//발주량
	private String mtrlDiv;		//자재구분
	private int mtrlCost;		//자재가격
	
	private List<MsgViewModel> msgList;
}
