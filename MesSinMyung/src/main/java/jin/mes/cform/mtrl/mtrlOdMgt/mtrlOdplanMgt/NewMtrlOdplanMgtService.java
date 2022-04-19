package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtService;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt.NewMtrlOdcursitMgtDto;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt.NewMtrlOdcursitMgtMapper;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewMtrlOdplanMgtService {
	@Resource
	NewMtrlOdplanMgtMapper newMtrlOrderMapper;
	
	@Resource
	NewMtrlOdcursitMgtMapper newMtrlOrderFormMapper;
	
	@Autowired
	NewMtrlMgtService newMtrlMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewMtrlOdplanMgtDto> getMtrlOrderList(NewMtrlOdplanMgtDto mtrlOrderDto, PageRequestVo pageRequestVo){
		List<NewMtrlOdplanMgtDto> mtrlOrderList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlOrderMapper.selectMtrlOrderCount(mtrlOrderDto);
			if (rowCount > 0) {
				//List
				mtrlOrderList = newMtrlOrderMapper.selectMtrlOrderList(mtrlOrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderList == null) {
			mtrlOrderList = new ArrayList<NewMtrlOdplanMgtDto>();
		}
		return new PageInfo<NewMtrlOdplanMgtDto>(mtrlOrderList, pageRequestVo, rowCount);
	}
	
	//발주정보 입력/수정
	@Transactional
	public String setMtrlOrderSave(NewMtrlOdplanMgtDto mtrlOrderDto){
		String returnKey = "";
		try {
			mtrlOrderDto.setCreatorId(JteUtils.getUserId());
			mtrlOrderDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlOrderDto.getAction().equals("C")) {
				//발주입력
				newMtrlOrderMapper.insertMtrlOrder(mtrlOrderDto);
				returnKey = mtrlOrderDto.getMtrlOrderId();
			}else if(mtrlOrderDto.getAction().equals("U")){//발주 변경/발주진행
				//발주수정
				newMtrlOrderMapper.updateMtrlOrder(mtrlOrderDto);
				
				returnKey =mtrlOrderDto.getMtrlOrderId();
			}else if(mtrlOrderDto.getAction().equals("END") || mtrlOrderDto.getAction().equals("ENDUP")){//발주 완료
				
				mtrlOrderDto.setMtrlOrderState("mtrl_order_end");//발주완료
				
				//발주수정
				newMtrlOrderMapper.updateMtrlOrder(mtrlOrderDto);
				
				returnKey = mtrlOrderDto.getMtrlOrderId();
				
				//자재수량을 저장하기 위한 생성자
				NewMtrlHistoryDto mtrlCntDto = new NewMtrlHistoryDto(mtrlOrderDto.getMtrlId(), "mtrl_tagt01", returnKey,
						mtrlOrderDto.getMtrlOrderQty(), mtrlOrderDto.getMtrlOrderDate(), mtrlOrderDto.getMtrlOrderUser(), mtrlOrderDto.getMtrlMgtId(), null);
				
				//등록인지 수정인지 판단
				if(mtrlOrderDto.getAction().equals("END")) {
					mtrlCntDto.setAction("ADD");//자재 수량 insert
				}else {
					mtrlCntDto.setAction("U");//자재 수량 update
				}
				
				//자재수량 저장
				newMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
				//모든품목이 발주가 완료되었으면 발주주문서 완료처리
				mtrlOrderDto.setMtrlOrderState("mtrl_order_prs");//진행중
				if(newMtrlOrderMapper.selectMtrlOrderList(mtrlOrderDto).size() == 0) {
					NewMtrlOdcursitMgtDto mtrlOrderFormDto = new NewMtrlOdcursitMgtDto();
					mtrlOrderFormDto.setMtrlOfId(mtrlOrderDto.getMtrlOfId());
					mtrlOrderFormDto.setMtrlOfState("mtrl_sta02");//발주완료
					newMtrlOrderFormMapper.updateMtrlOrderForm(mtrlOrderFormDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("발주정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//발주정보 삭제
	@Transactional
	public int setMtrlOrderDelete(List<NewMtrlOdplanMgtDto> mtrlOrderList){
		int resultInt = -1;
		try {
			//발주삭제
			for(NewMtrlOdplanMgtDto mtrlOrderDto : mtrlOrderList){
				newMtrlOrderMapper.deleteMtrlOrder(mtrlOrderDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("발주 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
