package jin.mes.form.qualMgt.qualPec.prcesQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.qualPec.prcesQualMgt.PrcesQualMgtDto;
import jin.mes.mapper.qualMgt.qualPec.prcesQualMgt.PrcesQualMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class PrcesQualMgtService {

	@Resource
	PrcesQualMgtMapper prcesQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<LotInfoDto> getPrcesQualList(LotInfoDto lotInfoDto, PageRequestVo pageRequestVo) {
		List<LotInfoDto> lotList = null;
		int rowCount = 0;
		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = prcesQualMgtMapper.selectPrcesQualCount(lotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = prcesQualMgtMapper.selectPrcesQualList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 Lot조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (lotList == null) {
			lotList = new ArrayList<LotInfoDto>();
		}
		return new PageInfo<LotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	//라우팅시트 조회
	public List<WrkinTeamMgtDto> getPrcesQualListAdd(WrkinTeamMgtDto asgnDto) {
		List<WrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = prcesQualMgtMapper.selectPrcesQualInfo(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<WrkinTeamMgtDto>();
		}
		return asgnList;
	}
		
}