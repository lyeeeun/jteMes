package jin.mes.form.perform.prodStaMgt.unworkStaMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class UnworkStaMgtService {
	
	@Resource
	UnworkStaMgtMapper unworkStaMgtMapper;
	
	//미작업 현황 조회
	public PageInfo<UnworkStaMgtDto> getUnWorkList(UnworkStaMgtDto unworkStaMgtDto, PageRequestVo pageRequestVo){
		List<UnworkStaMgtDto> unworkList = null;
		int rowCount = 0;
		
		// Page Setting
		unworkStaMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		unworkStaMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = unworkStaMgtMapper.selectUnWorkStaCount(unworkStaMgtDto);
			if (rowCount > 0) {
				//List
				unworkList = unworkStaMgtMapper.selectUnWorkStaList(unworkStaMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("미작업 현황 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (unworkList == null) {
			unworkList = new ArrayList<UnworkStaMgtDto>();
		}
		return new PageInfo<UnworkStaMgtDto>(unworkList, pageRequestVo, rowCount);
	}
}
