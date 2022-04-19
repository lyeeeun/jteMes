package kr.co.itcall.jte.common.code;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/common/code")
public class ComnCodeController {

//	@Autowired
//	private ComnCodeService comnCodeService;
//
//	@RequestMapping(value = {"/get"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> getComnCode(HttpServletRequest request, ModelMap map, @RequestParam("code") String code, @RequestParam(name="def", required=false) String def) {
//		try {
//			int defNum = Integer.parseInt(def);
//			map.addAttribute("result", CodeUtil.getCode(code, defNum));
//		} catch (Exception e) {
//			map.addAttribute("result", CodeUtil.getCode(code, def));
//		}
//		return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}
//
//	@RequestMapping(value = {"/getPage"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> getComnCodePage(HttpServletRequest request, ModelMap map
//			, @PageableDefault(sort = { "sortNum","cdId" }, direction = Direction.ASC, page = 0, size = 10) Pageable pageable
//			, @RequestParam("search") String search) {
//		return new ResponseEntity<Object>(this.comnCodeService.searchPage(search, pageable), HttpStatus.OK);
//	}
//
//	@RequestMapping(value = {"/getComnCodeList"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> getComnCodeList(HttpServletRequest request, @RequestParam("cdId") String cdId, ModelMap map) {
//		return new ResponseEntity<Object>(this.comnCodeService.getComnCodeList(cdId), HttpStatus.OK);
//	}
//
//	@RequestMapping(value = {"/getComnCode"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> getComnCode(HttpServletRequest request, @RequestParam("cdId") String cdId, ModelMap map) {
//		return new ResponseEntity<Object>(this.comnCodeService.getComnCode(cdId), HttpStatus.OK);
//	}
//
//	@PreAuthorize("isAuthenticated()")
//	@RequestMapping(value = {"/addComnCode"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> addComnCode(HttpServletRequest request, @ModelAttribute ComnCodeVo comnCodeVo, ModelMap map) {
//		return new ResponseEntity<Object>(this.comnCodeService.addComnCode(comnCodeVo), HttpStatus.OK);
//	}
//
//	@PreAuthorize("isAuthenticated()")
//	@RequestMapping(value = {"/setComnCode"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> setComnCode(HttpServletRequest request, @ModelAttribute ComnCodeVo comnCodeVo, ModelMap map) {
//		return new ResponseEntity<Object>(this.comnCodeService.setComnCode(comnCodeVo), HttpStatus.OK);
//	}
//
//	@PreAuthorize(("hasAnyAuthority('ROLE_ADMIN', 'ROLE_ROOT')"))
//	@RequestMapping(value = {"/rmComnCode"}, method = RequestMethod.POST , produces = {"application/json"})
//	public ResponseEntity<Object> rmComnCode(HttpServletRequest request, @RequestParam("cdId") String cdId, ModelMap map) {
//		this.comnCodeService.rmComnCode(cdId);
//		log.info("success deleted comnCode[{}]", cdId);
//		return new ResponseEntity<Object>(HttpStatus.OK);
//	}

}
