package jin.mes.form.mtrl.asHisMgt;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import jin.mes.form.ship.shipMgt.ShipMgtDto;
import jin.mes.form.ship.shipMgt.ShipMgtMapper;
import jin.mes.form.ship.shipMgt.ShipMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class AsHisMgtService {

	@Resource
	AsHisMgtMapper asHisMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	ShipMgtMapper shipMgtMapper;
	
	//바코드 정보 조회
	public PageInfo<AsHisMgtDto> getSerialList(AsHisMgtDto asHisMgtDto, PageRequestVo pageRequestVo){
		List<AsHisMgtDto> asHisMgtList = null;
		int rowCount = 0;

		// Page Setting
		asHisMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		asHisMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = asHisMgtMapper.selectSerialCount(asHisMgtDto);
			if (rowCount > 0) {
				//List
				asHisMgtList = asHisMgtMapper.selectSerialList(asHisMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("바코드 조회 에러입니다. : " + e.getMessage());
		}
		if (asHisMgtList == null) {
			asHisMgtList = new ArrayList<AsHisMgtDto>();
		}
		return new PageInfo<AsHisMgtDto>(asHisMgtList, pageRequestVo, rowCount);
	}
	
	//as 정보 조회
	public PageInfo<AsHisMgtDto> getAsHisMgtList(AsHisMgtDto asHisMgtDto, PageRequestVo pageRequestVo){
		List<AsHisMgtDto> asHisMgtList = null;
		int rowCount = 0;

		// Page Setting
		asHisMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		asHisMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = asHisMgtMapper.selectAsHisMgtCount(asHisMgtDto);
			if (rowCount > 0) {
				//List
				asHisMgtList = asHisMgtMapper.selectAsHisMgtList(asHisMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("as정보 조회 에러입니다. : " + e.getMessage());
		}
		if (asHisMgtList == null) {
			asHisMgtList = new ArrayList<AsHisMgtDto>();
		}
		return new PageInfo<AsHisMgtDto>(asHisMgtList, pageRequestVo, rowCount);
	}
	
	//as정보 입력/수정
	@Transactional
	public String setAsHisMgtSave(AsHisMgtDto asHisMgtDto){
		String returnKey = "";
		try {
			asHisMgtDto.setCreatorId(JteUtils.getUserId());
			asHisMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(asHisMgtDto.getAction().equals("C")) {//
				//as정보 입력
				asHisMgtMapper.insertAsHisMgt(asHisMgtDto);
				
//				asHisMgtMapper.insertAsHisSerialMgt(asHisMgtDto);
				returnKey = asHisMgtDto.getAshisId();
				
				//as 수량을 등록하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(asHisMgtDto.getMtrlId(), "mtrl_tagt07", returnKey,
						asHisMgtDto.getAshisCnt()*-1, asHisMgtDto.getAshisAt(), asHisMgtDto.getAshisUser() ,asHisMgtDto.getMtrlMgtId(), asHisMgtDto.getLotId());
				
				//as를 등록하고 자재수량을 갱신
				mtrlCntDto.setAction("SUBTRACT");					
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
			}else if(asHisMgtDto.getAction().equals("U")){//자재 변경
				//as정보 수정
				asHisMgtMapper.updateAsHisMgt(asHisMgtDto);
				returnKey =asHisMgtDto.getAshisId();
				
				//as 수량을 수정하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(asHisMgtDto.getMtrlId(), "mtrl_tagt07", returnKey,
						asHisMgtDto.getAshisCnt()*-1, asHisMgtDto.getAshisAt(), asHisMgtDto.getAshisUser() ,asHisMgtDto.getMtrlMgtId(), asHisMgtDto.getLotId());
				
				//as를 수정하고 자재수량을 갱신
				mtrlCntDto.setAction("U");
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//as정보 삭제
	@Transactional
	public int setAsHisMgtDelete(List<AsHisMgtDto> asHisMgtList){
		int resultInt = -1;
		try {
			//as삭제
			for(AsHisMgtDto asHisMgtDto : asHisMgtList){
				asHisMgtMapper.deleteAsHisMgt(asHisMgtDto);
				
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto();
				mtrlCntDto.setMtrlMgtId(asHisMgtDto.getMtrlMgtId());
				mtrlCntDto.setMtrlQtyTarget("mtrl_tagt07");
				mtrlCntDto.setMtrlQtyTargetCode(asHisMgtDto.getAshisId());
				
				//불량품 수량을 삭제하고 자재수량 갱신
				mtrlCntDto.setAction("D");
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("as 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
		
}
