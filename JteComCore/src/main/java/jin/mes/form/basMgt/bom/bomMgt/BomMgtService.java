package jin.mes.form.basMgt.bom.bomMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.operMgt.mtrlInfo.MtrlInfoMapper;
import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class BomMgtService {

	@Resource
	protected BomMgtMapper bomMgtMapper;
	
	@Resource
	protected MtrlInfoMapper mtrlInfoMapper;

	@Resource
	protected ItemMgtMapper itemMgtMapper;
	
	public List<BomMgtDto> getBomList(BomMgtDto bomMgtDto){
		List<BomMgtDto> bomList = null;
		try {
			bomList = bomMgtMapper.selectBomList(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectBom Error: " + e.getMessage());
		}
		return bomList;
	}
	
	public List<BomMgtDto> getBomTree(BomMgtDto bomMgtDto){
		List<BomMgtDto> bomList = null;
		try {
			bomList = bomMgtMapper.selectBomTree(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectBomTree Error: " + e.getMessage());
		}
		return bomList;
	}

	@Transactional
	public void setBom(BomMgtDto bomMgtDto) {
		try {
			List<BomMgtDto> bomList = getBomList(bomMgtDto);
			
			//최상위 Root 요소가 없을 경우 Root 요소 생성
//			if(bomList.isEmpty()) {
//				BomMgtDto bomMgtDtoRoot = bomMgtMapper.selectBomRoot(bomMgtDto);
//				bomMgtDtoRoot.setCreatorId(JteUtils.getUserId());
//				bomMgtDtoRoot.setUpdatorId(JteUtils.getUserId());
//				
//				bomMgtMapper.insertBom(bomMgtDtoRoot);
//				
//				bomMgtDto.setBomParentId(bomMgtDtoRoot.getBomId());
//			} else {
//				bomMgtDto.setBomParentId(bomList.get(0).getBomId());
//			}
			
			bomMgtDto.setCreatorId(JteUtils.getUserId());
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			bomMgtMapper.insertBom(bomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			changeMtrlCost(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateBom(BomMgtDto bomMgtDto) {
		try {
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			bomMgtMapper.updateBom(bomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			changeMtrlCost(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteBom(BomMgtDto bomMgtDto) {
		try {
			String bomRoot = bomMgtMapper.selectBomRoot(bomMgtDto);
			
			bomMgtMapper.deleteBom(bomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			ItemMgtDto itemMgtDto = new ItemMgtDto();
			itemMgtDto.setItemId(bomRoot);
			itemMgtDto.setItemMtrlCost(mtrlInfoMapper.selectItemMtrlCost(bomRoot));
			itemMgtMapper.updateItem(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteBom Error: " + e.getMessage());
		}
	}
	
	public void changeMtrlCost(BomMgtDto bomMgtDto) {
		try {
			String bomRoot = bomMgtMapper.selectBomRoot(bomMgtDto);
			
			/*** 품목 제조 원가 - 업체 별 자재 단가 평균 -> 업체 별 자재 단가 변경 시 Update ***/
			ItemMgtDto itemMgtDto = new ItemMgtDto();
			itemMgtDto.setItemId(bomRoot);
			itemMgtDto.setItemMtrlCost(mtrlInfoMapper.selectItemMtrlCost(bomRoot));
			itemMgtMapper.updateItem(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: changeMtrlCost Error: " + e.getMessage());
		} 
	}
}