package jin.mes.form.mtrl.mtrlInputSta;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrlInputStaService {
	
	@Resource
	MtrlInputStaMapper mtrlInputStaMapper;
	
	@Resource
	MsgMgtServiceImpl msgService;
	
	public PageInfo<MtrlInputStaDto> getLotList (MtrlInputStaDto mtrlInputStaDto, PageRequestVo pageRequestVo){
		List<MtrlInputStaDto> lotList = null;
		int rowCount = 0;
		
		//page Setting
		mtrlInputStaDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlInputStaDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mtrlInputStaMapper.selectLotCount(mtrlInputStaDto);
			if(rowCount > 0) {
				
				//List
				lotList = mtrlInputStaMapper.selectLotList(mtrlInputStaDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("lot 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (lotList ==null ) {
			lotList = new ArrayList<MtrlInputStaDto> ();
		}
		return new PageInfo<MtrlInputStaDto>(lotList, pageRequestVo, rowCount);
	}
	
	public PageInfo<MtrlInputStaDto> getMrpMtlList (MtrlInputStaDto mtrlInputStaDto, PageRequestVo pageRequestVo){
		List<MtrlInputStaDto> mrcalList = null;
		int rowCount = 0;
		
		//page Setting
		mtrlInputStaDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlInputStaDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = mtrlInputStaMapper.selectMtrlInputCount(mtrlInputStaDto);
			if(rowCount > 0) {
				
				//List
				mrcalList = mtrlInputStaMapper.selectMtrlInputList(mtrlInputStaDto);
			}
		} catch (Exception e) {
			
			throw new BusinessException("자재 투입량 정보 조회 에러입니다!!! : "+ e.getMessage());
		}
		if (mrcalList ==null ) {
			mrcalList = new ArrayList<MtrlInputStaDto> ();
		}
		return new PageInfo<MtrlInputStaDto>(mrcalList, pageRequestVo, rowCount);
	}
}
