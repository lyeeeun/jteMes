package jin.mes.cform.qualMgt.qualPec.prcesQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class NewPrcesQualMgtService {

	@Resource
	NewPrcesQualMgtMapper newPrcesQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewLotInfoDto> getPrcesQualList(NewLotInfoDto lotInfoDto, PageRequestVo pageRequestVo) {
		List<NewLotInfoDto> lotList = null;
		int rowCount = 0;
		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newPrcesQualMgtMapper.selectPrcesQualCount(lotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = newPrcesQualMgtMapper.selectPrcesQualList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 Lot조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (lotList == null) {
			lotList = new ArrayList<NewLotInfoDto>();
		}
		return new PageInfo<NewLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	//라우팅시트 조회
	public List<NewWrkinTeamMgtDto> getPrcesQualListAdd(NewWrkinTeamMgtDto asgnDto) {
		List<NewWrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = newPrcesQualMgtMapper.selectPrcesQualInfo(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return asgnList;
	}
		
}
