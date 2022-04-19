package jin.mes.form.perform.prodStaMgt.facilProdMgt;

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
public class FacilProdMgtService {
	
	@Resource
	FacilProdMgtMapper facilProdMgtMapper;

	public PageInfo<FacilProdMgtDto> getEqmtProd(FacilProdMgtDto facilProdMgtDto, PageRequestVo pageRequestVo){
		List<FacilProdMgtDto> facilProdList = null;
		int rowCount = 0;

		if(!facilProdMgtDto.getPagingYN().equals("N")) {
			facilProdMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			facilProdMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = facilProdMgtMapper.selectFacilProdCount(facilProdMgtDto);
			if (rowCount > 0) {
				facilProdList = facilProdMgtMapper.selectFacilProdList(facilProdMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (facilProdList == null) {
			facilProdList = new ArrayList<FacilProdMgtDto>();
		}
 		return new PageInfo<FacilProdMgtDto>(facilProdList, pageRequestVo, rowCount);
	}
}
