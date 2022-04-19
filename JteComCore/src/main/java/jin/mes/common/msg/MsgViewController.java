package jin.mes.common.msg;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;

/**
 * <pre>
 * <b>jin.mes.common.msg</b>
 * <b>MsgViewController.java</b>
 * <p>Descriptions : 단순 언어별 메시지 조회는 공통 MessageSourceController를 사용한다. 여기서는 메시지.저장DB의 CRUD에 대해서 관리한다.</p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 12. 8.
 * @Version :
 */
@Controller
@RequestMapping("/common/msg")
public class MsgViewController extends BaseController {


}
