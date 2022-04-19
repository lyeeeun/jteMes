package jin.mes.cform.item.itemStockMgt;

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

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/item/itemStockMgt")
public class ZinixItemStockMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ZinixItemStockMgtController.class);

	@Resource
	protected ZinixItemStockMgtService zinixItemStockMgtService;

	@RequestMapping("/getItemStockList")
	public ModelMap getItemStockList(@ModelAttribute("itemStockMgtDto") ZinixItemStockMgtDto itemStockMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemStockMgtDto.getPage())));
		pageRequestVo.setRows(itemStockMgtDto.getRows());

		setModelWithkendoList(model, zinixItemStockMgtService.getItemStockList(itemStockMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getItemStockHistory")
	public ModelMap getItemStockHistory(@ModelAttribute("itemStockMgtDto") ZinixItemStockMgtDto itemStockMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemStockMgtDto.getPage())));
		pageRequestVo.setRows(itemStockMgtDto.getRows());

		setModelWithkendoList(model, zinixItemStockMgtService.getItemStockHistory(itemStockMgtDto, pageRequestVo));

		return model;
	}
	@RequestMapping("/getStockList")
	public ModelMap getStockList(ModelMap model, @ModelAttribute("itemStockMgtDto") ZinixItemStockMgtDto itemStockMgtDto) {
		try {
			model.addAttribute("rows", zinixItemStockMgtService.getStockList(itemStockMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅시트  조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("/insertItemStock")
	public void insertItemStock(@RequestBody ZinixItemStockMgtDto itemStockMgtDto) {
		zinixItemStockMgtService.insertItemStock(itemStockMgtDto);
	}
	@RequestMapping("/updateItemMgt")
	public void updateItemMgt(@RequestBody ZinixItemStockMgtDto itemStockMgtDto) {
		zinixItemStockMgtService.updateItemMgt(itemStockMgtDto);
	}
	@RequestMapping("/updateItemStock")
	public void updateItemStock(@RequestBody ZinixItemStockMgtDto itemStockMgtDto) {
		zinixItemStockMgtService.updateItemStock(itemStockMgtDto);
	}
	
	@RequestMapping("/itemCompleteUse")
	public void itemCompleteUse(@RequestBody ZinixItemStockMgtDto itemStockMgtDto) {
		zinixItemStockMgtService.itemCompleteUse(itemStockMgtDto);
	}
	
	@RequestMapping("/deleteItemStock")
	@ResponseBody
	public int deleteItemStock(ModelMap model, @RequestBody List<ZinixItemStockMgtDto> itemStockList) {
		return zinixItemStockMgtService.deleteItemStock(itemStockList);
	}
	
}
