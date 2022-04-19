package jin.mes.cform.techMgt.offsetMgt;

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
public class NewOffsetMgtService {
	@Resource
	protected NewOffsetMgtMapper newOffsetMgtMapper;
	
	public PageInfo<NewOffsetMgtDto> selectOffsetData(NewOffsetMgtDto offsetMgtDto, PageRequestVo pageRequestVo){
		List<NewOffsetMgtDto> offsetDataList = null;
		int rowCount = 0;

		offsetMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		offsetMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newOffsetMgtMapper.selectOffsetDataCount(offsetMgtDto);
			if (rowCount > 0) {
				offsetDataList = newOffsetMgtMapper.selectOffsetData(offsetMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (offsetDataList == null) {
			offsetDataList = new ArrayList<NewOffsetMgtDto>();
		}
 		return new PageInfo<NewOffsetMgtDto>(offsetDataList, pageRequestVo, rowCount);
	}
}
