package jin.mes.form.ship.shipMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtService;
import jin.mes.form.pick.rlesMgt.RlesMgtMapper;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ShipMgtService {
	
	@Resource
    protected ShipMgtMapper shipMgtMapper;
	
	@Resource
    protected ShipPlanMgtMapper shipPlanMgtMapper;
	
	@Resource
    protected RlesMgtMapper rlesMgtMapper;
	
	@Resource
	protected OrderDetailMgtService orderDetailMgtService;
	
	//출하계획 조회
	public PageInfo<ShipMgtDto> getShipPlanList(ShipMgtDto shipMgtDto, PageRequestVo pageRequestVo){
		List<ShipMgtDto> shipPlanList = null;
		int rowCount = 0;

		shipMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = shipMgtMapper.selectShipPlanCount(shipMgtDto);
			if (rowCount > 0) {
				shipPlanList = shipMgtMapper.selectShipPlanList(shipMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipPlanList == null) {
			shipPlanList = new ArrayList<ShipMgtDto>();
		}
		return new PageInfo<ShipMgtDto>(shipPlanList, pageRequestVo, rowCount);
	}

	//출하 정보 저장
	@Transactional
	public String setShipSave(ShipMgtDto shipMgtDto){
		String returnKey = "";
		try {
			ShipPlanMgtDto shipPlanMgtDto = new ShipPlanMgtDto ();
			
			if(shipMgtDto.getAction().equals("C")) {

			} else if (shipMgtDto.getAction().equals("U")) {
				//출하정보 신규 저장
				if(shipMgtDto.getShipId()==null) {
					
					//출하계획량<출하완료수량 (계획된 수량보다 적은 수량으로 부분 출하 진행)
					if(shipMgtDto.getShipQty()<shipMgtDto.getShipPlanQty()) {
						shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
						shipPlanMgtDto.setShipPlanId(shipMgtDto.getShipPlanId());
						//출하 상태->부분 출하로 변경
						shipPlanMgtDto.setShipPlanState("shipSta02");
						shipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
						
						shipMgtDto.setShipInspect("shipInspectWait");
						shipMgtDto.setCreatorId(JteUtils.getUserId());
						shipMgtDto.setUpdatorId(JteUtils.getUserId());
						//출하 정보 등록
						shipMgtMapper.insertShipInfo(shipMgtDto);
						
						returnKey = "ing";
					}else { //출하계획량 = 출하완료수량 (계획된 수량 이상의 출하 완료.)
						shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
						shipPlanMgtDto.setShipPlanId(shipMgtDto.getShipPlanId());
						//출하 상태->출하 완료로 변경
						shipPlanMgtDto.setShipPlanState("shipSta03");
						shipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
						
						shipMgtDto.setShipInspect("shipInspectWait");
						shipMgtDto.setCreatorId(JteUtils.getUserId());
						shipMgtDto.setUpdatorId(JteUtils.getUserId());
						//출하 정보 등록
						shipMgtMapper.insertShipInfo(shipMgtDto);

						returnKey = "end";
					}
					
				}else { //부분 출하건에 대하여 출하 정보 수정
					
					//출하계획량<출하완료수량 (계획된 수량보다 적은 수량으로 부분 출하 진행)
					if(shipMgtDto.getShipQty()<shipMgtDto.getShipPlanQty()) {
						
						shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
						shipPlanMgtDto.setShipPlanId(shipMgtDto.getShipPlanId());
						//출하 상태->부분 출하로 변경
						shipPlanMgtDto.setShipPlanState("shipSta02");
						shipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
						
						shipMgtDto.setUpdatorId(JteUtils.getUserId());
						//출하정보 수정
						shipMgtMapper.updateShipInfo(shipMgtDto);
						
						returnKey = "ing";
					}else {  //출하계획량 = 출하완료수량 (계획된 수량 이상의 출하 완료.)
						shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
						shipPlanMgtDto.setShipPlanId(shipMgtDto.getShipPlanId());
						//출하 상태->출하 완료로 변경
						shipPlanMgtDto.setShipPlanState("shipSta03");
						shipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
						
						shipMgtDto.setUpdatorId(JteUtils.getUserId());
						//출하 정보 수정
						shipMgtMapper.updateShipInfo(shipMgtDto);
					
						returnKey = "end";
					}
				}
				
				shipPlanMgtDto.setLotId(shipMgtDto.getLotId());
				List<ShipPlanMgtDto> shipPlanList = shipPlanMgtMapper.selectLotStockList(shipPlanMgtDto);
				
				//출하가 진행되면 LoT 상태를 납품진행중으로 변경
				if(shipPlanList.get(0).getShipEndQty()==shipPlanList.get(0).getLotQty()) {
					shipMgtDto.setLotState("ord_sta04");
					shipMgtMapper.updateLotState(shipMgtDto);
				}
				//LoT 수량만큼 출하가 진행되면 LoT 상태를 납품완료로 변경
				else if(!shipPlanList.get(0).getLotState().equals("ord_sta03")) {
					shipMgtDto.setLotState("ord_sta03");
					shipMgtMapper.updateLotState(shipMgtDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("setShipInfo : " + e.getMessage());
		}
		return returnKey;
	}

}
