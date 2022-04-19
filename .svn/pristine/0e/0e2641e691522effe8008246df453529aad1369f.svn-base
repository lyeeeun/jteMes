package jin.mes.form.barcode.barcodePrint;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.barcode.barcodeBase.BarcodeBaseDto;
import jin.mes.form.barcode.barcodeBase.BarcodeBaseMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class BarcodePrintService {

	@Resource
	protected BarcodeBaseMapper barcodeBaseMapper;
	
	//바코드 조회
	public PageInfo<BarcodeBaseDto> getBarcodeList(BarcodeBaseDto barcodeBaseDto, PageRequestVo pageRequestVo){
		List<BarcodeBaseDto> BarcodeBaseList = null;
		int rowCount = 0;

		if(!barcodeBaseDto.getPagingYN().equals("N")) {
			barcodeBaseDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			barcodeBaseDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		
		try {
			rowCount = barcodeBaseMapper.selectBarcodeCount(barcodeBaseDto);
			if (rowCount > 0) {
				BarcodeBaseList = barcodeBaseMapper.selectBarcodeList(barcodeBaseDto);
			}
		} catch (Exception e) {
			throw new BusinessException("바코드 조회 에러입니다." + e.getMessage());
		}
		
		if (BarcodeBaseList == null) {
			BarcodeBaseList = new ArrayList<BarcodeBaseDto>();
		}
		return new PageInfo<BarcodeBaseDto>(BarcodeBaseList, pageRequestVo, rowCount);
	}
}
