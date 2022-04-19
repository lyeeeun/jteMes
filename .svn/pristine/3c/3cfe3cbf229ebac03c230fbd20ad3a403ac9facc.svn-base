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
	
	public PageInfo<NewOrderDetailMgtDto> getOrderClaimList(NewOrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<NewOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newClaimMapper.selectOrderClaimListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = newClaimMapper.selectOrderClaimList(orderDto);
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
	public PageInfo<NewClaimMgtDto> getLotClaimList(NewClaimMgtDto claimDto, PageRequestVo pageRequestVo){
		List<NewClaimMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		claimDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newClaimMapper.selectLotClaimListCount(claimDto);
			if (rowCount > 0) {
				//List
				lotList = newClaimMapper.selectLotClaimList(claimDto);
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
	public String setClaimInfoSave(NewClaimMgtDto claimDto){
		String returnKey = "";
		try {
			claimDto.setCreatorId(JteUtils.getUserId());
			claimDto.setUpdatorId(JteUtils.getUserId());
			
			//Lot Table에 클레임아이디 등록을 위함
			NewLotInfoDto lotDto = new NewLotInfoDto();
			lotDto.setCreatorId(JteUtils.getUserId());
			lotDto.setUpdatorId(JteUtils.getUserId());
			
			if(claimDto.getAction().equals("C")) {
				//Claim 상태 기본값 입력
				claimDto.setClaimState("ord_cla03");
				//Claim 입력
				newClaimMapper.insertClaimInfo(claimDto);				
				returnKey = claimDto.getClaimId();
				
				//Lot Table에 클레임아이디 등록
				lotDto.setLotSeq(claimDto.getLotSeq());
				lotDto.setClaimId(returnKey);
				lotDto.setAction("U");
				newOrderService.setLotInfoSave(lotDto);
				
				//Claim 불량 원인 등록
				if(claimDto.getDefectInsertList() != null) {
					claimDto.getDefectInsertList().forEach(x -> {
						newClaimMapper.insertRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
			}else if(claimDto.getAction().equals("U")){
				//Claim정보 수정
				newClaimMapper.updateClaimInfo(claimDto);
				
				returnKey = claimDto.getClaimId();
				
				//Claim 불량 원인 등록
				if(claimDto.getDefectInsertList() != null) {
					claimDto.getDefectInsertList().forEach(x -> {
						newClaimMapper.insertRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(claimDto.getDefectUpdateList() != null) {
					claimDto.getDefectUpdateList().forEach(x -> {
						newClaimMapper.updateRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(claimDto.getDefectDeleteList() != null) {
					claimDto.getDefectDeleteList().forEach(x -> {
						newClaimMapper.deleteRtlDefectList(claimDto, x.getBadCode());
					});
				}
			}else if(claimDto.getAction().equals("RE")) {
				//Claim재발주기능
				//claimDto.setLotType("ord_div02");
				//claimDto.setLotState("ord_sta01");
				//재발주 Lot 등록 후 등록된 키값 리턴
				/* claimDto.setLotSeq(orderService.setLotInfoSave(claimDto)); */
				// 재 수주 시 Lot Update (로직 변경)
				newClaimMapper.updateReorder(claimDto);
				//Claim 재발주 진행 상태변경,재발주 Lot 키 값 매핑 
				claimDto.setClaimState("ord_cla01");
				newClaimMapper.updateClaimInfo(claimDto);
				
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
	public int setClaimInfoDelete(List<NewClaimMgtDto> claimList){
		int resultInt = -1;
		try {
			//자재삭제
			for(NewClaimMgtDto claimDto : claimList){
				newClaimMapper.deleteClaimInfo(claimDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	public List<NewInfergodsMgtDto> getRtlDefectList(NewClaimMgtDto claimMgtDto) {
		List<NewInfergodsMgtDto> defectList;
		try {
			defectList = newClaimMapper.selectRtlDefectList(claimMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlDefectList Error " + e.getMessage());
		}
		
		return defectList;
	}
	
	public PageInfo<NewClaimMgtDto> selectClaimInfo(NewClaimMgtDto claimMgtDto, PageRequestVo pageRequestVo){
		List<NewClaimMgtDto> claimList = null;
		int rowCount = 0;

		// Page Setting
		claimMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newClaimMapper.selectClaimInfoCount(claimMgtDto);
			if (rowCount > 0) {
				//List
				claimList = newClaimMapper.selectClaimInfo(claimMgtDto);
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
