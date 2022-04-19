package jin.mes.cform.basMgt.bom.bomMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.ZinixMtrlInfoMapper;
import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixBomMgtService {

	@Resource
	protected ZinixBomMgtMapper zinixBomMgtMapper;
	
	@Resource
	protected ZinixMtrlInfoMapper zinixMtrlInfoMapper;

	@Resource
	protected ZinixItemMgtMapper zinixItemMgtMapper;
	
	public List<ZinixBomMgtDto> getBomList(ZinixBomMgtDto bomMgtDto){
		List<ZinixBomMgtDto> bomList = null;
		try {
			bomList = zinixBomMgtMapper.selectBomList(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectBom Error: " + e.getMessage());
		}
		return bomList;
	}
	
	public List<ZinixBomMgtDto> getBomTree(ZinixBomMgtDto bomMgtDto){
		List<ZinixBomMgtDto> bomList = null;
		try {
			bomList = zinixBomMgtMapper.selectBomTree(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectBomTree Error: " + e.getMessage());
		}
		return bomList;
	}

	@Transactional
	public void setBom(ZinixBomMgtDto bomMgtDto) {
		try {
			List<ZinixBomMgtDto> bomList = getBomList(bomMgtDto);
			
			//최상위 Root 요소가 없을 경우 Root 요소 생성
//			if(bomList.isEmpty()) {
//				ZinixBomMgtDto bomMgtDtoRoot = zinixBomMgtMapper.selectBomRoot(bomMgtDto);
//				bomMgtDtoRoot.setCreatorId(JteUtils.getUserId());
//				bomMgtDtoRoot.setUpdatorId(JteUtils.getUserId());
//				
//				zinixBomMgtMapper.insertBom(bomMgtDtoRoot);
//				
//				bomMgtDto.setBomParentId(bomMgtDtoRoot.getBomId());
//			} else {
//				bomMgtDto.setBomParentId(bomList.get(0).getBomId());
//			}
			
			bomMgtDto.setCreatorId(JteUtils.getUserId());
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			zinixBomMgtMapper.insertBom(bomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			changeMtrlCost(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateBom(ZinixBomMgtDto bomMgtDto) {
		try {
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			zinixBomMgtMapper.updateBom(bomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			changeMtrlCost(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteBom(ZinixBomMgtDto bomMgtDto) {
		try {
			String bomRoot = zinixBomMgtMapper.selectBomRoot(bomMgtDto);
			
			zinixBomMgtMapper.deleteBom(bomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			ZinixItemMgtDto itemMgtDto = new ZinixItemMgtDto();
			itemMgtDto.setItemId(bomRoot);
			itemMgtDto.setItemMtrlCost(zinixMtrlInfoMapper.selectItemMtrlCost(bomRoot));
			zinixItemMgtMapper.updateItem(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteBom Error: " + e.getMessage());
		}
	}
	
	public void changeMtrlCost(ZinixBomMgtDto bomMgtDto) {
		try {
			String bomRoot = zinixBomMgtMapper.selectBomRoot(bomMgtDto);
			
			/*** 품목 제조 원가 - 업체 별 자재 단가 평균 -> 업체 별 자재 단가 변경 시 Update ***/
			ZinixItemMgtDto itemMgtDto = new ZinixItemMgtDto();
			itemMgtDto.setItemId(bomRoot);
			itemMgtDto.setItemMtrlCost(zinixMtrlInfoMapper.selectItemMtrlCost(bomRoot));
			zinixItemMgtMapper.updateItem(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: changeMtrlCost Error: " + e.getMessage());
		} 
	}
}
