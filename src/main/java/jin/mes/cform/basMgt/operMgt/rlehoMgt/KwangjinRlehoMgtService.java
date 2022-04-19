package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinRlehoMgtService {

	@Resource
	KwangjinRlehoMgtMapper kwangjinRlehoMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	public List<KwangjinRlehoMgtDto> getPlaceTree(KwangjinRlehoMgtDto kwangjinRlehoMgtDto){
		List<KwangjinRlehoMgtDto> placeList = null;
		try {
			placeList = kwangjinRlehoMgtMapper.selectPlaceTree(kwangjinRlehoMgtDto);
		} catch (Exception e) {
			throw new BusinessException("위치조회 에러입니다.(tree) : " + e.getMessage());
		}
		if (placeList == null) {
			placeList = new ArrayList<KwangjinRlehoMgtDto>();
		}
		return placeList;
	}
	
	public PageInfo<KwangjinRlehoMgtDto> getPlaceList(KwangjinRlehoMgtDto kwangjinRlehoMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinRlehoMgtDto> placeList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinRlehoMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinRlehoMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinRlehoMgtMapper.selectPlaceListCount(kwangjinRlehoMgtDto);
			if (rowCount > 0) {
				//List
				placeList = kwangjinRlehoMgtMapper.selectPlaceList(kwangjinRlehoMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("위치조회 에러입니다.(List) : " + e.getMessage());
		}
		if (placeList == null) {
			placeList = new ArrayList<KwangjinRlehoMgtDto>();
		}
		return new PageInfo<KwangjinRlehoMgtDto>(placeList, pageRequestVo, rowCount);
	}
	
	@Transactional
	public String setPlaceSave(KwangjinRlehoMgtDto kwangjinRlehoMgtDto){
		String returnKey = "";
		try {
			kwangjinRlehoMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinRlehoMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinRlehoMgtDto.getAction().equals("C")) {//위치 등록
				//위치입력
				kwangjinRlehoMgtMapper.insertPlaceInfo(kwangjinRlehoMgtDto);
				
				returnKey = kwangjinRlehoMgtDto.getPlaceId(); 
			
				//다국어 저장
				if(kwangjinRlehoMgtDto.getMsgList() != null && kwangjinRlehoMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinRlehoMgtDto.getMsgList(), "place", returnKey);
				}
				
				//첨부파일 저장
				if(kwangjinRlehoMgtDto.getInsertAttach() != null && kwangjinRlehoMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinRlehoMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinRlehoMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinRlehoMgtDto.getDeleteAttach() != null && kwangjinRlehoMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinRlehoMgtDto.getDeleteAttach());
				}
				
			}else if(kwangjinRlehoMgtDto.getAction().equals("U")){//위치 수정
				//위치수정
				kwangjinRlehoMgtMapper.updatePlaceInfo(kwangjinRlehoMgtDto);
				
				returnKey = kwangjinRlehoMgtDto.getPlaceId();
				
				//다국어 저장
				if(kwangjinRlehoMgtDto.getMsgList() != null && kwangjinRlehoMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinRlehoMgtDto.getMsgList(), "place", returnKey);
				}
				
				//첨부파일 저장
				if(kwangjinRlehoMgtDto.getInsertAttach() != null && kwangjinRlehoMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinRlehoMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinRlehoMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinRlehoMgtDto.getDeleteAttach() != null && kwangjinRlehoMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinRlehoMgtDto.getDeleteAttach());
				}
			}else if(kwangjinRlehoMgtDto.getAction().equals("USE")){//위치 잠금/해제
				if(kwangjinRlehoMgtDto.isUse()) {
					kwangjinRlehoMgtDto.setUse(false);
				}else {
					kwangjinRlehoMgtDto.setUse(true);
				}
				//위치잠금수정	
				kwangjinRlehoMgtMapper.updatePlaceInfo(kwangjinRlehoMgtDto);
				
				returnKey = kwangjinRlehoMgtDto.getPlaceId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("위치 입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	@Transactional
	public int setPlaceDelete(List<KwangjinRlehoMgtDto> placeList){
		int resultInt = -1;
		try {
			//위치삭제
			for(KwangjinRlehoMgtDto kwangjinRlehoMgtDto : placeList){
				kwangjinRlehoMgtMapper.deletePlaceInfo(kwangjinRlehoMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("위치 삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
	
}
