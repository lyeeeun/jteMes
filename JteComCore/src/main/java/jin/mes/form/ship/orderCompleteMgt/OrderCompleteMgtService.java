package jin.mes.form.ship.orderCompleteMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.ship.shipMgt.ShipMgtDto;
import jin.mes.form.ship.shipMgt.ShipMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class OrderCompleteMgtService {
	
	@Resource
    protected OrderCompleteMgtMapper orderCompleteMgtMapper;
	
	@Resource
	protected ShipMgtMapper shipMgtMapper;
	
	public PageInfo<OrderCompleteMgtDto> selectOrderList(OrderCompleteMgtDto orderCompleteMgtDto, PageRequestVo pageRequestVo){
		List<OrderCompleteMgtDto> orderCompleteMgtList = null;
		int rowCount = 0;

		orderCompleteMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderCompleteMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = orderCompleteMgtMapper.selectOrderCount(orderCompleteMgtDto);
			if (rowCount > 0) {
				orderCompleteMgtList = orderCompleteMgtMapper.selectOrderList(orderCompleteMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("selectOrderList : " + e.getMessage());
		}

		if (orderCompleteMgtList == null) {
			orderCompleteMgtList = new ArrayList<OrderCompleteMgtDto>();
		}
		return new PageInfo<OrderCompleteMgtDto>(orderCompleteMgtList, pageRequestVo, rowCount);
	}
	
	
	@Transactional
	public void lotStateUpdate(ShipMgtDto shipMgtDto){
		try {
			//shipMgtMapper.lotStateUpdate(shipMgtDto);
			//shipMgtMapper.updateAfterCost(shipMgtDto);
		} catch (Exception e) {
			throw new BusinessException("lotStateUpdate : " + e.getMessage());
		}
	}
	
	@Transactional
	public void orderStateUpdate(ShipMgtDto shipMgtDto){
		try {
			for(ShipMgtDto notCompletLotList : orderCompleteMgtMapper.selectNotCompleteLot(shipMgtDto)){
				notCompletLotList.setLotState("ord_sta02");
				//shipMgtMapper.lotStateUpdate(notCompletLotList);
				//shipMgtMapper.updateAfterCost(notCompletLotList);
			}
			//shipMgtDto.setOrderState("ord_prcd02");
			orderCompleteMgtMapper.orderStateUpdate(shipMgtDto);
		} catch (Exception e) {
			throw new BusinessException("orderStateUpdate : " + e.getMessage());
		}
	}
	
	public List<OrderCompleteMgtDto> selectProcShiftTable(OrderCompleteMgtDto orderCompleteMgtDto) {
		List<OrderCompleteMgtDto> procShiftTable = null;
		try {
			procShiftTable = orderCompleteMgtMapper.selectProcShiftTable(orderCompleteMgtDto);
			return procShiftTable;
		} catch (Exception e) {
			throw new BusinessException("selectNotCompleteLot : " + e.getMessage());
		}
	}
	
	public List<OrderCompleteMgtDto> selectReturnSurplusMtrl(OrderCompleteMgtDto orderCompleteMgtDto) {
		List<OrderCompleteMgtDto> ReturnSurplusMtrl = null;
		try {
			ReturnSurplusMtrl = orderCompleteMgtMapper.selectReturnSurplusMtrl(orderCompleteMgtDto);
			return ReturnSurplusMtrl;
		} catch (Exception e) {
			throw new BusinessException("selectReturnSurplusMtrl : " + e.getMessage());
		}
	}
	
}
