package kr.co.itcall.jte.pms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.pms.model.ExcelUploadVO;
import kr.co.itcall.jte.pms.model.PmsTechOrderHistModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.pms.service.ExcelFileService;
import kr.co.itcall.jte.pms.service.PmsService;
import kr.co.itcall.jte.rms.model.MasterVO;
import kr.co.itcall.jte.rms.model.PageVO;

@Controller
public class PmsController {

	@Autowired
	PmsService pmsService;

	@Autowired
	ExcelFileService excelFileService;
	
	/* 
	 * Works_Spare페이지 이동 화면 및 검색(Get방식 - 화면 새로고침)
	 * */
	@RequestMapping(value = "/works_spare")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView getSearchWorksName(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		//검색 구분에 따른 분기처리
		if("name".equals(masterVO.getSearchGubun())) {
			mv.addObject("searchResult", pmsService.searchWorksNameListAll(masterVO.getSearchText()));
		}else if("code".equals(masterVO.getSearchGubun())) {
			mv.addObject("searchResult", pmsService.searchWorksCodeListAll(masterVO.getSearchText()));
		}else {
			mv.addObject("searchResult", pmsService.searchWorksCodeListAll(""));
		}
		//검색조건 유지를 위함
		mv.addObject("search",masterVO);
		
		//좌측메뉴와 컨텐츠 부분 제목을 위함
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/MaintenanceManagement/works_spare");
		return mv;
	}
	
	/*
	 * Works_Spare 상세조회
	 */	
	@RequestMapping(value = "/getAllPmsOrderList")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getAllPmsOrderList(@RequestBody PmsTechOrderModel pmsOrderModel) {
		return new ResponseEntity<Object>(pmsService.orderListFindItem(pmsOrderModel), HttpStatus.OK);
	}
	
	/*
	 * Works_Spare 팝업창 오픈 및 선택한 order 조회
	 */
	@RequestMapping(value = "/PartsManagePop")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView appendPartsPop(ModelAndView mv, @ModelAttribute("pmsOrderPk") PmsTechOrderPk pmsOrderPk) {
		PmsTechOrderModel pmsOrderModel = new PmsTechOrderModel();
		pmsOrderModel.setPmsTechOrderPk(pmsOrderPk);
		mv.addObject("searchResult",pmsService.orderListFindItem(pmsOrderModel));
		mv.setViewName("contents/rms/MaintenanceManagement/appendPartsPop");
		return mv;
	}
	
	/*
	 * Works_Spare 팝업 Parts 검색
	*/
	@RequestMapping(value = "/getPartsList")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getPartsList(@RequestBody MasterVO masterVO) {
		return new ResponseEntity<Object>(pmsService.searchPartsListAll(masterVO), HttpStatus.OK);
	}
	
	/*
	 * Works_Spare 팝업 Parts 상세조회
	*/
	@RequestMapping(value = "/getPartsItemDetail")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getPartsItemDetail(@RequestBody PmsPartDtlPk dtlModel) {
		return new ResponseEntity<Object>(pmsService.getPartsItemDetail(dtlModel), HttpStatus.OK);		
	}
	
	/*
	 * Works_Spare 팝업 Parts 추가
	*/
	@RequestMapping(value = "/setPartsAppend")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setPartsAppend(@RequestBody PmsTechOrderModel ordermodel) {
		return pmsService.setPartsAppend(ordermodel);
	}
	
	/*
	 * Works_Spare 팝업 Parts 수정
	*/
	@RequestMapping(value = "/setPartsModify")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setPartsModify(@RequestBody PmsTechOrderModel ordermodel) {
		return pmsService.setPartsModify(ordermodel);
	}
	
	/*
	 * Works_Spare 팝업 Parts 삭제
	*/
	@RequestMapping(value = "/setPartsDelete")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setPartsDelete(@RequestBody PmsTechOrderModel ordermodel) {
		return pmsService.setPartsDelete(ordermodel);
	}
	/*
	 * Works_Spare History 조회(Engine Tab)
	*/
	@RequestMapping(value = "/getHitoryParent")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getHitoryParent(@RequestBody PmsTechOrderHistModel histmodel) {
		return new ResponseEntity<Object>(pmsService.getHistoryParent(histmodel), HttpStatus.OK);
	}
	
	
	/*
	 * Works_Spare History 추가
	*/
	@RequestMapping(value = "/setHistoryAppend")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setHistoryAppend(@RequestBody PmsTechOrderHistModel histmodel) {
		return pmsService.setHistoryAppend(histmodel);
	}
	
	
	/* 
	 * HistoryMain 페이지 이동 화면 및 검색(Get방식 - 화면 새로고침)
	 * */
	@RequestMapping(value = "/main_history")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView getMainHistory(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		//검색 구분에 따른 분기처리
		if("name".equals(masterVO.getSearchGubun())) {
			mv.addObject("searchResult", pmsService.searchWorksNameListAll(masterVO.getSearchText()));
		}else if("code".equals(masterVO.getSearchGubun())) {
			mv.addObject("searchResult", pmsService.searchWorksCodeListAll(masterVO.getSearchText()));
		}else {
			mv.addObject("searchResult", pmsService.searchWorksCodeListAll(""));
		}
		//검색조건 유지를 위함
		mv.addObject("search",masterVO);
		
		//좌측메뉴와 컨텐츠 부분 제목을 위함
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/MaintenanceManagement/maintenance_history");
		return mv;
	}
	
	/*
	 * History 구분 리스트
	 */	
	@RequestMapping(value = "/getAllHistoryList")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getAllHistoryList(@RequestBody PmsTechOrderPk pmsTechOrderPk) {
		return new ResponseEntity<Object>(pmsService.getAllHistoryList(pmsTechOrderPk), HttpStatus.OK);
	}
	
	@RequestMapping(value = "/getMainHistoryDetail")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getMainHistoryDetail(@RequestBody PmsTechOrderHistModel pmsTechOrderHistModel) {
		return new ResponseEntity<Object>(pmsService.getMainHistoryDetail(pmsTechOrderHistModel), HttpStatus.OK);
	}
	
	/*
	 * History R/H 일괄변경
	*/
	@RequestMapping(value = "/setHisoryRhMod")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setHisoryRhMod(@RequestBody Map<String, Object> map) {
		return pmsService.setHisoryRhMod(map);
	}
	
		
	// MaintenanceManagement - Maintenance List
	@RequestMapping("/maintenance_list")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView Maintenance_list(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/MaintenanceManagement/maintenance_list");
		
		return mv;
	}
	
	//MaintenanceManagement - Maintenance List GridView Data
	@RequestMapping(value = "/getGridOrderList")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getGridOrderList(@ModelAttribute("pageVO") PageVO pageVO) {
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,Object> orderList = pmsService.getGridOrderList(pageVO);
//		map.put("total", orderList.getTotalElements());
//		map.put("rows", orderList.getContent());
		return new ResponseEntity<Object>(orderList, HttpStatus.OK);
	}
	
	// MaintenanceManagement - Parts list for Maintenance
	@RequestMapping("/parts_list_for_maintenance")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView Parts_list_for_maintenance(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/MaintenanceManagement/parts_list_for_maintenance");
		
		return mv;
	}
	
	//MaintenanceManagement - Parts list for Maintenance GridView Data
		@RequestMapping(value = "/getGridPartsForMainList")
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<Object> getGridPartsForMainList(@ModelAttribute("pageVO") PageVO pageVO) {
			Map<String,Object> map = new HashMap<String, Object>();
			Map<String,Object> PFMList = pmsService.getGridPartsForMainList(pageVO);
//			map.put("total", PFMList.getTotalElements());
//			map.put("rows", PFMList.getContent());
			return new ResponseEntity<Object>(PFMList, HttpStatus.OK);
		}
	
	// MaintenanceManagement - Spare in Stock
	@RequestMapping("/spare_in_stock")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView Spare_in_stock(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/MaintenanceManagement/spare_in_stock");
		
		return mv;
	}
	
	//MaintenanceManagement - Spare in Stock GridView Data
	@RequestMapping(value = "/getGridSpareStockList")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Object> getGridSpareStockList(@ModelAttribute("pageVO") PageVO pageVO) {
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,Object> SISList = pmsService.getGridSpareStockList(pageVO);
//			map.put("total", SISList.getTotalElements());
//			map.put("rows", SISList.getContent());
		return new ResponseEntity<Object>(SISList, HttpStatus.OK);
	}
	
	//MaintenaceList - pms_tech_order Table 엑셀 일괄 업로드(insert/update)
	@RequestMapping(value="/setOrderUpload", method = RequestMethod.POST)
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setOrderUpload(HttpServletRequest request, @ModelAttribute("excelUploadVO") ExcelUploadVO excelUploadVO) throws Exception{
			String strResult = "ERROR";
		try{
			//절대 경로 구하기
			File filePath = new File("");
			String rootPath = filePath.getAbsolutePath();
			
			//절대 경로 구하기
			SimpleDateFormat fommat = new SimpleDateFormat("yyyyMMddhhmmss_");
			String nowDate = fommat.format(new Date());
			
			//복사할 파일 위치
			File destFile = new File(rootPath+"\\src\\main\\resources\\static\\Excel\\"+ nowDate +excelUploadVO.getFile().getOriginalFilename());
			
			//파일복사
			excelUploadVO.getFile().transferTo(destFile);
			
			// 엑셀 업로드 service 수행
			strResult = excelFileService.excelUploadOrder(excelUploadVO, destFile);
			
			//파일삭제
			destFile.delete();
		}catch(IllegalStateException | IOException e){
			strResult ="ERROR";
			throw new RuntimeException(e.getMessage(),e);
		}
		
		return strResult;
	}
	
	//Spare_in_stock - pms_part_dtl Table 엑셀 일괄 업로드(insert/update)
	@RequestMapping(value="/setPartsUpload", method = RequestMethod.POST)
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String setPartsUpload(@RequestParam("file") MultipartFile file, @ModelAttribute("excelUploadVO") ExcelUploadVO excelUploadVO) throws Exception{
			String strResult = "ERROR";
		try{
			//절대 경로 구하기
			File filePath = new File("");
			String rootPath = filePath.getAbsolutePath();
			
			//유일한 파일을 만들기 위해 파일명 앞에 시간정보 적어줌
			SimpleDateFormat fommat = new SimpleDateFormat("yyyyMMddhhmmss_");
			String nowDate = fommat.format(new Date());
			
			//복사할 파일 위치
			File destFile = new File(rootPath+"\\src\\main\\resources\\static\\Excel\\"+ nowDate +excelUploadVO.getFile().getOriginalFilename());
			
			//파일복사
			excelUploadVO.getFile().transferTo(destFile);
			
			// 엑셀 업로드 service 수행
			strResult = excelFileService.excelUploadParts(excelUploadVO, destFile);
			
			//파일삭제
			destFile.delete();
		}catch(IllegalStateException | IOException e){
			strResult ="ERROR";
			throw new RuntimeException(e.getMessage(),e);
		}
		
		return strResult;
	}
	
	//Sample 파일 다운로드
	@RequestMapping("/fileDown/{fileName}")
	private void fileDown(@PathVariable String fileName, HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8"); 
		try{
			File filePath = new File("");
			String rootPath = filePath.getAbsolutePath();
			
			//유일한 파일을 만들기 위해 파일명 앞에 시간정보 적어줌
			SimpleDateFormat fommat = new SimpleDateFormat("yyyyMMddhhmmss_");
			String nowDate = fommat.format(new Date());
			
			//복사할 파일 위치
			String path = rootPath+"\\src\\main\\resources\\static\\Excel\\"+fileName+".xlsx"; //full경로
			String downfileName = nowDate+fileName+".xlsx";
			
			InputStream in = null;
			OutputStream os = null;
			File file = null;
			boolean skip = false;
			String client = "";
			
			//파일을 읽어 스트림에 담기  
			try{
				file = new File(path);
				in = new FileInputStream(file);
			} catch (FileNotFoundException fe) {
				skip = true;
			}
			
			client = request.getHeader("User-Agent");
			
			//파일 다운로드 헤더 지정 
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Description", "JSP Generated Data");
			
			if (!skip) {
				// IE
				if (client.indexOf("MSIE") != -1) {
					response.setHeader("Content-Disposition", "attachment; filename=\""
							+ java.net.URLEncoder.encode(downfileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
					//IE 11 이상.
				} else if (client.indexOf("Trident") != -1) {
					response.setHeader("Content-Disposition", "attachment; filename=\""
							+ java.net.URLEncoder.encode(downfileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
				} else {
					//한글 파일명 처리
					response.setHeader("Content-Disposition",
							"attachment; filename=\"" + new String(downfileName.getBytes("UTF-8"), "ISO8859_1") + "\"");
					response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
				}
				response.setHeader("Content-Length", "" + file.length());
				os = response.getOutputStream();
				byte b[] = new byte[(int) file.length()];
				int leng = 0;
				while ((leng = in.read(b)) > 0) {
					os.write(b, 0, leng);
				}
			} else {
				response.setContentType("text/html;charset=UTF-8");
			}
			in.close();
			os.close();
		} catch (Exception e) {
			System.out.println("ERROR : " + e.getMessage());
		}
	}
}
