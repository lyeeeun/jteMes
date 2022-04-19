package jin.mes.form.ship.rlesMgt;

import java.util.List;

import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RlesMgtDto extends BaseVo{
	
	private static final long serialVersionUID = 1285233245643841468L;

	/*** 품목 재고 정보 ***/
	// 수주 ID
	private String orderId;
	// 수주 명
	private String orderNm;
	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 개별 품목 ID
	private String itemMgtId;
	// 개별 품목 구분(ADMIN, LOT)
	private String itemMgtType;
	// 개별 품목 재고량
	private int itemStock;
	// 개별 품목 포장 수량(출하 대기 수량)
	private int itemPackageStock;
	// 품목 총 수량
	private int itemTotalStock;
	
	/*** 포장 계획 정보 ***/
	// 포장 계획 ID
	private String pkgId;
	// 포장 계획 수량
	private int pkgPlanQty;
	// 비고
	private String pkgDesc;
	// 포장 계획 상태
	private String pkgState;
	
	/*** 포장 작업 정보 ***/
	// 포장 작업 ID
	private String pkgWorkId;
	// 작업자
	private String pkgWorkUser;
	// 포장 작업수량
	private int prsPackageQty;
	// 포장 작업 시작 시간
	private String pkgWorkStart;
	// 포장 작업 종료 시간
	private String pkgWorkEnd;
	// Lot ID
	private String lotId;
	// 비고
	private String description;
	// 작업자명
	private String pkgWorkUserNm;
	/*** 불량 정보 ***/
	// 불량 정보(Insert)
	private List<InfergodsMgtDto> defectInsertList;
	// 불량 총 수량
	private int defectQty;
	
	//품질 - 검사
	private int badQty;
	private int lotQty;
	private String compId;
	private String compNm;
	
	/*** 묶음 정보 ***/
	// 포장 단위
	private String bundleUnit;
	// 포장 수량
	private int bundleQty;
	// 포장 리스트(Select, Insert)
	private List<RlesMgtDto> bundleInsertList;
	// 포장 리스트(Update)
	private List<RlesMgtDto> bundleUpdateList;
	// 포장 리스트(Delete)
	private List<RlesMgtDto> bundleDeleteList;
	
}
