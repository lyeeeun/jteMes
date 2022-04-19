package jin.mes.form.perform.prodStaMgt.unworkStaMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UnworkStaMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
	//작업정보
	private String prodWorkId;
	private String eqmtMgtId;
	private String prodWorkUser;
	private String prodWorkUserNm;
	private int prodWorkQty;
	private int prodWorkGood;
	private int prodWorkBad;
	private int unWorkQty;
	private String prodWorkStatus;
	
	//JOIN
	private String prodAsmId;
	private String prodAsmDate;
	private int prodAsmQty;
	private String lotId;
	private int lotQty;
	private String itemId;
	private String itemNm;
}
