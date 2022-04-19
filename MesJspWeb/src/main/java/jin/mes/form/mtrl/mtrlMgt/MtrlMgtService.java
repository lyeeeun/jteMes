package jin.mes.form.mtrl.mtrlMgt;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.basMgt.operMgt.mtrlInfo.MtrlInfoDto;
import jin.mes.mapper.basMgt.operMgt.mtrlInfo.MtrlInfoMapper;
import jin.mes.mapper.mtrl.mtrlMgt.MtrlMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrlMgtService {

	@Resource
	MtrlMgtMapper mtrlMgtMapper;
	
	@Resource
	MtrlInfoMapper mtrlInfoMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//자재 관리 조회
	public PageInfo<MtrlMgtDto> getMtrlMgtList(MtrlMgtDto mtrlMgtDto, PageRequestVo pageRequestVo){
		List<MtrlMgtDto> mtrlMgtList = null;
		int rowCount = 0;

		// Page Setting
		mtrlMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mtrlMgtMapper.selectMtrlMgtCount(mtrlMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtList = mtrlMgtMapper.selectMtrlMgtList(mtrlMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtList == null) {
			mtrlMgtList = new ArrayList<MtrlMgtDto>();
		}
		return new PageInfo<MtrlMgtDto>(mtrlMgtList, pageRequestVo, rowCount);
	}
	
	//자재관리 입력/수정
	@Transactional
	public String setMtrlMgtSave(MtrlMgtDto mtrlMgtDto){
		String returnKey = "";
		try {
			mtrlMgtDto.setCreatorId(JteUtils.getUserId());
			mtrlMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlMgtDto.getAction().equals("C")) {//
				//자재입력
				mtrlMgtMapper.insertMtrlMgt(mtrlMgtDto);
				returnKey = mtrlMgtDto.getMtrlMgtId();
			}else if(mtrlMgtDto.getAction().equals("U")){//자재 변경
				//자재수정
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtDto);
				
				returnKey =mtrlMgtDto.getMtrlMgtId();
			}else if(mtrlMgtDto.getAction().equals("D")){//isdel 처리
				mtrlMgtDto.setDel(true);
				//isdel 처리
				mtrlMgtMapper.updateMtrlMgtIsDel(mtrlMgtDto);
				
				returnKey =mtrlMgtDto.getMtrlMgtId();
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재정보 삭제
	@Transactional
	public int setMtrlMgtDelete(List<MtrlMgtDto> mtrlMgtList){
		int resultInt = -1;
		try {
			//자재삭제
			for(MtrlMgtDto mtrlMgtDto : mtrlMgtList){
				mtrlMgtMapper.deleteMtrlMgt(mtrlMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	
	//자재 수량 히스토리(내역) 조회
	public PageInfo<MtrlHistoryDto> getMtrlHistoryList(MtrlHistoryDto mtrlHistoryDto, PageRequestVo pageRequestVo){
		List<MtrlHistoryDto> mtrlHisList = null;
		int rowCount = 0;

		// Page Setting
		mtrlHistoryDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlHistoryDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlMgtMapper.selectMtrlHistoryCount(mtrlHistoryDto);
			if (rowCount > 0) {
				//List
				mtrlHisList = mtrlMgtMapper.selectMtrlHistoryList(mtrlHistoryDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlHisList == null) {
			mtrlHisList = new ArrayList<MtrlHistoryDto>();
		}
		return new PageInfo<MtrlHistoryDto>(mtrlHisList, pageRequestVo, rowCount);
	}
	
	//자재 수량이력 수동입력
	@Transactional
	public String setMtrlManualSave(MtrlHistoryDto mtrlHisDto){
		String returnKey = "";
		try {
			mtrlHisDto.setCreatorId(JteUtils.getUserId());
			mtrlHisDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlHisDto.getAction().equals("C")) {//
				//자재 수량이력 수동 입력
				mtrlMgtMapper.insertManualInfo(mtrlHisDto);
				
				//자재 수량관리 입력
				mtrlMgtMapper.insertMtrlHistory(mtrlHisDto);
				
				returnKey = mtrlHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				MtrlMgtDto mtrlMgtCnt = new MtrlMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtCnt);
			}
			else if(mtrlHisDto.getAction().equals("U")){//자재 사용 히스토리 변경
				//자재 사용dlfur 수동 수정
				mtrlMgtMapper.updateManualInfo(mtrlHisDto);
				
				//자재 수량관리 tnwjd
				mtrlMgtMapper.updateMtrlHistory(mtrlHisDto);
				
				returnKey = mtrlHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				MtrlMgtDto mtrlMgtCnt = new MtrlMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtCnt);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 사용 히스토리 삭제
	@Transactional
	public int setMtrlManualDelete(List<MtrlHistoryDto> mtrlHisList){
		int resultInt = -1;
		try {
			//자재 사용 히스토리 삭제
			for(MtrlHistoryDto mtrlHisDto : mtrlHisList){
				mtrlMgtMapper.deleteManualInfo(mtrlHisDto);
				mtrlMgtMapper.deleteMtrlHistory(mtrlHisDto);
			}
			
			MtrlMgtDto mtrlMgtCnt = new MtrlMgtDto();
			mtrlMgtCnt.setMtrlMgtId(mtrlHisList.get(0).getMtrlMgtId());
			mtrlMgtCnt.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisList.get(0)));
			mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
			mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
			mtrlMgtMapper.updateMtrlMgt(mtrlMgtCnt);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용 히스토리 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	
	//타 모듈에서 자재 사용 또는 입고
	@Transactional
	public String setMtrlMgtPgSave(MtrlHistoryDto mtrlHisDto){
		String returnKey = "";
		try {
			mtrlHisDto.setCreatorId(JteUtils.getUserId());
 			mtrlHisDto.setUpdatorId(JteUtils.getUserId());
			
			//자재정보
			MtrlInfoDto mtrlInfoDto = new MtrlInfoDto();
			//자재관리
			MtrlMgtDto mtrlMgtDto = new MtrlMgtDto();
			List<MtrlMgtDto> mtrlMgtList = new ArrayList<MtrlMgtDto>();
			mtrlMgtDto.setCreatorId(JteUtils.getUserId());
			mtrlMgtDto.setUpdatorId(JteUtils.getUserId());
			mtrlMgtDto.setUse(true);
			//ADD : 입고(더하기), SUBTRACT(사용,불량 등등차감) ,U : 수정  
			if(mtrlHisDto.getAction().equals("ADD")) {
				//자재정보 목록 조회
				mtrlInfoDto.setMtrlId(mtrlHisDto.getMtrlId());
				mtrlInfoDto = mtrlInfoMapper.selectMtrlInfoList(mtrlInfoDto).get(0);
				
				//일반자재,시효자재,사급자재 분기처리
				if(mtrlInfoDto.getMtrlType().equals("mtrl_div01")) {//일반자재
					//-일반자재인 경우 등록된 자재조회(일반자재는 무조건 한개의 데이터로 관리)
					mtrlMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
					mtrlMgtList = mtrlMgtMapper.selectMtrlMgtList(mtrlMgtDto);
					if(mtrlMgtList.size() == 0) {
						//자재가 없는 경우 > 재재관리 insert
						mtrlMgtDto.setMtrlMgtPurchase(mtrlHisDto.getMtrlQtyDate());
						mtrlMgtDto.setLotId(mtrlHisDto.getMtrlQtyTargetCode());
						mtrlMgtDto.setMtrlMgtDesc(mtrlHisDto.getMtrlQtyDesc());
						mtrlMgtMapper.insertMtrlMgt(mtrlMgtDto);
					}else {
						//자재가 있는 경우  > 객체에 담아줌
						mtrlMgtDto = mtrlMgtList.get(0);
					}
				}else if(mtrlInfoDto.getMtrlType().equals("mtrl_div02")) {//시효자재
					//-시효자재인 경우 무조건 하고 insert
					mtrlMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
					//입고일 설정
					mtrlMgtDto.setMtrlMgtPurchase(mtrlHisDto.getMtrlQtyDate());
					mtrlMgtDto.setLotId(mtrlHisDto.getMtrlQtyTargetCode());
					//시효일 지정을 위한 세팅
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					Calendar cal = Calendar.getInstance();
					
					//입고일 시간 세팅
					cal.setTime(df.parse(mtrlHisDto.getMtrlQtyDate()));
					//입고일 + 시효일(자재마스터 정보)
					cal.add(Calendar.DATE, mtrlInfoDto.getMtrlUseday());
					//시효일설정
					mtrlMgtDto.setMtrlMgtPrescription(df.format(cal.getTime()));
					//비고설정
					mtrlMgtDto.setMtrlMgtDesc(mtrlHisDto.getMtrlQtyDesc());
					mtrlMgtMapper.insertMtrlMgt(mtrlMgtDto);
					
				}else if(mtrlInfoDto.getMtrlType().equals("mtrl_div00")) {//사급자재
					//-사급자재인 경우 무조건 하고 insert
					mtrlMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
					//입고일 설정
					mtrlMgtDto.setMtrlMgtPurchase(mtrlHisDto.getMtrlQtyDate());
					//사급자재 추적용 LOTID
					mtrlMgtDto.setLotId(mtrlHisDto.getMtrlQtyTargetCode());
					//비고설정
					mtrlMgtDto.setMtrlMgtDesc(mtrlHisDto.getMtrlQtyDesc());
					mtrlMgtMapper.insertMtrlMgt(mtrlMgtDto);
				}
				
				//history insert
				mtrlHisDto.setMtrlMgtId(mtrlMgtDto.getMtrlMgtId());
				mtrlMgtMapper.insertMtrlHistory(mtrlHisDto);
				
				//재재관리 total update
				mtrlMgtDto.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisDto));
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtDto);
			}else if(mtrlHisDto.getAction().equals("SUBTRACT")) {//차감
				//history insert
				mtrlMgtMapper.insertMtrlHistory(mtrlHisDto);
				
				//재재관리 total update
				mtrlMgtDto.setMtrlId(mtrlHisDto.getMtrlId());
				mtrlMgtDto.setMtrlMgtId(mtrlHisDto.getMtrlMgtId());
				mtrlMgtDto.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisDto));
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtDto);
			}else if(mtrlHisDto.getAction().equals("U")){//자재 내역 수정
				mtrlMgtMapper.updateMtrlHistory(mtrlHisDto);
				
				//자재관리 총수량 변경
				mtrlMgtDto.setMtrlMgtId(mtrlHisDto.getMtrlMgtId());
				mtrlMgtDto.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisDto));
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtDto);
			}else if(mtrlHisDto.getAction().equals("D")) {//히스토리제거
				//history 'delete'
				mtrlMgtMapper.deleteMtrlHistory(mtrlHisDto);
				
				//자재관리 총수량 변경
				mtrlMgtDto.setMtrlMgtId(mtrlHisDto.getMtrlMgtId());
				mtrlMgtDto.setMtrlMgtCnt(mtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisDto));
				mtrlMgtMapper.updateMtrlMgt(mtrlMgtDto);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
