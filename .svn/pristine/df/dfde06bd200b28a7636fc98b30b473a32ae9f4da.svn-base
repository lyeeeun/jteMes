package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.ZinixMtrlOdplanMgtDto;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.ZinixMtrlOdplanMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixMtrlOdcursitMgtService {
	@Resource
	ZinixMtrlOdcursitMgtMapper zinixMtrlOrderFormMapper;

	@Autowired
	ZinixMtrlOdplanMgtService mtrlOrderService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<ZinixMtrlOdcursitMgtDto> getMtrlOrderFormList(ZinixMtrlOdcursitMgtDto mtrlOrderFormDto, PageRequestVo pageRequestVo){
		List<ZinixMtrlOdcursitMgtDto> mtrlOrderFormList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderFormDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderFormDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixMtrlOrderFormMapper.selectMtrlOrderFormCount(mtrlOrderFormDto);
			if (rowCount > 0) {
				//List
				mtrlOrderFormList = zinixMtrlOrderFormMapper.selectMtrlOrderFormList(mtrlOrderFormDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderFormList == null) {
			mtrlOrderFormList = new ArrayList<ZinixMtrlOdcursitMgtDto>();
		}
		return new PageInfo<ZinixMtrlOdcursitMgtDto>(mtrlOrderFormList, pageRequestVo, rowCount);
	}
	
	//발주주문정보 입력/수정
	@Transactional
	public String setMtrlOrderFormSave(ZinixMtrlOdcursitMgtDto mtrlOrderFormDto){
		String returnKey = "";
		try {
			mtrlOrderFormDto.setCreatorId(JteUtils.getUserId());
			mtrlOrderFormDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlOrderFormDto.getAction().equals("C")) {//
				//발주입력
				zinixMtrlOrderFormMapper.insertMtrlOrderForm(mtrlOrderFormDto);
				returnKey = mtrlOrderFormDto.getMtrlOfId();
				
				for(ZinixMtrlOdplanMgtDto mtrlOrderDto : mtrlOrderFormDto.getMtrlOrderList()) {
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
				zinixMtrlOrderFormMapper.updateMtrlOrderForm(mtrlOrderFormDto);
				
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
	public int setMtrlOrderFormDelete(List<ZinixMtrlOdcursitMgtDto> mtrlOrderFormList){
		int resultInt = -1;
		try {
			//발주삭제
			for(ZinixMtrlOdcursitMgtDto mtrlOrderFormDto : mtrlOrderFormList){
				zinixMtrlOrderFormMapper.deleteMtrlOrderForm(mtrlOrderFormDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("발주주문정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
