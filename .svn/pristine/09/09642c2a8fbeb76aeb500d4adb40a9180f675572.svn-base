package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.text.SimpleDateFormat;
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
	
    public PageInfo<NewItemMgtDto> getItemList(NewItemMgtDto newItemMgtDto, PageRequestVo pageRequestVo){
    	List<NewItemMgtDto> itemList = null;
		int rowCount = 0;

		newItemMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newItemMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemMgtMapper.rowCount(newItemMgtDto);
			if (rowCount > 0) {
				itemList = newItemMgtMapper.selectItemList(newItemMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemList == null) {
			itemList = new ArrayList<NewItemMgtDto>();
		}
 		return new PageInfo<NewItemMgtDto>(itemList, pageRequestVo, rowCount);
	}

	public List<NewItemMgtDto> getRtlCompList(NewItemMgtDto newItemMgtDto) {
		List<NewItemMgtDto> rtlCompList = null;
		int rowCount = 0;
		
		try {
			rowCount = newItemMgtMapper.selectRtlCompCount(newItemMgtDto);
			if (rowCount > 0) {
				rtlCompList = newItemMgtMapper.selectRtlCompList(newItemMgtDto);
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
	public void setItem(NewItemMgtDto newItemMgtDto) {
		try {
			newItemMgtDto.setCreatorId(JteUtils.getUserId());
			newItemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newItemMgtMapper.insertItem(newItemMgtDto);
			
			//Item 등록 시, Bom Root 생성
			NewBomMgtDto newBomMgtDto = new NewBomMgtDto();
			
			newBomMgtDto.setBomParentId(newItemMgtDto.getItemId());
			newBomMgtDto.setBomTarget("prcs_bom01");
			newBomMgtDto.setBomTargetId(newItemMgtDto.getItemId());
			newBomMgtDto.setBomTargetNm(newItemMgtDto.getItemNm());
			newBomMgtDto.setBomTargetCnt(0);
			newBomMgtDto.setCreatorId(JteUtils.getUserId());
			newBomMgtDto.setUpdatorId(JteUtils.getUserId());
			newBomMgtDto.setItemId(newItemMgtDto.getItemId());
			
			newBomMgtMapper.insertBom(newBomMgtDto);
			String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

			NewItemMgtDto kpiInfo = new NewItemMgtDto();
			kpiInfo.setItemId(newItemMgtDto.getItemId());
			kpiInfo.setKpiDate(currentDate);

//			kpiInfo.setKpiTarget("kpi_mtrlCost");
//			kpiInfo.setKpiValue(newItemMgtDto.getItemMtrlCost());
//			newItemMgtMapper.insertKpi(kpiInfo);
//			kpiInfo.setKpiTarget("kpi_personCost");
//			kpiInfo.setKpiValue(newItemMgtDto.getItemPersonCost());
//			newItemMgtMapper.insertKpi(kpiInfo);
			
			kpiInfo.setKpiTarget("kpi_sumCost");
			kpiInfo.setKpiValue(newItemMgtDto.getItemMtrlCost() + newItemMgtDto.getItemPersonCost());
			newItemMgtMapper.insertKpi(kpiInfo);
			
			
			if(newItemMgtDto.getCompList() != null) {
				newItemMgtDto.getCompList().forEach(x -> {
					newItemMgtMapper.insertRtlComp(x.getCompId(), newItemMgtDto.getItemId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateItem(NewItemMgtDto newItemMgtDto) {
		try {
			int rowCount = 0;
			
			newItemMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			rowCount = newItemMgtMapper.rowCount(newItemMgtDto);
			if (rowCount > 0) {
				List<NewItemMgtDto> prevItemInfo = newItemMgtMapper.selectItemList(newItemMgtDto);
				String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				
				NewItemMgtDto kpiInfo = new NewItemMgtDto();
				kpiInfo.setItemId(newItemMgtDto.getItemId());
				kpiInfo.setKpiDate(currentDate);
				if(prevItemInfo.get(0).getItemMtrlCost() != newItemMgtDto.getItemMtrlCost() || prevItemInfo.get(0).getItemPersonCost() != newItemMgtDto.getItemPersonCost()) {
//					kpiInfo.setKpiTarget("kpi_mtrlCost");
//					kpiInfo.setKpiValue(newItemMgtDto.getItemMtrlCost());
//					newItemMgtMapper.insertKpi(kpiInfo);
//					
//					kpiInfo.setKpiTarget("kpi_personCost");
//					kpiInfo.setKpiValue(newItemMgtDto.getItemPersonCost());
//					newItemMgtMapper.insertKpi(kpiInfo);
					
					kpiInfo.setKpiTarget("kpi_sumCost");
					kpiInfo.setKpiValue(newItemMgtDto.getItemMtrlCost() + newItemMgtDto.getItemPersonCost());
					newItemMgtMapper.insertKpi(kpiInfo);
				}
			}
			
			newItemMgtMapper.updateItem(newItemMgtDto);
			
			newItemMgtDto.setSearchGubun("itemId");
			newItemMgtDto.setSearchText(newItemMgtDto.getItemId());
			
			if(newItemMgtDto.getCompList() != null) {
				newItemMgtDto.getCompList().forEach(x -> {
					newItemMgtMapper.insertRtlComp(x.getCompId(), newItemMgtDto.getItemId());
				});
			}
			if(newItemMgtDto.getDelCompList() != null) {
				newItemMgtDto.getDelCompList().forEach(x -> {
					newItemMgtMapper.deleteRtlComp(x.getCompId(), newItemMgtDto.getItemId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateItem Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(NewItemMgtDto newItemMgtDto) {
		try {
			newItemMgtMapper.updateIsUse(newItemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}
	
	public List<NewItemMgtDto> selectKpi(NewItemMgtDto newItemMgtDto) {
		try {
			return newItemMgtMapper.selectKpi(newItemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpi " + e.getMessage());
		}
	}

}
