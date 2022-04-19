package jin.mes.form.perform.workStaMgt.lotProStatus;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class LotProStatusService {
	
	@Resource
	LotProStatusMapper lotProStatusMapper;

	public PageInfo<LotProStatusDto> getLotProgressList(LotProStatusDto lotProStatusDto, PageRequestVo pageRequestVo){
		List<LotProStatusDto> lotProgressList = null;
		int rowCount = 0;

		// Page Setting
		lotProStatusDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotProStatusDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = lotProStatusMapper.selectLotProgressCount(lotProStatusDto);
			if (rowCount > 0) {
				//List
				lotProgressList = lotProStatusMapper.selectLotProgressList(lotProStatusDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (lotProgressList == null) {
			lotProgressList = new ArrayList<LotProStatusDto>();
		}
		return new PageInfo<LotProStatusDto>(lotProgressList, pageRequestVo, rowCount);
	}
}
