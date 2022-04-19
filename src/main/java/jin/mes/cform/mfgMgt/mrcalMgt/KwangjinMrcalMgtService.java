package jin.mes.cform.mfgMgt.mrcalMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinMrcalMgtService {
	
	@Resource
	KwangjinMrcalMgtMapper kwangjinMrcalMgtMapper;
	
	@Resource
	MsgMgtServiceImpl msgService;
	
	public PageInfo<KwangjinMrcalMgtDto> getLotList (KwangjinMrcalMgtDto kwangjinMrcalMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMrcalMgtDto> lotList = null;
		int rowCount = 0;
		
		//page Setting
		kwangjinMrcalMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinMrcalMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinMrcalMgtMapper.selectLotCount(kwangjinMrcalMgtDto);
			if(rowCount > 0) {
				
				//List
				lotList = kwangjinMrcalMgtMapper.selectLotList(kwangjinMrcalMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (lotList ==null ) {
			lotList = new ArrayList<KwangjinMrcalMgtDto> ();
		}
		return new PageInfo<KwangjinMrcalMgtDto>(lotList, pageRequestVo, rowCount);
	}

	public PageInfo<KwangjinMrcalMgtDto> getMrpMtlList (KwangjinMrcalMgtDto kwangjinMrcalMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMrcalMgtDto> mrcalList = null;
		int rowCount = 0;
		
		//page Setting
		kwangjinMrcalMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinMrcalMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinMrcalMgtMapper.selectMrpMtlCount(kwangjinMrcalMgtDto);
			if(rowCount > 0) {
				
				//List
				mrcalList = kwangjinMrcalMgtMapper.selectMrpMtlList(kwangjinMrcalMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 자재 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (mrcalList ==null ) {
			mrcalList = new ArrayList<KwangjinMrcalMgtDto> ();
		}
		return new PageInfo<KwangjinMrcalMgtDto>(mrcalList, pageRequestVo, rowCount);
	}
	
	
	public List<KwangjinMrcalMgtDto> getAllLotList(KwangjinMrcalMgtDto kwangjinMrcalMgtDto) {
		List<KwangjinMrcalMgtDto> lotList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = kwangjinMrcalMgtMapper.selectLotCount(kwangjinMrcalMgtDto);
			if (rowCount > 0) {
				//List
				lotList = kwangjinMrcalMgtMapper.selectAllLotList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service : getAllLotList Error  : " +e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<KwangjinMrcalMgtDto>();
		}
		
		return lotList;
	}
	
}
