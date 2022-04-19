package jin.mes.form.techMgt.mqsToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.techMgt.techDocMgt.TechDocMgtDto;
import jin.mes.mapper.techMgt.mqsToolMgt.MqsToolMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class MqsToolMgtService {

	@Resource
    protected MqsToolMgtMapper mqsToolMgtMapper;
	
	public PageInfo<MqsToolMgtDto> selectMqsRoutingInfo(MqsToolMgtDto mqsToolMgtDto, PageRequestVo pageRequestVo){
		List<MqsToolMgtDto> mqsToolInfoList = null;
		int rowCount = 0;

		mqsToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mqsToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = mqsToolMgtMapper.selectMqsRoutingInfoCount(mqsToolMgtDto);
			if (rowCount > 0) {
				mqsToolInfoList = mqsToolMgtMapper.selectMqsRoutingInfo(mqsToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (mqsToolInfoList == null) {
			mqsToolInfoList = new ArrayList<MqsToolMgtDto>();
		}
		return new PageInfo<MqsToolMgtDto>(mqsToolInfoList, pageRequestVo, rowCount);
	}
	
	public PageInfo<MqsToolMgtDto> selectMqsToolInfo(MqsToolMgtDto mqsToolMgtDto, PageRequestVo pageRequestVo){
		List<MqsToolMgtDto> mqsToolInfoList = null;
		int rowCount = 0;

		mqsToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mqsToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = mqsToolMgtMapper.selectMqsToolInfoCount(mqsToolMgtDto);
			if (rowCount > 0) {
				mqsToolInfoList = mqsToolMgtMapper.selectMqsToolInfo(mqsToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (mqsToolInfoList == null) {
			mqsToolInfoList = new ArrayList<MqsToolMgtDto>();
		}
		return new PageInfo<MqsToolMgtDto>(mqsToolInfoList, pageRequestVo, rowCount);
	}
	

	@Transactional
	public void saveMqsToolInfo(MqsToolMgtDto mqsToolMgtDto){
		try {
			if(mqsToolMgtDto.getAction().equals("C")) {//사용자 등록
				//기술문서 그룹 관련 ITEM 등록
				mqsToolMgtMapper.insertMqsToolInfo(mqsToolMgtDto);
			}else if(mqsToolMgtDto.getAction().equals("U")){//사용자 변경
				//메뉴수정
				mqsToolMgtMapper.updateMqsToolInfo(mqsToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("saveTechDocInfo : " + e.getMessage());
		}
	}
	
	/*
	 * @Transactional public int selectDupleKeyCheck(MqsToolMgtDto mqsToolMgtDto){ try { return mqsToolMgtMapper.selectDupleKeyCheck(mqsToolMgtDto); } catch (Exception e) { throw new BusinessException("saveTechDocInfo : " + e.getMessage()); } }
	 */
	
	
	
}