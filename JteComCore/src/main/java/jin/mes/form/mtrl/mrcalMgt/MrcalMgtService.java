package jin.mes.form.mtrl.mrcalMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MrcalMgtService {
	
	@Resource
	MrcalMgtMapper mrcalMgtMapper;
	
	@Resource
	MsgMgtServiceImpl msgService;
	
	public PageInfo<MrcalMgtDto> getLotList (MrcalMgtDto mrcalMgtDto, PageRequestVo pageRequestVo){
		List<MrcalMgtDto> lotList = null;
		int rowCount = 0;
		
		//page Setting
		mrcalMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mrcalMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mrcalMgtMapper.selectLotCount(mrcalMgtDto);
			if(rowCount > 0) {
				
				//List
				lotList = mrcalMgtMapper.selectLotList(mrcalMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (lotList ==null ) {
			lotList = new ArrayList<MrcalMgtDto> ();
		}
		return new PageInfo<MrcalMgtDto>(lotList, pageRequestVo, rowCount);
	}

	public PageInfo<MrcalMgtDto> getMrpMtlList (MrcalMgtDto mrcalMgtDto, PageRequestVo pageRequestVo){
		List<MrcalMgtDto> mrcalList = null;
		int rowCount = 0;
		
		//page Setting
		mrcalMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mrcalMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mrcalMgtMapper.selectMrpMtlCount(mrcalMgtDto);
			if(rowCount > 0) {
				
				//List
				mrcalList = mrcalMgtMapper.selectMrpMtlList(mrcalMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 자재 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (mrcalList ==null ) {
			mrcalList = new ArrayList<MrcalMgtDto> ();
		}
		return new PageInfo<MrcalMgtDto>(mrcalList, pageRequestVo, rowCount);
	}
	
	
	public List<MrcalMgtDto> getAllLotList(MrcalMgtDto mrcalMgtDto) {
		List<MrcalMgtDto> lotList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = mrcalMgtMapper.selectLotCount(mrcalMgtDto);
			if (rowCount > 0) {
				//List
				lotList = mrcalMgtMapper.selectAllLotList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service : getAllLotList Error  : " +e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<MrcalMgtDto>();
		}
		
		return lotList;
	}
	
}
