package jin.mes.cform.basMgt.bom.bomMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewBomMgtService {

	@Resource
	protected NewBomMgtMapper newBomMgtMapper;


	public List<NewBomMgtDto> getBomList(NewBomMgtDto newBomMgtDto){
		List<NewBomMgtDto> bomList = null;

		bomList = newBomMgtMapper.selectBomList(newBomMgtDto);
		
		return bomList;
	}

	@Transactional
	public void setBom(NewBomMgtDto newBomMgtDto) {
		try {
			List<NewBomMgtDto> bomList = getBomList(newBomMgtDto);
			
			//최상위 Root 요소가 없을 경우 Root 요소 생성
			if(bomList.isEmpty()) {
				NewBomMgtDto newBomMgtDtoRoot = newBomMgtMapper.selectBomRoot(newBomMgtDto);
				newBomMgtDtoRoot.setCreatorId(JteUtils.getUserId());
				newBomMgtDtoRoot.setUpdatorId(JteUtils.getUserId());
				
				newBomMgtMapper.insertBom(newBomMgtDtoRoot);
				
				newBomMgtDto.setBomParentId(newBomMgtDtoRoot.getBomId());
			} else {
				newBomMgtDto.setBomParentId(bomList.get(0).getBomId());
			}
			newBomMgtDto.setCreatorId(JteUtils.getUserId());
			newBomMgtDto.setUpdatorId(JteUtils.getUserId());
			//신명의 경우 1대1이므로, 무조건 자재로 입력.
			newBomMgtDto.setBomTarget("prcs_bom02");
			
			newBomMgtMapper.insertBom(newBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateBom(NewBomMgtDto newBomMgtDto) {
		try {
			newBomMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newBomMgtMapper.updateBom(newBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateBom Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteBom(NewBomMgtDto newBomMgtDto) {
		try {
			newBomMgtMapper.deleteBom(newBomMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteBom Error: " + e.getMessage());
		}
	}
}
