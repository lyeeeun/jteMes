package jin.mes.cform.orderMgt.claimMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinClaimMgtService {
	
	@Resource
	KwangjinClaimMgtMapper kwangjinClaimMapper;
	
	//클레임정보 조회
	public PageInfo<KwangjinClaimMgtDto> getLotClaimList(KwangjinClaimMgtDto claimDto, PageRequestVo pageRequestVo){
		List<KwangjinClaimMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		claimDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinClaimMapper.selectLotClaimListCount(claimDto);
			if (rowCount > 0) {
				//List
				lotList = kwangjinClaimMapper.selectLotClaimList(claimDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Claim조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<KwangjinClaimMgtDto>();
		}
		return new PageInfo<KwangjinClaimMgtDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Claim정보 입력/수정
	@Transactional
	public String setClaimInfoSave(KwangjinClaimMgtDto claimDto){
		String returnKey = "";
		try {
			claimDto.setCreatorId(JteUtils.getUserId());
			
			if(claimDto.getAction().equals("C")) {
				//Claim 상태 기본값 입력
				claimDto.setClaimState("ord_cla03");
				//Claim 입력
				kwangjinClaimMapper.insertClaimInfo(claimDto);
				returnKey = claimDto.getClaimId();
				
			}else if(claimDto.getAction().equals("U")){
				//Claim정보 수정
				kwangjinClaimMapper.updateClaimInfo(claimDto);
				
				returnKey = claimDto.getClaimId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("Claim정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Claim정보 삭제
	@Transactional
	public int setClaimInfoDelete(List<KwangjinClaimMgtDto> claimList){
		int resultInt = -1;
		try {
			//자재삭제
			for(KwangjinClaimMgtDto claimDto : claimList){
				kwangjinClaimMapper.deleteClaimInfo(claimDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
