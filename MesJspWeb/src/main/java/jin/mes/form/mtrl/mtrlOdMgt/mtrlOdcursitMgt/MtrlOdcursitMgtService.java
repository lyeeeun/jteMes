package jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtService;
import jin.mes.mapper.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrlOdcursitMgtService {
	@Resource
	MtrlOdcursitMgtMapper mtrlOrderFormMapper;

	@Autowired
	MtrlOdplanMgtService mtrlOrderService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<MtrlOdcursitMgtDto> getMtrlOrderFormList(MtrlOdcursitMgtDto mtrlOrderFormDto, PageRequestVo pageRequestVo){
		List<MtrlOdcursitMgtDto> mtrlOrderFormList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderFormDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderFormDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlOrderFormMapper.selectMtrlOrderFormCount(mtrlOrderFormDto);
			if (rowCount > 0) {
				//List
				mtrlOrderFormList = mtrlOrderFormMapper.selectMtrlOrderFormList(mtrlOrderFormDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderFormList == null) {
			mtrlOrderFormList = new ArrayList<MtrlOdcursitMgtDto>();
		}
		return new PageInfo<MtrlOdcursitMgtDto>(mtrlOrderFormList, pageRequestVo, rowCount);
	}
	
	//발주주문정보 입력/수정
	@Transactional
	public String setMtrlOrderFormSave(MtrlOdcursitMgtDto mtrlOrderFormDto){
		String returnKey = "";
		try {
			mtrlOrderFormDto.setCreatorId(JteUtils.getUserId());
			mtrlOrderFormDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlOrderFormDto.getAction().equals("C")) {//
				//발주입력
				mtrlOrderFormMapper.insertMtrlOrderForm(mtrlOrderFormDto);
				returnKey = mtrlOrderFormDto.getMtrlOfId();
				
				for(MtrlOdplanMgtDto mtrlOrderDto : mtrlOrderFormDto.getMtrlOrderList()) {
					//부모키 매핑시켜주기
					mtrlOrderDto.setMtrlOfId(returnKey);
					//상태값 진행중으로 변경
					mtrlOrderDto.setMtrlOrderState("mtrl_order_prs");
					//update모드 변경
					mtrlOrderDto.setAction("U");
					
					//발주리스트 발주 진행
					mtrlOrderService.setMtrlOrderSave(mtrlOrderDto);
				}
				
				//다국어 저장
//				if(mtrlOrderFormDto.getMsgList() != null && mtrlOrderFormDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(mtrlOrderFormDto.getMsgList(), "eqmt", returnKey);
//				}
			}else if(mtrlOrderFormDto.getAction().equals("U")){//발주 변경
				//발주수정
				mtrlOrderFormMapper.updateMtrlOrderForm(mtrlOrderFormDto);
				
				returnKey =mtrlOrderFormDto.getMtrlOfId();
				
				//다국어 저장
//				if(mtrlOrderFormDto.getMsgList() != null && mtrlOrderFormDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(mtrlOrderFormDto.getMsgList(), "eqmt", returnKey);
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
	public int setMtrlOrderFormDelete(List<MtrlOdcursitMgtDto> mtrlOrderFormList){
		int resultInt = -1;
		try {
			//발주삭제
			for(MtrlOdcursitMgtDto mtrlOrderFormDto : mtrlOrderFormList){
				mtrlOrderFormMapper.deleteMtrlOrderForm(mtrlOrderFormDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("발주주문정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}