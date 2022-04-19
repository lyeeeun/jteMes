package jin.mes.cform.mtrl.itemRecevingMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/mtrl/itemRecevingMgt")
public class KwangjinItemRecevingMgtController extends BaseController {

	@Autowired
	KwangjinItemRecevingMgtService kwangjinItemRecevingMgtService;
	
	@RequestMapping("/getItemRecevingMgtList")
	public ModelMap getItemRecevingMgtList(ModelMap model, @ModelAttribute("kwangjinItemRecevingMgtDto") KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinItemRecevingMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinItemRecevingMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinItemRecevingMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinItemRecevingMgtService.getItemRecevingMgtList(kwangjinItemRecevingMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("제품 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getItemLotList")
	public ModelMap getItemLotList(ModelMap model, @ModelAttribute("kwangjinItemRecevingMgtDto") KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinItemRecevingMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinItemRecevingMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinItemRecevingMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinItemRecevingMgtService.getItemLotList(kwangjinItemRecevingMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("제품 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/insertItemRecevingMgt")
	public void insertItemRecevingMgt(@RequestBody KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		kwangjinItemRecevingMgtService.insertItemRecevingMgt(kwangjinItemRecevingMgtDto);
	}
	
	@RequestMapping("/setItemRecevingMgtSave")
	@ResponseBody
	public String setItemRecevingMgtSave(@RequestBody KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		return kwangjinItemRecevingMgtService.setItemRecevingMgtSave(kwangjinItemRecevingMgtDto);
	}
	
	@RequestMapping("/deleteItemStock")
	@ResponseBody
	public int deleteItemStock(ModelMap model, @RequestBody List<KwangjinItemRecevingMgtDto> itemStockList) {
		return kwangjinItemRecevingMgtService.deleteItemStock(itemStockList);
	}
	
	@RequestMapping("/selectItemLotDupleKeyCount")
	@ResponseBody
	public int selectItemLotDupleKeyCount(@RequestBody KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		return kwangjinItemRecevingMgtService.selectItemLotDupleKeyCount(kwangjinItemRecevingMgtDto);
	}
	
	@RequestMapping("/getItemRecevingHisList")
	public ModelMap getItemRecevingHisList(ModelMap model, @ModelAttribute("kwangjinItemRecevingMgtDto") KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinItemRecevingMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinItemRecevingMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinItemRecevingMgtService.getItemRecevingHisList(kwangjinItemRecevingMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("제품 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemManualSave")
	@ResponseBody
	public String setItemManualSave(@RequestBody KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto) {
		return kwangjinItemRecevingMgtService.setItemManualSave(kwangjinItemRecevingMgtDto);
	}
	
	@RequestMapping("/setItemManualDelete")
	@ResponseBody
	public int setItemManualDelete(ModelMap model, @RequestBody List<KwangjinItemRecevingMgtDto> itemHisList) {
		return kwangjinItemRecevingMgtService.setItemManualDelete(itemHisList);
	}
}
