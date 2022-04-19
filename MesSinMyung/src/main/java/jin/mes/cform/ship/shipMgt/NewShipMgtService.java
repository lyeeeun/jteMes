package jin.mes.cform.ship.shipMgt;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.ship.rlesMgt.NewRlesMgtDto;
import jin.mes.cform.ship.rlesMgt.NewRlesMgtMapper;
import jin.mes.cform.ship.shipPlanMgt.NewShipPlanMgtDto;
import jin.mes.cform.ship.shipPlanMgt.NewShipPlanMgtMapper;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewShipMgtService {
	
	@Resource
    protected NewShipMgtMapper newShipMgtMapper;
	
	@Resource
	protected NewShipPlanMgtMapper newShipPlanMgtMapper;
	
	@Resource
	protected NewRlesMgtMapper newRlesMgtMapper;
	
	public int getPackageStock(NewShipMgtDto shipMgtDto) {
		int result = 0;
		try {
			result = newShipMgtMapper.selectPackageStock(shipMgtDto); 
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return result;
	}
	
	@Transactional
	public void shipAction(NewShipMgtDto shipMgtDto){
		try {
			newShipMgtMapper.shipStateUpdate(shipMgtDto);
			if(shipMgtDto.getShipState().equals("ship_dvry02")) {
				NewRlesMgtDto rlesMgtDto = new NewRlesMgtDto();
				rlesMgtDto.setItemId(shipMgtDto.getItemId());
				rlesMgtDto.setItemMgtId(shipMgtDto.getLotId());
				rlesMgtDto.setLotId(shipMgtDto.getLotId());
				rlesMgtDto.setPrsPackageQty(-shipMgtDto.getShipQty());
				newRlesMgtMapper.updatePackageStock(rlesMgtDto);
			} else if(shipMgtDto.getShipState().equals("ship_dvry03")) {
				NewShipPlanMgtDto shipPlanMgtDto = new NewShipPlanMgtDto();
				shipPlanMgtDto.setLotId(shipMgtDto.getLotId());
				shipPlanMgtDto.setLotSeq(shipMgtDto.getLotSeq());
				int shipCompleteQty = newShipPlanMgtMapper.selectShipCompleteQty(shipPlanMgtDto);
				int lotQty = newShipMgtMapper.selectLotQty(shipMgtDto);
				
				if(shipCompleteQty >= lotQty) {
					shipMgtDto.setLotState("ord_sta02");
					newShipMgtMapper.lotStateUpdate(shipMgtDto);
					newShipMgtMapper.updateAfterCost(shipMgtDto);
				}
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
	}
}
