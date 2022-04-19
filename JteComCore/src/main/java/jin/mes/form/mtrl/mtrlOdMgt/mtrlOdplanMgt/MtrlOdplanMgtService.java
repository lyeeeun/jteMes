package jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtMapper;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrlOdplanMgtService {
	@Resource
	MtrlOdplanMgtMapper mtrlOrderMapper;
	
	@Resource
	MtrlOdcursitMgtMapper mtrlOrderFormMapper;
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<MtrlOdplanMgtDto> getMtrlOrderList(MtrlOdplanMgtDto mtrlOrderDto, PageRequestVo pageRequestVo){
		List<MtrlOdplanMgtDto> mtrlOrderList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlOrderMapper.selectMtrlOrderCount(mtrlOrderDto);
			if (rowCount > 0) {
				//List
				mtrlOrderList = mtrlOrderMapper.selectMtrlOrderList(mtrlOrderDto);
				
				mtrlOrderList.get(0).setOrderCompList(mtrlOrderMapper.selectOrderCompChild(mtrlOrderDto));
			}
		} catch (Exception e) {
			throw new BusinessException("발주정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderList == null) {
			mtrlOrderList = new ArrayList<MtrlOdplanMgtDto>();
		}
		return new PageInfo<MtrlOdplanMgtDto>(mtrlOrderList, pageRequestVo, rowCount);
	}
	
	//발주정보 입력/수정
	@Transactional(rollbackFor = {Exception.class})
	public String setMtrlOrderSave(MtrlOdplanMgtDto mtrlOrderDto){
		String returnKey = "";
		try {
			mtrlOrderDto.setCreatorId(JteUtils.getUserId());
			mtrlOrderDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlOrderDto.getAction().equals("C")) {
				//발주입력
				mtrlOrderMapper.insertMtrlOrder(mtrlOrderDto);
				returnKey = mtrlOrderDto.getMtrlOrderId();
				
				setOrderCompSave(mtrlOrderDto);
			}else if(mtrlOrderDto.getAction().equals("U")){//발주 변경/발주진행
				//발주수정
				mtrlOrderMapper.updateMtrlOrder(mtrlOrderDto);
				returnKey =mtrlOrderDto.getMtrlOrderId();
				setOrderCompSave(mtrlOrderDto);
			}else if(mtrlOrderDto.getAction().equals("END") || mtrlOrderDto.getAction().equals("ENDUP")){//발주 완료
				
				mtrlOrderDto.setMtrlOrderState("mtrl_order_end");//발주완료
				
				//발주수정
				mtrlOrderMapper.updateMtrlOrder(mtrlOrderDto);
				
				returnKey = mtrlOrderDto.getMtrlOrderId();
				
				//자재수량을 저장하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(mtrlOrderDto.getMtrlId(), "mtrl_tagt01", returnKey,
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
				if(mtrlOrderMapper.selectMtrlOrderList(mtrlOrderDto).size() == 0) {
					MtrlOdcursitMgtDto mtrlOrderFormDto = new MtrlOdcursitMgtDto();
					mtrlOrderFormDto.setMtrlOfId(mtrlOrderDto.getMtrlOfId());
					mtrlOrderFormDto.setMtrlOfState("mtrl_sta02");//발주완료
					mtrlOrderFormDto.setUpdatorId(JteUtils.getUserId());
					mtrlOrderFormDto.setAction("END");
					mtrlOrderFormMapper.updateMtrlOrderForm(mtrlOrderFormDto);
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
	public String setMtrlOrderBatchSave(List<MtrlOdplanMgtDto> mtrlOrderList){
		String returnKey = "";
		try {
			for(MtrlOdplanMgtDto mtrlOrderDto : mtrlOrderList) {
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
	public int setMtrlOrderDelete(List<MtrlOdplanMgtDto> mtrlOrderList){
		int resultInt = -1;
		try {
			//발주삭제
			for(MtrlOdplanMgtDto mtrlOrderDto : mtrlOrderList){
				mtrlOrderMapper.deleteOrderComp(mtrlOrderDto);
				
				mtrlOrderMapper.deleteMtrlOrder(mtrlOrderDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("발주 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public void setOrderCompSave(MtrlOdplanMgtDto orderPlanDto){
		try {
			for(MtrlOdplanMgtDto compListDto : orderPlanDto.getOrderCompList()) {
				compListDto.setMtrlOrderId(orderPlanDto.getMtrlOrderId());
				if(compListDto.getAction().equals("C")) {//
					mtrlOrderMapper.insertOrderComp(compListDto);
				}else if(compListDto.getAction().equals("D")) {
					mtrlOrderMapper.deleteOrderComp(compListDto);
				}
			}
		} catch (Exception e) {
			throw new BusinessException("setOrderCompSave  : " + e.getMessage());
		}
	}
	
}
