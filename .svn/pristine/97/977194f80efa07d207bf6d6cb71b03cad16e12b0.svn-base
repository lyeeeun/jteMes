package jin.mes.form.basMgt.operMgt.itemMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.mapper.basMgt.bom.bomMgt.BomMgtMapper;
import jin.mes.mapper.basMgt.operMgt.itemMgt.ItemMgtMapper;
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
	public void setItem(ItemMgtDto itemMgtDto) {
		try {
			itemMgtDto.setCreatorId(JteUtils.getUserId());
			itemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			itemMgtMapper.insertItem(itemMgtDto);
			
			//Item 등록 시, Bom Root 생성
			BomMgtDto bomMgtDto = new BomMgtDto();
			
			bomMgtDto.setBomParentId(itemMgtDto.getItemId());
			bomMgtDto.setBomTarget("prcs_bom01");
			bomMgtDto.setBomTargetId(itemMgtDto.getItemId());
			bomMgtDto.setBomTargetNm(itemMgtDto.getItemNm());
			bomMgtDto.setBomTargetCnt(0);
			bomMgtDto.setCreatorId(JteUtils.getUserId());
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			bomMgtDto.setItemId(itemMgtDto.getItemId());
			
			bomMgtMapper.insertBom(bomMgtDto);
			String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

			ItemMgtDto kpiInfo = new ItemMgtDto();
			kpiInfo.setItemId(itemMgtDto.getItemId());
			kpiInfo.setKpiDate(currentDate);

//			kpiInfo.setKpiTarget("kpi_mtrlCost");
//			kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost());
//			itemMgtMapper.insertKpi(kpiInfo);
//			kpiInfo.setKpiTarget("kpi_personCost");
//			kpiInfo.setKpiValue(itemMgtDto.getItemPersonCost());
//			itemMgtMapper.insertKpi(kpiInfo);
			
			kpiInfo.setKpiTarget("kpi_sumCost");
			kpiInfo.setKpiValue(itemMgtDto.getItemMtrlCost() + itemMgtDto.getItemPersonCost());
			itemMgtMapper.insertKpi(kpiInfo);
			
			
			if(itemMgtDto.getCompList() != null) {
				itemMgtDto.getCompList().forEach(x -> {
					itemMgtMapper.insertRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
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
					itemMgtMapper.insertRtlComp(x.getCompId(), itemMgtDto.getItemId());
				});
			}
			if(itemMgtDto.getDelCompList() != null) {
				itemMgtDto.getDelCompList().forEach(x -> {
					itemMgtMapper.deleteRtlComp(x.getCompId(), itemMgtDto.getItemId());
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
