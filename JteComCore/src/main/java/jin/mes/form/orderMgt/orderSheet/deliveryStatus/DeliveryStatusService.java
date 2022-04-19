package jin.mes.form.orderMgt.orderSheet.deliveryStatus;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class DeliveryStatusService {
	
	@Resource
	DeliveryStatusMapper deliveryStaMapper;
	
	//수주 조회
	public PageInfo<DeliveryStatusDto> getOrderSearchList(DeliveryStatusDto deliveryStaDto, PageRequestVo pageRequestVo){
		List<DeliveryStatusDto> deliveryStaList = null;
		int rowCount = 0;

		// Page Setting
		deliveryStaDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		deliveryStaDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = deliveryStaMapper.selectOrderSearchListCount(deliveryStaDto);
			if (rowCount > 0) {
				//List
				deliveryStaList = deliveryStaMapper.selectOrderSearchList(deliveryStaDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (deliveryStaList == null) {
			deliveryStaList = new ArrayList<DeliveryStatusDto>();
		}
		return new PageInfo<DeliveryStatusDto>(deliveryStaList, pageRequestVo, rowCount);
	}
	
	//납품현황 - LoT조회(page)
	public PageInfo<DeliveryStatusDto> getDeliveryStaLotList(DeliveryStatusDto deliveryStaDto, PageRequestVo pageRequestVo){
		List<DeliveryStatusDto> deliveryStaList = null;
		int rowCount = 0;

		// Page Setting
		deliveryStaDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		deliveryStaDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = deliveryStaMapper.selectLotDeliveryStaListCount(deliveryStaDto);
			if (rowCount > 0) {
				//List
				deliveryStaList = deliveryStaMapper.selectLotDeliveryStaList(deliveryStaDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (deliveryStaList == null) {
			deliveryStaList = new ArrayList<DeliveryStatusDto>();
		}
		return new PageInfo<DeliveryStatusDto>(deliveryStaList, pageRequestVo, rowCount);
	}
	
	//납품현황 조회(page)
	public PageInfo<LotDeliveryStaDto> getDeliveryStatusList(LotDeliveryStaDto lotDeliveryStaDto, PageRequestVo pageRequestVo){
		List<LotDeliveryStaDto> lotDeliveryStaList = null;
		int rowCount = 0;

		// Page Setting
		lotDeliveryStaDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotDeliveryStaDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = deliveryStaMapper.selectDeliveryStatusListCount(lotDeliveryStaDto);
			if (rowCount > 0) {
				//List
				lotDeliveryStaList = deliveryStaMapper.selectDeliveryStatusList(lotDeliveryStaDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (lotDeliveryStaList == null) {
			lotDeliveryStaList = new ArrayList<LotDeliveryStaDto>();
		}
		return new PageInfo<LotDeliveryStaDto>(lotDeliveryStaList, pageRequestVo, rowCount);
	}
}
