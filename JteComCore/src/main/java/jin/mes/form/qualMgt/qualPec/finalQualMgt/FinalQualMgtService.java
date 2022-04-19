package jin.mes.form.qualMgt.qualPec.finalQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.barcode.barcodeBase.BarcodeBaseDto;
import jin.mes.form.barcode.barcodeBase.BarcodeBaseMapper;
//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class FinalQualMgtService {

	@Resource
	FinalQualMgtMapper finalQualMgtMapper;

	@Resource
	BarcodeBaseMapper barcodeBaseMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;

	// 입고검사 조회
	public PageInfo<FinalQualMgtDto> getPlcEqmtLogList(FinalQualMgtDto finalQualMgtDto, PageRequestVo pageRequestVo) {

		List<FinalQualMgtDto> finalQualMgtList = null;
		int rowCount = 0;

		// Page Setting
		if(!finalQualMgtDto.getPagingYN().equals("N")) {
			finalQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			finalQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		try {
			// Count
			rowCount = finalQualMgtMapper.selectPlcEqmtLogCount(finalQualMgtDto);
			if (rowCount > 0) {
				// List
				finalQualMgtList = finalQualMgtMapper.selectPlcEqmtLogList(finalQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("최종검사 조회 에러입니다. : " + e.getMessage());
		}
		
		if (finalQualMgtList == null) {
			finalQualMgtList = new ArrayList<FinalQualMgtDto>();
			if(!finalQualMgtDto.getCurrentMenuId().equals(null) && finalQualMgtDto.getCurrentMenuId().equals("asHisMgt")) {
				finalQualMgtList.add(new FinalQualMgtDto());
			} else if(!finalQualMgtDto.getCurrentMenuId().equals(null) && finalQualMgtDto.getCurrentMenuId().equals("barcodeHistory")) {
				finalQualMgtList.add(new FinalQualMgtDto());
			}
		}
		
		return new PageInfo<FinalQualMgtDto>(finalQualMgtList, pageRequestVo, rowCount);
	}
	
	//plc 데이터 - 대기 > 완료 저장
	@Transactional(rollbackFor = {Exception.class})
	public String setEqmtLogUpdate(FinalQualMgtDto finalQualMgtDto){
		String returnKey = "";
		try {
			
			//검사이력 저장
			finalQualMgtDto.setCreatorId(JteUtils.getUserId());
			finalQualMgtDto.setUpdatorId(JteUtils.getUserId());
			
			finalQualMgtMapper.updateEqmtLog(finalQualMgtDto);
			
			returnKey =finalQualMgtDto.getPlcEqmtId();
			
			//바코드 등록
			BarcodeBaseDto barcodeBaseDto = new BarcodeBaseDto();
			
			barcodeBaseDto.setBarcodeId(finalQualMgtDto.getBarcodeId());
			barcodeBaseDto.setLotId(finalQualMgtDto.getLotId());
			barcodeBaseDto.setItemId(finalQualMgtDto.getItemId());
			barcodeBaseDto.setProdAsmId(finalQualMgtDto.getProdAsmId());
			barcodeBaseDto.setPlcEqmtId(returnKey);
			barcodeBaseDto.setCreatorId(JteUtils.getUserId());
			barcodeBaseDto.setUpdatorId(JteUtils.getUserId());
			
			barcodeBaseMapper.insertBarcodeBase(barcodeBaseDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//조치내역
	@Transactional(rollbackFor = {Exception.class})
	public FinalQualMgtDto setMeasureChange(List<FinalQualMgtDto> finalQualMgtList){
		FinalQualMgtDto returnKey = new FinalQualMgtDto();
		try {
			//객체 생성
			FinalQualMgtDto finalQualMgtDto = new FinalQualMgtDto();
			
			// 1.검사 불량 조치 데이터 등록(new)
			finalQualMgtDto = finalQualMgtList.get(0);
			finalQualMgtDto.setCreatorId(JteUtils.getUserId());
			finalQualMgtDto.setUpdatorId(JteUtils.getUserId());
			finalQualMgtDto.setPlcEqmtState("plcState02");
			
			finalQualMgtMapper.updateEqmtLog(finalQualMgtDto);
			
			returnKey = finalQualMgtDto;
			
			
			//2.바코드 매칭 키 변경
			BarcodeBaseDto barcodeBaseDto = new BarcodeBaseDto();
			barcodeBaseDto.setCreatorId(JteUtils.getUserId());
			barcodeBaseDto.setUpdatorId(JteUtils.getUserId());
			
			barcodeBaseDto.setBarcodeId(returnKey.getBarcodeId());
			barcodeBaseDto.setPlcEqmtId(returnKey.getPlcEqmtId());
			barcodeBaseMapper.updateBarcodeBase(barcodeBaseDto);
			
			//기존 검사데이터 
			finalQualMgtDto = finalQualMgtList.get(1);
			finalQualMgtDto.setCreatorId(JteUtils.getUserId());
			finalQualMgtDto.setUpdatorId(JteUtils.getUserId());
			finalQualMgtDto.setPlcEqmtState("plcState03");
			
			//바코드 매핑정보 초기화
			finalQualMgtDto.setBarcodeId("");
			
			//상위키 맵핑
			finalQualMgtDto.setUpPlcEqmtId(returnKey.getPlcEqmtId());
			
			//3.기존 조치내역  조회 하여 상위 검사내역 변경
			finalQualMgtMapper.updateEqmtLogChange(finalQualMgtDto);
			
			//4.불량 데이터 조치내역 이력으로 변경
			finalQualMgtMapper.updateEqmtLog(finalQualMgtDto);
			
			
		} catch (Exception e) {
			returnKey = null;
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
}

