package kr.co.itcall.jte.common.mvc;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

public abstract class BaseController {

	private final static String JSON_VIEW = "jsonView";
	private final static String PREFIX_THYEM_LEAF_VIEW = "tlf";

	public String toJsonView(){
		return JSON_VIEW;
	}
	public String toJspView(String viewPath){
		return new StringBuffer().append("/").append(viewPath).toString().replaceAll("//", "/");
	}
	public String toThyemleafView(String viewPath){
		return new StringBuffer().append(PREFIX_THYEM_LEAF_VIEW).append("/").append(viewPath).toString().replaceAll("//", "/");
	}

	// @GetMapping({"", "/", "/form", "/form/"})
	@RequestMapping({"", "/", "/form", "/form/"})
	public String formViewForJsp(HttpServletRequest request) {
		String returnResolver = request.getRequestURI();
		if(returnResolver.endsWith("/form/")) {
			returnResolver = returnResolver.substring(0, returnResolver.lastIndexOf("/form/"));
		} else if(returnResolver.endsWith("/form")) {
			returnResolver = returnResolver.substring(0, returnResolver.lastIndexOf("/form"));
		} else if(returnResolver.endsWith("/")) {
			returnResolver = returnResolver.substring(0, returnResolver.lastIndexOf("/"));
		}
		/***************************************
		 * PageView에 대한 접근권한 처리 및 Exception
		 */
		return returnResolver + "/" + returnResolver.substring(returnResolver.lastIndexOf("/")+1) + "Form"; // for JSP // /form/sysLog/sysCtrl
	}

	// @GetMapping({"/tlf", "/tlf/"})
	@RequestMapping({"/tlf", "/tlf/"})
	public String formViewForThyemleaf(HttpServletRequest request) {
		String returnResolver = request.getRequestURI();
		if(returnResolver.endsWith("/tlf/")) {
			returnResolver = returnResolver.substring(0, returnResolver.lastIndexOf("/tlf/"));
		} else if(returnResolver.endsWith("/tlf")) {
			returnResolver = returnResolver.substring(0, returnResolver.lastIndexOf("/tlf"));
		} else if(returnResolver.endsWith("/")) {
			returnResolver = returnResolver.substring(0, returnResolver.lastIndexOf("/"));
		}
		/***************************************
		 * PageView에 대한 접근권한 처리 및 Exception
		 */
		return "tlf" + returnResolver + "/" + returnResolver.substring(returnResolver.lastIndexOf("/")+1) + "Form"; // for Thymeleaf
	}

	public Integer getCurrentPage(String page){
		String strPage = page;
		Integer result = null;
		
		if(StringUtils.isEmpty(strPage)){
			/* Exception 처리 */
			strPage= "0";
		}
		
		result = Integer.parseInt(strPage);
		if (result != 0) {
			result--;
		}
		
		return result;
	}

	public static void setModelWithkendoList(ModelMap model,PageInfo<?> pageInfo){
		model.addAttribute("rows", pageInfo.getContent()); // 실제 데이터 해당량이 한페이지당 개수
		model.addAttribute("records", pageInfo.getTotalElements()); // 전체레코드개수
		model.addAttribute("total", pageInfo.getTotalPages()); // 전체페이지개수
		model.addAttribute("page", pageInfo.getNumber()); // 현재페이지 번호
		model.addAttribute("count", pageInfo.getTotalElements()); // 전체레코드개수
		// pageInfo.getSize(); // 한페이지당 row개수
	}
	
	public static void setModelWithkendoList(ModelMap model,Page<?> page){
		model.addAttribute("rows", page.getContent()); // 실제 데이터 해당량이 한페이지당 개수
		model.addAttribute("records", page.getTotalElements()); // 전체레코드개수
		model.addAttribute("total", page.getTotalPages()); // 전체페이지개수
		model.addAttribute("page", page.getNumber()); // 현재페이지 번호
		model.addAttribute("count", page.getTotalElements()); // 전체레코드개수
		// pageInfo.getSize(); // 한페이지당 row개수
	}

}
