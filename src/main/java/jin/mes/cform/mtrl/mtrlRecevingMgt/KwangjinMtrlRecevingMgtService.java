package jin.mes.cform.mtrl.mtrlRecevingMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingHisDto;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingMgtDto;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinMtrlRecevingMgtService {
	
	@Resource
	KwangjinMtrlRecevingMgtMapper kwangjinMtrlRecevingMgtMapper;
	
	//자재 관리 조회
	public PageInfo<KwangjinMtrlRecevingMgtDto> getMtrlRecevingMgtList(KwangjinMtrlRecevingMgtDto mtrlRecevingMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrlRecevingMgtDto> mtrlMgtList = null;
		int rowCount = 0;

		// Page Setting
		mtrlRecevingMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlRecevingMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingMgtCount(mtrlRecevingMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtList = kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingMgtList(mtrlRecevingMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtList == null) {
			mtrlMgtList = new ArrayList<KwangjinMtrlRecevingMgtDto>();
		}
		return new PageInfo<KwangjinMtrlRecevingMgtDto>(mtrlMgtList, pageRequestVo, rowCount);
	}
	
	//자재관리 입력/수정
	@Transactional
	public String setMtrlRecevingMgtSave(KwangjinMtrlRecevingMgtDto mtrlRecevingMgtDto){
		String returnKey = "";
		try {
			mtrlRecevingMgtDto.setCreatorId(JteUtils.getUserId());
			mtrlRecevingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlRecevingMgtDto.getAction().equals("C")) {//
				//자재입력
				kwangjinMtrlRecevingMgtMapper.insertMtrlRecevingMgt(mtrlRecevingMgtDto);
				returnKey = mtrlRecevingMgtDto.getMtrlMgtId();
			}else if(mtrlRecevingMgtDto.getAction().equals("U")){//자재 변경
				//자재수정
				kwangjinMtrlRecevingMgtMapper.updateMtrlRecevingMgt(mtrlRecevingMgtDto);
				
				returnKey =mtrlRecevingMgtDto.getMtrlMgtId();
			}else if(mtrlRecevingMgtDto.getAction().equals("D")){//isdel 처리
				mtrlRecevingMgtDto.setDel(true);
				//isdel 처리
				kwangjinMtrlRecevingMgtMapper.updateMtrlRecevingMgtIsDel(mtrlRecevingMgtDto);
				
				returnKey =mtrlRecevingMgtDto.getMtrlMgtId();
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 수량 히스토리(내역) 조회
	public PageInfo<KwangjinMtrlRecevingHisDto> getMtrlRecevingHisList(KwangjinMtrlRecevingHisDto mtrlRecevingHisDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrlRecevingHisDto> mtrlHisList = null;
		int rowCount = 0;

		// Page Setting
		mtrlRecevingHisDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlRecevingHisDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingHisCount(mtrlRecevingHisDto);
			if (rowCount > 0) {
				//List
				mtrlHisList = kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingHisList(mtrlRecevingHisDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlHisList == null) {
			mtrlHisList = new ArrayList<KwangjinMtrlRecevingHisDto>();
		}
		return new PageInfo<KwangjinMtrlRecevingHisDto>(mtrlHisList, pageRequestVo, rowCount);
	}
	
	//자재 수량이력 수동입력
	@Transactional
	public String setMtrlManualSave(KwangjinMtrlRecevingHisDto mtrlRecevingHisDto){
		String returnKey = "";
		try {
			mtrlRecevingHisDto.setCreatorId(JteUtils.getUserId());
			mtrlRecevingHisDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlRecevingHisDto.getAction().equals("C")) {//
				//자재 수량이력 수동 입력
				kwangjinMtrlRecevingMgtMapper.insertManualInfo(mtrlRecevingHisDto);
				
				//자재 수량관리 입력
				kwangjinMtrlRecevingMgtMapper.insertMtrlRecevingHis(mtrlRecevingHisDto);
				
				returnKey = mtrlRecevingHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				KwangjinMtrlRecevingMgtDto mtrlMgtCnt = new KwangjinMtrlRecevingMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingHisTotal(mtrlRecevingHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				kwangjinMtrlRecevingMgtMapper.updateMtrlRecevingMgt(mtrlMgtCnt);
			}
			else if(mtrlRecevingHisDto.getAction().equals("U")){//자재 사용 히스토리 변경
				//자재 사용dlfur 수동 수정
				kwangjinMtrlRecevingMgtMapper.updateManualInfo(mtrlRecevingHisDto);
				
				//자재 수량관리 tnwjd
				kwangjinMtrlRecevingMgtMapper.updateMtrlRecevingHis(mtrlRecevingHisDto);
				
				returnKey = mtrlRecevingHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				KwangjinMtrlRecevingMgtDto mtrlMgtCnt = new KwangjinMtrlRecevingMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingHisTotal(mtrlRecevingHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				kwangjinMtrlRecevingMgtMapper.updateMtrlRecevingMgt(mtrlMgtCnt);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 사용 히스토리 삭제
	@Transactional
	public int setMtrlManualDelete(List<KwangjinMtrlRecevingHisDto> mtrlHisList){
		int resultInt = -1;
		try {
			//자재 사용 히스토리 삭제
			for(KwangjinMtrlRecevingHisDto mtrlRecevingHisDto : mtrlHisList){
				kwangjinMtrlRecevingMgtMapper.deleteManualInfo(mtrlRecevingHisDto);
				kwangjinMtrlRecevingMgtMapper.deleteMtrlRecevingHis(mtrlRecevingHisDto);
			}
			
			KwangjinMtrlRecevingMgtDto mtrlMgtCnt = new KwangjinMtrlRecevingMgtDto();
			mtrlMgtCnt.setMtrlMgtId(mtrlHisList.get(0).getMtrlMgtId());
			mtrlMgtCnt.setMtrlMgtCnt(kwangjinMtrlRecevingMgtMapper.selectMtrlRecevingHisTotal(mtrlHisList.get(0)));
			mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
			mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
			kwangjinMtrlRecevingMgtMapper.updateMtrlRecevingMgt(mtrlMgtCnt);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용 히스토리 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
}
