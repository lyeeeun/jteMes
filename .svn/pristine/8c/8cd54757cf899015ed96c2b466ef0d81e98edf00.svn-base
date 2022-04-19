package jin.mes.form.basMgt.operMgt.itemMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.bom.bomMgt.BomMgtMapper;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemCompMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ItemMgtService {

	@Resource
    protected ItemMgtMapper itemMgtMapper;
	
	@Resource
	protected BomMgtMapper bomMgtMapper;
	
    public PageInfo<ItemMgtDto> getItemList(ItemMgtDto itemMgtDto, PageRequestVo pageRequestVo){
    	List<ItemMgtDto> itemList = null;
		int rowCount = 0;

		itemMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = itemMgtMapper.rowCount(itemMgtDto);
			if (rowCount > 0) {
				itemList = itemMgtMapper.selectItemList(itemMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemList == null) {
			itemList = new ArrayList<ItemMgtDto>();
		}
 		return new PageInfo<ItemMgtDto>(itemList, pageRequestVo, rowCount);
	}
    
    public ItemMgtDto getItemPop(ItemMgtDto itemMgtDto) {
    	ItemMgtDto itemPop = null;
    	try {
    		itemPop = itemMgtMapper.selectIteminfo(itemMgtDto);
    		
    		if(!itemPop.getItemId().equals(null)) {
    			ItemCompMgtDto itemCompDto = new ItemCompMgtDto();
    			itemCompDto.setItemId(itemPop.getItemId());
    			itemPop.setChildCompMgtList(itemMgtMapper.selectItemCompChild(itemCompDto));//에러발생
    		}
    		
    	}catch(Exception e){
    		throw new BusinessException("부품 업체관리팝업 조회 에러입니다. : " + e.getMessage());
    	}
    	return itemPop;
    }

	public List<ItemMgtDto> getRtlCompList(ItemMgtDto itemMgtDto) {
		List<ItemMgtDto> rtlCompList = null;
		int rowCount = 0;
		
		try {
			rowCount = itemMgtMapper.selectRtlCompCount(itemMgtDto);
			if (rowCount > 0) {
				rtlCompList = itemMgtMapper.selectRtlCompList(itemMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error " + e.getMessage());
		}
		if (rtlCompList == null) {
			rtlCompList = new ArrayList<ItemMgtDto>();
		}
		
		return rtlCompList;
	}

	@Transactional
	public String setItem(ItemMgtDto itemMgtDto) {
		String returnKey = "";
		try {
			itemMgtDto.setCreatorId(JteUtils.getUserId());
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(itemMgtDto.getAction().equals("C")) {
				
				//품목입력
				itemMgtMapper.insertItem(itemMgtDto);
				returnKey = itemMgtDto.getItemId();
				
				setItemCompSave(itemMgtDto);
				
				//Item 등록 시, Bom Root 생성
				BomMgtDto bomMgtDto = new BomMgtDto();
				
				bomMgtDto.setBomNm(itemMgtDto.getItemNm());
				bomMgtDto.setBomParentId(itemMgtDto.getItemId());
				bomMgtDto.setBomTarget("prcs_bom01");
				bomMgtDto.setBomTargetId(itemMgtDto.getItemId());
				bomMgtDto.setBomTargetNm(itemMgtDto.getItemNm());
				bomMgtDto.setBomTargetCnt(1);
				bomMgtDto.setCreatorId(JteUtils.getUserId());
				bomMgtDto.setUpdatorId(JteUtils.getUserId());
				bomMgtDto.setItemId(itemMgtDto.getItemId());
				
				bomMgtMapper.insertBom(bomMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

				ItemMgtDto kpiInfo = new ItemMgtDto();
				kpiInfo.setItemId(itemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);

				kpiInfo.setKpiTarget("kpi_sumCost");
				kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
				itemMgtMapper.insertKpi(kpiInfo);
		
			}else if(itemMgtDto.getAction().equals("U")){//품목 변경
			
				//품목수정
				itemMgtMapper.updateItem(itemMgtDto);
				
				returnKey =itemMgtDto.getItemId();
				
				//
				setItemCompSave(itemMgtDto);
				
				int rowCount = 0;
				
				rowCount = itemMgtMapper.rowCount(itemMgtDto);
				if (rowCount > 0) {
					List<ItemMgtDto> prevItemInfo = itemMgtMapper.selectItemList(itemMgtDto);
					String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					
					ItemMgtDto kpiInfo = new ItemMgtDto();
					kpiInfo.setItemId(itemMgtDto.getItemId());
					kpiInfo.setKpiDate(currentDate);
					if(prevItemInfo.get(0).getItemMtrlCost() != itemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != itemMgtDto.getItemPersonCost()) {
//						kpiInfo.setKpiTarget("kpi_mtrlCost");
//						kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//						itemMgtMapper.insertKpi(kpiInfo);
//						
//						kpiInfo.setKpiTarget("kpi_personCost");
//						kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//						itemMgtMapper.insertKpi(kpiInfo);
						
						kpiInfo.setKpiTarget("kpi_sumCost");
						kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
						itemMgtMapper.insertKpi(kpiInfo);
					}
				}
			}
			else if(itemMgtDto.getAction().equals("USE")){//공구 잠금/해제
				if(itemMgtDto.isUse()) {
					itemMgtDto.setUse(false);
				}else {
					itemMgtDto.setUse(true);
				}
				//공구사용수정	
				itemMgtMapper.updateItem(itemMgtDto);
				
				returnKey =itemMgtDto.getItemId();
			}

			


		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
	@Transactional
	public String setItemCompSave(ItemMgtDto itemMgtDto){
		String returnKey = "";
		
		try {
			for(ItemCompMgtDto itemCompMgtDto : itemMgtDto.getChildCompMgtList()) {
				itemCompMgtDto.setCreatorId(JteUtils.getUserId());
				itemCompMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(itemCompMgtDto.getAction().equals("C")) {//
					//공구입력
					itemCompMgtDto.setItemId(itemMgtDto.getItemId());
					itemMgtMapper.insertRtlComp(itemCompMgtDto);
					returnKey = itemCompMgtDto.getCompId();
				}else if(itemCompMgtDto.getAction().equals("D")) {
					itemMgtMapper.deleteRtlComp(itemCompMgtDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public void updateItem(ItemMgtDto itemMgtDto) {
		try {
			int rowCount = 0;
			
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			rowCount = itemMgtMapper.rowCount(itemMgtDto);
			if (rowCount > 0) {
				List<ItemMgtDto> prevItemInfo = itemMgtMapper.selectItemList(itemMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				
				ItemMgtDto kpiInfo = new ItemMgtDto();
				kpiInfo.setItemId(itemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);
				if(prevItemInfo.get(0).getItemMtrlCost() != itemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != itemMgtDto.getItemPersonCost()) {
//					kpiInfo.setKpiTarget("kpi_mtrlCost");
//					kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//					itemMgtMapper.insertKpi(kpiInfo);
//					
//					kpiInfo.setKpiTarget("kpi_personCost");
//					kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//					itemMgtMapper.insertKpi(kpiInfo);
					
					kpiInfo.setKpiTarget("kpi_sumCost");
					kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
					itemMgtMapper.insertKpi(kpiInfo);
				}
			}
			
			itemMgtMapper.updateItem(itemMgtDto);
			
			itemMgtDto.setSearchGubun("itemId");
			itemMgtDto.setSearchText(itemMgtDto.getItemId());
			
			if(itemMgtDto.getCompList() != null) {
				itemMgtDto.getCompList().forEach(x -> {
					// itemMgtMapper.insertRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			if(itemMgtDto.getDelCompList() != null) {
				itemMgtDto.getDelCompList().forEach(x -> {
					//itemMgtMapper.deleteRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateItem Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(ItemMgtDto itemMgtDto) {
		try {
			itemMgtMapper.updateIsUse(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}
	
	public List<ItemMgtDto> selectKpi(ItemMgtDto itemMgtDto) {
		try {
			return itemMgtMapper.selectKpi(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpi " + e.getMessage());
		}
	}

}
