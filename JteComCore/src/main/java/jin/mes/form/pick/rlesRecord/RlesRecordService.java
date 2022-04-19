package jin.mes.form.pick.rlesRecord;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.pick.rlesPlanMgt.RlesPlanMgtDto;
import jin.mes.form.pick.rlesPlanMgt.RlesPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
@Transactional(transactionManager="transactionManager")
public class RlesRecordService {
	
	@Resource
    protected RlesRecordMapper rlesRecordMapper;
	
	@Resource
    protected RlesPlanMgtMapper rlesPlanMgtMapper;
	
	public PageInfo<RlesRecordDto> getRlesRecordList(RlesRecordDto rlesRecordDto, PageRequestVo pageRequestVo){
    	List<RlesRecordDto> rlesRecordList = null;
		int rowCount = 0;

		rlesRecordDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		rlesRecordDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = rlesRecordMapper.selectRlesRecordCount(rlesRecordDto);
			if (rowCount > 0) {
				rlesRecordList = rlesRecordMapper.selectRlesRecordList(rlesRecordDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getRlesRecordList 조회 에러입니다. : " + e.getMessage());
		}

		if (rlesRecordList == null) {
			rlesRecordList = new ArrayList<RlesRecordDto>();
		}
		return new PageInfo<RlesRecordDto>(rlesRecordList, pageRequestVo, rowCount);
	}
	
	//lot별 생산재고량 조회
		public PageInfo<RlesPlanMgtDto> getLotStockList(RlesPlanMgtDto rlesPlanMgtDto, PageRequestVo pageRequestVo){
	    	List<RlesPlanMgtDto> lotStockList = null;
			int rowCount = 0;

			rlesPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			rlesPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = rlesPlanMgtMapper.selectLotStockCount(rlesPlanMgtDto);
				if (rowCount > 0) {
					lotStockList = rlesPlanMgtMapper.selectLotStockList(rlesPlanMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getLotStockList 조회 에러입니다. : " + e.getMessage());
			}

			if (lotStockList == null) {
				lotStockList = new ArrayList<RlesPlanMgtDto>();
			}
			return new PageInfo<RlesPlanMgtDto>(lotStockList, pageRequestVo, rowCount);
		}

}
