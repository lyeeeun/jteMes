package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt.ZinixMtrlOdcursitMgtDto;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt.ZinixMtrlOdcursitMgtMapper;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixMtrlOdplanMgtService {
	@Resource
	ZinixMtrlOdplanMgtMapper zinixMtrlOrderMapper;
	
	@Resource
	ZinixMtrlOdcursitMgtMapper zinixMtrlOrderFormMapper;
	
	@Autowired
	ZinixMtrlMgtService mtrlMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<ZinixMtrlOdplanMgtDto> getMtrlOrderList(ZinixMtrlOdplanMgtDto mtrlOrderDto, PageRequestVo pageRequestVo){
		List<ZinixMtrlOdplanMgtDto> mtrlOrderList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixMtrlOrderMapper.selectMtrlOrderCount(mtrlOrderDto);
			if (rowCount > 0) {
				//List
				mtrlOrderList = zinixMtrlOrderMapper.selectMtrlOrderList(mtrlOrderDto);
				
				mtrlOrderList.get(0).setOrderCompList(zinixMtrlOrderMapper.selectOrderCompChild(mtrlOrderDto));
			}
		} catch (Exception e) {
			throw new BusinessException("발주정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderList == null) {
			mtrlOrderList = new ArrayList<ZinixMtrlOdplanMgtDto>();
		}
		return new PageInfo<ZinixMtrlOdplanMgtDto>(mtrlOrderList, pageRequestVo, rowCount);
	}
	
	//발주정보 입력/수정
	@Transactional(rollbackFor = {Exception.class})
	public String setMtrlOrderSave(ZinixMtrlOdplanMgtDto mtrlOrderDto){
		String returnKey = "";
		try {
			mtrlOrderDto.setCreatorId(JteUtils.getUserId());
			mtrlOrderDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlOrderDto.getAction().equals("C")) {
				//발주입력
				zinixMtrlOrderMapper.insertMtrlOrder(mtrlOrderDto);
				returnKey = mtrlOrderDto.getMtrlOrderId();
				
				setOrderCompSave(mtrlOrderDto);
			}else if(mtrlOrderDto.getAction().equals("U")){//발주 변경/발주진행
				//발주수정
				zinixMtrlOrderMapper.updateMtrlOrder(mtrlOrderDto);
				
				returnKey =mtrlOrderDto.getMtrlOrderId();
				setOrderCompSave(mtrlOrderDto);
			}else if(mtrlOrderDto.getAction().equals("END") || mtrlOrderDto.getAction().equals("ENDUP")){//발주 완료
				
				mtrlOrderDto.setMtrlOrderState("mtrl_order_end");//발주완료
				
				//발주수정
				zinixMtrlOrderMapper.updateMtrlOrder(mtrlOrderDto);
				
				returnKey = mtrlOrderDto.getMtrlOrderId();
				
				//자재수량을 저장하기 위한 생성자
				ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(mtrlOrderDto.getMtrlId(), "mtrl_tagt01", returnKey,
						mtrlOrderDto.getMtrlOrderQty(), mtrlOrderDto.getMtrlOrderDate(), mtrlOrderDto.getMtrlOrderUser(), mtrlOrderDto.getMtrlMgtId(), null);
				
				//등록인지 수정인지 판단
				if(mtrlOrderDto.getAction().equals("END")) {
					mtrlCntDto.setAction("ADD");//자재 수량 insert
				}else {
					mtrlCntDto.setAction("U");//자재 수량 update
				}
				
				//자재수량 저장
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
				//모든품목이 발주가 완료되었으면 발주주문서 완료처리
				mtrlOrderDto.setMtrlOrderState("mtrl_order_prs");//진행중
				mtrlOrderDto.setMtrlOrderId(null);
				if(zinixMtrlOrderMapper.selectMtrlOrderList(mtrlOrderDto).size() == 0) {
					ZinixMtrlOdcursitMgtDto mtrlOrderFormDto = new ZinixMtrlOdcursitMgtDto();
					mtrlOrderFormDto.setMtrlOfId(mtrlOrderDto.getMtrlOfId());
					mtrlOrderFormDto.setMtrlOfState("mtrl_sta02");//발주완료
					mtrlOrderFormDto.setUpdatorId(JteUtils.getUserId());
					mtrlOrderFormDto.setAction("END");
					zinixMtrlOrderFormMapper.updateMtrlOrderForm(mtrlOrderFormDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("발주정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//발주현황 - 일괄저장
	@Transactional(rollbackFor = {Exception.class})
	public String setMtrlOrderBatchSave(List<ZinixMtrlOdplanMgtDto> mtrlOrderList){
		String returnKey = "";
		try {
			for(ZinixMtrlOdplanMgtDto mtrlOrderDto : mtrlOrderList) {
				setMtrlOrderSave(mtrlOrderDto);
			}
			
			returnKey = mtrlOrderList.get(0).getMtrlOfId();
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("발주현황 - 일괄저장 : " + e.getMessage());
		}
		return returnKey;
	}
		
	//발주정보 삭제
	@Transactional(rollbackFor = {Exception.class})
	public int setMtrlOrderDelete(List<ZinixMtrlOdplanMgtDto> mtrlOrderList){
		int resultInt = -1;
		try {
			//발주삭제
			for(ZinixMtrlOdplanMgtDto mtrlOrderDto : mtrlOrderList){
				zinixMtrlOrderMapper.deleteOrderComp(mtrlOrderDto);
				
				zinixMtrlOrderMapper.deleteMtrlOrder(mtrlOrderDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("발주 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public void setOrderCompSave(ZinixMtrlOdplanMgtDto orderPlanDto){
		try {
			for(ZinixMtrlOdplanMgtDto compListDto : orderPlanDto.getOrderCompList()) {
				compListDto.setMtrlOrderId(orderPlanDto.getMtrlOrderId());
				if(compListDto.getAction().equals("C")) {//
					zinixMtrlOrderMapper.insertOrderComp(compListDto);
				}else if(compListDto.getAction().equals("D")) {
					zinixMtrlOrderMapper.deleteOrderComp(compListDto);
				}
			}
		} catch (Exception e) {
			throw new BusinessException("setOrderCompSave  : " + e.getMessage());
		}
	}
	
}
