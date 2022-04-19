package jin.mes.form.basMgt.operMgt.mtrlInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.mapper.basMgt.operMgt.mtrlInfo.MtrlInfoMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrlInfoService {

	@Resource
	MtrlInfoMapper mtrlInfoMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<MtrlInfoDto> getMtrlInfoList(MtrlInfoDto mtrlInfoDto, PageRequestVo pageRequestVo){
		List<MtrlInfoDto> mtrlInfoList = null;
		int rowCount = 0;

		// Page Setting
		mtrlInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlInfoMapper.selectMtrlInfoCount(mtrlInfoDto);
			if (rowCount > 0) {
				//List
				mtrlInfoList = mtrlInfoMapper.selectMtrlInfoList(mtrlInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlInfoList == null) {
			mtrlInfoList = new ArrayList<MtrlInfoDto>();
		}
		return new PageInfo<MtrlInfoDto>(mtrlInfoList, pageRequestVo, rowCount);
	}
	
	//자재정보 입력/수정
	@Transactional
	public String setMtrlInfoSave(MtrlInfoDto mtrlInfoDto){
		String returnKey = "";
		try {
			mtrlInfoDto.setCreatorId(JteUtils.getUserId());
			mtrlInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlInfoDto.getAction().equals("C")) {//
				//자재입력
				mtrlInfoMapper.insertMtrlInfo(mtrlInfoDto);
				returnKey = mtrlInfoDto.getMtrlId();
				//다국어 저장
				if(mtrlInfoDto.getMsgList() != null && mtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(mtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
			}else if(mtrlInfoDto.getAction().equals("U")){//자재 변경
				//자재수정
				mtrlInfoMapper.updateMtrlInfo(mtrlInfoDto);
				
				returnKey =mtrlInfoDto.getMtrlId();
				
				//다국어 저장
				if(mtrlInfoDto.getMsgList() != null && mtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(mtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
			}else if(mtrlInfoDto.getAction().equals("USE")){//자재 잠금/해제
				if(mtrlInfoDto.isUse()) {
					mtrlInfoDto.setUse(false);
				}else {
					mtrlInfoDto.setUse(true);
				}
				//자재사용수정	
				mtrlInfoMapper.updateMtrlInfo(mtrlInfoDto);
				
				returnKey =mtrlInfoDto.getMtrlId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재정보 삭제
	@Transactional
	public int setMtrlInfoDelete(List<MtrlInfoDto> mtrlInfoList){
		int resultInt = -1;
		try {
			//자재삭제
			for(MtrlInfoDto mtrlInfoDto : mtrlInfoList){
				mtrlInfoMapper.deleteMtrlInfo(mtrlInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	//자재구매업체 조회
	public PageInfo<CompMgtDto> getMtrlRtlCompList(CompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<CompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlInfoMapper.selectMtrlRtlCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = mtrlInfoMapper.selectMtrlRtlCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재구매업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<CompMgtDto>();
		}
		return new PageInfo<CompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//자재구매업체 입력/수정
	@Transactional
	public String setMtrlRtlCompSave(CompMgtDto compMgtDto){
		String returnKey = "";
		try {
			compMgtDto.setCreatorId(JteUtils.getUserId());
			compMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(compMgtDto.getAction().equals("C")) {//
				//업체입력
				mtrlInfoMapper.insertMtrlRtlComp(compMgtDto);
				returnKey = compMgtDto.getCompId();
			}
//			else if(compMgtDto.getAction().equals("U")){//업체 변경
//				//업체수정
//				mtrlInfoMapper.updateCompInfo(compMgtDto);
//				
//				returnKey =compMgtDto.getCompId();
//				
//				//다국어 저장
//				if(compMgtDto.getMsgList() != null && compMgtDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(compMgtDto.getMsgList(), "comp", returnKey);
//				}
//			}else if(compMgtDto.getAction().equals("USE")){//업체 잠금/해제
//				if(compMgtDto.isUse()) {
//					compMgtDto.setUse(false);
//				}else {
//					compMgtDto.setUse(true);
//				}
//				//업체사용수정	
//				mtrlInfoMapper.updateCompInfo(compMgtDto);
//				
//				returnKey =compMgtDto.getCompId();
//			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재구매업체 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//업체정보 삭제
	@Transactional
	public int setMtrlRtlCompDelete(List<CompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(CompMgtDto compDto : compList){
				mtrlInfoMapper.deleteMtrlRtlComp(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재구매업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
}
