package jin.mes.cform.techMgt.techDocMgt;

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
public class KwangjinTechDocMgtService {

	@Resource
    protected KwangjinTechDocMgtMapper kwangjinTechDocMgtMapper;
	
	@Autowired
	AttachMgtService attachMgtService;

	public PageInfo<KwangjinTechDocMgtDto> selectTechDocInfo(KwangjinTechDocMgtDto techDocMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinTechDocMgtDto> techDocInfoList = null;
		int rowCount = 0;

		techDocMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		techDocMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = kwangjinTechDocMgtMapper.selectTechDocInfoCount(techDocMgtDto);
			if (rowCount > 0) {
				techDocInfoList = kwangjinTechDocMgtMapper.selectTechDocInfo(techDocMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (techDocInfoList == null) {
			techDocInfoList = new ArrayList<KwangjinTechDocMgtDto>();
		}
 		return new PageInfo<KwangjinTechDocMgtDto>(techDocInfoList, pageRequestVo, rowCount);
	}
	
	public List<KwangjinTechDocMgtDto> selectTechDocGroup(KwangjinTechDocMgtDto techDocMgtDto) {
		try {
			return kwangjinTechDocMgtMapper.selectTechDocGroup(techDocMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectTechDocGroup " + e.getMessage());
		}
	}
	
	public PageInfo<KwangjinTechDocMgtDto> selectTechDocRtlItem(KwangjinTechDocMgtDto techDocMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinTechDocMgtDto> techDocInfoList = null;
		int rowCount = 0;

		techDocMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		techDocMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = kwangjinTechDocMgtMapper.selectTechDocRtlItemCount(techDocMgtDto);
			if (rowCount > 0) {
				techDocInfoList = kwangjinTechDocMgtMapper.selectTechDocRtlItem(techDocMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (techDocInfoList == null) {
			techDocInfoList = new ArrayList<KwangjinTechDocMgtDto>();
		}
 		return new PageInfo<KwangjinTechDocMgtDto>(techDocInfoList, pageRequestVo, rowCount);
	}
	
	
	@Transactional
	public void saveTechDocRtlItem(KwangjinTechDocMgtDto techDocMgtDto){
		try {
			techDocMgtDto.setCreatorId(JteUtils.getUserId());
			techDocMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(techDocMgtDto.getAction().equals("C")) {//????????? ??????
				//???????????? ?????? ?????? ITEM ??????
				kwangjinTechDocMgtMapper.insertTechDocRtlItem(techDocMgtDto);
			}else if(techDocMgtDto.getAction().equals("U")){//????????? ??????
				//????????????
				kwangjinTechDocMgtMapper.updateTechDocRtlItem(techDocMgtDto);
			}
//			else if(menuInfoDto.getAction().equals("D")){//????????? ??????/??????
//				if(menuInfoDto.isDel()) {
//					menuInfoDto.setDel(false);
//				}else {
//					menuInfoDto.setDel(true);
//				}
//				//?????? ??????(isDel)	
//				resultInt = menuInfoMapper.updateMenuInfo(menuInfoDto);
//			}
		} catch (Exception e) {
			throw new BusinessException("saveTechDocRtlItem : " + e.getMessage());
		}
	}
	
	@Transactional
	public void saveTechDocInfo(KwangjinTechDocMgtDto techDocMgtDto){
		try {
			techDocMgtDto.setCreatorId(JteUtils.getUserId());
			techDocMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(techDocMgtDto.getAction().equals("C")) {//????????? ??????
				//???????????? ?????? ?????? ITEM ??????
				kwangjinTechDocMgtMapper.insertTechDocInfo(techDocMgtDto);
			}else if(techDocMgtDto.getAction().equals("U")){//????????? ??????
				//????????????
				kwangjinTechDocMgtMapper.updateTechDocInfo(techDocMgtDto);
			}
			
			//???????????? ??????
			if(techDocMgtDto.getInsertAttach() != null && techDocMgtDto.getInsertAttach().size() > 0) {
				String target = techDocMgtDto.getCurrentMenuId();
				String targetCode = techDocMgtDto.getDocId();
				attachMgtService.attachFilesSave(techDocMgtDto.getInsertAttach(), target, targetCode);
			}
			//???????????? ??????
			if(techDocMgtDto.getDeleteAttach() != null && techDocMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(techDocMgtDto.getDeleteAttach());
			}
			
		} catch (Exception e) {
			throw new BusinessException("saveTechDocInfo : " + e.getMessage());
		}
	}
	
	
}