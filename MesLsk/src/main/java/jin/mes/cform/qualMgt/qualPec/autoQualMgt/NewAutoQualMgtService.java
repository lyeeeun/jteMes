package jin.mes.cform.qualMgt.qualPec.autoQualMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.item.itemToolMgt.NewItemToolMgtDto;
import jin.mes.cform.item.itemToolMgt.NewItemToolMgtMapper;
import jin.mes.cform.qualMgt.qualCheckList.NewQualCheckListDto;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class NewAutoQualMgtService {

	@Resource
	protected NewAutoQualMgtMapper newAutoQualMgtMapper;
	
	public PageInfo<NewAutoQualMgtDto> selectAutoInspInfo(NewAutoQualMgtDto autoQualMgtDto, PageRequestVo pageRequestVo){
		List<NewAutoQualMgtDto> autoInspInfo = null;
		int rowCount = 0;

		autoQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		autoQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newAutoQualMgtMapper.selectAutoInspInfoCount(autoQualMgtDto);
			if (rowCount > 0) {
				autoInspInfo = newAutoQualMgtMapper.selectAutoInspInfo(autoQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: selectAutoInspInfo Error " + e.getMessage());
		}

		if (autoInspInfo == null) {
			autoInspInfo = new ArrayList<NewAutoQualMgtDto>();
		}
		return new PageInfo<NewAutoQualMgtDto>(autoInspInfo, pageRequestVo, rowCount);
	}
	
	@Transactional
	public List<NewAutoQualMgtDto> selectInspItemList(NewAutoQualMgtDto autoQualMgtDto){
		List<NewAutoQualMgtDto> itemList = null;

		try {
			itemList = newAutoQualMgtMapper.selectInspItemList(autoQualMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectInspItemList : " + e.getMessage());
		}
		
		return itemList;
	}
	
}
