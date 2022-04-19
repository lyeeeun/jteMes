package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;
import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtMapper;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemCompMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixItemMgtService {

	@Resource
    protected ZinixItemMgtMapper zinixItemMgtMapper;
	
	@Resource
	protected ZinixBomMgtMapper zinixBomMgtMapper;
	
    public PageInfo<ZinixItemMgtDto> getItemList(ZinixItemMgtDto itemMgtDto, PageRequestVo pageRequestVo){
    	List<ZinixItemMgtDto> itemList = null;
		int rowCount = 0;

		itemMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixItemMgtMapper.rowCount(itemMgtDto);
			if (rowCount > 0) {
				itemList = zinixItemMgtMapper.selectItemList(itemMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemList == null) {
			itemList = new ArrayList<ZinixItemMgtDto>();
		}
 		return new PageInfo<ZinixItemMgtDto>(itemList, pageRequestVo, rowCount);
	}
    
    public ZinixItemMgtDto getItemPop(ZinixItemMgtDto itemMgtDto) {
    	ZinixItemMgtDto itemPop = null;
    	try {
    		itemPop = zinixItemMgtMapper.selectIteminfo(itemMgtDto);
    		
    		if(!itemPop.getItemId().equals(null)) {
    			ZinixItemCompMgtDto itemCompMgtDto = new ZinixItemCompMgtDto();
    			itemCompMgtDto.setItemId(itemPop.getItemId());
    			itemPop.setChildCompMgtList(zinixItemMgtMapper.selectItemCompChild(itemCompMgtDto));//에러발생
    		}
    		
    	}catch(Exception e){
    		throw new BusinessException("부품 업체관리팝업 조회 에러입니다. : " + e.getMessage());
    	}
    	return itemPop;
    }

	public List<ZinixItemMgtDto> getRtlCompList(ZinixItemMgtDto itemMgtDto) {
		List<ZinixItemMgtDto> rtlCompList = null;
		int rowCount = 0;
		
		try {
			rowCount = zinixItemMgtMapper.selectRtlCompCount(itemMgtDto);
			if (rowCount > 0) {
				rtlCompList = zinixItemMgtMapper.selectRtlCompList(itemMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error " + e.getMessage());
		}
		if (rtlCompList == null) {
			rtlCompList = new ArrayList<ZinixItemMgtDto>();
		}
		
		return rtlCompList;
	}

	@Transactional
	public String setItem(ZinixItemMgtDto itemMgtDto) {
		String returnKey = "";
		try {
			itemMgtDto.setCreatorId(JteUtils.getUserId());
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(itemMgtDto.getAction().equals("C")) {
				
				//품목입력
				zinixItemMgtMapper.insertItem(itemMgtDto);
				returnKey = itemMgtDto.getItemId();
				
				setItemCompSave(itemMgtDto);
				
				//Item 등록 시, Bom Root 생성
				ZinixBomMgtDto zinixBomMgtDto = new ZinixBomMgtDto();
				
				zinixBomMgtDto.setBomNm(itemMgtDto.getItemNm());
				zinixBomMgtDto.setBomParentId(itemMgtDto.getItemId());
				zinixBomMgtDto.setBomTarget("prcs_bom01");
				zinixBomMgtDto.setBomTargetId(itemMgtDto.getItemId());
				zinixBomMgtDto.setBomTargetNm(itemMgtDto.getItemNm());
				zinixBomMgtDto.setBomTargetCnt(1);
				zinixBomMgtDto.setCreatorId(JteUtils.getUserId());
				zinixBomMgtDto.setUpdatorId(JteUtils.getUserId());
				zinixBomMgtDto.setItemId(itemMgtDto.getItemId());
				
				zinixBomMgtMapper.insertBom(zinixBomMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

				ZinixItemMgtDto kpiInfo = new ZinixItemMgtDto();
				kpiInfo.setItemId(itemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);

				kpiInfo.setKpiTarget("kpi_sumCost");
				kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
				zinixItemMgtMapper.insertKpi(kpiInfo);
		
			}else if(itemMgtDto.getAction().equals("U")){//품목 변경
			
				//품목수정
				zinixItemMgtMapper.updateItem(itemMgtDto);
				
				returnKey =itemMgtDto.getItemId();
				
				//
				setItemCompSave(itemMgtDto);
				
				int rowCount = 0;
				
				rowCount = zinixItemMgtMapper.rowCount(itemMgtDto);
				if (rowCount > 0) {
					List<ZinixItemMgtDto> prevItemInfo = zinixItemMgtMapper.selectItemList(itemMgtDto);
					String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					
					ZinixItemMgtDto kpiInfo = new ZinixItemMgtDto();
					kpiInfo.setItemId(itemMgtDto.getItemId());
					kpiInfo.setKpiDate(currentDate);
					if(prevItemInfo.get(0).getItemMtrlCost() != itemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != itemMgtDto.getItemPersonCost()) {
//						kpiInfo.setKpiTarget("kpi_mtrlCost");
//						kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//						zinixItemMgtMapper.insertKpi(kpiInfo);
//						
//						kpiInfo.setKpiTarget("kpi_personCost");
//						kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//						zinixItemMgtMapper.insertKpi(kpiInfo);
						
						kpiInfo.setKpiTarget("kpi_sumCost");
						kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
						zinixItemMgtMapper.insertKpi(kpiInfo);
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
				zinixItemMgtMapper.updateItem(itemMgtDto);
				
				returnKey =itemMgtDto.getItemId();
			}

			


		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
	@Transactional
	public String setItemCompSave(ZinixItemMgtDto itemMgtDto){
		String returnKey = "";
		
		try {
			for(ZinixItemCompMgtDto itemCompMgtDto : itemMgtDto.getChildCompMgtList()) {
				itemCompMgtDto.setCreatorId(JteUtils.getUserId());
				itemCompMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(itemCompMgtDto.getAction().equals("C")) {//
					//공구입력
					itemCompMgtDto.setItemId(itemMgtDto.getItemId());
					zinixItemMgtMapper.insertRtlComp(itemCompMgtDto);
					returnKey = itemCompMgtDto.getCompId();
				}else if(itemCompMgtDto.getAction().equals("D")) {
					zinixItemMgtMapper.deleteRtlComp(itemCompMgtDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public void updateItem(ZinixItemMgtDto itemMgtDto) {
		try {
			int rowCount = 0;
			
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			rowCount = zinixItemMgtMapper.rowCount(itemMgtDto);
			if (rowCount > 0) {
				List<ZinixItemMgtDto> prevItemInfo = zinixItemMgtMapper.selectItemList(itemMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				
				ZinixItemMgtDto kpiInfo = new ZinixItemMgtDto();
				kpiInfo.setItemId(itemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);
				if(prevItemInfo.get(0).getItemMtrlCost() != itemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != itemMgtDto.getItemPersonCost()) {
//					kpiInfo.setKpiTarget("kpi_mtrlCost");
//					kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//					zinixItemMgtMapper.insertKpi(kpiInfo);
//					
//					kpiInfo.setKpiTarget("kpi_personCost");
//					kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//					zinixItemMgtMapper.insertKpi(kpiInfo);
					
					kpiInfo.setKpiTarget("kpi_sumCost");
					kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
					zinixItemMgtMapper.insertKpi(kpiInfo);
				}
			}
			
			zinixItemMgtMapper.updateItem(itemMgtDto);
			
			itemMgtDto.setSearchGubun("itemId");
			itemMgtDto.setSearchText(itemMgtDto.getItemId());
			
			if(itemMgtDto.getCompList() != null) {
				itemMgtDto.getCompList().forEach(x -> {
					// zinixItemMgtMapper.insertRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			if(itemMgtDto.getDelCompList() != null) {
				itemMgtDto.getDelCompList().forEach(x -> {
					//zinixItemMgtMapper.deleteRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateItem Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(ZinixItemMgtDto itemMgtDto) {
		try {
			zinixItemMgtMapper.updateIsUse(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}
	
	public List<ZinixItemMgtDto> selectKpi(ZinixItemMgtDto itemMgtDto) {
		try {
			return zinixItemMgtMapper.selectKpi(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpi " + e.getMessage());
		}
	}

}