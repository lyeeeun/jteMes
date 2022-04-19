package jin.mes.form.orderMgt.costMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class CostMgtService {
	
	@Resource
	CostMgtMapper costMgtMapper;
	
	public PageInfo<CostMgtDto> selectLotCostList(CostMgtDto costMgtDto, PageRequestVo pageRequestVo){
		List<CostMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		costMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		costMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = costMgtMapper.selectLotCostListCount(costMgtDto);
			if (rowCount > 0) {
				//List
				lotList = costMgtMapper.selectLotCostList(costMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<CostMgtDto>();
		}
		return new PageInfo<CostMgtDto>(lotList, pageRequestVo, rowCount);
	}
}
