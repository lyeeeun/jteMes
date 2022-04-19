package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.bom.bomMgt.KwangjinBomMgtDto;
import jin.mes.cform.basMgt.bom.bomMgt.KwangjinBomMgtMapper;
import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemCompMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class KwangjinItemMgtService {

	@Resource
    protected KwangjinItemMgtMapper kwangjinItemMgtMapper;
	
	@Resource
	protected KwangjinBomMgtMapper kwangjinBomMgtMapper;
	
    public PageInfo<KwangjinItemMgtDto> getItemList(KwangjinItemMgtDto kwangjinItemMgtDto, PageRequestVo pageRequestVo){
    	List<KwangjinItemMgtDto> itemList = null;
		int rowCount = 0;

		kwangjinItemMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinItemMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = kwangjinItemMgtMapper.rowCount(kwangjinItemMgtDto);
			if (rowCount > 0) {
				itemList = kwangjinItemMgtMapper.selectItemList(kwangjinItemMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemList == null) {
			itemList = new ArrayList<KwangjinItemMgtDto>();
		}
 		return new PageInfo<KwangjinItemMgtDto>(itemList, pageRequestVo, rowCount);
	}
    
    public KwangjinItemMgtDto getItemPop(KwangjinItemMgtDto kwangjinItemMgtDto) {
    	KwangjinItemMgtDto itemPop = null;
    	try {
    		itemPop = kwangjinItemMgtMapper.selectIteminfo(kwangjinItemMgtDto);
    		
    		if(!itemPop.getItemId().equals(null)) {
    			KwangjinItemCompMgtDto kwangjinItemCompMgtDto = new KwangjinItemCompMgtDto();
    			kwangjinItemCompMgtDto.setItemId(itemPop.getItemId());
    			itemPop.setChildCompMgtList(kwangjinItemMgtMapper.selectItemCompChild(kwangjinItemCompMgtDto));//에러발생
    		}
    		
    	}catch(Exception e){
    		throw new BusinessException("부품 업체관리팝업 조회 에러입니다. : " + e.getMessage());
    	}
    	return itemPop;
    }

	public List<KwangjinItemMgtDto> getRtlCompList(KwangjinItemMgtDto kwangjinItemMgtDto) {
		List<KwangjinItemMgtDto> rtlCompList = null;
		int rowCount = 0;
		
		try {
			rowCount = kwangjinItemMgtMapper.selectRtlCompCount(kwangjinItemMgtDto);
			if (rowCount > 0) {
				rtlCompList = kwangjinItemMgtMapper.selectRtlCompList(kwangjinItemMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error " + e.getMessage());
		}
		if (rtlCompList == null) {
			rtlCompList = new ArrayList<KwangjinItemMgtDto>();
		}
		
		return rtlCompList;
	}

	@Transactional
	public String setItem(KwangjinItemMgtDto kwangjinItemMgtDto) {
		String returnKey = "";
		try {
			kwangjinItemMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinItemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(kwangjinItemMgtDto.getAction().equals("C")) {
				
				//품목입력
				kwangjinItemMgtMapper.insertItem(kwangjinItemMgtDto);
				returnKey = kwangjinItemMgtDto.getItemId();
				
				setItemCompSave(kwangjinItemMgtDto);
				
				//Item 등록 시, Bom Root 생성
				KwangjinBomMgtDto kwangjinBomMgtDto = new KwangjinBomMgtDto();
				
				kwangjinBomMgtDto.setBomNm(kwangjinItemMgtDto.getItemNm());
				kwangjinBomMgtDto.setBomParentId(kwangjinItemMgtDto.getItemId());
				kwangjinBomMgtDto.setBomTarget("prcs_bom01");
				kwangjinBomMgtDto.setBomTargetId(kwangjinItemMgtDto.getItemId());
				kwangjinBomMgtDto.setBomTargetNm(kwangjinItemMgtDto.getItemNm());
				kwangjinBomMgtDto.setBomTargetCnt(1);
				kwangjinBomMgtDto.setCreatorId(JteUtils.getUserId());
				kwangjinBomMgtDto.setUpdatorId(JteUtils.getUserId());
				kwangjinBomMgtDto.setItemId(kwangjinItemMgtDto.getItemId());
				
				kwangjinBomMgtMapper.insertBom(kwangjinBomMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

				KwangjinItemMgtDto kpiInfo = new KwangjinItemMgtDto();
				kpiInfo.setItemId(kwangjinItemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);

				kpiInfo.setKpiTarget("kpi_sumCost");
				kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemMtrlCost() + kwangjinItemMgtDto.getItemPersonCost());
				kwangjinItemMgtMapper.insertKpi(kpiInfo);
		
			}else if(kwangjinItemMgtDto.getAction().equals("U")){//품목 변경
			
				//품목수정
				kwangjinItemMgtMapper.updateItem(kwangjinItemMgtDto);
				
				returnKey =kwangjinItemMgtDto.getItemId();
				
				//
				setItemCompSave(kwangjinItemMgtDto);
				
				int rowCount = 0;
				
				rowCount = kwangjinItemMgtMapper.rowCount(kwangjinItemMgtDto);
				if (rowCount > 0) {
					List<KwangjinItemMgtDto> prevItemInfo = kwangjinItemMgtMapper.selectItemList(kwangjinItemMgtDto);
					String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					
					KwangjinItemMgtDto kpiInfo = new KwangjinItemMgtDto();
					kpiInfo.setItemId(kwangjinItemMgtDto.getItemId());
					kpiInfo.setKpiDate(currentDate);
					if(prevItemInfo.get(0).getItemMtrlCost() != kwangjinItemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != kwangjinItemMgtDto.getItemPersonCost()) {
//						kpiInfo.setKpiTarget("kpi_mtrlCost");
//						kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemMtrlCost());
//						kwangjinItemMgtMapper.insertKpi(kpiInfo);
//						
//						kpiInfo.setKpiTarget("kpi_personCost");
//						kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemPersonCost());
//						kwangjinItemMgtMapper.insertKpi(kpiInfo);
						
						kpiInfo.setKpiTarget("kpi_sumCost");
						kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemMtrlCost() + kwangjinItemMgtDto.getItemPersonCost());
						kwangjinItemMgtMapper.insertKpi(kpiInfo);
					}
				}
			}
			else if(kwangjinItemMgtDto.getAction().equals("USE")){//공구 잠금/해제
				if(kwangjinItemMgtDto.isUse()) {
					kwangjinItemMgtDto.setUse(false);
				}else {
					kwangjinItemMgtDto.setUse(true);
				}
				//공구사용수정	
				kwangjinItemMgtMapper.updateItem(kwangjinItemMgtDto);
				
				returnKey =kwangjinItemMgtDto.getItemId();
			}

			


		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
	@Transactional
	public String setItemCompSave(KwangjinItemMgtDto kwangjinItemMgtDto){
		String returnKey = "";
		
		try {
			for(KwangjinItemCompMgtDto kwangjinItemCompMgtDto : kwangjinItemMgtDto.getChildCompMgtList()) {
				kwangjinItemCompMgtDto.setCreatorId(JteUtils.getUserId());
				kwangjinItemCompMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(kwangjinItemCompMgtDto.getAction().equals("C")) {//
					//공구입력
					kwangjinItemCompMgtDto.setItemId(kwangjinItemMgtDto.getItemId());
					kwangjinItemMgtMapper.insertRtlComp(kwangjinItemCompMgtDto);
					returnKey = kwangjinItemCompMgtDto.getCompId();
				}else if(kwangjinItemCompMgtDto.getAction().equals("D")) {
					kwangjinItemMgtMapper.deleteRtlComp(kwangjinItemCompMgtDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public void updateItem(KwangjinItemMgtDto kwangjinItemMgtDto) {
		try {
			int rowCount = 0;
			
			kwangjinItemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			rowCount = kwangjinItemMgtMapper.rowCount(kwangjinItemMgtDto);
			if (rowCount > 0) {
				List<KwangjinItemMgtDto> prevItemInfo = kwangjinItemMgtMapper.selectItemList(kwangjinItemMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				
				KwangjinItemMgtDto kpiInfo = new KwangjinItemMgtDto();
				kpiInfo.setItemId(kwangjinItemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);
				if(prevItemInfo.get(0).getItemMtrlCost() != kwangjinItemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != kwangjinItemMgtDto.getItemPersonCost()) {
//					kpiInfo.setKpiTarget("kpi_mtrlCost");
//					kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemMtrlCost());
//					kwangjinItemMgtMapper.insertKpi(kpiInfo);
//					
//					kpiInfo.setKpiTarget("kpi_personCost");
//					kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemPersonCost());
//					kwangjinItemMgtMapper.insertKpi(kpiInfo);
					
					kpiInfo.setKpiTarget("kpi_sumCost");
					kpiInfo.setKpiValue(kwangjinItemMgtDto.getItemMtrlCost() + kwangjinItemMgtDto.getItemPersonCost());
					kwangjinItemMgtMapper.insertKpi(kpiInfo);
				}
			}
			
			kwangjinItemMgtMapper.updateItem(kwangjinItemMgtDto);
			
			kwangjinItemMgtDto.setSearchGubun("itemId");
			kwangjinItemMgtDto.setSearchText(kwangjinItemMgtDto.getItemId());
			
			if(kwangjinItemMgtDto.getCompList() != null) {
				kwangjinItemMgtDto.getCompList().forEach(x -> {
					// kwangjinItemMgtMapper.insertRtlComp(x.getCompId(), kwangjinItemMgtDto.getItemId());
				});
			}
			if(kwangjinItemMgtDto.getDelCompList() != null) {
				kwangjinItemMgtDto.getDelCompList().forEach(x -> {
					//kwangjinItemMgtMapper.deleteRtlComp(x.getCompId(), kwangjinItemMgtDto.getItemId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateItem Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(KwangjinItemMgtDto kwangjinItemMgtDto) {
		try {
			kwangjinItemMgtMapper.updateIsUse(kwangjinItemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}
	
	public List<KwangjinItemMgtDto> selectKpi(KwangjinItemMgtDto kwangjinItemMgtDto) {
		try {
			return kwangjinItemMgtMapper.selectKpi(kwangjinItemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpi " + e.getMessage());
		}
	}

}
