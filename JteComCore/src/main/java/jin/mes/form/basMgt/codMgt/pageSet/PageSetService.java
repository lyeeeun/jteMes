package jin.mes.form.basMgt.codMgt.pageSet;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.cache.CacheService;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class PageSetService {
	
	@Resource
	PageSetMapper pageSetMapper;
	
	@Autowired
	CacheService cacheService;
	
	//페이지 세팅 - 그리드 정보 조회
	public List<PageSetDto> getPageSetList(PageSetDto pageSetDto){
		List<PageSetDto> pageSetList = new ArrayList<PageSetDto>();
		try { 
			pageSetList = pageSetMapper.selectPageSetList(pageSetDto);
		}catch(Exception ex) {
			throw new BusinessException("페이지 세팅 - 그리드 정보 조회 에러 : " + ex.getMessage());
		}
		return pageSetList;
	}
	
	
	//페이지 세팅 - 그리드 정보 등록/수정
	@Transactional(rollbackFor = {Exception.class})
	public PageSetDto setPageSetSave(PageSetDto pageSetDto){
		try {
			pageSetDto.setCreatorId(JteUtils.getUserId());
			pageSetDto.setUpdatorId(JteUtils.getUserId());
			
			if(pageSetDto.getAction().equals("C")) {//
				
				//등록
				pageSetMapper.insertPageSetSave(pageSetDto);
			}else if(pageSetDto.getAction().equals("U")){//
				//수정
				pageSetMapper.updatePageSetSave(pageSetDto);
				
			}
		} catch (Exception e) {
			pageSetDto = new PageSetDto();
			throw new BusinessException("페이지 세팅 - 그리드 정보 등록/수정 에러: " + e.getMessage());
		}
		return pageSetDto;
	}
	
	//페이지 세팅 - 그리드 정보 삭제
	@Transactional(rollbackFor = {Exception.class})
	public String setPageSetDelete(PageSetDto pageSetDto){
		String returnKey = "success";
		try {
			//필드 정보 불러오기
			List<PageSetDto> deleteFields = new ArrayList<PageSetDto>();
			deleteFields = getPageFieldList(pageSetDto);
			
			//필드삭제
			for(PageSetDto deleteField : deleteFields) {
				pageSetMapper.deletePageField(deleteField);
			}
			
			//그리드 삭제
			pageSetMapper.deletePageSet(pageSetDto);
			
		} catch (Exception e) {
			returnKey = "error";
			throw new BusinessException("페이지 세팅 - 그리드 정보 삭제 에러: " + e.getMessage());
		}
		return returnKey;
	}
	
	//페이지 세팅 - 화면설정 복사(전체복사)
	@Transactional(rollbackFor = {Exception.class})
	public String setPageCopyMenu(PageSetDto pageSetDto){
		String returnKey = "success";
		try {
			//복사할 데이터  menuID
			String copyId = pageSetDto.getCopyMenuId();
			//복사 대상 menuID
			String targetId = pageSetDto.getMenuId();
			
			//복사할 PageDTO 세팅
			PageSetDto copyPageDto = new PageSetDto();
			copyPageDto.setMenuId(copyId);
			
			//복사할 페이지 조회
			List<PageSetDto> copyGridList = new ArrayList<PageSetDto>();
			copyGridList = getPageSetList(copyPageDto);
			
			//복사할 페이지 반복
			for(PageSetDto copyGrid : copyGridList) {
				
				//메뉴아이디 세팅(복사대상 메뉴 아이디)
				copyGrid.setMenuId(targetId);
				copyGrid.setCreatorId(JteUtils.getUserId());
				copyGrid.setUpdatorId(JteUtils.getUserId());
				
				//복사할 필드 불러오기
				List<PageSetDto> copyFieldList = new ArrayList<PageSetDto>();
				copyFieldList = getPageFieldList(copyGrid);
				
				//그리드 복사(저장)
				pageSetMapper.insertPageSetSave(copyGrid);
				
				//필드 복사(저장)
				for(PageSetDto copyField : copyFieldList) {
					copyField.setGridNo(copyGrid.getGridNo());
					copyField.setCreatorId(JteUtils.getUserId());
					copyField.setUpdatorId(JteUtils.getUserId());
					
					pageSetMapper.insertPageField(copyField);
				}
			}
			
		} catch (Exception e) {
			returnKey = "error";
			throw new BusinessException("페이지 세팅 - 복사하기 에러: " + e.getMessage());
		}
		return returnKey;
	}
	
	
	//페이지 세팅 - 필드 정보 조회
	public List<PageSetDto> getPageFieldList(PageSetDto pageSetDto){
		
		List<PageSetDto> pageSetList = new ArrayList<PageSetDto>();
		try {
			pageSetList = pageSetMapper.selectPageFieldList(pageSetDto);
		}catch(Exception ex) {
			throw new BusinessException("페이지 세팅 - 필드 정보 조회 에러 : " + ex.getMessage());
		}
		return pageSetList;
	}
	
	//페이지 세팅 - 필드 정보 등록/수정
	@Transactional(rollbackFor = {Exception.class})
	public String setPageFieldSave(PageSetDto pageSetDto){
		String returnKey = "";
		try {
			pageSetDto.setCreatorId(JteUtils.getUserId());
			pageSetDto.setUpdatorId(JteUtils.getUserId());
			
			if(pageSetDto.getAction().equals("C")) {//
				
				//
				pageSetMapper.insertPageField(pageSetDto);
				
				returnKey = pageSetDto.getGridNo();
			}else if(pageSetDto.getAction().equals("U")){//
				//
				pageSetMapper.updatePageField(pageSetDto);
				
				returnKey = pageSetDto.getGridNo();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("페이지 세팅 - 필드 정보 등록/수정 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//페이지 세팅 - 필드 정보 삭제
	@Transactional(rollbackFor = {Exception.class})
	public String setPageFieldDelete(PageSetDto pageSetDto){
		String returnKey = "success";
		try {
			pageSetMapper.deletePageField(pageSetDto);
		} catch (Exception e) {
			returnKey = "error";
			throw new BusinessException("페이지 세팅 - 필드 정보 삭제 에러: " + e.getMessage());
		}
		return returnKey;
	}
}
