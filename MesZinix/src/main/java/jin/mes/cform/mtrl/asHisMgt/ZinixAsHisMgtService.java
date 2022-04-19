package jin.mes.cform.mtrl.asHisMgt;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtService;
import jin.mes.cform.ship.shipMgt.ZinixShipMgtDto;
import jin.mes.cform.ship.shipMgt.ZinixShipMgtMapper;
import jin.mes.cform.ship.shipMgt.ZinixShipMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixAsHisMgtService {

	@Resource
	ZinixAsHisMgtMapper zinixAsHisMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	ZinixMtrlMgtService zinixMtrlMgtService;
	
	@Autowired
	ZinixShipMgtMapper zinixShipMgtMapper;
	
	//바코드 정보 조회
	public PageInfo<ZinixAsHisMgtDto> getSerialList(ZinixAsHisMgtDto zinixAsHisMgtDto, PageRequestVo pageRequestVo){
		List<ZinixAsHisMgtDto> asHisMgtList = null;
		int rowCount = 0;

		// Page Setting
		zinixAsHisMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixAsHisMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = zinixAsHisMgtMapper.selectSerialCount(zinixAsHisMgtDto);
			if (rowCount > 0) {
				//List
				asHisMgtList = zinixAsHisMgtMapper.selectSerialList(zinixAsHisMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("바코드 조회 에러입니다. : " + e.getMessage());
		}
		if (asHisMgtList == null) {
			asHisMgtList = new ArrayList<ZinixAsHisMgtDto>();
		}
		return new PageInfo<ZinixAsHisMgtDto>(asHisMgtList, pageRequestVo, rowCount);
	}
	
	//as 정보 조회
	public PageInfo<ZinixAsHisMgtDto> getAsHisMgtList(ZinixAsHisMgtDto zinixAsHisMgtDto, PageRequestVo pageRequestVo){
		List<ZinixAsHisMgtDto> asHisMgtList = null;
		int rowCount = 0;

		// Page Setting
		zinixAsHisMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixAsHisMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = zinixAsHisMgtMapper.selectAsHisMgtCount(zinixAsHisMgtDto);
			if (rowCount > 0) {
				//List
				asHisMgtList = zinixAsHisMgtMapper.selectAsHisMgtList(zinixAsHisMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("as정보 조회 에러입니다. : " + e.getMessage());
		}
		if (asHisMgtList == null) {
			asHisMgtList = new ArrayList<ZinixAsHisMgtDto>();
		}
		return new PageInfo<ZinixAsHisMgtDto>(asHisMgtList, pageRequestVo, rowCount);
	}
	
	//as정보 입력/수정
	@Transactional
	public String setAsHisMgtSave(ZinixAsHisMgtDto zinixAsHisMgtDto){
		String returnKey = "";
		try {
			zinixAsHisMgtDto.setCreatorId(JteUtils.getUserId());
			zinixAsHisMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(zinixAsHisMgtDto.getAction().equals("C")) {//
				//as정보 입력
				zinixAsHisMgtMapper.insertAsHisMgt(zinixAsHisMgtDto);
				
//				zinixAsHisMgtMapper.insertAsHisSerialMgt(zinixAsHisMgtDto);
				returnKey = zinixAsHisMgtDto.getAshisId();
				
				//as 수량을 등록하기 위한 생성자
				ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(zinixAsHisMgtDto.getMtrlId(), "mtrl_tagt07", returnKey,
						zinixAsHisMgtDto.getAshisCnt()*-1, zinixAsHisMgtDto.getAshisAt(), zinixAsHisMgtDto.getAshisUser() ,zinixAsHisMgtDto.getMtrlMgtId(), zinixAsHisMgtDto.getLotId());
				
				//as를 등록하고 자재수량을 갱신
				mtrlCntDto.setAction("SUBTRACT");					
				zinixMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
			}else if(zinixAsHisMgtDto.getAction().equals("U")){//자재 변경
				//as정보 수정
				zinixAsHisMgtMapper.updateAsHisMgt(zinixAsHisMgtDto);
				returnKey =zinixAsHisMgtDto.getAshisId();
				
				//as 수량을 수정하기 위한 생성자
				ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(zinixAsHisMgtDto.getMtrlId(), "mtrl_tagt07", returnKey,
						zinixAsHisMgtDto.getAshisCnt()*-1, zinixAsHisMgtDto.getAshisAt(), zinixAsHisMgtDto.getAshisUser() ,zinixAsHisMgtDto.getMtrlMgtId(), zinixAsHisMgtDto.getLotId());
				
				//as를 수정하고 자재수량을 갱신
				mtrlCntDto.setAction("U");
				zinixMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//as정보 삭제
	@Transactional
	public int setAsHisMgtDelete(List<ZinixAsHisMgtDto> asHisMgtList){
		int resultInt = -1;
		try {
			//as삭제
			for(ZinixAsHisMgtDto zinixAsHisMgtDto : asHisMgtList){
				zinixAsHisMgtMapper.deleteAsHisMgt(zinixAsHisMgtDto);
				
				ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto();
				mtrlCntDto.setMtrlMgtId(zinixAsHisMgtDto.getMtrlMgtId());
				mtrlCntDto.setMtrlQtyTarget("mtrl_tagt07");
				mtrlCntDto.setMtrlQtyTargetCode(zinixAsHisMgtDto.getAshisId());
				
				//불량품 수량을 삭제하고 자재수량 갱신
				mtrlCntDto.setAction("D");
				zinixMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("as 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
		
}
