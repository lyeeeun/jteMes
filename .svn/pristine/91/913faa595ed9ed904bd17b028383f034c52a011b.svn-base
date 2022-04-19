package jin.mes.form.mfgMgt.mfgplanMgt.mrplanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MrplanMgtService {
	
	@Resource
	MrplanMgtMapper mrplanMgtMapper;
	
	@Resource
	MsgMgtServiceImpl msgService;
	
	public PageInfo<MrplanMgtDto> getLotList (MrplanMgtDto mrplanMgtDto, PageRequestVo pageRequestVo){
		List<MrplanMgtDto> lotList = null;
		int rowCount = 0;
		
		//page Setting
		mrplanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mrplanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mrplanMgtMapper.selectLotCount(mrplanMgtDto);
			if(rowCount > 0) {
				
				//List
				lotList = mrplanMgtMapper.selectLotList(mrplanMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (lotList ==null ) {
			lotList = new ArrayList<MrplanMgtDto> ();
		}
		return new PageInfo<MrplanMgtDto>(lotList, pageRequestVo, rowCount);
	}

	public PageInfo<MrplanMgtDto> getMrpMtlList (MrplanMgtDto mrplanMgtDto, PageRequestVo pageRequestVo){
		List<MrplanMgtDto> mrpMtlList = null;
		int rowCount = 0;
		
		//page Setting
		mrplanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mrplanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mrplanMgtMapper.selectMrpMtlCount(mrplanMgtDto);
			if(rowCount > 0) {
				
				//List
				mrpMtlList = mrplanMgtMapper.selectMrpMtlList(mrplanMgtDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 자재 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (mrpMtlList ==null ) {
			mrpMtlList = new ArrayList<MrplanMgtDto> ();
		}
		return new PageInfo<MrplanMgtDto>(mrpMtlList, pageRequestVo, rowCount);
	}
	
	
	public List<MrplanMgtDto> getAllLotList(MrplanMgtDto mrplanMgtDto) {
		List<MrplanMgtDto> lotList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = mrplanMgtMapper.selectLotCount(mrplanMgtDto);
			if (rowCount > 0) {
				//List
				lotList = mrplanMgtMapper.selectAllLotList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service : getAllLotList Error  : " +e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<MrplanMgtDto>();
		}
		
		return lotList;
	}
	
	
}
