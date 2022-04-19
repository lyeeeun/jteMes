package jin.mes.form.ship.shipMgt;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.ship.rlesMgt.RlesMgtDto;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import jin.mes.mapper.ship.rlesMgt.RlesMgtMapper;
import jin.mes.mapper.ship.shipMgt.ShipMgtMapper;
import jin.mes.mapper.ship.shipPlanMgt.ShipPlanMgtMapper;
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
	
	public int getPackageStock(ShipMgtDto shipMgtDto) {
		int result = 0;
		try {
			result = shipMgtMapper.selectPackageStock(shipMgtDto); 
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return result;
	}
	
	@Transactional
	public void shipAction(ShipMgtDto shipMgtDto){
		try {
			shipMgtMapper.shipStateUpdate(shipMgtDto);
			if(shipMgtDto.getShipState().equals("ship_dvry02")) {
				RlesMgtDto rlesMgtDto = new RlesMgtDto();
				rlesMgtDto.setItemId(shipMgtDto.getItemId());
				rlesMgtDto.setItemMgtId(shipMgtDto.getLotId());
				rlesMgtDto.setLotId(shipMgtDto.getLotId());
				rlesMgtDto.setPrsPackageQty(-shipMgtDto.getShipQty());
				rlesMgtMapper.updatePackageStock(rlesMgtDto);
			} else if(shipMgtDto.getShipState().equals("ship_dvry03")) {
				ShipPlanMgtDto shipPlanMgtDto = new ShipPlanMgtDto();
				shipPlanMgtDto.setLotId(shipMgtDto.getLotId());
				shipPlanMgtDto.setLotSeq(shipMgtDto.getLotSeq());
				int shipCompleteQty = shipPlanMgtMapper.selectShipCompleteQty(shipPlanMgtDto);
				int lotQty = shipMgtMapper.selectLotQty(shipMgtDto);
				
				if(shipCompleteQty >= lotQty) {
					shipMgtDto.setLotState("ord_sta02");
					shipMgtMapper.lotStateUpdate(shipMgtDto);
					shipMgtMapper.updateAfterCost(shipMgtDto);
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
	}
}
