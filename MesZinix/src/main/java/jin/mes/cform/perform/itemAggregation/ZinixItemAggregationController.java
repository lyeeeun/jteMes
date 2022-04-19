package jin.mes.cform.perform.itemAggregation;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/perform/itemAggregation")
public class ZinixItemAggregationController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ZinixItemAggregationController.class);

	@Resource
	protected ZinixItemAggregationService zinixItemAggregationService;

	@RequestMapping("/getItemAggregation")
	public ModelMap getItemAggregation(@ModelAttribute("zinixItemAggregationDto") ZinixItemAggregationDto zinixItemAggregationDto, ModelMap model) {
		try {
			PageRequestVo pageRequestVo = new PageRequestVo();
			pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixItemAggregationDto.getPage())));
			pageRequestVo.setRows(zinixItemAggregationDto.getRows());
			
			setModelWithkendoList(model, zinixItemAggregationService.getItemAggregation(zinixItemAggregationDto, pageRequestVo));
			
		}catch(Exception ex) {
			throw new BusinessException("생산현황 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
}
