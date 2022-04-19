package jin.mes.cform.orderMgt.claimMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtMapper;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtService;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixClaimMgtService {
	
	@Resource
	ZinixClaimMgtMapper zinixClaimMapper;
	
	@Resource
	ZinixOrderDetailMgtMapper zinixOrderMapperr;
	
	@Autowired
	ZinixOrderDetailMgtService orderService;
	
	public PageInfo<ZinixOrderDetailMgtDto> getOrderList(ZinixOrderDetailMgtDto OrderDto, PageRequestVo pageRequestVo){
		List<ZinixOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		OrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		OrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixClaimMapper.selectOrderListCount(OrderDto);
			if (rowCount > 0) {
				//List
				orderList = zinixClaimMapper.selectOrderList(OrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<ZinixOrderDetailMgtDto>();
		}
		return new PageInfo<ZinixOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}
	public PageInfo<ZinixLotInfoDto> getLotList(ZinixLotInfoDto ZinixLotInfoDto, PageRequestVo pageRequestVo){
		List<ZinixLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		ZinixLotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		ZinixLotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixClaimMapper.selectLotListCount(ZinixLotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = zinixClaimMapper.selectLotList(ZinixLotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<ZinixLotInfoDto>();
		}
		return new PageInfo<ZinixLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	public PageInfo<ZinixOrderDetailMgtDto> getOrderClaimList(ZinixOrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<ZinixOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixClaimMapper.selectOrderClaimListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = zinixClaimMapper.selectOrderClaimList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<ZinixOrderDetailMgtDto>();
		}
		return new PageInfo<ZinixOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}

	//클레임정보 조회
	public PageInfo<ZinixClaimMgtDto> getLotClaimList(ZinixClaimMgtDto claimDto, PageRequestVo pageRequestVo){
		List<ZinixClaimMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		claimDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixClaimMapper.selectLotClaimListCount(claimDto);
			if (rowCount > 0) {
				//List
				lotList = zinixClaimMapper.selectLotClaimList(claimDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Claim조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<ZinixClaimMgtDto>();
		}
		return new PageInfo<ZinixClaimMgtDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Claim정보 입력/수정
	@Transactional
	public String setClaimInfoSave(ZinixClaimMgtDto claimDto){
		String returnKey = "";
		try {
			claimDto.setCreatorId(JteUtils.getUserId());
			claimDto.setUpdatorId(JteUtils.getUserId());
			
			//Lot Table에 클레임아이디 등록을 위함
			ZinixLotInfoDto lotDto = new ZinixLotInfoDto();
			lotDto.setCreatorId(JteUtils.getUserId());
			lotDto.setUpdatorId(JteUtils.getUserId());
			
			if(claimDto.getAction().equals("C")) {
				//Claim 상태 기본값 입력
				claimDto.setClaimState("ord_cla03");
				//Claim 입력
				zinixClaimMapper.insertClaimInfo(claimDto);				
				returnKey = claimDto.getClaimId();
				
				//Lot Table에 클레임아이디 등록
				lotDto.setLotSeq(claimDto.getLotSeq());
				lotDto.setClaimId(returnKey);
				lotDto.setAction("U");
				orderService.setLotInfoSave(lotDto);
				
				//Claim 불량 원인 등록
				if(claimDto.getDefectInsertList() != null) {
					claimDto.getDefectInsertList().forEach(x -> {
						zinixClaimMapper.insertRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
			}else if(claimDto.getAction().equals("U")){
				//Claim정보 수정
				zinixClaimMapper.updateClaimInfo(claimDto);
				
				returnKey = claimDto.getClaimId();
				
				//Claim 불량 원인 등록
				if(claimDto.getDefectInsertList() != null) {
					claimDto.getDefectInsertList().forEach(x -> {
						zinixClaimMapper.insertRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(claimDto.getDefectUpdateList() != null) {
					claimDto.getDefectUpdateList().forEach(x -> {
						zinixClaimMapper.updateRtlDefectList(claimDto, x.getBadCode(), x.getBadQty(), JteUtils.getUserId());
					});
				}
				
				if(claimDto.getDefectDeleteList() != null) {
					claimDto.getDefectDeleteList().forEach(x -> {
						zinixClaimMapper.deleteRtlDefectList(claimDto, x.getBadCode());
					});
				}
			}else if(claimDto.getAction().equals("RE")) {
				//Claim재발주기능
				//claimDto.setLotType("ord_div02");
				//claimDto.setLotState("ord_sta01");
				//재발주 Lot 등록 후 등록된 키값 리턴
				/* claimDto.setLotSeq(orderService.setLotInfoSave(claimDto)); */
				// 재 수주 시 Lot Update (로직 변경)
				zinixClaimMapper.updateReorder(claimDto);
				//Claim 재발주 진행 상태변경,재발주 Lot 키 값 매핑 
				claimDto.setClaimState("ord_cla01");
				zinixClaimMapper.updateClaimInfo(claimDto);
				
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
	public int setClaimInfoDelete(List<ZinixClaimMgtDto> claimList){
		int resultInt = -1;
		try {
			//자재삭제
			for(ZinixClaimMgtDto claimDto : claimList){
				zinixClaimMapper.deleteClaimInfo(claimDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	public List<ZinixInfergodsMgtDto> getRtlDefectList(ZinixClaimMgtDto claimMgtDto) {
		List<ZinixInfergodsMgtDto> defectList;
		try {
			defectList = zinixClaimMapper.selectRtlDefectList(claimMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlDefectList Error " + e.getMessage());
		}
		
		return defectList;
	}
	
	public PageInfo<ZinixClaimMgtDto> selectClaimInfo(ZinixClaimMgtDto claimMgtDto, PageRequestVo pageRequestVo){
		List<ZinixClaimMgtDto> claimList = null;
		int rowCount = 0;

		// Page Setting
		claimMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		claimMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixClaimMapper.selectClaimInfoCount(claimMgtDto);
			if (rowCount > 0) {
				//List
				claimList = zinixClaimMapper.selectClaimInfo(claimMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("selectClaimInfo : " + e.getMessage());
		}
		if (claimList == null) {
			claimList = new ArrayList<ZinixClaimMgtDto>();
		}
		return new PageInfo<ZinixClaimMgtDto>(claimList, pageRequestVo, rowCount);
	}
	
}
