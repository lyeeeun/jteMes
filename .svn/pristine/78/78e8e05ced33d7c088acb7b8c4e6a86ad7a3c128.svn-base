package jin.mes.form.basMgt.operMgt.rlehoMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.basMgt.operMgt.rlehoMgt.RlehoMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class RlehoMgtService {

	@Resource
	RlehoMgtMapper placeMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public List<RlehoMgtDto> getPlaceTree(RlehoMgtDto placeDto){
		List<RlehoMgtDto> placeList = null;
		try {
			placeList = placeMapper.selectPlaceTree(placeDto);
		} catch (Exception e) {
			throw new BusinessException("위치조회 에러입니다.(tree) : " + e.getMessage());
		}
		if (placeList == null) {
			placeList = new ArrayList<RlehoMgtDto>();
		}
		return placeList;
	}
	
	public PageInfo<RlehoMgtDto> getPlaceList(RlehoMgtDto placeDto, PageRequestVo pageRequestVo){
		List<RlehoMgtDto> placeList = null;
		int rowCount = 0;

		// Page Setting
		placeDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		placeDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = placeMapper.selectPlaceListCount(placeDto);
			if (rowCount > 0) {
				//List
				placeList = placeMapper.selectPlaceList(placeDto);
			}
		} catch (Exception e) {
			throw new BusinessException("위치조회 에러입니다.(List) : " + e.getMessage());
		}
		if (placeList == null) {
			placeList = new ArrayList<RlehoMgtDto>();
		}
		return new PageInfo<RlehoMgtDto>(placeList, pageRequestVo, rowCount);
	}
	
	@Transactional
	public int setPlaceSave(RlehoMgtDto placeDto){
		int resultInt = -1;
		try {
			placeDto.setCreatorId(JteUtils.getUserId());
			placeDto.setUpdatorId(JteUtils.getUserId());
			
			if(placeDto.getAction().equals("C")) {//위치 등록
				//위치입력
				resultInt = placeMapper.insertPlaceInfo(placeDto);
			
				//다국어 저장
				if(placeDto.getMsgList() != null && placeDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(placeDto.getMsgList(), "place", placeDto.getPlaceId());
				}
			}else if(placeDto.getAction().equals("U")){//위치 수정
				//위치수정
				resultInt = placeMapper.updatePlaceInfo(placeDto);
				
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
				resultInt = placeMapper.updatePlaceInfo(placeDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("위치 입력 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	@Transactional
	public int setPlaceDelete(List<RlehoMgtDto> placeList){
		int resultInt = -1;
		try {
			//위치삭제
			for(RlehoMgtDto placeDto : placeList){
				placeMapper.deletePlaceInfo(placeDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("위치 삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
	
}
