package jin.mes.form.orderMgt.claimMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtMapper;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtService;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ClaimMgtService {
	
	@Resource
	ClaimMgtMapper claimMapper;
	
	@Resource
	OrderDetailMgtMapper orderMapper;
	
	@Autowired
	OrderDetailMgtService orderService;
	
	public PageInfo<OrderDetailMgtDto> getOrderList(OrderDetailMgtDto OrderDto, PageRequestVo pageRequestVo){
		List<OrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		OrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		OrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = claimMapper.selectOrderListCount(OrderDto);
			if (rowCount > 0) {
				//List
				orderList = claimMapper.selectOrderList(OrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<OrderDetailMgtDto>();
		}
		return new PageInfo<OrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}
	public PageInfo<LotInfoDto> getLotList(LotInfoDto LotInfoDto, PageRequestVo pageRequestVo){
		List<LotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		LotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		LotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = claimMapper.selectLotListCount(LotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = claimMapper.selectLotList(LotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<LotInfoDto>();
		}
		return new PageInfo<LotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	public PageInfo<OrderDetailMgtDto> getOrderClaimList(OrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<OrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = claimMapper.selectOrderClaimListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = claimMapper.selectOrderClaimList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<OrderDetailMgtDto>();
		}
		return new PageInfo<OrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}

	//클레임정보 조회
	public PageInfo<ClaimMgtDto> getLotClaimList(ClaimMgtDto claimDto, PageRequestVo pageRequestVo){
		List<ClaimMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		claimDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = claimMapper.selectLotClaimListCount(claimDto);
			if (rowCount > 0) {
				//List
				lotList = claimMapper.selectLotClaimList(claimDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Claim조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<ClaimMgtDto>();
		}
		return new PageInfo<ClaimMgtDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Claim정보 입력/수정
	@Transactional
	public String setClaimInfoSave(ClaimMgtDto claimDto){
		String returnKey = "";
		try {
			claimDto.setCreatorId(JteUtils.getUserId());
			claimDto.setUpdatorId(JteUtils.getUserId());
			
			//Lot Table에 클레임아이디 등록을 위함
			LotInfoDto lotDto = new LotInfoDto();
			lotDto.setCreatorId(JteUtils.getUserId());
			lotDto.setUpdatorId(JteUtils.getUserId());
			
			if(claimDto.getAction().equals("C")) {
				//Claim 상태 기본값 입력
				claimDto.setClaimState("ord_cla03");
				//Claim 입력
				claimMapper.insertClaimInfo(claimDto);				
				returnKey = claimDto.getClaimId();
				
				//Lot Table에 클레임아이디 등록
				lotDto.setLotSeq(claimDto.getLotSeq());
				lotDto.setClaimId(returnKey);
				lotDto.setAction("U");
				orderService.setLotInfoSave(lotDto);
				
				//Claim 불량 원인 등록
				if(claimDto.getDefectInsertList() != null) {
					claimDto.getDefectInsertList().forEach(x -> {
						claimMapper.insertRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
			}else if(claimDto.getAction().equals("U")){
				//Claim정보 수정
				claimMapper.updateClaimInfo(claimDto);
				
				returnKey = claimDto.getClaimId();
				
				//Claim 불량 원인 등록
				if(claimDto.getDefectInsertList() != null) {
					claimDto.getDefectInsertList().forEach(x -> {
						claimMapper.insertRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(claimDto.getDefectUpdateList() != null) {
					claimDto.getDefectUpdateList().forEach(x -> {
						claimMapper.updateRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(claimDto.getDefectDeleteList() != null) {
					claimDto.getDefectDeleteList().forEach(x -> {
						claimMapper.deleteRtlDefectList(claimDto, x.getBadCode());
					});
				}
			}else if(claimDto.getAction().equals("RE")) {
				//Claim재발주기능
				//claimDto.setLotType("ord_div02");
				//claimDto.setLotState("ord_sta01");
				//재발주 Lot 등록 후 등록된 키값 리턴
				/* claimDto.setLotSeq(orderService.setLotInfoSave(claimDto)); */
				// 재 수주 시 Lot Update (로직 변경)
				claimMapper.updateReorder(claimDto);
				//Claim 재발주 진행 상태변경,재발주 Lot 키 값 매핑 
				claimDto.setClaimState("ord_cla01");
				claimMapper.updateClaimInfo(claimDto);
				
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
	public int setClaimInfoDelete(List<ClaimMgtDto> claimList){
		int resultInt = -1;
		try {
			//자재삭제
			for(ClaimMgtDto claimDto : claimList){
				claimMapper.deleteClaimInfo(claimDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	public List<InfergodsMgtDto> getRtlDefectList(ClaimMgtDto claimMgtDto) {
		List<InfergodsMgtDto> defectList;
		try {
			defectList = claimMapper.selectRtlDefectList(claimMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlDefectList Error " + e.getMessage());
		}
		
		return defectList;
	}
	
	public PageInfo<ClaimMgtDto> selectClaimInfo(ClaimMgtDto claimMgtDto, PageRequestVo pageRequestVo){
		List<ClaimMgtDto> claimList = null;
		int rowCount = 0;

		// Page Setting
		claimMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = claimMapper.selectClaimInfoCount(claimMgtDto);
			if (rowCount > 0) {
				//List
				claimList = claimMapper.selectClaimInfo(claimMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("selectClaimInfo : " + e.getMessage());
		}
		if (claimList == null) {
			claimList = new ArrayList<ClaimMgtDto>();
		}
		return new PageInfo<ClaimMgtDto>(claimList, pageRequestVo, rowCount);
	}
	
}
