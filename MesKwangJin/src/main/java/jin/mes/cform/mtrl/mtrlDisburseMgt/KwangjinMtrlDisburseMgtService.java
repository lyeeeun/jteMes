package jin.mes.cform.mtrl.mtrlDisburseMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseHisDto;
import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseMgtDto;
import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinMtrlDisburseMgtService {
	
	@Resource
	KwangjinMtrlDisburseMgtMapper kwangjinMtrlDisburseMgtMapper;
	
	//자재 관리 조회
	public PageInfo<KwangjinMtrlDisburseMgtDto> getMtrlDisburseMgtList(KwangjinMtrlDisburseMgtDto mtrlDisburseMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrlDisburseMgtDto> mtrlMgtList = null;
		int rowCount = 0;

		// Page Setting
		mtrlDisburseMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlDisburseMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseMgtCount(mtrlDisburseMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtList = kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseMgtList(mtrlDisburseMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtList == null) {
			mtrlMgtList = new ArrayList<KwangjinMtrlDisburseMgtDto>();
		}
		return new PageInfo<KwangjinMtrlDisburseMgtDto>(mtrlMgtList, pageRequestVo, rowCount);
	}
	
	//자재관리 입력/수정
	@Transactional
	public String setMtrlDisburseMgtSave(KwangjinMtrlDisburseMgtDto mtrlDisburseMgtDto){
		String returnKey = "";
		try {
			mtrlDisburseMgtDto.setCreatorId(JteUtils.getUserId());
			mtrlDisburseMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlDisburseMgtDto.getAction().equals("C")) {//
				//자재입력
				kwangjinMtrlDisburseMgtMapper.insertMtrlDisburseMgt(mtrlDisburseMgtDto);
				returnKey = mtrlDisburseMgtDto.getMtrlMgtId();
			}else if(mtrlDisburseMgtDto.getAction().equals("U")){//자재 변경
				//자재수정
				kwangjinMtrlDisburseMgtMapper.updateMtrlDisburseMgt(mtrlDisburseMgtDto);
				
				returnKey =mtrlDisburseMgtDto.getMtrlMgtId();
			}else if(mtrlDisburseMgtDto.getAction().equals("D")){//isdel 처리
				mtrlDisburseMgtDto.setDel(true);
				//isdel 처리
				kwangjinMtrlDisburseMgtMapper.updateMtrlDisburseMgtIsDel(mtrlDisburseMgtDto);
				
				returnKey =mtrlDisburseMgtDto.getMtrlMgtId();
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 수량 히스토리(내역) 조회
	public PageInfo<KwangjinMtrlDisburseHisDto> getMtrlDisburseHisList(KwangjinMtrlDisburseHisDto mtrlDisburseHisDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrlDisburseHisDto> mtrlHisList = null;
		int rowCount = 0;

		// Page Setting
		mtrlDisburseHisDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlDisburseHisDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseHisCount(mtrlDisburseHisDto);
			if (rowCount > 0) {
				//List
				mtrlHisList = kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseHisList(mtrlDisburseHisDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlHisList == null) {
			mtrlHisList = new ArrayList<KwangjinMtrlDisburseHisDto>();
		}
		return new PageInfo<KwangjinMtrlDisburseHisDto>(mtrlHisList, pageRequestVo, rowCount);
	}
	
	//자재 수량이력 수동입력
	@Transactional
	public String setMtrlManualSave(KwangjinMtrlDisburseHisDto mtrlDisburseHisDto){
		String returnKey = "";
		try {
			mtrlDisburseHisDto.setCreatorId(JteUtils.getUserId());
			mtrlDisburseHisDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlDisburseHisDto.getAction().equals("C")) {//
				//자재 수량이력 수동 입력
				kwangjinMtrlDisburseMgtMapper.insertManualInfo(mtrlDisburseHisDto);
				
				//자재 수량관리 입력
				kwangjinMtrlDisburseMgtMapper.insertMtrlDisburseHis(mtrlDisburseHisDto);
				
				returnKey = mtrlDisburseHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				KwangjinMtrlDisburseMgtDto mtrlMgtCnt = new KwangjinMtrlDisburseMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseHisTotal(mtrlDisburseHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				kwangjinMtrlDisburseMgtMapper.updateMtrlDisburseMgt(mtrlMgtCnt);
			}
			else if(mtrlDisburseHisDto.getAction().equals("U")){//자재 사용 히스토리 변경
				//자재 사용dlfur 수동 수정
				kwangjinMtrlDisburseMgtMapper.updateManualInfo(mtrlDisburseHisDto);
				
				//자재 수량관리 tnwjd
				kwangjinMtrlDisburseMgtMapper.updateMtrlDisburseHis(mtrlDisburseHisDto);
				
				returnKey = mtrlDisburseHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				KwangjinMtrlDisburseMgtDto mtrlMgtCnt = new KwangjinMtrlDisburseMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseHisTotal(mtrlDisburseHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				kwangjinMtrlDisburseMgtMapper.updateMtrlDisburseMgt(mtrlMgtCnt);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 사용 히스토리 삭제
	@Transactional
	public int setMtrlManualDelete(List<KwangjinMtrlDisburseHisDto> mtrlHisList){
		int resultInt = -1;
		try {
			//자재 사용 히스토리 삭제
			for(KwangjinMtrlDisburseHisDto mtrlDisburseHisDto : mtrlHisList){
				kwangjinMtrlDisburseMgtMapper.deleteManualInfo(mtrlDisburseHisDto);
				kwangjinMtrlDisburseMgtMapper.deleteMtrlDisburseHis(mtrlDisburseHisDto);
			}
			
			KwangjinMtrlDisburseMgtDto mtrlMgtCnt = new KwangjinMtrlDisburseMgtDto();
			mtrlMgtCnt.setMtrlMgtId(mtrlHisList.get(0).getMtrlMgtId());
			mtrlMgtCnt.setMtrlMgtCnt(kwangjinMtrlDisburseMgtMapper.selectMtrlDisburseHisTotal(mtrlHisList.get(0)));
			mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
			mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
			kwangjinMtrlDisburseMgtMapper.updateMtrlDisburseMgt(mtrlMgtCnt);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용 히스토리 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
}
