package jin.mes.form.pick.rlesPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class RlesPlanMgtService {
	@Resource
    protected RlesPlanMgtMapper rlesPlanMgtMapper;
	
	@Resource
    protected ShipPlanMgtMapper shipPlanMgtMapper;
	
	//출고계획 조회
	public PageInfo<RlesPlanMgtDto> getRlesPlanList(RlesPlanMgtDto rlesPlanMgtDto, PageRequestVo pageRequestVo){
    	List<RlesPlanMgtDto> rlesPlanList = null;
		int rowCount = 0;

		rlesPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesPlanMgtMapper.selectRlesPlanCount(rlesPlanMgtDto);
			if (rowCount > 0) {
				rlesPlanList = rlesPlanMgtMapper.selectRlesPlanList(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getRlesPlanList 조회 에러입니다. : " + e.getMessage());
		}

		if (rlesPlanList == null) {
			rlesPlanList = new ArrayList<RlesPlanMgtDto>();
		}
		return new PageInfo<RlesPlanMgtDto>(rlesPlanList, pageRequestVo, rowCount);
	}
	
	//lot별 생산재고량 조회
	public PageInfo<RlesPlanMgtDto> getLotStockList(RlesPlanMgtDto rlesPlanMgtDto, PageRequestVo pageRequestVo){
    	List<RlesPlanMgtDto> lotStockList = null;
		int rowCount = 0;

		rlesPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesPlanMgtMapper.selectLotStockCount(rlesPlanMgtDto);
			if (rowCount > 0) {
				lotStockList = rlesPlanMgtMapper.selectLotStockList(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getLotStockList 조회 에러입니다. : " + e.getMessage());
		}

		if (lotStockList == null) {
			lotStockList = new ArrayList<RlesPlanMgtDto>();
		}
		return new PageInfo<RlesPlanMgtDto>(lotStockList, pageRequestVo, rowCount);
	}
	
	//출고계획 저장
	@Transactional
	public String setRlesPlanSave(RlesPlanMgtDto rlesPlanMgtDto) {
		String resultStr = "";
		try {
			rlesPlanMgtDto.setCreatorId(JteUtils.getUserId());
			rlesPlanMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(rlesPlanMgtDto.getAction().equals("C")) { //출고계획 등록
				
				//출고계획 입력
				rlesPlanMgtMapper.insertRlesPlan(rlesPlanMgtDto);

				resultStr =  rlesPlanMgtDto.getRlesPlanId();
				
			}else if(rlesPlanMgtDto.getAction().equals("U")) { //출고계획 수정
				//출고계획 수정
				rlesPlanMgtMapper.updateRlesPlan(rlesPlanMgtDto);
				
				resultStr =  rlesPlanMgtDto.getRlesPlanId();
			}
			
		} catch (Exception e) {
			throw new BusinessException("출고 계획 입력 에러 : " + e.getMessage());
		}
		return resultStr;
	};
	
	//출고계획 삭제
	@Transactional(rollbackFor = {Exception.class})
	public String setRlesPlanDelete(List<RlesPlanMgtDto> rlesPlanList){
		String resultStr = "success";
		try {
			for(RlesPlanMgtDto rlesPlanMgtDto : rlesPlanList){
				if(!rlesPlanMgtDto.getRlesPlanState().equals("rlesSta01")) {
					resultStr = "releasing";
					throw new Exception();
				}
				rlesPlanMgtMapper.deleteRlesPlan(rlesPlanMgtDto);
			}
		} catch (Exception e) {
			if(!resultStr.equals("releasing")) {
			resultStr = "error";
			}
		}
		return resultStr;
	}
	
	
}
