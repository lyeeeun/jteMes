package jin.mes.cform.mtrl.sparePartsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;



@Service

public class NewSparePartsMgtService {
	
	@Resource
	NewSparePartsMgtMapper newSparePartsMgtMapper;
	

	public PageInfo<NewSparePartsMgtDto> getToolInfoList(NewSparePartsMgtDto newSparePartsMgtDto, PageRequestVo pageRequestVo){
		List<NewSparePartsMgtDto> toolMgtList = null;
		
		int rowCount = 0;

		// Page Setting
		newSparePartsMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newSparePartsMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newSparePartsMgtMapper.selectToolInfoCount(newSparePartsMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = newSparePartsMgtMapper.selectToolInfoList(newSparePartsMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<NewSparePartsMgtDto>();
		}
		return new PageInfo<NewSparePartsMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

}
