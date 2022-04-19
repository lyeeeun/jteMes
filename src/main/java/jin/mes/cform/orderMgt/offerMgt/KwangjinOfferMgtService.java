package jin.mes.cform.orderMgt.offerMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.cform.orderMgt.offerMgt.KwangjinOfferMgtDto;
import jin.mes.cform.orderMgt.offerMgt.KwangjinOfferMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinOfferMgtService {
	
	@Resource
	KwangjinOfferMgtMapper kwangjinOfferMgtMapper;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//클레임정보 조회
	public PageInfo<KwangjinOfferMgtDto> getOfferList(KwangjinOfferMgtDto kwangjinOfferMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinOfferMgtDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinOfferMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinOfferMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinOfferMgtMapper.selectOfferInfoCount(kwangjinOfferMgtDto);
			if (rowCount > 0) {
				//List
				lotList = kwangjinOfferMgtMapper.selectOfferInfoList(kwangjinOfferMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Claim조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<KwangjinOfferMgtDto>();
		}
		return new PageInfo<KwangjinOfferMgtDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Claim정보 입력/수정
	@Transactional
	public String setOfferSave(KwangjinOfferMgtDto kwangjinOfferMgtDto){
		String returnKey = "";
		try {
			kwangjinOfferMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinOfferMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinOfferMgtDto.getAction().equals("C")) {

				kwangjinOfferMgtMapper.insertOfferInfo(kwangjinOfferMgtDto);
				
				returnKey = kwangjinOfferMgtDto.getOfferId();
				
				//첨부파일 저장
				if(kwangjinOfferMgtDto.getInsertAttach() != null && kwangjinOfferMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinOfferMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinOfferMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinOfferMgtDto.getDeleteAttach() != null && kwangjinOfferMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinOfferMgtDto.getDeleteAttach());
				}
			}else if(kwangjinOfferMgtDto.getAction().equals("U")){
				//Claim정보 수정
				kwangjinOfferMgtMapper.updateOfferInfo(kwangjinOfferMgtDto);
				
				returnKey = kwangjinOfferMgtDto.getOfferId();
				
				//첨부파일 저장
				if(kwangjinOfferMgtDto.getInsertAttach() != null && kwangjinOfferMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinOfferMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinOfferMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinOfferMgtDto.getDeleteAttach() != null && kwangjinOfferMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinOfferMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("Claim정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Claim정보 삭제
	@Transactional
	public int setOfferDelete(List<KwangjinOfferMgtDto> offerList){
		int resultInt = -1;
		try {
			//자재삭제
			for(KwangjinOfferMgtDto kwangjinOfferMgtDto : offerList){
				kwangjinOfferMgtMapper.deleteOfferInfo(kwangjinOfferMgtDto);
				
				//첨부파일 삭제
				if(kwangjinOfferMgtDto.getDeleteAttach() != null && kwangjinOfferMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinOfferMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
