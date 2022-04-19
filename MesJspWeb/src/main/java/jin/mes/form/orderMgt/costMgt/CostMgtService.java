package jin.mes.form.orderMgt.costMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderDetailMgt.OrderDetailMgtDto;
import jin.mes.mapper.orderMgt.costMgt.CostMgtMapper;
import jin.mes.mapper.orderMgt.orderDetailMgt.OrderDetailMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class CostMgtService {
	
	@Resource
	CostMgtMapper costMapper;
	
	@Resource
	OrderDetailMgtMapper orderDetailMgtMapper;
	
	public PageInfo<OrderDetailMgtDto> getOrderCostList(OrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<OrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = costMapper.selectOrderCostListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = costMapper.selectOrderCostList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<OrderDetailMgtDto>();
		}
		return new PageInfo<OrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}

	public PageInfo<LotInfoDto> getLotCostList(LotInfoDto lotInfoDto, PageRequestVo pageRequestVo){
		List<LotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = orderDetailMgtMapper.selectLotListCount(lotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = orderDetailMgtMapper.selectLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<LotInfoDto>();
		}
		return new PageInfo<LotInfoDto>(lotList, pageRequestVo, rowCount);
	}
}
