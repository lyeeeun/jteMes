package jin.mes.cform.mtrl.invenMgt;


import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.cform.mtrl.invenMgt.KwangjinInvenHisDto;
import jin.mes.cform.mtrl.invenMgt.KwangjinInvenMgtDto;
import jin.mes.cform.mtrl.invenMgt.KwangjinInvenMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinInvenMgtService {
	
	@Resource
	KwangjinInvenMgtMapper kwangjinInvenMgtMapper;
	
	//제품 관리 조회
	public PageInfo<KwangjinInvenMgtDto> getInvenMgtList(KwangjinInvenMgtDto invenMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinInvenMgtDto> itemMgtList = null;
		int rowCount = 0;

		// Page Setting
		invenMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		invenMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinInvenMgtMapper.selectInvenMgtCount(invenMgtDto);
			if (rowCount > 0) {
				//List
				itemMgtList = kwangjinInvenMgtMapper.selectInvenMgt(invenMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("제품정보 조회 에러입니다. : " + e.getMessage());
		}
		if (itemMgtList == null) {
			itemMgtList = new ArrayList<KwangjinInvenMgtDto>();
		}
		return new PageInfo<KwangjinInvenMgtDto>(itemMgtList, pageRequestVo, rowCount);
	}

	//제품 수량 히스토리(내역) 조회
	public PageInfo<KwangjinInvenHisDto> getItemHisList(KwangjinInvenHisDto invenHisDto, PageRequestVo pageRequestVo){
		List<KwangjinInvenHisDto> itemHisList = null;
		int rowCount = 0;

		// Page Setting
		invenHisDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		invenHisDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinInvenMgtMapper.selectItemHisCount(invenHisDto);
			if (rowCount > 0) {
				//List
				itemHisList = kwangjinInvenMgtMapper.selectItemHisList(invenHisDto);
			}
		} catch (Exception e) {
			throw new BusinessException("제품 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (itemHisList == null) {
			itemHisList = new ArrayList<KwangjinInvenHisDto>();
		}
		return new PageInfo<KwangjinInvenHisDto>(itemHisList, pageRequestVo, rowCount);
	}
	
	//제품 수량 히스토리(내역) 조회
	public PageInfo<KwangjinInvenHisDto> getMtrlHisList(KwangjinInvenHisDto invenHisDto, PageRequestVo pageRequestVo){
		List<KwangjinInvenHisDto> itemHisList = null;
		int rowCount = 0;

		// Page Setting
		invenHisDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		invenHisDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinInvenMgtMapper.selectMtrlHisCount(invenHisDto);
			if (rowCount > 0) {
				//List
				itemHisList = kwangjinInvenMgtMapper.selectMtrlHisList(invenHisDto);
			}
		} catch (Exception e) {
			throw new BusinessException("제품 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (itemHisList == null) {
			itemHisList = new ArrayList<KwangjinInvenHisDto>();
		}
		return new PageInfo<KwangjinInvenHisDto>(itemHisList, pageRequestVo, rowCount);
	}
}
