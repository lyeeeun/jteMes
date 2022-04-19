package jin.mes.cform.barcode.barcodePrint;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.barcode.barcodeBase.ZinixBarcodeBaseDto;
import jin.mes.cform.barcode.barcodeBase.ZinixBarcodeBaseMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixBarcodePrintService {

	@Resource
	protected ZinixBarcodeBaseMapper zinixBarcodeBaseMapper;
	
	//바코드 조회
	public PageInfo<ZinixBarcodeBaseDto> getBarcodeList(ZinixBarcodeBaseDto zinixBarcodeBaseDto, PageRequestVo pageRequestVo){
		List<ZinixBarcodeBaseDto> ZinixBarcodeBaseList = null;
		int rowCount = 0;

		if(!zinixBarcodeBaseDto.getPagingYN().equals("N")) {
			zinixBarcodeBaseDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			zinixBarcodeBaseDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		
		try {
			rowCount = zinixBarcodeBaseMapper.selectBarcodeCount(zinixBarcodeBaseDto);
			if (rowCount > 0) {
				ZinixBarcodeBaseList = zinixBarcodeBaseMapper.selectBarcodeList(zinixBarcodeBaseDto);
			}
		} catch (Exception e) {
			throw new BusinessException("바코드 조회 에러입니다." + e.getMessage());
		}
		
		if (ZinixBarcodeBaseList == null) {
			ZinixBarcodeBaseList = new ArrayList<ZinixBarcodeBaseDto>();
		}
		return new PageInfo<ZinixBarcodeBaseDto>(ZinixBarcodeBaseList, pageRequestVo, rowCount);
	}
}
