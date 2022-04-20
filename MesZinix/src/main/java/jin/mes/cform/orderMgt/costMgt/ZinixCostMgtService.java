package jin.mes.cform.orderMgt.costMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixCostMgtService {
	
	@Resource
	ZinixCostMgtMapper zinixCostMgtMapper;
	
	public PageInfo<ZinixCostMgtDto> selectLotCostList(ZinixCostMgtDto costMgtDto, PageRequestVo pageRequestVo){
		List<ZinixCostMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		costMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		costMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixCostMgtMapper.selectLotCostListCount(costMgtDto);
			if (rowCount > 0) {
				//List
				lotList = zinixCostMgtMapper.selectLotCostList(costMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<ZinixCostMgtDto>();
		}
		return new PageInfo<ZinixCostMgtDto>(lotList, pageRequestVo, rowCount);
	}
}