package jin.mes.cform.qualMgt.smplPectMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtDto;
import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinSmplPectMgtService {

	@Resource
	KwangjinSmplPectMgtMapper kwangjinSmplPectMgtMapper;
	
	@Resource
	KwangjinItemRecevingMgtMapper kwangjinItemRecevingMgtMapper;
	
	public PageInfo<KwangjinSmplPectMgtDto> getProdAsgnList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinSmplPectMgtDto> mtrlMgtInputList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinSmplPectMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinSmplPectMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinSmplPectMgtMapper.selectProdAsgnCount(kwangjinSmplPectMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtInputList = kwangjinSmplPectMgtMapper.selectProdAsgnList(kwangjinSmplPectMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtInputList == null) {
			mtrlMgtInputList = new ArrayList<KwangjinSmplPectMgtDto>();
		}
		return new PageInfo<KwangjinSmplPectMgtDto>(mtrlMgtInputList, pageRequestVo, rowCount);
	}
	
	public PageInfo<KwangjinSmplPectMgtDto> getLotList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinSmplPectMgtDto> mtrlMgtInputList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinSmplPectMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinSmplPectMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinSmplPectMgtMapper.selectLotCount(kwangjinSmplPectMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtInputList = kwangjinSmplPectMgtMapper.selectLotList(kwangjinSmplPectMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtInputList == null) {
			mtrlMgtInputList = new ArrayList<KwangjinSmplPectMgtDto>();
		}
		return new PageInfo<KwangjinSmplPectMgtDto>(mtrlMgtInputList, pageRequestVo, rowCount);
	}
	
	public PageInfo<KwangjinSmplPectMgtDto> getRoutWorkList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinSmplPectMgtDto> mtrlMgtInputList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinSmplPectMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinSmplPectMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinSmplPectMgtMapper.selectRoutWorkCount(kwangjinSmplPectMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtInputList = kwangjinSmplPectMgtMapper.selectRoutWorkList(kwangjinSmplPectMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtInputList == null) {
			mtrlMgtInputList = new ArrayList<KwangjinSmplPectMgtDto>();
		}
		return new PageInfo<KwangjinSmplPectMgtDto>(mtrlMgtInputList, pageRequestVo, rowCount);
	}
	
	//품목 불량 조회
	public PageInfo<KwangjinSmplPectMgtDto> getItemBadList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinSmplPectMgtDto> itemBadList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinSmplPectMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinSmplPectMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinSmplPectMgtMapper.selectItemBadCount(kwangjinSmplPectMgtDto);
			if (rowCount > 0) {
				//List
				itemBadList = kwangjinSmplPectMgtMapper.selectItemBadList(kwangjinSmplPectMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
		}
		if (itemBadList == null) {
			itemBadList = new ArrayList<KwangjinSmplPectMgtDto>();
		}
		return new PageInfo<KwangjinSmplPectMgtDto>(itemBadList, pageRequestVo, rowCount);
	}
	
	//품목 불량 저장
	@Transactional
	public String setItemBadSave(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto){
		String returnKey = "";
		try {
			if(kwangjinSmplPectMgtDto.getAction().equals("C")) {
				kwangjinSmplPectMgtDto.setChkUser(JteUtils.getUserId());
				kwangjinSmplPectMgtDto.setBadTarget("qual_spec03");
				//kwangjinSmplPectMgtDto.setBadTargetCode("ADMIN");
				kwangjinSmplPectMgtMapper.insertItemBad(kwangjinSmplPectMgtDto);
				returnKey = kwangjinSmplPectMgtDto.getBadId();

				//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
				KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto = new KwangjinItemRecevingMgtDto();
				kwangjinItemRecevingMgtDto.setItemId(kwangjinSmplPectMgtDto.getItemId());
				kwangjinItemRecevingMgtDto.setItemMgtId(kwangjinSmplPectMgtDto.getLotId());
				kwangjinItemRecevingMgtDto.setItemQtyTarget("prod_tagt04"); //불량
				kwangjinItemRecevingMgtDto.setItemQtyTargetCode(kwangjinSmplPectMgtDto.getBadId());
				kwangjinItemRecevingMgtDto.setItemQtyTotal(-kwangjinSmplPectMgtDto.getBadQty());
				kwangjinItemRecevingMgtDto.setCreatorId(JteUtils.getUserId());
				kwangjinItemRecevingMgtDto.setUpdatorId(JteUtils.getUserId());
				
				kwangjinItemRecevingMgtMapper.insertItemRecevingHis(kwangjinItemRecevingMgtDto);
				
				kwangjinItemRecevingMgtDto.setItemStock(kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(kwangjinItemRecevingMgtDto));
					
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(kwangjinItemRecevingMgtDto);

			} else if(kwangjinSmplPectMgtDto.getAction().equals("U")){
				kwangjinSmplPectMgtDto.setChkUser(JteUtils.getUserId());
				kwangjinSmplPectMgtMapper.updateItemBad(kwangjinSmplPectMgtDto);
				
				KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto = new KwangjinItemRecevingMgtDto();
				kwangjinItemRecevingMgtDto.setItemId(kwangjinSmplPectMgtDto.getItemId());
				kwangjinItemRecevingMgtDto.setItemMgtId(kwangjinSmplPectMgtDto.getLotId());
				kwangjinItemRecevingMgtDto.setItemQtyTargetCode(kwangjinSmplPectMgtDto.getBadId());
				kwangjinItemRecevingMgtDto.setItemQtyTotal(-kwangjinSmplPectMgtDto.getBadQty());
				kwangjinItemRecevingMgtDto.setCreatorId(JteUtils.getUserId());
				kwangjinItemRecevingMgtDto.setUpdatorId(JteUtils.getUserId());
				
				kwangjinItemRecevingMgtMapper.updateItemRecevingHis(kwangjinItemRecevingMgtDto);
				
				kwangjinItemRecevingMgtDto.setItemStock(kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(kwangjinItemRecevingMgtDto));
				
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(kwangjinItemRecevingMgtDto);

			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}

	//품목 불량 삭제
	@Transactional
	public int setItemBadDelete(List<KwangjinSmplPectMgtDto> itemBadDeleteList){
		int resultInt = -1;
		int flag = -1;
		try {
			for(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto : itemBadDeleteList){
				resultInt = kwangjinSmplPectMgtMapper.deleteItemBad(kwangjinSmplPectMgtDto);
				
				KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto = new KwangjinItemRecevingMgtDto();
				kwangjinItemRecevingMgtDto.setItemId(kwangjinSmplPectMgtDto.getItemId());
				kwangjinItemRecevingMgtDto.setItemMgtId(kwangjinSmplPectMgtDto.getLotId());
				kwangjinItemRecevingMgtDto.setItemQtyTargetCode(kwangjinSmplPectMgtDto.getBadId());
				flag = kwangjinItemRecevingMgtMapper.deleteItemRecevingHis(kwangjinItemRecevingMgtDto);
				if(flag == 0) {
					continue;
				}
				
				flag = kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(kwangjinItemRecevingMgtDto);
				if(flag == 0) {
					continue;
				}
				kwangjinItemRecevingMgtDto.setItemStock(kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(kwangjinItemRecevingMgtDto));
				
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(kwangjinItemRecevingMgtDto);
				
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("품목 불량 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
