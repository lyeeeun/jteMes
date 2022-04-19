package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewRlehoMgtService {

	@Resource
	NewRlehoMgtMapper newPlaceMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public List<NewRlehoMgtDto> getPlaceTree(NewRlehoMgtDto placeDto){
		List<NewRlehoMgtDto> placeList = null;
		try {
			placeList = newPlaceMapper.selectPlaceTree(placeDto);
		} catch (Exception e) {
			throw new BusinessException("위치조회 에러입니다.(tree) : " + e.getMessage());
		}
		if (placeList == null) {
			placeList = new ArrayList<NewRlehoMgtDto>();
		}
		return placeList;
	}
	
	public PageInfo<NewRlehoMgtDto> getPlaceList(NewRlehoMgtDto placeDto, PageRequestVo pageRequestVo){
		List<NewRlehoMgtDto> placeList = null;
		int rowCount = 0;

		// Page Setting
		placeDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		placeDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newPlaceMapper.selectPlaceListCount(placeDto);
			if (rowCount > 0) {
				//List
				placeList = newPlaceMapper.selectPlaceList(placeDto);
			}
		} catch (Exception e) {
			throw new BusinessException("위치조회 에러입니다.(List) : " + e.getMessage());
		}
		if (placeList == null) {
			placeList = new ArrayList<NewRlehoMgtDto>();
		}
		return new PageInfo<NewRlehoMgtDto>(placeList, pageRequestVo, rowCount);
	}
	
	@Transactional
	public int setPlaceSave(NewRlehoMgtDto placeDto){
		int resultInt = -1;
		try {
			placeDto.setCreatorId(JteUtils.getUserId());
			placeDto.setUpdatorId(JteUtils.getUserId());
			
			if(placeDto.getAction().equals("C")) {//위치 등록
				//위치입력
				resultInt = newPlaceMapper.insertPlaceInfo(placeDto);
			
				//다국어 저장
				if(placeDto.getMsgList() != null && placeDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(placeDto.getMsgList(), "place", placeDto.getPlaceId());
				}
			}else if(placeDto.getAction().equals("U")){//위치 수정
				//위치수정
				resultInt = newPlaceMapper.updatePlaceInfo(placeDto);
				
				//다국어 저장
				if(placeDto.getMsgList() != null && placeDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(placeDto.getMsgList(), "place", placeDto.getPlaceId());
				}
			}else if(placeDto.getAction().equals("USE")){//위치 잠금/해제
				if(placeDto.isUse()) {
					placeDto.setUse(false);
				}else {
					placeDto.setUse(true);
				}
				//위치잠금수정	
				resultInt = newPlaceMapper.updatePlaceInfo(placeDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("위치 입력 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	@Transactional
	public int setPlaceDelete(List<NewRlehoMgtDto> placeList){
		int resultInt = -1;
		try {
			//위치삭제
			for(NewRlehoMgtDto placeDto : placeList){
				newPlaceMapper.deletePlaceInfo(placeDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("위치 삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
	
}
