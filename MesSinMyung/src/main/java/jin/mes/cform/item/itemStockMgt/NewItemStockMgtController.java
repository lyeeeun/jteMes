package jin.mes.cform.item.itemStockMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/item/itemStockMgt")
public class NewItemStockMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewItemStockMgtController.class);

	@Resource
	protected NewItemStockMgtService newItemStockMgtService;

	@RequestMapping("/getItemStockList")
	public ModelMap getItemStockList(@ModelAttribute("itemStockMgtDto") NewItemStockMgtDto itemStockMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemStockMgtDto.getPage())));
		pageRequestVo.setRows(itemStockMgtDto.getRows());

		setModelWithkendoList(model, newItemStockMgtService.getItemStockList(itemStockMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getItemStockHistory")
	public ModelMap getItemStockHistory(@ModelAttribute("itemStockMgtDto") NewItemStockMgtDto itemStockMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemStockMgtDto.getPage())));
		pageRequestVo.setRows(itemStockMgtDto.getRows());

		setModelWithkendoList(model, newItemStockMgtService.getItemStockHistory(itemStockMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/insertItemStock")
	public void insertItemStock(@RequestBody NewItemStockMgtDto itemStockMgtDto) {
		newItemStockMgtService.insertItemStock(itemStockMgtDto);
	}
	
	@RequestMapping("/updateItemStock")
	public void updateItemStock(@RequestBody NewItemStockMgtDto itemStockMgtDto) {
		newItemStockMgtService.updateItemStock(itemStockMgtDto);
	}
	
	@RequestMapping("/itemCompleteUse")
	public void itemCompleteUse(@RequestBody NewItemStockMgtDto itemStockMgtDto) {
		newItemStockMgtService.itemCompleteUse(itemStockMgtDto);
	}
	
}
