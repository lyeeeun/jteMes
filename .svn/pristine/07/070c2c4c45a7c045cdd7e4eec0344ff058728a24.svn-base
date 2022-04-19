package jin.mes.form.ship.rlesMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import jin.mes.mapper.item.itemStockMgt.ItemStockMgtMapper;
import jin.mes.mapper.qualMgt.infergodsMgt.InfergodsMgtMapper;
import jin.mes.mapper.ship.rlesMgt.RlesMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class RlesMgtService {

	@Resource
    protected RlesMgtMapper rlesMgtMapper;
	
	@Resource
	protected InfergodsMgtMapper inferGodsMgtMapper;
	
	@Resource
	protected ItemStockMgtMapper itemStockMgtMapper;

    public PageInfo<RlesMgtDto> getPackageList(RlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<RlesMgtDto> packageList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesMgtMapper.rowCount(rlesMgtDto);
			if (rowCount > 0) {
				packageList = rlesMgtMapper.selectPackageList(rlesMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (packageList == null) {
			packageList = new ArrayList<RlesMgtDto>();
		}
		return new PageInfo<RlesMgtDto>(packageList, pageRequestVo, rowCount);
	}
    
    public PageInfo<RlesMgtDto> getPackageWorkList(RlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<RlesMgtDto> packageWorkList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesMgtMapper.selectPackageWorkCount(rlesMgtDto);
			if (rowCount > 0) {
				packageWorkList = rlesMgtMapper.selectPackageWork(rlesMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (packageWorkList == null) {
			packageWorkList = new ArrayList<RlesMgtDto>();
		}
		return new PageInfo<RlesMgtDto>(packageWorkList, pageRequestVo, rowCount);
	}
    
    public PageInfo<RlesMgtDto> getPackagePlanList(RlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<RlesMgtDto> packageWorkList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesMgtMapper.selectPackagePlanCount(rlesMgtDto);
			if (rowCount > 0) {
				packageWorkList = rlesMgtMapper.selectPackagePlanList(rlesMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (packageWorkList == null) {
			packageWorkList = new ArrayList<RlesMgtDto>();
		}
		return new PageInfo<RlesMgtDto>(packageWorkList, pageRequestVo, rowCount);
	}
    
    public List<RlesMgtDto> getRtlBundleList(RlesMgtDto rlesMgtDto){
		List<RlesMgtDto> pkgRtlBundleList = null;
		try {
			pkgRtlBundleList = rlesMgtMapper.selectRtlBundleList(rlesMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlBundleList Error " + e.getMessage());
		}
		return pkgRtlBundleList;
	}
	
	@Transactional
	public String setPackageWorkList(RlesMgtDto rlesMgtDto){
		String returnKey = "";
		try {
			rlesMgtDto.setPkgWorkUser(JteUtils.getUserId());
			rlesMgtMapper.insertPackageWork(rlesMgtDto);
			
			ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
			itemStockMgtDto.setItemId(rlesMgtDto.getItemId());
			itemStockMgtDto.setItemMgtId(rlesMgtDto.getItemMgtId());
			itemStockMgtDto.setCreatorId(JteUtils.getUserId());
			itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
			
			//Claim 불량 원인 등록
			if(rlesMgtDto.getDefectInsertList() != null) {
				for(InfergodsMgtDto itemBadDto : rlesMgtDto.getDefectInsertList()){
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec04");
					itemBadDto.setBadTargetCode(rlesMgtDto.getPkgWorkId());
					itemBadDto.setBadDesc(rlesMgtDto.getDescription());
					itemBadDto.setLotId(rlesMgtDto.getItemMgtId());
					inferGodsMgtMapper.insertItemBad(itemBadDto);
					
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					
					itemStockMgtMapper.insertItemStockHistory(itemStockMgtDto); // 불량 수량으로 인한 차감
				}
			}
			
			itemStockMgtDto.setItemQtyTargetCode(rlesMgtDto.getPkgWorkId());
			itemStockMgtDto.setItemQtyTarget("prod_tagt02"); //포장
			itemStockMgtDto.setItemQtyTotal(-rlesMgtDto.getPrsPackageQty());
			
			itemStockMgtMapper.insertItemStockHistory(itemStockMgtDto); // 포장 수량으로 인한 차감
			
			ItemStockMgtDto itemStock = new ItemStockMgtDto();
			
			itemStock.setItemId(rlesMgtDto.getItemId());
			itemStock.setItemMgtId(rlesMgtDto.getItemMgtId());
			itemStock.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
			itemStock.setUpdatorId(JteUtils.getUserId());
				
			itemStockMgtMapper.updateItemStock(itemStock);
			
			ItemStockMgtDto itemTotalStock = new ItemStockMgtDto();
			
			itemTotalStock.setItemId(rlesMgtDto.getItemId());
			itemTotalStock.setItemMgtId(rlesMgtDto.getItemMgtId());
			itemTotalStock.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
			
			itemStockMgtMapper.updateItemTotalStock(itemTotalStock);
			
			rlesMgtMapper.updatePackageStock(rlesMgtDto);
			
			if(rlesMgtDto.getBundleInsertList() != null) {
				rlesMgtDto.getBundleInsertList().forEach(x -> {
					rlesMgtMapper.insertBundleList(rlesMgtDto.getPkgWorkId(), x.getBundleQty(), x.getBundleUnit());
				});
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("setPackageWorkList : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public int delPackageWorkList(List<RlesMgtDto> rlesMgtDtoList){
		int resultInt = -1;
		try {
			for(RlesMgtDto rlesMgtDto : rlesMgtDtoList){
				rlesMgtMapper.deleteQmBadItemInfo(rlesMgtDto);
				rlesMgtMapper.deleteQmPkgItemInfo(rlesMgtDto);
				rlesMgtMapper.deleteBadItemInfo(rlesMgtDto);
				rlesMgtMapper.deletePackageWork(rlesMgtDto);
				rlesMgtMapper.deleteBundle(rlesMgtDto);
				
				rlesMgtDto.setPrsPackageQty(-rlesMgtDto.getPrsPackageQty());
				rlesMgtMapper.updatePackageStock(rlesMgtDto);
			}
			
			ItemStockMgtDto itemStock = new ItemStockMgtDto();
			
			itemStock.setItemId(rlesMgtDtoList.get(0).getItemId());
			itemStock.setItemMgtId(rlesMgtDtoList.get(0).getLotId());
			itemStock.setItemStock(itemStockMgtMapper.selectItemStock(itemStock));
			
			itemStockMgtMapper.updateItemStock(itemStock);
			
			itemStock.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStock));
			
			itemStockMgtMapper.updateItemTotalStock(itemStock);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("delPackageWorkList : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional
	public void updatePkgPlanState(RlesMgtDto rlesMgtDto){
		try {
			rlesMgtMapper.updatePkgPlanState(rlesMgtDto);
		} catch (Exception e) {
			throw new BusinessException("updatePkgPlanState : " + e.getMessage());
		}
	}
    
}
