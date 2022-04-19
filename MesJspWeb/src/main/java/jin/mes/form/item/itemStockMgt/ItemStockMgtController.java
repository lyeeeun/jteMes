package jin.mes.form.item.itemStockMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/item/itemStockMgt")
public class ItemStockMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ItemStockMgtController.class);

	@Resource
	protected ItemStockMgtService itemStockMgtService;

	@RequestMapping("/getItemStockList")
	public ModelMap getItemStockList(@ModelAttribute("itemStockMgtDto") ItemStockMgtDto itemStockMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemStockMgtDto.getPage())));
		pageRequestVo.setRows(itemStockMgtDto.getRows());

		setModelWithkendoList(model, itemStockMgtService.getItemStockList(itemStockMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getItemStockHistory")
	public ModelMap getItemStockHistory(@ModelAttribute("itemStockMgtDto") ItemStockMgtDto itemStockMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemStockMgtDto.getPage())));
		pageRequestVo.setRows(itemStockMgtDto.getRows());

		setModelWithkendoList(model, itemStockMgtService.getItemStockHistory(itemStockMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/insertItemStock")
	public void insertItemStock(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.insertItemStock(itemStockMgtDto);
	}
	
	@RequestMapping("/updateItemStock")
	public void updateItemStock(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.updateItemStock(itemStockMgtDto);
	}
	
	@RequestMapping("/itemCompleteUse")
	public void itemCompleteUse(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.itemCompleteUse(itemStockMgtDto);
	}
	
}
