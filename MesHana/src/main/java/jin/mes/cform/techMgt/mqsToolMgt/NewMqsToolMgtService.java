package jin.mes.cform.techMgt.mqsToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewMqsToolMgtService {

	@Resource
    protected NewMqsToolMgtMapper newMqsToolMgtMapper;
	
	public PageInfo<NewMqsToolMgtDto> selectMqsRoutingInfo(NewMqsToolMgtDto mqsToolMgtDto, PageRequestVo pageRequestVo){
		List<NewMqsToolMgtDto> mqsToolInfoList = null;
		int rowCount = 0;

		mqsToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mqsToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newMqsToolMgtMapper.selectMqsRoutingInfoCount(mqsToolMgtDto);
			if (rowCount > 0) {
				mqsToolInfoList = newMqsToolMgtMapper.selectMqsRoutingInfo(mqsToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (mqsToolInfoList == null) {
			mqsToolInfoList = new ArrayList<NewMqsToolMgtDto>();
		}
		return new PageInfo<NewMqsToolMgtDto>(mqsToolInfoList, pageRequestVo, rowCount);
	}
	
	public PageInfo<NewMqsToolMgtDto> selectMqsToolInfo(NewMqsToolMgtDto mqsToolMgtDto, PageRequestVo pageRequestVo){
		List<NewMqsToolMgtDto> mqsToolInfoList = null;
		int rowCount = 0;

		mqsToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mqsToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newMqsToolMgtMapper.selectMqsToolInfoCount(mqsToolMgtDto);
			if (rowCount > 0) {
				mqsToolInfoList = newMqsToolMgtMapper.selectMqsToolInfo(mqsToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (mqsToolInfoList == null) {
			mqsToolInfoList = new ArrayList<NewMqsToolMgtDto>();
		}
		return new PageInfo<NewMqsToolMgtDto>(mqsToolInfoList, pageRequestVo, rowCount);
	}
	

	@Transactional
	public void saveMqsToolInfo(NewMqsToolMgtDto mqsToolMgtDto){
		try {
			if(mqsToolMgtDto.getAction().equals("C")) {//사용자 등록
				//기술문서 그룹 관련 ITEM 등록
				newMqsToolMgtMapper.insertMqsToolInfo(mqsToolMgtDto);
			}else if(mqsToolMgtDto.getAction().equals("U")){//사용자 변경
				//메뉴수정
				newMqsToolMgtMapper.updateMqsToolInfo(mqsToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("saveTechDocInfo : " + e.getMessage());
		}
	}
	
	/*
	 * @Transactional public int selectDupleKeyCheck(MqsToolMgtDto mqsToolMgtDto){ try { return newMqsToolMgtMapper.selectDupleKeyCheck(mqsToolMgtDto); } catch (Exception e) { throw new BusinessException("saveTechDocInfo : " + e.getMessage()); } }
	 */
	
	
	
}