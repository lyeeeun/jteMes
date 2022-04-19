package jin.mes.form.mtrl.mtrlInputSta;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MtrlInputStaDto extends BaseVo{
	
	private String orderId;		//수주 코드
	private String orderNm;		//수주명
	private String lotId;		//lot 코드
	private String lotNm;		//lot 이름
	private String itemNm;		//제품명
	private String itemId;		//제품 코드
	private int lotQty;			//주문 수량
	private String mtrlId;		//자재코드
	private String mtrlNm;		//자재명
	private int mtrlNeed;		//필요량
	private int inputQty;		//투입량
	private String prodAsmId;		//작업지시코드
	private String prodAsmNm;		//작업지시명
	private String prodWorkGood;	//생산량
	private String prodWorkBad;		//불량량
	private String bomTargetCnt;		//불량량


	
	private List<MsgViewModel> msgList;
}
