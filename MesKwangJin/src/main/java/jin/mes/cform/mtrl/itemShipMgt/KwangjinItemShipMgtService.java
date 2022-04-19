package jin.mes.cform.mtrl.itemShipMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipHisDto;
import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipMgtDto;
import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinItemShipMgtService {
	
	@Resource
	KwangjinItemShipMgtMapper kwangjinItemShipMgtMapper;
	
	//자재 관리 조회
	public PageInfo<KwangjinItemShipMgtDto> getItemShipMgtList(KwangjinItemShipMgtDto itemShipMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinItemShipMgtDto> itemShipMgtList = null;
		int rowCount = 0;

		// Page Setting
		itemShipMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemShipMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinItemShipMgtMapper.selectItemShipMgtCount(itemShipMgtDto);
			if (rowCount > 0) {
				//List
				itemShipMgtList = kwangjinItemShipMgtMapper.selectItemShipMgtList(itemShipMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (itemShipMgtList == null) {
			itemShipMgtList = new ArrayList<KwangjinItemShipMgtDto>();
		}
		return new PageInfo<KwangjinItemShipMgtDto>(itemShipMgtList, pageRequestVo, rowCount);
	}
	
	//자재관리 입력/수정
	@Transactional
	public String setItemShipMgtSave(KwangjinItemShipMgtDto itemShipMgtDto){
		String returnKey = "";
		try {
			itemShipMgtDto.setCreatorId(JteUtils.getUserId());
			itemShipMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(itemShipMgtDto.getAction().equals("C")) {//
				//자재입력
				kwangjinItemShipMgtMapper.insertItemShipMgt(itemShipMgtDto);
				returnKey = itemShipMgtDto.getItemMgtId();
			}else if(itemShipMgtDto.getAction().equals("U")){//자재 변경
				//자재수정
				kwangjinItemShipMgtMapper.updateItemShipMgt(itemShipMgtDto);
				
				returnKey =itemShipMgtDto.getItemMgtId();
			}else if(itemShipMgtDto.getAction().equals("D")){//isdel 처리
				itemShipMgtDto.setDel(true);
				//isdel 처리
				kwangjinItemShipMgtMapper.updateItemShipMgtIsDel(itemShipMgtDto);
				
				returnKey =itemShipMgtDto.getItemMgtId();
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 수량 히스토리(내역) 조회
	public PageInfo<KwangjinItemShipHisDto> getItemShipHisList(KwangjinItemShipHisDto itemShipHisDto, PageRequestVo pageRequestVo){
		List<KwangjinItemShipHisDto> itemShipHisList = null;
		int rowCount = 0;

		// Page Setting
		itemShipHisDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemShipHisDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinItemShipMgtMapper.selectItemShipHisCount(itemShipHisDto);
			if (rowCount > 0) {
				//List
				itemShipHisList = kwangjinItemShipMgtMapper.selectItemShipHisList(itemShipHisDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (itemShipHisList == null) {
			itemShipHisList = new ArrayList<KwangjinItemShipHisDto>();
		}
		return new PageInfo<KwangjinItemShipHisDto>(itemShipHisList, pageRequestVo, rowCount);
	}
	
	//자재 수량이력 수동입력
	@Transactional
	public String setItemManualSave(KwangjinItemShipHisDto itemShipHisDto){
		String returnKey = "";
		try {
			itemShipHisDto.setCreatorId(JteUtils.getUserId());
			itemShipHisDto.setUpdatorId(JteUtils.getUserId());
			
			if(itemShipHisDto.getAction().equals("C")) {//
				//자재 수량이력 수동 입력
				kwangjinItemShipMgtMapper.insertManualInfo(itemShipHisDto);
				
				//자재 수량관리 입력
				kwangjinItemShipMgtMapper.insertItemShipHis(itemShipHisDto);
				
				returnKey = itemShipHisDto.getItemMgtId();
				
				//자재관리 합계 total
				KwangjinItemShipMgtDto itemShipMgtCnt = new KwangjinItemShipMgtDto();
				itemShipMgtCnt.setItemMgtId(returnKey);
				itemShipMgtCnt.setItemStock(kwangjinItemShipMgtMapper.selectItemShipHisTotal(itemShipHisDto));
				itemShipMgtCnt.setCreatorId(JteUtils.getUserId());
				itemShipMgtCnt.setUpdatorId(JteUtils.getUserId());
				kwangjinItemShipMgtMapper.updateItemShipMgt(itemShipMgtCnt);
			}
			else if(itemShipHisDto.getAction().equals("U")){//자재 사용 히스토리 변경
				//자재 사용dlfur 수동 수정
				kwangjinItemShipMgtMapper.updateManualInfo(itemShipHisDto);
				
				//자재 수량관리 tnwjd
				kwangjinItemShipMgtMapper.updateItemShipHis(itemShipHisDto);
				
				returnKey = itemShipHisDto.getItemMgtId();
				
				//자재관리 합계 total
				KwangjinItemShipMgtDto itemShipMgtCnt = new KwangjinItemShipMgtDto();
				itemShipMgtCnt.setItemMgtId(returnKey);
				itemShipMgtCnt.setItemStock(kwangjinItemShipMgtMapper.selectItemShipHisTotal(itemShipHisDto));
				itemShipMgtCnt.setCreatorId(JteUtils.getUserId());
				itemShipMgtCnt.setUpdatorId(JteUtils.getUserId());
				kwangjinItemShipMgtMapper.updateItemShipMgt(itemShipMgtCnt);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 사용 히스토리 삭제
	@Transactional
	public int setItemManualDelete(List<KwangjinItemShipHisDto> itemShipHisList){
		int resultInt = -1;
		try {
			//자재 사용 히스토리 삭제
			for(KwangjinItemShipHisDto itemShipHisDto : itemShipHisList){
				kwangjinItemShipMgtMapper.deleteManualInfo(itemShipHisDto);
				kwangjinItemShipMgtMapper.deleteItemShipHis(itemShipHisDto);
			}
			
			KwangjinItemShipMgtDto itemShipMgtCnt = new KwangjinItemShipMgtDto();
			itemShipMgtCnt.setItemMgtId(itemShipHisList.get(0).getItemMgtId());
			itemShipMgtCnt.setItemStock(kwangjinItemShipMgtMapper.selectItemShipHisTotal(itemShipHisList.get(0)));
			itemShipMgtCnt.setCreatorId(JteUtils.getUserId());
			itemShipMgtCnt.setUpdatorId(JteUtils.getUserId());
			kwangjinItemShipMgtMapper.updateItemShipMgt(itemShipMgtCnt);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용 히스토리 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
}
