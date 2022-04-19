package jin.mes.cform.orderMgt.costMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewCostMgtService {
	
	@Resource
	NewCostMgtMapper newCostMapper;
	
	@Resource
	NewOrderDetailMgtMapper newOrderDetailMgtMapper;
	
	public PageInfo<NewOrderDetailMgtDto> getOrderCostList(NewOrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<NewOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newCostMapper.selectOrderCostListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = newCostMapper.selectOrderCostList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<NewOrderDetailMgtDto>();
		}
		return new PageInfo<NewOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}

	public PageInfo<NewLotInfoDto> getLotCostList(NewLotInfoDto lotInfoDto, PageRequestVo pageRequestVo){
		List<NewLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newOrderDetailMgtMapper.selectLotListCount(lotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = newOrderDetailMgtMapper.selectLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<NewLotInfoDto>();
		}
		return new PageInfo<NewLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
}
