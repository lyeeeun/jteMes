package jin.mes.form.perform.itemAggregation;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/perform/itemAggregation")
public class ItemAggregationController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ItemAggregationController.class);

	@Resource
	protected ItemAggregationService itemAggregationService;

	@RequestMapping("/getItemAggregation")
	public ModelMap getItemAggregation(@ModelAttribute("itemAggregationDto") ItemAggregationDto itemAggregationDto, ModelMap model) {
		try {
			PageRequestVo pageRequestVo = new PageRequestVo();
			pageRequestVo.setPage(getCurrentPage(Integer.toString(itemAggregationDto.getPage())));
			pageRequestVo.setRows(itemAggregationDto.getRows());
			
			setModelWithkendoList(model, itemAggregationService.getItemAggregation(itemAggregationDto, pageRequestVo));
			
		}catch(Exception ex) {
			throw new BusinessException("생산현황 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
}
