package jin.mes.cform.perform.prodBadSta;

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
public class KwangjinProdBadStaService {

	@Resource
    protected KwangjinProdBadStaMapper kwangjinProdBadStaMapper;

	public PageInfo<KwangjinProdBadStaDto> getProdBad(KwangjinProdBadStaDto kwangjinProdBadStaDto, PageRequestVo pageRequestVo){
		List<KwangjinProdBadStaDto> prodBadList = null;
		int rowCount = 0;

		if(!kwangjinProdBadStaDto.getPagingYN().equals("N")) {
			kwangjinProdBadStaDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			kwangjinProdBadStaDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		try {
			rowCount = kwangjinProdBadStaMapper.selectProdBadCount(kwangjinProdBadStaDto);
			if (rowCount > 0) {
				prodBadList = kwangjinProdBadStaMapper.selectProdBad(kwangjinProdBadStaDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (prodBadList == null) {
			prodBadList = new ArrayList<KwangjinProdBadStaDto>();
		}
 		return new PageInfo<KwangjinProdBadStaDto>(prodBadList, pageRequestVo, rowCount);
	}
}
