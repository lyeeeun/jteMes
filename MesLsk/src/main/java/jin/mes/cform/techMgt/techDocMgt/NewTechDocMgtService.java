package jin.mes.cform.techMgt.techDocMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewTechDocMgtService {

	@Resource
    protected NewTechDocMgtMapper newTechDocMgtMapper;
	
	@Autowired
	AttachMgtService attachMgtService;

	public PageInfo<NewTechDocMgtDto> selectTechDocInfo(NewTechDocMgtDto techDocMgtDto, PageRequestVo pageRequestVo){
		List<NewTechDocMgtDto> techDocInfoList = null;
		int rowCount = 0;

		techDocMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		techDocMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newTechDocMgtMapper.selectTechDocInfoCount(techDocMgtDto);
			if (rowCount > 0) {
				techDocInfoList = newTechDocMgtMapper.selectTechDocInfo(techDocMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (techDocInfoList == null) {
			techDocInfoList = new ArrayList<NewTechDocMgtDto>();
		}
 		return new PageInfo<NewTechDocMgtDto>(techDocInfoList, pageRequestVo, rowCount);
	}
	
	public List<NewTechDocMgtDto> selectTechDocGroup(NewTechDocMgtDto techDocMgtDto) {
		try {
			return newTechDocMgtMapper.selectTechDocGroup(techDocMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectTechDocGroup " + e.getMessage());
		}
	}
	
	public PageInfo<NewTechDocMgtDto> selectTechDocRtlItem(NewTechDocMgtDto techDocMgtDto, PageRequestVo pageRequestVo){
		List<NewTechDocMgtDto> techDocInfoList = null;
		int rowCount = 0;

		techDocMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		techDocMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newTechDocMgtMapper.selectTechDocRtlItemCount(techDocMgtDto);
			if (rowCount > 0) {
				techDocInfoList = newTechDocMgtMapper.selectTechDocRtlItem(techDocMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (techDocInfoList == null) {
			techDocInfoList = new ArrayList<NewTechDocMgtDto>();
		}
 		return new PageInfo<NewTechDocMgtDto>(techDocInfoList, pageRequestVo, rowCount);
	}
	
	
	@Transactional
	public void saveTechDocRtlItem(NewTechDocMgtDto techDocMgtDto){
		try {
			techDocMgtDto.setCreatorId(JteUtils.getUserId());
			techDocMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(techDocMgtDto.getAction().equals("C")) {//사용자 등록
				//기술문서 그룹 관련 ITEM 등록
				newTechDocMgtMapper.insertTechDocRtlItem(techDocMgtDto);
			}else if(techDocMgtDto.getAction().equals("U")){//사용자 변경
				//메뉴수정
				newTechDocMgtMapper.updateTechDocRtlItem(techDocMgtDto);
			}
//			else if(menuInfoDto.getAction().equals("D")){//사용자 잠금/해제
//				if(menuInfoDto.isDel()) {
//					menuInfoDto.setDel(false);
//				}else {
//					menuInfoDto.setDel(true);
//				}
//				//메뉴 삭제(isDel)	
//				resultInt = menuInfoMapper.updateMenuInfo(menuInfoDto);
//			}
		} catch (Exception e) {
			throw new BusinessException("saveTechDocRtlItem : " + e.getMessage());
		}
	}
	
	@Transactional
	public void saveTechDocInfo(NewTechDocMgtDto techDocMgtDto){
		try {
			techDocMgtDto.setCreatorId(JteUtils.getUserId());
			techDocMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(techDocMgtDto.getAction().equals("C")) {//사용자 등록
				//기술문서 그룹 관련 ITEM 등록
				newTechDocMgtMapper.insertTechDocInfo(techDocMgtDto);
			}else if(techDocMgtDto.getAction().equals("U")){//사용자 변경
				//메뉴수정
				newTechDocMgtMapper.updateTechDocInfo(techDocMgtDto);
			}
			
			//첨부파일 저장
			if(techDocMgtDto.getInsertAttach() != null && techDocMgtDto.getInsertAttach().size() > 0) {
				String target = techDocMgtDto.getCurrentMenuId();
				String targetCode = techDocMgtDto.getDocId();
				attachMgtService.attachFilesSave(techDocMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(techDocMgtDto.getDeleteAttach() != null && techDocMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(techDocMgtDto.getDeleteAttach());
			}
			
		} catch (Exception e) {
			throw new BusinessException("saveTechDocInfo : " + e.getMessage());
		}
	}
	
	
}