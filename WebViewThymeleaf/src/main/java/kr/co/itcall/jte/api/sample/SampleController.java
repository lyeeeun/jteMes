package kr.co.itcall.jte.api.sample;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/sample")
public class SampleController {

	@Value("${test.enc.data:}")
	private String cmdLinePwd;

	@Value("${spring.app.enc.test:}")
	private String bootPropertiesPwd;

	@Value("#{app['app.prop.enc.test']?:''}")
	private String appPropertiesPwd;

	@Value("#{biz['biz.prop.enc.test']?:''}")
	private String bizPropertiesPwd;

	@RequestMapping("/FormAndTable")
	@PreAuthorize("isAuthenticated()")
	public String sampleFormAndTable(Model model) {
		model.addAttribute("key", "Object나 특정 값들을 view로 보낼 수 있다.");
		return "sample/FormAndTable";
	}

	@RequestMapping("/angular/drag")
	@PreAuthorize("isAuthenticated()")
	public String sampleDrag(Model model) {
		model.addAttribute("key", "Object나 특정 값들을 view로 보낼 수 있다.");
		return "sample/angular/drag/drag";
	}
	
	@RequestMapping("/menusample")
	@PreAuthorize("isAuthenticated()")
	public String sampleMenu(Model model) {
		model.addAttribute("key", "Object나 특정 값들을 view로 보낼 수 있다.");
		return "elasticsearch/MenuSample";
	}

	@RequestMapping("/{part}/{kind}/{sample}")
	@PreAuthorize("isAuthenticated()")
	public String sampleTransViews(@PathVariable(name="part", required=true) String part
			, @PathVariable(name="kind", required=true) String kind
			, @PathVariable(name="sample", required=true) String sample, Model model) {
		String result = String.format("sample/%s/%s/%s", part, kind, sample);
		model.addAttribute("key", String.format("Object나 특정 값들을 view로 보낼 수 있다. 사용자가 접근한 주소는 \"[%s]\" 이다.",result));
		return result;
	}

}
