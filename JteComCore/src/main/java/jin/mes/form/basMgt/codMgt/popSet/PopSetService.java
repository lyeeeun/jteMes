package jin.mes.form.basMgt.codMgt.popSet;

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
public class PopSetService {
	
	@Resource
	PopSetMapper popSetMapper;
	
	@Autowired
	CacheService cacheService;
	
	//팝업세팅 -  조회
	public List<PopSetDto> getPopSetList(PopSetDto popSetDto){
		List<PopSetDto> popSetList = new ArrayList<PopSetDto>();
		try { 
			popSetList = popSetMapper.selectPopSetList(popSetDto);
		}catch(Exception ex) {
			throw new BusinessException("팝업세팅 - 조회 : " + ex.getMessage());
		}
		return popSetList;
	}
	
	
	//팝업세팅 - 저장
	@Transactional(rollbackFor = {Exception.class})
	public String setPopSetSave(PopSetDto popSetDto){
		String returnKey = "";
		try {
			popSetDto.setCreatorId(JteUtils.getUserId());
			popSetDto.setUpdatorId(JteUtils.getUserId());
			
			if(popSetDto.getAction().equals("C")) {
				//입력
				popSetMapper.insertPopSetSave(popSetDto);
				returnKey = popSetDto.getPopId();
			}else if(popSetDto.getAction().equals("U")){
				//수정
				popSetMapper.updatePopSetSave(popSetDto);
				
				returnKey = popSetDto.getPopId();
			}else if(popSetDto.getAction().equals("D")){
				//삭제
				popSetMapper.deletePopSet(popSetDto);
				
				returnKey = popSetDto.getPopId();
			}
			
			//팝업 필드 정보 저장
			if(popSetDto.getPopFieldList() !=  null && popSetDto.getPopFieldList().size() > 0) {
				for(PopSetDto popFieldDto : popSetDto.getPopFieldList()) {
					//upid 값 세팅
					popFieldDto.setUpPopId(popSetDto.getPopId());

					setPopSetSave(popFieldDto);
				}
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("팝업세팅 - 저장 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//팝업세팅 -  삭제
	@Transactional(rollbackFor = {Exception.class})
	public String setPopSetDelete(PopSetDto popSetDto){
		String returnKey = "success";
		try {
			//팝업 필드 정보 삭제
			if(popSetDto.getPopFieldList() !=  null && popSetDto.getPopFieldList().size() > 0) {
				for(PopSetDto popFieldDto : popSetDto.getPopFieldList()) {
					
					setPopSetDelete(popFieldDto);
					
				}
			}
			
			//삭제
			popSetMapper.deletePopSet(popSetDto);
			
		} catch (Exception e) {
			returnKey = "error";
			throw new BusinessException("팝업세팅 - 삭제: " + e.getMessage());
		}
		return returnKey;
	}
}
