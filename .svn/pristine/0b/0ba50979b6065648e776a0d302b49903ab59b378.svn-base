package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.bom.bomMgt.NewBomMgtDto;
import jin.mes.cform.basMgt.bom.bomMgt.NewBomMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewItemMgtService {

	@Resource
    protected NewItemMgtMapper newItemMgtMapper;
	
	@Resource
	protected NewBomMgtMapper newBomMgtMapper;
	
    public PageInfo<NewItemMgtDto> getItemList(NewItemMgtDto itemMgtDto, PageRequestVo pageRequestVo){
    	List<NewItemMgtDto> itemList = null;
		int rowCount = 0;

		itemMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemMgtMapper.rowCount(itemMgtDto);
			if (rowCount > 0) {
				itemList = newItemMgtMapper.selectItemList(itemMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemList == null) {
			itemList = new ArrayList<NewItemMgtDto>();
		}
 		return new PageInfo<NewItemMgtDto>(itemList, pageRequestVo, rowCount);
	}

	public List<NewItemMgtDto> getRtlCompList(NewItemMgtDto itemMgtDto) {
		List<NewItemMgtDto> rtlCompList = null;
		int rowCount = 0;
		
		try {
			rowCount = newItemMgtMapper.selectRtlCompCount(itemMgtDto);
			if (rowCount > 0) {
				rtlCompList = newItemMgtMapper.selectRtlCompList(itemMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error " + e.getMessage());
		}
		if (rtlCompList == null) {
			rtlCompList = new ArrayList<NewItemMgtDto>();
		}
		
		return rtlCompList;
	}

	@Transactional
	public void setItem(NewItemMgtDto itemMgtDto) {
		try {
			itemMgtDto.setCreatorId(JteUtils.getUserId());
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newItemMgtMapper.insertItem(itemMgtDto);
			
			//Item 등록 시, Bom Root 생성
			NewBomMgtDto newBomMgtDto = new NewBomMgtDto();
			
			newBomMgtDto.setBomParentId(itemMgtDto.getItemId());
			newBomMgtDto.setBomTarget("prcs_bom01");
			newBomMgtDto.setBomTargetId(itemMgtDto.getItemId());
			newBomMgtDto.setBomTargetNm(itemMgtDto.getItemNm());
			newBomMgtDto.setBomTargetCnt(0);
			newBomMgtDto.setCreatorId(JteUtils.getUserId());
			newBomMgtDto.setUpdatorId(JteUtils.getUserId());
			newBomMgtDto.setItemId(itemMgtDto.getItemId());
			
			newBomMgtMapper.insertBom(newBomMgtDto);
			
			NewItemMgtDto kpiInfo = new NewItemMgtDto();
			kpiInfo.setItemId(itemMgtDto.getItemId());
			kpiInfo.setKpiDate(new Date());

//			kpiInfo.setKpiTarget("kpi_mtrlCost");
//			kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//			newItemMgtMapper.insertKpi(kpiInfo);
//			kpiInfo.setKpiTarget("kpi_personCost");
//			kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//			newItemMgtMapper.insertKpi(kpiInfo);
			
			kpiInfo.setKpiTarget("kpi_sumCost");
			kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
			newItemMgtMapper.insertKpi(kpiInfo);
			
			
			if(itemMgtDto.getCompList() != null) {
				itemMgtDto.getCompList().forEach(x -> {
					newItemMgtMapper.insertRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateItem(NewItemMgtDto itemMgtDto) {
		try {
			int rowCount = 0;
			
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			rowCount = newItemMgtMapper.rowCount(itemMgtDto);
			if (rowCount > 0) {
				List<NewItemMgtDto> prevItemInfo = newItemMgtMapper.selectItemList(itemMgtDto);

				NewItemMgtDto kpiInfo = new NewItemMgtDto();
				kpiInfo.setItemId(itemMgtDto.getItemId());
				kpiInfo.setKpiDate(new Date());
				if(prevItemInfo.get(0).getItemMtrlCost() != itemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != itemMgtDto.getItemPersonCost()) {
//					kpiInfo.setKpiTarget("kpi_mtrlCost");
//					kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//					newItemMgtMapper.insertKpi(kpiInfo);
//					
//					kpiInfo.setKpiTarget("kpi_personCost");
//					kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//					newItemMgtMapper.insertKpi(kpiInfo);
					
					kpiInfo.setKpiTarget("kpi_sumCost");
					kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
					newItemMgtMapper.insertKpi(kpiInfo);
				}
			}
			
			newItemMgtMapper.updateItem(itemMgtDto);
			
			itemMgtDto.setSearchGubun("itemId");
			itemMgtDto.setSearchText(itemMgtDto.getItemId());
			
			if(itemMgtDto.getCompList() != null) {
				itemMgtDto.getCompList().forEach(x -> {
					newItemMgtMapper.insertRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			if(itemMgtDto.getDelCompList() != null) {
				itemMgtDto.getDelCompList().forEach(x -> {
					newItemMgtMapper.deleteRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateItem Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(NewItemMgtDto itemMgtDto) {
		try {
			newItemMgtMapper.updateIsUse(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}
	
	public List<NewItemMgtDto> selectKpi(NewItemMgtDto itemMgtDto) {
		try {
			return newItemMgtMapper.selectKpi(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpi " + e.getMessage());
		}
	}

}
