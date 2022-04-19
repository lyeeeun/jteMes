package jin.mes.cform.orderMgt.claimMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtMapper;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtService;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewClaimMgtService {
	
	@Resource
	NewClaimMgtMapper newClaimMapper;
	
	@Resource
	NewOrderDetailMgtMapper newOrderMapper;
	
	@Autowired
	NewOrderDetailMgtService newOrderService;
	
	public PageInfo<NewOrderDetailMgtDto> getOrderClaimList(NewOrderDetailMgtDto newOrderDto, PageRequestVo pageRequestVo){
		List<NewOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		newOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newClaimMapper.selectOrderClaimListCount(newOrderDto);
			if (rowCount > 0) {
				//List
				orderList = newClaimMapper.selectOrderClaimList(newOrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<NewOrderDetailMgtDto>();
		}
		return new PageInfo<NewOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}

	//클레임정보 조회
	public PageInfo<NewClaimMgtDto> getLotClaimList(NewClaimMgtDto newClaimDto, PageRequestVo pageRequestVo){
		List<NewClaimMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		newClaimDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newClaimDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newClaimMapper.selectLotClaimListCount(newClaimDto);
			if (rowCount > 0) {
				//List
				lotList = newClaimMapper.selectLotClaimList(newClaimDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Claim조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<NewClaimMgtDto>();
		}
		return new PageInfo<NewClaimMgtDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Claim정보 입력/수정
	@Transactional
	public String setClaimInfoSave(NewClaimMgtDto newClaimDto){
		String returnKey = "";
		try {
			newClaimDto.setCreatorId(JteUtils.getUserId());
			newClaimDto.setUpdatorId(JteUtils.getUserId());
			
			//Lot Table에 클레임아이디 등록을 위함
			NewLotInfoDto newLotDto = new NewLotInfoDto();
			newLotDto.setCreatorId(JteUtils.getUserId());
			newLotDto.setUpdatorId(JteUtils.getUserId());
			
			if(newClaimDto.getAction().equals("C")) {
				//Claim 상태 기본값 입력
				newClaimDto.setClaimState("ord_cla03");
				//Claim 입력
				newClaimMapper.insertClaimInfo(newClaimDto);				
				returnKey = newClaimDto.getClaimId();
				
				//Lot Table에 클레임아이디 등록
				newLotDto.setLotSeq(newClaimDto.getLotSeq());
				newLotDto.setClaimId(returnKey);
				newLotDto.setAction("U");
				newOrderService.setLotInfoSave(newLotDto);
				
				//Claim 불량 원인 등록
				if(newClaimDto.getDefectInsertList() != null) {
					newClaimDto.getDefectInsertList().forEach(x -> {
						newClaimMapper.insertRtlDefectList(newClaimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
			}else if(newClaimDto.getAction().equals("U")){
				//Claim정보 수정
				newClaimMapper.updateClaimInfo(newClaimDto);
				
				returnKey = newClaimDto.getClaimId();
				
				//Claim 불량 원인 등록
				if(newClaimDto.getDefectInsertList() != null) {
					newClaimDto.getDefectInsertList().forEach(x -> {
						newClaimMapper.insertRtlDefectList(newClaimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(newClaimDto.getDefectUpdateList() != null) {
					newClaimDto.getDefectUpdateList().forEach(x -> {
						newClaimMapper.updateRtlDefectList(newClaimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(newClaimDto.getDefectDeleteList() != null) {
					newClaimDto.getDefectDeleteList().forEach(x -> {
						newClaimMapper.deleteRtlDefectList(newClaimDto, x.getBadCode());
					});
				}
			}else if(newClaimDto.getAction().equals("RE")) {
				//Claim재발주기능
				//newClaimDto.setLotType("ord_div02");
				//newClaimDto.setLotState("ord_sta01");
				//재발주 Lot 등록 후 등록된 키값 리턴
				/* newClaimDto.setLotSeq(newOrderService.setLotInfoSave(newClaimDto)); */
				// 재 수주 시 Lot Update (로직 변경)
				newClaimMapper.updateReorder(newClaimDto);
				//Claim 재발주 진행 상태변경,재발주 Lot 키 값 매핑 
				newClaimDto.setClaimState("ord_cla01");
				newClaimMapper.updateClaimInfo(newClaimDto);
				
				returnKey = newClaimDto.getClaimId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("Claim정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Claim정보 삭제
	@Transactional
	public int setClaimInfoDelete(List<NewClaimMgtDto> claimList){
		int resultInt = -1;
		try {
			//자재삭제
			for(NewClaimMgtDto newClaimDto : claimList){
				newClaimMapper.deleteClaimInfo(newClaimDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	public List<NewInfergodsMgtDto> getRtlDefectList(NewClaimMgtDto newClaimMgtDto) {
		List<NewInfergodsMgtDto> defectList;
		try {
			defectList = newClaimMapper.selectRtlDefectList(newClaimMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlDefectList Error " + e.getMessage());
		}
		
		return defectList;
	}
	
	public PageInfo<NewClaimMgtDto> selectClaimInfo(NewClaimMgtDto newClaimMgtDto, PageRequestVo pageRequestVo){
		List<NewClaimMgtDto> claimList = null;
		int rowCount = 0;

		// Page Setting
		newClaimMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newClaimMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newClaimMapper.selectClaimInfoCount(newClaimMgtDto);
			if (rowCount > 0) {
				//List
				claimList = newClaimMapper.selectClaimInfo(newClaimMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("selectClaimInfo : " + e.getMessage());
		}
		if (claimList == null) {
			claimList = new ArrayList<NewClaimMgtDto>();
		}
		return new PageInfo<NewClaimMgtDto>(claimList, pageRequestVo, rowCount);
	}
	
}
