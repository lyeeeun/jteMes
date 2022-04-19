package jin.mes.common.excelUtil;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/excelUtil")
public class ExcelUtilController extends BaseController {

	@Autowired
	ExcelUtilService excelUtilService;
	
	@ResponseBody
	@RequestMapping(path = "/downloadExcelFile", produces = "application/vnd.ms-excel")
	public void downloadExcelFile(Model model, @RequestBody ExcelUtilDto excelUtilDto, HttpServletRequest request, HttpServletResponse response) {

		excelUtilService.downloadExcelFile(request, response, excelUtilDto);
	}
	
	@RequestMapping("/uploadExcelFile")
	public void uploadExcelFile(MultipartHttpServletRequest request, @RequestParam("menuId") String menuId) {
		MultipartFile file = null;
		Iterator<String> iterator = request.getFileNames();
		
		if(iterator.hasNext()) {
			file = request.getFile(iterator.next());
		}
		excelUtilService.uploadExcelFile(file, menuId);
	}
	
	
	@RequestMapping("/selectTableInfo")
	public ModelMap selectTableInfo(@ModelAttribute("excelUtilDto") ExcelUtilDto excelUtilDto, ModelMap model) {
		model.addAttribute("rows", excelUtilService.selectTableInfo(excelUtilDto));

		return model;
	}
	
	@ResponseBody
	@RequestMapping("/selectIsSet")
	public int selectIsSet(@RequestBody ExcelUtilDto excelUtilDto) {
		return excelUtilService.selectIsSet(excelUtilDto);
	}
	
	@ResponseBody
	@RequestMapping("/insertExcelSetting")
	public void insertExcelSetting(@RequestBody ExcelUtilDto excelUtilDto) {
		excelUtilService.insertExcelSetting(excelUtilDto);
	}
	
	@ResponseBody
	@RequestMapping("/updateExcelSetting")
	public void updateExcelSetting(@RequestBody ExcelUtilDto excelUtilDto) {
		excelUtilService.updateExcelSetting(excelUtilDto);
	}
	
	@ResponseBody
	@RequestMapping("/deleteExcelSetting")
	public void deleteExcelSetting(@RequestBody ExcelUtilDto excelUtilDto) {
		excelUtilService.deleteExcelSetting(excelUtilDto);
	}
	
	
	@RequestMapping("/excelUpload")
	public List<Map<String, String>> excelUpload(MultipartHttpServletRequest request) {
		MultipartFile file = null;
		Iterator<String> iterator = request.getFileNames();
		
		if(iterator.hasNext()) {
			file = request.getFile(iterator.next());
		}
		
		return excelUtilService.excelUpload(file);
	}
	
	
	@RequestMapping("/selectTableTestInfo")
	public ModelMap selectTableTestInfo(@ModelAttribute("excelUtilDto") ExcelUtilDto excelUtilDto, ModelMap model) {
		model.addAttribute("rows", excelUtilService.selectTableTestInfo(excelUtilDto));

		return model;
	}

	@ResponseBody
	@RequestMapping("/insertOrderMgt")
	public void insertOrderMgt(@RequestBody ExcelUtilDto excelUtilDto) {
		excelUtilService.insertOrderMgt(excelUtilDto);
	}
	
	@ResponseBody
	@RequestMapping("/updateOrderMgt")
	public void updateOrderMgt(@RequestBody ExcelUtilDto excelUtilDto) {
		excelUtilService.updateOrderMgt(excelUtilDto);
	}
	
	@ResponseBody
	@RequestMapping("/deleteOrderMgt")
	public void deleteOrderMgt(@RequestBody ExcelUtilDto excelUtilDto) {
		excelUtilService.deleteOrderMgt(excelUtilDto);
	}

}