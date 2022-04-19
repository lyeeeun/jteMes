package jin.mes.form.pick.rlesMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtMapper;
import jin.mes.form.pick.rlesPlanMgt.RlesPlanMgtDto;
import jin.mes.form.pick.rlesPlanMgt.RlesPlanMgtMapper;
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
	protected ItemStockMgtMapper itemStockMgtMapper;
	
	@Resource
	protected RlesPlanMgtMapper rlesPlanMgtMapper;

    public PageInfo<RlesMgtDto> getRlesPlansList(RlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
    	List<RlesMgtDto> rlesPlansList = null;
		int rowCount = 0;

		rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			rowCount = rlesMgtMapper.selectRlesPlansCount(rlesMgtDto);
			if (rowCount > 0) {
				rlesPlansList = rlesMgtMapper.selectRlesPlansList(rlesMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getRlesPlanList 조회 에러입니다. : " + e.getMessage());
		}

		if (rlesPlansList == null) {
			rlesPlansList = new ArrayList<RlesMgtDto>();
		}
		return new PageInfo<RlesMgtDto>(rlesPlansList, pageRequestVo, rowCount);
	}
    //출고 작업 시작
    @Transactional
	public String setRlesWorkStart(RlesMgtDto rlesMgtDto) {
    	String returnKey = "";
    	try {
    		rlesMgtDto.setCreatorId(JteUtils.getUserId());
    		rlesMgtMapper.insertRlesWork(rlesMgtDto);
    		
    		RlesPlanMgtDto rlesPlanMgtDto = new RlesPlanMgtDto();
    		//출고 상태 -> 출고 진행중으로 변경
    		rlesPlanMgtDto.setRlesPlanState("rlesSta02");
    		rlesPlanMgtDto.setUpdatorId(JteUtils.getUserId());
    		rlesPlanMgtDto.setRlesPlanId(rlesMgtDto.getRlesPlanId());
    		rlesPlanMgtMapper.updateRlesPlan(rlesPlanMgtDto);
    		
		} catch (Exception e) {
			returnKey = "error";
			throw new BusinessException("출고 작업 정보 입력 에러 : " + e.getMessage());
		}
    	return returnKey;
    };
    
    //출고 작업 완료(출고 작업 정보 저장)
	@Transactional
	public String setRlesWorkSave(RlesMgtDto rlesMgtDto){
		String returnKey = "";
		try {
			//출고계획수량 이하의 출고작업수량을 입력했을 때
			if(rlesMgtDto.getRlesMgtQty()<rlesMgtDto.getRlesPlanQty()) {
				rlesMgtDto.setUpdatorId(JteUtils.getUserId());
				rlesMgtDto.setRlesWorker(JteUtils.getUserId());
				rlesMgtDto.setRlesWorkEnd(null);
				//출고 작업 정보 저장
				rlesMgtMapper.updateRlesWork(rlesMgtDto);
				
				returnKey = "ing";
			}else {//출고 계획수량 이상의 출고작업수량을 입력했을 때
				rlesMgtDto.setUpdatorId(JteUtils.getUserId());
				rlesMgtDto.setRlesWorker(JteUtils.getUserId());
				//출고 작업 정보 저장
				rlesMgtMapper.updateRlesWork(rlesMgtDto);
					
				RlesPlanMgtDto rlesPlanMgtDto = new RlesPlanMgtDto();
				//출고 상태 -> 출고 완료로 변경
				rlesPlanMgtDto.setRlesPlanId(rlesMgtDto.getRlesPlanId());
	    		rlesPlanMgtDto.setRlesPlanState("rlesSta03");
	    		rlesPlanMgtDto.setUpdatorId(JteUtils.getUserId());
	    		rlesPlanMgtMapper.updateRlesPlan(rlesPlanMgtDto);
				
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
				itemStockMgtDto.setItemId(rlesMgtDto.getItemId());
				itemStockMgtDto.setItemMgtId(rlesMgtDto.getItemMgtId());
				itemStockMgtDto.setCreatorId(JteUtils.getUserId());
				itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
			
				itemStockMgtDto.setItemQtyTargetCode(rlesMgtDto.getRlesMgtId());
				itemStockMgtDto.setItemQtyTarget("prod_tagt02"); //출고
				itemStockMgtDto.setItemQtyTotal(-rlesMgtDto.getRlesMgtQty());
				
				// 출고 수량으로 인한 차감(qm_item_mgt)->출고작업량이 -로 들어감
				itemStockMgtMapper.insertItemStockHistory(itemStockMgtDto); 
				
				ItemStockMgtDto itemStock = new ItemStockMgtDto();
				
				itemStock.setItemId(rlesMgtDto.getItemId());
				itemStock.setItemMgtId(rlesMgtDto.getItemMgtId());
				itemStock.setUpdatorId(JteUtils.getUserId());
				
				//cm_item_mgt.item_stock = SUM(cm_item_mgt.item_qty_total)
				itemStock.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
				//cm_item_mgt 업데이트
				itemStockMgtMapper.updateItemStock(itemStock);
				
				ItemStockMgtDto itemTotalStock = new ItemStockMgtDto();
				
				itemTotalStock.setItemId(rlesMgtDto.getItemId());
				itemTotalStock.setItemMgtId(rlesMgtDto.getItemMgtId());
				itemTotalStock.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
				
				//부품 총 수량 반영(bc_item_info)
				itemStockMgtMapper.updateItemTotalStock(itemTotalStock);
				//제품 개별 코드별 출고수량 저장(cm_item_mgt)
				rlesMgtMapper.updateRlesStock(rlesMgtDto);
				
				returnKey = "end";
				
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("출고 작업 저장 에러 : " + e.getMessage());
			
		}
		return returnKey;
	};
    
}
