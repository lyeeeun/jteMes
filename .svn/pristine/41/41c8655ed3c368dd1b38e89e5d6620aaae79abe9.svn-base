package jin.mes.form.mtrl.sparePartsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;



@Service

public class SparePartsMgtService {
	
	@Resource
	SparePartsMgtMapper sparePartsMgtMapper;
	

	public PageInfo<SparePartsMgtDto> getToolInfoList(SparePartsMgtDto sparePartsMgtDto, PageRequestVo pageRequestVo){
		List<SparePartsMgtDto> toolMgtList = null;
		
		int rowCount = 0;

		// Page Setting
		sparePartsMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		sparePartsMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = sparePartsMgtMapper.selectToolInfoCount(sparePartsMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = sparePartsMgtMapper.selectToolInfoList(sparePartsMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<SparePartsMgtDto>();
		}
		return new PageInfo<SparePartsMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

}
