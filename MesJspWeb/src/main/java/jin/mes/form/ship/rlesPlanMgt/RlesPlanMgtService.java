package jin.mes.form.ship.rlesPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.ship.rlesPlanMgt.RlesPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class RlesPlanMgtService {
	@Resource
    protected RlesPlanMgtMapper rlesPlanMgtMapper;
	
	public PageInfo<RlesPlanMgtDto> getPackagePlanList(RlesPlanMgtDto rlesPlanMgtDto, PageRequestVo pageRequestVo){
    	List<RlesPlanMgtDto> packageList = null;
		int rowCount = 0;

		rlesPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesPlanMgtMapper.selectPackagePlanCount(rlesPlanMgtDto);
			if (rowCount > 0) {
				packageList = rlesPlanMgtMapper.selectPackagePlanList(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getPackagePlanList 조회 에러입니다. : " + e.getMessage());
		}

		if (packageList == null) {
			packageList = new ArrayList<RlesPlanMgtDto>();
		}
		return new PageInfo<RlesPlanMgtDto>(packageList, pageRequestVo, rowCount);
	}
	
	public RlesPlanMgtDto getPackageAgg(RlesPlanMgtDto rlesPlanMgtDto) {
		try {
			return rlesPlanMgtMapper.selectPackageAgg(rlesPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("getPackageAgg : " + e.getMessage());
		}
	};
	
	public void setPackagePlanList(RlesPlanMgtDto rlesPlanMgtDto) {
		try {
			rlesPlanMgtMapper.insertPackagePlan(rlesPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("setPackagePlanList : " + e.getMessage());
		}
	};
	
	public void updatePackagePlan(RlesPlanMgtDto rlesPlanMgtDto) {
		try {
			rlesPlanMgtMapper.updatePackagePlan(rlesPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("updatePakagePlan : " + e.getMessage());
		}
	};
	
	
	@Transactional
	public void deletePackagePlan(List<RlesPlanMgtDto> rlesPlanList){
		try {
			for(RlesPlanMgtDto rlesPlanMgtDto : rlesPlanList){
				rlesPlanMgtMapper.deletePackagePlan(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("deletePackagePlan : " + e.getMessage());
		}
	}
	
	
}
