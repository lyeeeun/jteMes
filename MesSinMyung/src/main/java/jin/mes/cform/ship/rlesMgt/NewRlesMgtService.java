package jin.mes.cform.ship.rlesMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtMapper;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewRlesMgtService {

	@Resource
    protected NewRlesMgtMapper newRlesMgtMapper;
	
	@Resource
	protected NewInfergodsMgtMapper newInferGodsMgtMapper;
	
	@Resource
	protected NewItemStockMgtMapper newItemStockMgtMapper;

    public PageInfo<NewRlesMgtDto> getPackageList(NewRlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<NewRlesMgtDto> packageList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newRlesMgtMapper.rowCount(rlesMgtDto);
			if (rowCount > 0) {
				packageList = newRlesMgtMapper.selectPackageList(rlesMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (packageList == null) {
			packageList = new ArrayList<NewRlesMgtDto>();
		}
		return new PageInfo<NewRlesMgtDto>(packageList, pageRequestVo, rowCount);
	}
    
    public PageInfo<NewRlesMgtDto> getPackageWorkList(NewRlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<NewRlesMgtDto> packageWorkList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newRlesMgtMapper.selectPackageWorkCount(rlesMgtDto);
			if (rowCount > 0) {
				packageWorkList = newRlesMgtMapper.selectPackageWork(rlesMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (packageWorkList == null) {
			packageWorkList = new ArrayList<NewRlesMgtDto>();
		}
		return new PageInfo<NewRlesMgtDto>(packageWorkList, pageRequestVo, rowCount);
	}
    
    public PageInfo<NewRlesMgtDto> getPackagePlanList(NewRlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<NewRlesMgtDto> packageWorkList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newRlesMgtMapper.selectPackagePlanCount(rlesMgtDto);
			if (rowCount > 0) {
				packageWorkList = newRlesMgtMapper.selectPackagePlanList(rlesMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (packageWorkList == null) {
			packageWorkList = new ArrayList<NewRlesMgtDto>();
		}
		return new PageInfo<NewRlesMgtDto>(packageWorkList, pageRequestVo, rowCount);
	}
    
    public List<NewRlesMgtDto> getRtlBundleList(NewRlesMgtDto rlesMgtDto){
		List<NewRlesMgtDto> pkgRtlBundleList = null;
		try {
			pkgRtlBundleList = newRlesMgtMapper.selectRtlBundleList(rlesMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlBundleList Error " + e.getMessage());
		}
		return pkgRtlBundleList;
	}
	
	@Transactional
	public String setPackageWorkList(NewRlesMgtDto rlesMgtDto){
		String returnKey = "";
		try {
			rlesMgtDto.setPkgWorkUser(JteUtils.getUserId());
			newRlesMgtMapper.insertPackageWork(rlesMgtDto);
			
			NewItemStockMgtDto itemStockMgtDto = new NewItemStockMgtDto();
			itemStockMgtDto.setItemId(rlesMgtDto.getItemId());
			itemStockMgtDto.setItemMgtId(rlesMgtDto.getItemMgtId());
			itemStockMgtDto.setCreatorId(JteUtils.getUserId());
			itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
			
			//Claim 불량 원인 등록
			if(rlesMgtDto.getDefectInsertList() != null) {
				for(NewInfergodsMgtDto itemBadDto : rlesMgtDto.getDefectInsertList()){
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec04");
					itemBadDto.setBadTargetCode(rlesMgtDto.getPkgWorkId());
					itemBadDto.setBadDesc(rlesMgtDto.getDescription());
					itemBadDto.setLotId(rlesMgtDto.getItemMgtId());
					newInferGodsMgtMapper.insertItemBad(itemBadDto);
					
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					
					newItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto); // 불량 수량으로 인한 차감
				}
			}
			
			itemStockMgtDto.setItemQtyTargetCode(rlesMgtDto.getPkgWorkId());
			itemStockMgtDto.setItemQtyTarget("prod_tagt02"); //포장
			itemStockMgtDto.setItemQtyTotal(-rlesMgtDto.getPrsPackageQty());
			
			newItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto); // 포장 수량으로 인한 차감
			
			NewItemStockMgtDto itemStock = new NewItemStockMgtDto();
			
			itemStock.setItemId(rlesMgtDto.getItemId());
			itemStock.setItemMgtId(rlesMgtDto.getItemMgtId());
			itemStock.setItemStock(newItemStockMgtMapper.selectItemStock(itemStockMgtDto));
			itemStock.setUpdatorId(JteUtils.getUserId());
				
			newItemStockMgtMapper.updateItemStock(itemStock);
			
			NewItemStockMgtDto itemTotalStock = new NewItemStockMgtDto();
			
			itemTotalStock.setItemId(rlesMgtDto.getItemId());
			itemTotalStock.setItemMgtId(rlesMgtDto.getItemMgtId());
			itemTotalStock.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
			
			newItemStockMgtMapper.updateItemTotalStock(itemTotalStock);
			
			newRlesMgtMapper.updatePackageStock(rlesMgtDto);
			
			if(rlesMgtDto.getBundleInsertList() != null) {
				rlesMgtDto.getBundleInsertList().forEach(x -> {
					newRlesMgtMapper.insertBundleList(rlesMgtDto.getPkgWorkId(), x.getBundleQty(), x.getBundleUnit());
				});
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("setPackageWorkList : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public int delPackageWorkList(List<NewRlesMgtDto> rlesMgtDtoList){
		int resultInt = -1;
		try {
			for(NewRlesMgtDto rlesMgtDto : rlesMgtDtoList){
				newRlesMgtMapper.deleteQmBadItemInfo(rlesMgtDto);
				newRlesMgtMapper.deleteQmPkgItemInfo(rlesMgtDto);
				newRlesMgtMapper.deleteBadItemInfo(rlesMgtDto);
				newRlesMgtMapper.deletePackageWork(rlesMgtDto);
				newRlesMgtMapper.deleteBundle(rlesMgtDto);
				
				rlesMgtDto.setPrsPackageQty(-rlesMgtDto.getPrsPackageQty());
				newRlesMgtMapper.updatePackageStock(rlesMgtDto);
			}
			
			NewItemStockMgtDto itemStock = new NewItemStockMgtDto();
			
			itemStock.setItemId(rlesMgtDtoList.get(0).getItemId());
			itemStock.setItemMgtId(rlesMgtDtoList.get(0).getLotId());
			itemStock.setItemStock(newItemStockMgtMapper.selectItemStock(itemStock));
			
			newItemStockMgtMapper.updateItemStock(itemStock);
			
			itemStock.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(itemStock));
			
			newItemStockMgtMapper.updateItemTotalStock(itemStock);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("delPackageWorkList : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional
	public void updatePkgPlanState(NewRlesMgtDto rlesMgtDto){
		try {
			newRlesMgtMapper.updatePkgPlanState(rlesMgtDto);
		} catch (Exception e) {
			throw new BusinessException("updatePkgPlanState : " + e.getMessage());
		}
	}
    
}
