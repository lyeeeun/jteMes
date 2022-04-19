package jin.mes.form.basMgt.bom.bomMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.basMgt.bom.bomMgt.BomMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class BomMgtService {

	@Resource
	protected BomMgtMapper bomMgtMapper;


	public List<BomMgtDto> getBomList(BomMgtDto bomMgtDto){
		List<BomMgtDto> bomList = null;

		bomList = bomMgtMapper.selectBomList(bomMgtDto);
		
		return bomList;
	}

	@Transactional
	public void setBom(BomMgtDto bomMgtDto) {
		try {
			List<BomMgtDto> bomList = getBomList(bomMgtDto);
			
			//최상위 Root 요소가 없을 경우 Root 요소 생성
			if(bomList.isEmpty()) {
				BomMgtDto bomMgtDtoRoot = bomMgtMapper.selectBomRoot(bomMgtDto);
				bomMgtDtoRoot.setCreatorId(JteUtils.getUserId());
				bomMgtDtoRoot.setUpdatorId(JteUtils.getUserId());
				
				bomMgtMapper.insertBom(bomMgtDtoRoot);
				
				bomMgtDto.setBomParentId(bomMgtDtoRoot.getBomId());
			} else {
				bomMgtDto.setBomParentId(bomList.get(0).getBomId());
			}
			bomMgtDto.setCreatorId(JteUtils.getUserId());
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			//신명의 경우 1대1이므로, 무조건 자재로 입력.
			bomMgtDto.setBomTarget("prcs_bom02");
			
			bomMgtMapper.insertBom(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateBom(BomMgtDto bomMgtDto) {
		try {
			bomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			bomMgtMapper.updateBom(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteBom(BomMgtDto bomMgtDto) {
		try {
			bomMgtMapper.deleteBom(bomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteBom Error: " + e.getMessage());
		}
	}
}
