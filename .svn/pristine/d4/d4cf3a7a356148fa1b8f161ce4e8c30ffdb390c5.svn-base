package jin.mes.cform.ship.rlesPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewRlesPlanMgtService {
	@Resource
    protected NewRlesPlanMgtMapper newRlesPlanMgtMapper;
	
	public PageInfo<NewRlesPlanMgtDto> getPackagePlanList(NewRlesPlanMgtDto rlesPlanMgtDto, PageRequestVo pageRequestVo){
    	List<NewRlesPlanMgtDto> packageList = null;
		int rowCount = 0;

		rlesPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newRlesPlanMgtMapper.selectPackagePlanCount(rlesPlanMgtDto);
			if (rowCount > 0) {
				packageList = newRlesPlanMgtMapper.selectPackagePlanList(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getPackagePlanList 조회 에러입니다. : " + e.getMessage());
		}

		if (packageList == null) {
			packageList = new ArrayList<NewRlesPlanMgtDto>();
		}
		return new PageInfo<NewRlesPlanMgtDto>(packageList, pageRequestVo, rowCount);
	}
	
	public NewRlesPlanMgtDto getPackageAgg(NewRlesPlanMgtDto rlesPlanMgtDto) {
		try {
			return newRlesPlanMgtMapper.selectPackageAgg(rlesPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("getPackageAgg : " + e.getMessage());
		}
	};
	
	public void setPackagePlanList(NewRlesPlanMgtDto rlesPlanMgtDto) {
		try {
			newRlesPlanMgtMapper.insertPackagePlan(rlesPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("setPackagePlanList : " + e.getMessage());
		}
	};
	
	public void updatePackagePlan(NewRlesPlanMgtDto rlesPlanMgtDto) {
		try {
			newRlesPlanMgtMapper.updatePackagePlan(rlesPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("updatePakagePlan : " + e.getMessage());
		}
	};
	
	
	@Transactional
	public void deletePackagePlan(List<NewRlesPlanMgtDto> rlesPlanList){
		try {
			for(NewRlesPlanMgtDto rlesPlanMgtDto : rlesPlanList){
				newRlesPlanMgtMapper.deletePackagePlan(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("deletePackagePlan : " + e.getMessage());
		}
	}
	
	
}
