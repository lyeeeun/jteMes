package jin.mes.cform.mtrl.mtrlMgt;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.NewMtrlInfoDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.NewMtrlInfoMapper;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewMtrlMgtService {

	@Resource
	NewMtrlMgtMapper newMtrlMgtMapper;
	
	@Resource
	NewMtrlInfoMapper newMtrlInfoMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//자재 관리 조회
	public PageInfo<NewMtrlMgtDto> getMtrlMgtList(NewMtrlMgtDto newMtrlMgtDto, PageRequestVo pageRequestVo){
		List<NewMtrlMgtDto> mtrlMgtList = null;
		int rowCount = 0;

		// Page Setting
		newMtrlMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMtrlMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = newMtrlMgtMapper.selectMtrlMgtCount(newMtrlMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtList = newMtrlMgtMapper.selectMtrlMgtList(newMtrlMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtList == null) {
			mtrlMgtList = new ArrayList<NewMtrlMgtDto>();
		}
		return new PageInfo<NewMtrlMgtDto>(mtrlMgtList, pageRequestVo, rowCount);
	}
	
	//자재관리 입력/수정
	@Transactional
	public String setMtrlMgtSave(NewMtrlMgtDto newMtrlMgtDto){
		String returnKey = "";
		try {
			newMtrlMgtDto.setCreatorId(JteUtils.getUserId());
			newMtrlMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(newMtrlMgtDto.getAction().equals("C")) {//
				//자재입력
				newMtrlMgtMapper.insertMtrlMgt(newMtrlMgtDto);
				returnKey = newMtrlMgtDto.getMtrlMgtId();
			}else if(newMtrlMgtDto.getAction().equals("U")){//자재 변경
				//자재수정
				newMtrlMgtMapper.updateMtrlMgt(newMtrlMgtDto);
				
				returnKey =newMtrlMgtDto.getMtrlMgtId();
			}else if(newMtrlMgtDto.getAction().equals("D")){//isdel 처리
				newMtrlMgtDto.setDel(true);
				//isdel 처리
				newMtrlMgtMapper.updateMtrlMgtIsDel(newMtrlMgtDto);
				
				returnKey =newMtrlMgtDto.getMtrlMgtId();
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재정보 삭제
	@Transactional
	public int setMtrlMgtDelete(List<NewMtrlMgtDto> mtrlMgtList){
		int resultInt = -1;
		try {
			//자재삭제
			for(NewMtrlMgtDto newMtrlMgtDto : mtrlMgtList){
				newMtrlMgtMapper.deleteMtrlMgt(newMtrlMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	
	//자재 수량 히스토리(내역) 조회
	public PageInfo<NewMtrlHistoryDto> getMtrlHistoryList(NewMtrlHistoryDto newMtrlHistoryDto, PageRequestVo pageRequestVo){
		List<NewMtrlHistoryDto> mtrlHisList = null;
		int rowCount = 0;

		// Page Setting
		newMtrlHistoryDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMtrlHistoryDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlMgtMapper.selectMtrlHistoryCount(newMtrlHistoryDto);
			if (rowCount > 0) {
				//List
				mtrlHisList = newMtrlMgtMapper.selectMtrlHistoryList(newMtrlHistoryDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlHisList == null) {
			mtrlHisList = new ArrayList<NewMtrlHistoryDto>();
		}
		return new PageInfo<NewMtrlHistoryDto>(mtrlHisList, pageRequestVo, rowCount);
	}
	
	//자재 수량이력 수동입력
	@Transactional
	public String setMtrlManualSave(NewMtrlHistoryDto newMtrlHisDto){
		String returnKey = "";
		try {
			newMtrlHisDto.setCreatorId(JteUtils.getUserId());
			newMtrlHisDto.setUpdatorId(JteUtils.getUserId());
			
			if(newMtrlHisDto.getAction().equals("C")) {//
				//자재 수량이력 수동 입력
				newMtrlMgtMapper.insertManualInfo(newMtrlHisDto);
				
				//자재 수량관리 입력
				newMtrlMgtMapper.insertMtrlHistory(newMtrlHisDto);
				
				returnKey = newMtrlHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				NewMtrlMgtDto mtrlMgtCnt = new NewMtrlMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(newMtrlHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				newMtrlMgtMapper.updateMtrlMgt(mtrlMgtCnt);
			}
			else if(newMtrlHisDto.getAction().equals("U")){//자재 사용 히스토리 변경
				//자재 사용dlfur 수동 수정
				newMtrlMgtMapper.updateManualInfo(newMtrlHisDto);
				
				//자재 수량관리 tnwjd
				newMtrlMgtMapper.updateMtrlHistory(newMtrlHisDto);
				
				returnKey = newMtrlHisDto.getMtrlMgtId();
				
				//자재관리 합계 total
				NewMtrlMgtDto mtrlMgtCnt = new NewMtrlMgtDto();
				mtrlMgtCnt.setMtrlMgtId(returnKey);
				mtrlMgtCnt.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(newMtrlHisDto));
				mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
				mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
				newMtrlMgtMapper.updateMtrlMgt(mtrlMgtCnt);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 사용 히스토리 삭제
	@Transactional
	public int setMtrlManualDelete(List<NewMtrlHistoryDto> mtrlHisList){
		int resultInt = -1;
		try {
			//자재 사용 히스토리 삭제
			for(NewMtrlHistoryDto newMtrlHisDto : mtrlHisList){
				newMtrlMgtMapper.deleteManualInfo(newMtrlHisDto);
				newMtrlMgtMapper.deleteMtrlHistory(newMtrlHisDto);
			}
			
			NewMtrlMgtDto mtrlMgtCnt = new NewMtrlMgtDto();
			mtrlMgtCnt.setMtrlMgtId(mtrlHisList.get(0).getMtrlMgtId());
			mtrlMgtCnt.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(mtrlHisList.get(0)));
			mtrlMgtCnt.setCreatorId(JteUtils.getUserId());
			mtrlMgtCnt.setUpdatorId(JteUtils.getUserId());
			newMtrlMgtMapper.updateMtrlMgt(mtrlMgtCnt);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용 히스토리 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	
	//타 모듈에서 자재 사용 또는 입고
	@Transactional
	public String setMtrlMgtPgSave(NewMtrlHistoryDto newMtrlHisDto){
		String returnKey = "";
		try {
			newMtrlHisDto.setCreatorId(JteUtils.getUserId());
 			newMtrlHisDto.setUpdatorId(JteUtils.getUserId());
			
			//자재정보
			NewMtrlInfoDto newMtrlInfoDto = new NewMtrlInfoDto();
			//자재관리
			NewMtrlMgtDto newMtrlMgtDto = new NewMtrlMgtDto();
			List<NewMtrlMgtDto> mtrlMgtList = new ArrayList<NewMtrlMgtDto>();
			newMtrlMgtDto.setCreatorId(JteUtils.getUserId());
			newMtrlMgtDto.setUpdatorId(JteUtils.getUserId());
			newMtrlMgtDto.setUse(true);
			//ADD : 입고(더하기), SUBTRACT(사용,불량 등등차감) ,U : 수정  
			if(newMtrlHisDto.getAction().equals("ADD")) {
				//자재정보 목록 조회
				newMtrlInfoDto.setMtrlId(newMtrlHisDto.getMtrlId());
				newMtrlInfoDto = newMtrlInfoMapper.selectMtrlInfoList(newMtrlInfoDto).get(0);
				
				//일반자재,시효자재,사급자재 분기처리
				if(newMtrlInfoDto.getMtrlType().equals("mtrl_div01")) {//일반자재
					//-일반자재인 경우 등록된 자재조회(일반자재는 무조건 한개의 데이터로 관리)
					newMtrlMgtDto.setMtrlId(newMtrlInfoDto.getMtrlId());
					mtrlMgtList = newMtrlMgtMapper.selectMtrlMgtList(newMtrlMgtDto);
					if(mtrlMgtList.size() == 0) {
						//자재가 없는 경우 > 재재관리 insert
						newMtrlMgtDto.setMtrlMgtPurchase(newMtrlHisDto.getMtrlQtyDate());
						newMtrlMgtDto.setLotId(newMtrlHisDto.getMtrlQtyTargetCode());
						newMtrlMgtDto.setMtrlMgtDesc(newMtrlHisDto.getMtrlQtyDesc());
						newMtrlMgtMapper.insertMtrlMgt(newMtrlMgtDto);
					}else {
						//자재가 있는 경우  > 객체에 담아줌
						newMtrlMgtDto = mtrlMgtList.get(0);
					}
				}else if(newMtrlInfoDto.getMtrlType().equals("mtrl_div02")) {//시효자재
					//-시효자재인 경우 무조건 하고 insert
					newMtrlMgtDto.setMtrlId(newMtrlInfoDto.getMtrlId());
					//입고일 설정
					newMtrlMgtDto.setMtrlMgtPurchase(newMtrlHisDto.getMtrlQtyDate());
					newMtrlMgtDto.setLotId(newMtrlHisDto.getMtrlQtyTargetCode());
					//시효일 지정을 위한 세팅
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					Calendar cal = Calendar.getInstance();
					
					//입고일 시간 세팅
					cal.setTime(df.parse(newMtrlHisDto.getMtrlQtyDate()));
					//입고일 + 시효일(자재마스터 정보)
					cal.add(Calendar.DATE, newMtrlInfoDto.getMtrlUseday());
					//시효일설정
					newMtrlMgtDto.setMtrlMgtPrescription(df.format(cal.getTime()));
					//비고설정
					newMtrlMgtDto.setMtrlMgtDesc(newMtrlHisDto.getMtrlQtyDesc());
					newMtrlMgtMapper.insertMtrlMgt(newMtrlMgtDto);
					
				}else if(newMtrlInfoDto.getMtrlType().equals("mtrl_div00")) {//사급자재
					//-사급자재인 경우 무조건 하고 insert
					newMtrlMgtDto.setMtrlId(newMtrlInfoDto.getMtrlId());
					//입고일 설정
					newMtrlMgtDto.setMtrlMgtPurchase(newMtrlHisDto.getMtrlQtyDate());
					//사급자재 추적용 LOTID
					newMtrlMgtDto.setLotId(newMtrlHisDto.getMtrlQtyTargetCode());
					//비고설정
					newMtrlMgtDto.setMtrlMgtDesc(newMtrlHisDto.getMtrlQtyDesc());
					newMtrlMgtMapper.insertMtrlMgt(newMtrlMgtDto);
				}
				
				//history insert
				newMtrlHisDto.setMtrlMgtId(newMtrlMgtDto.getMtrlMgtId());
				newMtrlMgtMapper.insertMtrlHistory(newMtrlHisDto);
				
				//재재관리 total update
				newMtrlMgtDto.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(newMtrlHisDto));
				newMtrlMgtMapper.updateMtrlMgt(newMtrlMgtDto);
			}else if(newMtrlHisDto.getAction().equals("SUBTRACT")) {//차감
				//history insert
				newMtrlMgtMapper.insertMtrlHistory(newMtrlHisDto);
				
				//재재관리 total update
				newMtrlMgtDto.setMtrlId(newMtrlHisDto.getMtrlId());
				newMtrlMgtDto.setMtrlMgtId(newMtrlHisDto.getMtrlMgtId());
				newMtrlMgtDto.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(newMtrlHisDto));
				newMtrlMgtMapper.updateMtrlMgt(newMtrlMgtDto);
			}else if(newMtrlHisDto.getAction().equals("U")){//자재 내역 수정
				newMtrlMgtMapper.updateMtrlHistory(newMtrlHisDto);
				
				//자재관리 총수량 변경
				newMtrlMgtDto.setMtrlMgtId(newMtrlHisDto.getMtrlMgtId());
				newMtrlMgtDto.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(newMtrlHisDto));
				newMtrlMgtMapper.updateMtrlMgt(newMtrlMgtDto);
			}else if(newMtrlHisDto.getAction().equals("D")) {//히스토리제거
				//history 'delete'
				newMtrlMgtMapper.deleteMtrlHistory(newMtrlHisDto);
				
				//자재관리 총수량 변경
				newMtrlMgtDto.setMtrlMgtId(newMtrlHisDto.getMtrlMgtId());
				newMtrlMgtDto.setMtrlMgtCnt(newMtrlMgtMapper.selectMtrlHistoryTotal(newMtrlHisDto));
				newMtrlMgtMapper.updateMtrlMgt(newMtrlMgtDto);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
