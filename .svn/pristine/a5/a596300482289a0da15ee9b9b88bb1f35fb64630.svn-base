package jin.mes.form.item.itemStockMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

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
	@RequestMapping("/getStockList")
	public ModelMap getStockList(ModelMap model, @ModelAttribute("itemStockMgtDto") ItemStockMgtDto itemStockMgtDto) {
		try {
			model.addAttribute("rows", itemStockMgtService.getStockList(itemStockMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅시트  조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("/insertItemStock")
	public void insertItemStock(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.insertItemStock(itemStockMgtDto);
	}
	@RequestMapping("/updateItemMgt")
	public void updateItemMgt(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.updateItemMgt(itemStockMgtDto);
	}
	@RequestMapping("/updateItemStock")
	public void updateItemStock(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.updateItemStock(itemStockMgtDto);
	}
	
	@RequestMapping("/itemCompleteUse")
	public void itemCompleteUse(@RequestBody ItemStockMgtDto itemStockMgtDto) {
		itemStockMgtService.itemCompleteUse(itemStockMgtDto);
	}
	
	@RequestMapping("/deleteItemStock")
	@ResponseBody
	public int deleteItemStock(ModelMap model, @RequestBody List<ItemStockMgtDto> itemStockList) {
		return itemStockMgtService.deleteItemStock(itemStockList);
	}
	
}
