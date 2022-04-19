package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewMtrlInfoService {

	@Resource
	NewMtrlInfoMapper newMtrlInfoMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewMtrlInfoDto> getMtrlInfoList(NewMtrlInfoDto newMtrlInfoDto, PageRequestVo pageRequestVo){
		List<NewMtrlInfoDto> mtrlInfoList = null;
		int rowCount = 0;

		// Page Setting
		newMtrlInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMtrlInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlInfoMapper.selectMtrlInfoCount(newMtrlInfoDto);
			if (rowCount > 0) {
				//List
				mtrlInfoList = newMtrlInfoMapper.selectMtrlInfoList(newMtrlInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlInfoList == null) {
			mtrlInfoList = new ArrayList<NewMtrlInfoDto>();
		}
		return new PageInfo<NewMtrlInfoDto>(mtrlInfoList, pageRequestVo, rowCount);
	}
	
	//자재정보 입력/수정
	@Transactional
	public String setMtrlInfoSave(NewMtrlInfoDto newMtrlInfoDto){
		String returnKey = "";
		try {
			newMtrlInfoDto.setCreatorId(JteUtils.getUserId());
			newMtrlInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(newMtrlInfoDto.getAction().equals("C")) {//
				//자재입력
				newMtrlInfoMapper.insertMtrlInfo(newMtrlInfoDto);
				returnKey = newMtrlInfoDto.getMtrlId();
				//다국어 저장
				if(newMtrlInfoDto.getMsgList() != null && newMtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newMtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
			}else if(newMtrlInfoDto.getAction().equals("U")){//자재 변경
				//자재수정
				newMtrlInfoMapper.updateMtrlInfo(newMtrlInfoDto);
				
				returnKey =newMtrlInfoDto.getMtrlId();
				
				//다국어 저장
				if(newMtrlInfoDto.getMsgList() != null && newMtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newMtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
			}else if(newMtrlInfoDto.getAction().equals("USE")){//자재 잠금/해제
				if(newMtrlInfoDto.isUse()) {
					newMtrlInfoDto.setUse(false);
				}else {
					newMtrlInfoDto.setUse(true);
				}
				//자재사용수정	
				newMtrlInfoMapper.updateMtrlInfo(newMtrlInfoDto);
				
				returnKey =newMtrlInfoDto.getMtrlId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재정보 삭제
	@Transactional
	public int setMtrlInfoDelete(List<NewMtrlInfoDto> mtrlInfoList){
		int resultInt = -1;
		try {
			//자재삭제
			for(NewMtrlInfoDto newMtrlInfoDto : mtrlInfoList){
				newMtrlInfoMapper.deleteMtrlInfo(newMtrlInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	//자재구매업체 조회
	public PageInfo<NewCompMgtDto> getMtrlRtlCompList(NewCompMgtDto newCompMgtDto, PageRequestVo pageRequestVo){
		List<NewCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		newCompMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newCompMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlInfoMapper.selectMtrlRtlCompCount(newCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = newMtrlInfoMapper.selectMtrlRtlCompList(newCompMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재구매업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<NewCompMgtDto>();
		}
		return new PageInfo<NewCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//자재구매업체 입력/수정
	@Transactional
	public String setMtrlRtlCompSave(NewCompMgtDto newCompMgtDto){
		String returnKey = "";
		try {
			newCompMgtDto.setCreatorId(JteUtils.getUserId());
			newCompMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(newCompMgtDto.getAction().equals("C")) {//
				//업체입력
				newMtrlInfoMapper.insertMtrlRtlComp(newCompMgtDto);
				returnKey = newCompMgtDto.getCompId();
			}
//			else if(newCompMgtDto.getAction().equals("U")){//업체 변경
//				//업체수정
//				newMtrlInfoMapper.updateCompInfo(newCompMgtDto);
//				
//				returnKey =newCompMgtDto.getCompId();
//				
//				//다국어 저장
//				if(newCompMgtDto.getMsgList() != null && newCompMgtDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(newCompMgtDto.getMsgList(), "comp", returnKey);
//				}
//			}else if(newCompMgtDto.getAction().equals("USE")){//업체 잠금/해제
//				if(newCompMgtDto.isUse()) {
//					newCompMgtDto.setUse(false);
//				}else {
//					newCompMgtDto.setUse(true);
//				}
//				//업체사용수정	
//				newMtrlInfoMapper.updateCompInfo(newCompMgtDto);
//				
//				returnKey =newCompMgtDto.getCompId();
//			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재구매업체 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//업체정보 삭제
	@Transactional
	public int setMtrlRtlCompDelete(List<NewCompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(NewCompMgtDto newCompDto : compList){
				newMtrlInfoMapper.deleteMtrlRtlComp(newCompDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재구매업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
}
