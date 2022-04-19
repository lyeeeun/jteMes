package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtDto;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewMtrlOdcursitMgtService {
	@Resource
	NewMtrlOdcursitMgtMapper newMtrlOrderFormMapper;

	@Autowired
	NewMtrlOdplanMgtService newMtrlOrderService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewMtrlOdcursitMgtDto> getMtrlOrderFormList(NewMtrlOdcursitMgtDto newMtrlOrderFormDto, PageRequestVo pageRequestVo){
		List<NewMtrlOdcursitMgtDto> mtrlOrderFormList = null;
		int rowCount = 0;

		// Page Setting
		newMtrlOrderFormDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMtrlOrderFormDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlOrderFormMapper.selectMtrlOrderFormCount(newMtrlOrderFormDto);
			if (rowCount > 0) {
				//List
				mtrlOrderFormList = newMtrlOrderFormMapper.selectMtrlOrderFormList(newMtrlOrderFormDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderFormList == null) {
			mtrlOrderFormList = new ArrayList<NewMtrlOdcursitMgtDto>();
		}
		return new PageInfo<NewMtrlOdcursitMgtDto>(mtrlOrderFormList, pageRequestVo, rowCount);
	}
	
	//발주주문정보 입력/수정
	@Transactional
	public String setMtrlOrderFormSave(NewMtrlOdcursitMgtDto newMtrlOrderFormDto){
		String returnKey = "";
		try {
			newMtrlOrderFormDto.setCreatorId(JteUtils.getUserId());
			newMtrlOrderFormDto.setUpdatorId(JteUtils.getUserId());
			
			if(newMtrlOrderFormDto.getAction().equals("C")) {//
				//발주입력
				newMtrlOrderFormMapper.insertMtrlOrderForm(newMtrlOrderFormDto);
				returnKey = newMtrlOrderFormDto.getMtrlOfId();
				
				for(NewMtrlOdplanMgtDto mtrlOrderDto : newMtrlOrderFormDto.getMtrlOrderList()) {
					//부모키 매핑시켜주기
					mtrlOrderDto.setMtrlOfId(returnKey);
					//상태값 진행중으로 변경
					mtrlOrderDto.setMtrlOrderState("mtrl_order_prs");
					//update모드 변경
					mtrlOrderDto.setAction("U");
					
					//발주리스트 발주 진행
					newMtrlOrderService.setMtrlOrderSave(mtrlOrderDto);
				}
				
				//다국어 저장
//				if(newMtrlOrderFormDto.getMsgList() != null && newMtrlOrderFormDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(newMtrlOrderFormDto.getMsgList(), "eqmt", returnKey);
//				}
			}else if(newMtrlOrderFormDto.getAction().equals("U")){//발주 변경
				//발주수정
				newMtrlOrderFormMapper.updateMtrlOrderForm(newMtrlOrderFormDto);
				
				returnKey =newMtrlOrderFormDto.getMtrlOfId();
				
				//다국어 저장
//				if(newMtrlOrderFormDto.getMsgList() != null && newMtrlOrderFormDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(newMtrlOrderFormDto.getMsgList(), "eqmt", returnKey);
//				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("발주주문정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//발주주문정보 삭제
	@Transactional
	public int setMtrlOrderFormDelete(List<NewMtrlOdcursitMgtDto> mtrlOrderFormList){
		int resultInt = -1;
		try {
			//발주삭제
			for(NewMtrlOdcursitMgtDto newMtrlOrderFormDto : mtrlOrderFormList){
				newMtrlOrderFormMapper.deleteMtrlOrderForm(newMtrlOrderFormDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("발주주문정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
