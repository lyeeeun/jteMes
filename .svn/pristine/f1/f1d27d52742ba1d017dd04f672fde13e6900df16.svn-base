package jin.mes.cform.ship.orderCompleteMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.ship.shipMgt.NewShipMgtDto;
import jin.mes.cform.ship.shipMgt.NewShipMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewOrderCompleteMgtService {
	
	@Resource
    protected NewOrderCompleteMgtMapper newOrderCompleteMgtMapper;
	
	@Resource
	protected NewShipMgtMapper newShipMgtMapper;
	
	public PageInfo<NewOrderCompleteMgtDto> selectOrderList(NewOrderCompleteMgtDto orderCompleteMgtDto, PageRequestVo pageRequestVo){
		List<NewOrderCompleteMgtDto> orderCompleteMgtList = null;
		int rowCount = 0;

		orderCompleteMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderCompleteMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newOrderCompleteMgtMapper.selectOrderCount(orderCompleteMgtDto);
			if (rowCount > 0) {
				orderCompleteMgtList = newOrderCompleteMgtMapper.selectOrderList(orderCompleteMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("selectOrderList : " + e.getMessage());
		}

		if (orderCompleteMgtList == null) {
			orderCompleteMgtList = new ArrayList<NewOrderCompleteMgtDto>();
		}
		return new PageInfo<NewOrderCompleteMgtDto>(orderCompleteMgtList, pageRequestVo, rowCount);
	}
	
	
	@Transactional
	public void lotStateUpdate(NewShipMgtDto shipMgtDto){
		try {
			newShipMgtMapper.lotStateUpdate(shipMgtDto);
			newShipMgtMapper.updateAfterCost(shipMgtDto);
		} catch (Exception e) {
			throw new BusinessException("lotStateUpdate : " + e.getMessage());
		}
	}
	
	@Transactional
	public void orderStateUpdate(NewShipMgtDto shipMgtDto){
		try {
			for(NewShipMgtDto notCompletLotList : newOrderCompleteMgtMapper.selectNotCompleteLot(shipMgtDto)){
				notCompletLotList.setLotState("ord_sta02");
				newShipMgtMapper.lotStateUpdate(notCompletLotList);
				newShipMgtMapper.updateAfterCost(notCompletLotList);
			}
			shipMgtDto.setOrderState("ord_prcd02");
			newOrderCompleteMgtMapper.orderStateUpdate(shipMgtDto);
		} catch (Exception e) {
			throw new BusinessException("orderStateUpdate : " + e.getMessage());
		}
	}
	
	public List<NewOrderCompleteMgtDto> selectProcShiftTable(NewOrderCompleteMgtDto orderCompleteMgtDto) {
		List<NewOrderCompleteMgtDto> procShiftTable = null;
		try {
			procShiftTable = newOrderCompleteMgtMapper.selectProcShiftTable(orderCompleteMgtDto);
			return procShiftTable;
		} catch (Exception e) {
			throw new BusinessException("selectNotCompleteLot : " + e.getMessage());
		}
	}
	
	public List<NewOrderCompleteMgtDto> selectReturnSurplusMtrl(NewOrderCompleteMgtDto orderCompleteMgtDto) {
		List<NewOrderCompleteMgtDto> ReturnSurplusMtrl = null;
		try {
			ReturnSurplusMtrl = newOrderCompleteMgtMapper.selectReturnSurplusMtrl(orderCompleteMgtDto);
			return ReturnSurplusMtrl;
		} catch (Exception e) {
			throw new BusinessException("selectReturnSurplusMtrl : " + e.getMessage());
		}
	}
	
}
