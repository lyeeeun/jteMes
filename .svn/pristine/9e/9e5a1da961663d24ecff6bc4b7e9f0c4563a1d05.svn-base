package jin.mes.form.techMgt.offsetMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class OffsetMgtService {
	@Resource
	protected OffsetMgtMapper offsetMgtMapper;
	
	public PageInfo<OffsetMgtDto> selectOffsetData(OffsetMgtDto offsetMgtDto, PageRequestVo pageRequestVo){
		List<OffsetMgtDto> offsetDataList = null;
		int rowCount = 0;

		offsetMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		offsetMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = offsetMgtMapper.selectOffsetDataCount(offsetMgtDto);
			if (rowCount > 0) {
				offsetDataList = offsetMgtMapper.selectOffsetData(offsetMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (offsetDataList == null) {
			offsetDataList = new ArrayList<OffsetMgtDto>();
		}
 		return new PageInfo<OffsetMgtDto>(offsetDataList, pageRequestVo, rowCount);
	}
}
