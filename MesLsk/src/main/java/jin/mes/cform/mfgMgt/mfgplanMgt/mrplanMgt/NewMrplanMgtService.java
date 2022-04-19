package jin.mes.cform.mfgMgt.mfgplanMgt.mrplanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewMrplanMgtService {
	
	@Resource
	NewMrplanMgtMapper newMrplanMgtMapper;
	
	@Resource
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewMrplanMgtDto> getLotList (NewMrplanMgtDto newMrplanMgtDto, PageRequestVo pageRequestVo){
		List<NewMrplanMgtDto> lotList = null;
		int rowCount = 0;
		
		//page Setting
		newMrplanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMrplanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = newMrplanMgtMapper.selectLotCount(newMrplanMgtDto);
			if(rowCount > 0) {
				
				//List
				lotList = newMrplanMgtMapper.selectLotList(newMrplanMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (lotList ==null ) {
			lotList = new ArrayList<NewMrplanMgtDto> ();
		}
		return new PageInfo<NewMrplanMgtDto>(lotList, pageRequestVo, rowCount);
	}

	public PageInfo<NewMrplanMgtDto> getMrpMtlList (NewMrplanMgtDto newMrplanMgtDto, PageRequestVo pageRequestVo){
		List<NewMrplanMgtDto> mrpMtlList = null;
		int rowCount = 0;
		
		//page Setting
		newMrplanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMrplanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = newMrplanMgtMapper.selectMrpMtlCount(newMrplanMgtDto);
			if(rowCount > 0) {
				
				//List
				mrpMtlList = newMrplanMgtMapper.selectMrpMtlList(newMrplanMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 자재 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (mrpMtlList ==null ) {
			mrpMtlList = new ArrayList<NewMrplanMgtDto> ();
		}
		return new PageInfo<NewMrplanMgtDto>(mrpMtlList, pageRequestVo, rowCount);
	}
	
	
	public List<NewMrplanMgtDto> getAllLotList(NewMrplanMgtDto newMrplanMgtDto) {
		List<NewMrplanMgtDto> lotList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = newMrplanMgtMapper.selectLotCount(newMrplanMgtDto);
			if (rowCount > 0) {
				//List
				lotList = newMrplanMgtMapper.selectAllLotList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service : getAllLotList Error  : " +e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<NewMrplanMgtDto>();
		}
		
		return lotList;
	}
	
	
}
