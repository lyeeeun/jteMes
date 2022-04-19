package jin.mes.cform.qualMgt.qualPec.finalQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.barcode.barcodeBase.ZinixBarcodeBaseDto;
import jin.mes.cform.barcode.barcodeBase.ZinixBarcodeBaseMapper;
//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class ZinixFinalQualMgtService {

	@Resource
	ZinixFinalQualMgtMapper zinixFinalQualMgtMapper;

	@Resource
	ZinixBarcodeBaseMapper zinixBarcodeBaseMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;

	// 입고검사 조회
	public PageInfo<ZinixFinalQualMgtDto> getPlcEqmtLogList(ZinixFinalQualMgtDto zinixFinalQualMgtDto, PageRequestVo pageRequestVo) {

		List<ZinixFinalQualMgtDto> zinixFinalQualMgtList = null;
		int rowCount = 0;

		// Page Setting
		if(!zinixFinalQualMgtDto.getPagingYN().equals("N")) {
			zinixFinalQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			zinixFinalQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		try {
			// Count
			rowCount = zinixFinalQualMgtMapper.selectPlcEqmtLogCount(zinixFinalQualMgtDto);
			if (rowCount > 0) {
				// List
				zinixFinalQualMgtList = zinixFinalQualMgtMapper.selectPlcEqmtLogList(zinixFinalQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("최종검사 조회 에러입니다. : " + e.getMessage());
		}
		
		if (zinixFinalQualMgtList == null) {
			zinixFinalQualMgtList = new ArrayList<ZinixFinalQualMgtDto>();
			if(!zinixFinalQualMgtDto.getCurrentMenuId().equals(null) && zinixFinalQualMgtDto.getCurrentMenuId().equals("asHisMgt")) {
				zinixFinalQualMgtList.add(new ZinixFinalQualMgtDto());
			} else if(!zinixFinalQualMgtDto.getCurrentMenuId().equals(null) && zinixFinalQualMgtDto.getCurrentMenuId().equals("barcodeHistory")) {
				zinixFinalQualMgtList.add(new ZinixFinalQualMgtDto());
			}
		}
		
		return new PageInfo<ZinixFinalQualMgtDto>(zinixFinalQualMgtList, pageRequestVo, rowCount);
	}
	
	//plc 데이터 - 대기 > 완료 저장
	@Transactional(rollbackFor = {Exception.class})
	public String setEqmtLogUpdate(ZinixFinalQualMgtDto zinixFinalQualMgtDto){
		String returnKey = "";
		try {
			
			//검사이력 저장
			zinixFinalQualMgtDto.setCreatorId(JteUtils.getUserId());
			zinixFinalQualMgtDto.setUpdatorId(JteUtils.getUserId());
			
			zinixFinalQualMgtMapper.updateEqmtLog(zinixFinalQualMgtDto);
			
			returnKey =zinixFinalQualMgtDto.getPlcEqmtId();
			
			//바코드 등록
			ZinixBarcodeBaseDto zinixBarcodeBaseDto = new ZinixBarcodeBaseDto();
			
			zinixBarcodeBaseDto.setBarcodeId(zinixFinalQualMgtDto.getBarcodeId());
			zinixBarcodeBaseDto.setLotId(zinixFinalQualMgtDto.getLotId());
			zinixBarcodeBaseDto.setItemId(zinixFinalQualMgtDto.getItemId());
			zinixBarcodeBaseDto.setProdAsmId(zinixFinalQualMgtDto.getProdAsmId());
			zinixBarcodeBaseDto.setPlcEqmtId(returnKey);
			zinixBarcodeBaseDto.setCreatorId(JteUtils.getUserId());
			zinixBarcodeBaseDto.setUpdatorId(JteUtils.getUserId());
			
			zinixBarcodeBaseMapper.insertBarcodeBase(zinixBarcodeBaseDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//조치내역
	@Transactional(rollbackFor = {Exception.class})
	public ZinixFinalQualMgtDto setMeasureChange(List<ZinixFinalQualMgtDto> zinixFinalQualMgtList){
		ZinixFinalQualMgtDto returnKey = new ZinixFinalQualMgtDto();
		try {
			//객체 생성
			ZinixFinalQualMgtDto zinixFinalQualMgtDto = new ZinixFinalQualMgtDto();
			
			// 1.검사 불량 조치 데이터 등록(new)
			zinixFinalQualMgtDto = zinixFinalQualMgtList.get(0);
			zinixFinalQualMgtDto.setCreatorId(JteUtils.getUserId());
			zinixFinalQualMgtDto.setUpdatorId(JteUtils.getUserId());
			zinixFinalQualMgtDto.setPlcEqmtState("plcState02");
			
			zinixFinalQualMgtMapper.updateEqmtLog(zinixFinalQualMgtDto);
			
			returnKey = zinixFinalQualMgtDto;
			
			
			//2.바코드 매칭 키 변경
			ZinixBarcodeBaseDto zinixBarcodeBaseDto = new ZinixBarcodeBaseDto();
			zinixBarcodeBaseDto.setCreatorId(JteUtils.getUserId());
			zinixBarcodeBaseDto.setUpdatorId(JteUtils.getUserId());
			
			zinixBarcodeBaseDto.setBarcodeId(returnKey.getBarcodeId());
			zinixBarcodeBaseDto.setPlcEqmtId(returnKey.getPlcEqmtId());
			zinixBarcodeBaseMapper.updateBarcodeBase(zinixBarcodeBaseDto);
			
			//기존 검사데이터 
			zinixFinalQualMgtDto = zinixFinalQualMgtList.get(1);
			zinixFinalQualMgtDto.setCreatorId(JteUtils.getUserId());
			zinixFinalQualMgtDto.setUpdatorId(JteUtils.getUserId());
			zinixFinalQualMgtDto.setPlcEqmtState("plcState03");
			
			//바코드 매핑정보 초기화
			zinixFinalQualMgtDto.setBarcodeId("");
			
			//상위키 맵핑
			zinixFinalQualMgtDto.setUpPlcEqmtId(returnKey.getPlcEqmtId());
			
			//3.기존 조치내역  조회 하여 상위 검사내역 변경
			zinixFinalQualMgtMapper.updateEqmtLogChange(zinixFinalQualMgtDto);
			
			//4.불량 데이터 조치내역 이력으로 변경
			zinixFinalQualMgtMapper.updateEqmtLog(zinixFinalQualMgtDto);
			
			
		} catch (Exception e) {
			returnKey = null;
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
}
