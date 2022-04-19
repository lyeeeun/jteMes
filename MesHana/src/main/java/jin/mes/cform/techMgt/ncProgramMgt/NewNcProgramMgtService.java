package jin.mes.cform.techMgt.ncProgramMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewNcProgramMgtService {
	
	@Resource
    protected NewNcProgramMgtMapper newNcProgramMgtMapper;
	
	@Autowired
	AttachMgtService attachMgtService;

	public PageInfo<NewNcProgramMgtDto> selectRoutingInfo(NewNcProgramMgtDto ncProgramMgtDto, PageRequestVo pageRequestVo){
		List<NewNcProgramMgtDto> routingInfoList = null;
		int rowCount = 0;

		ncProgramMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		ncProgramMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newNcProgramMgtMapper.selectRoutingInfoCount(ncProgramMgtDto);
			if (rowCount > 0) {
				routingInfoList = newNcProgramMgtMapper.selectRoutingInfo(ncProgramMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (routingInfoList == null) {
			routingInfoList = new ArrayList<NewNcProgramMgtDto>();
		}
 		return new PageInfo<NewNcProgramMgtDto>(routingInfoList, pageRequestVo, rowCount);
	}
	
	public PageInfo<NewNcProgramMgtDto> selectNcPgmInfo(NewNcProgramMgtDto ncProgramMgtDto, PageRequestVo pageRequestVo){
		List<NewNcProgramMgtDto> ncPgmInfoList = null;
		int rowCount = 0;

		ncProgramMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		ncProgramMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newNcProgramMgtMapper.selectNcPgmInfoCount(ncProgramMgtDto);
			if (rowCount > 0) {
				ncPgmInfoList = newNcProgramMgtMapper.selectNcPgmInfo(ncProgramMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (ncPgmInfoList == null) {
			ncPgmInfoList = new ArrayList<NewNcProgramMgtDto>();
		}
 		return new PageInfo<NewNcProgramMgtDto>(ncPgmInfoList, pageRequestVo, rowCount);
	}
	
	@Transactional
	public void saveNcPgmInfo(NewNcProgramMgtDto ncProgramMgtDto){
		try {
			ncProgramMgtDto.setCreatorId(JteUtils.getUserId());
			ncProgramMgtDto.setUpdatorId(JteUtils.getUserId());
			ncProgramMgtDto.setReqUser(JteUtils.getUserId());
			
			if(ncProgramMgtDto.getAction().equals("C")) {//사용자 등록
				//기술문서 그룹 관련 ITEM 등록
				newNcProgramMgtMapper.insertNcPgmInfo(ncProgramMgtDto);
			}else if(ncProgramMgtDto.getAction().equals("U")){//사용자 변경
				//메뉴수정
				newNcProgramMgtMapper.updateNcPgmInfo(ncProgramMgtDto);
			}
			
			//첨부파일 저장
			if(ncProgramMgtDto.getInsertAttach() != null && ncProgramMgtDto.getInsertAttach().size() > 0) {
				String target = ncProgramMgtDto.getCurrentMenuId();
				String targetCode = ncProgramMgtDto.getNcpgmId();
				attachMgtService.attachFilesSave(ncProgramMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(ncProgramMgtDto.getDeleteAttach() != null && ncProgramMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(ncProgramMgtDto.getDeleteAttach());
			}
			
		} catch (Exception e) {
			throw new BusinessException("saveNcPgmInfo : " + e.getMessage());
		}
	}
	
	public void updateIsUse(NewNcProgramMgtDto ncProgramMgtDto) {
		try {
			newNcProgramMgtMapper.updateIsUse(ncProgramMgtDto);
		} catch (Exception e) {
			throw new BusinessException("updateIsUse : " + e.getMessage());
		}
	}
	
	@Transactional
	public int selectDupleKeyCheck(NewNcProgramMgtDto ncProgramMgtDto){
		try {
			return newNcProgramMgtMapper.selectDupleKeyCheck(ncProgramMgtDto);
		} catch (Exception e) {
			throw new BusinessException("saveTechDocInfo : " + e.getMessage());
		}
	}
	
	
}
