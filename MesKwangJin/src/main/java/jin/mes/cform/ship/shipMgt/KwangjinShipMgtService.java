package jin.mes.cform.ship.shipMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtDto;
import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager = "transactionManager")
@Slf4j
public class KwangjinShipMgtService {

	@Resource
	protected KwangjinShipMgtMapper kwangjinShipMgtMapper;

	@Resource
	protected KwangjinShipPlanMgtMapper kwangjinShipPlanMgtMapper;

	// 출하계획 조회
	public PageInfo<KwangjinShipMgtDto> getShipPlanList(KwangjinShipMgtDto shipMgtDto, PageRequestVo pageRequestVo) {
		List<KwangjinShipMgtDto> shipPlanList = null;
		int rowCount = 0;

		shipMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = kwangjinShipMgtMapper.selectShipPlanCount(shipMgtDto);
			if (rowCount > 0) {
				shipPlanList = kwangjinShipMgtMapper.selectShipPlanList(shipMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipPlanList == null) {
			shipPlanList = new ArrayList<KwangjinShipMgtDto>();
		}
		return new PageInfo<KwangjinShipMgtDto>(shipPlanList, pageRequestVo, rowCount);
	}

	// 출하 정보 저장
	@Transactional
	public String setShipSave(KwangjinShipMgtDto shipMgtDto) {
		String returnKey = "";
		try {
			shipMgtDto.setCreatorId(JteUtils.getUserId());
			shipMgtDto.setUpdatorId(JteUtils.getUserId());

			KwangjinShipPlanMgtDto shipPlanMgtDto = new KwangjinShipPlanMgtDto();

			if (shipMgtDto.getAction().equals("C")) {

				// 출하정보 신규 저장
				shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
				shipPlanMgtDto.setShipPlanId(shipMgtDto.getShipPlanId());
				shipPlanMgtDto.setShipDelivery("deliveryWait");
				
				// 출하 계획 상태 : 출하대기 -> 출하 완료로 변경
				shipPlanMgtDto.setShipPlanState("shipSta02");
				kwangjinShipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);

				// 출하 정보 등록
				kwangjinShipMgtMapper.insertShipInfo(shipMgtDto);

				
				//lot 상태 납품 대기중으로 변경 
				shipMgtDto.setLotState("ord_sta03");
				kwangjinShipMgtMapper.updateLotState(shipMgtDto);
				 

				returnKey = shipMgtDto.getShipPlanId();

			} else if (shipMgtDto.getAction().equals("U")) {
				// 출하정보 신규 저장
				if (shipMgtDto.getShipId() != null) {

					// 출하 정보 수정
					kwangjinShipMgtMapper.updateShipInfo(shipMgtDto);
					returnKey = shipMgtDto.getShipPlanId();
				}
			}

		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("setShipInfo : " + e.getMessage());
		}
		return returnKey;
	}
}
