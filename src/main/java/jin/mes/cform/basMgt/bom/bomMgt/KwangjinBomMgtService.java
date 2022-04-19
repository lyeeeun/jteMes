package jin.mes.cform.basMgt.bom.bomMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.KwangjinMtrlInfoMapper;
import jin.mes.cform.basMgt.bom.bomMgt.KwangjinBomMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class KwangjinBomMgtService {

	@Resource
	protected KwangjinBomMgtMapper kwangjinBomMgtMapper;
	
	@Resource
	protected KwangjinMtrlInfoMapper kwangjinMtrlInfoMapper;

	@Resource
	protected KwangjinItemMgtMapper kwangjinItemMgtMapper;
	
	public List<KwangjinBomMgtDto> getBomList(KwangjinBomMgtDto kwangjinBomMgtDto){
		List<KwangjinBomMgtDto> bomList = null;
		try {
			bomList = kwangjinBomMgtMapper.selectBomList(kwangjinBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectBom Error: " + e.getMessage());
		}
		return bomList;
	}
	
	public List<KwangjinBomMgtDto> getBomTree(KwangjinBomMgtDto kwangjinBomMgtDto){
		List<KwangjinBomMgtDto> bomList = null;
		try {
			bomList = kwangjinBomMgtMapper.selectBomTree(kwangjinBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectBomTree Error: " + e.getMessage());
		}
		return bomList;
	}

	@Transactional
	public void setBom(KwangjinBomMgtDto kwangjinBomMgtDto) {
		try {
			List<KwangjinBomMgtDto> bomList = getBomList(kwangjinBomMgtDto);
			
			//최상위 Root 요소가 없을 경우 Root 요소 생성
//			if(bomList.isEmpty()) {
//				KwangjinBomMgtDto kwangjinBomMgtDtoRoot = kwangjinBomMgtMapper.selectBomRoot(kwangjinBomMgtDto);
//				kwangjinBomMgtDtoRoot.setCreatorId(JteUtils.getUserId());
//				kwangjinBomMgtDtoRoot.setUpdatorId(JteUtils.getUserId());
//				
//				kwangjinBomMgtMapper.insertBom(kwangjinBomMgtDtoRoot);
//				
//				kwangjinBomMgtDto.setBomParentId(kwangjinBomMgtDtoRoot.getBomId());
//			} else {
//				kwangjinBomMgtDto.setBomParentId(bomList.get(0).getBomId());
//			}
			
			kwangjinBomMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinBomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			kwangjinBomMgtMapper.insertBom(kwangjinBomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			changeMtrlCost(kwangjinBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateBom(KwangjinBomMgtDto kwangjinBomMgtDto) {
		try {
			kwangjinBomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			kwangjinBomMgtMapper.updateBom(kwangjinBomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			changeMtrlCost(kwangjinBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteBom(KwangjinBomMgtDto kwangjinBomMgtDto) {
		try {
			String bomRoot = kwangjinBomMgtMapper.selectBomRoot(kwangjinBomMgtDto);
			
			kwangjinBomMgtMapper.deleteBom(kwangjinBomMgtDto);
			
			/*** BOM 변경 시, 품목 제조원가 값 변경 ***/
			KwangjinItemMgtDto itemMgtDto = new KwangjinItemMgtDto();
			itemMgtDto.setItemId(bomRoot);
			itemMgtDto.setItemMtrlCost(kwangjinMtrlInfoMapper.selectItemMtrlCost(bomRoot));
			kwangjinItemMgtMapper.updateItem(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteBom Error: " + e.getMessage());
		}
	}
	
	public void changeMtrlCost(KwangjinBomMgtDto kwangjinBomMgtDto) {
		try {
			String bomRoot = kwangjinBomMgtMapper.selectBomRoot(kwangjinBomMgtDto);
			
			/*** 품목 제조 원가 - 업체 별 자재 단가 평균 -> 업체 별 자재 단가 변경 시 Update ***/
			KwangjinItemMgtDto itemMgtDto = new KwangjinItemMgtDto();
			itemMgtDto.setItemId(bomRoot);
			itemMgtDto.setItemMtrlCost(kwangjinMtrlInfoMapper.selectItemMtrlCost(bomRoot));
			kwangjinItemMgtMapper.updateItem(itemMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: changeMtrlCost Error: " + e.getMessage());
		} 
	}
}
