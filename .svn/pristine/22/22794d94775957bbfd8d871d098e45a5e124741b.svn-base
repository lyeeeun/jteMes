package kr.co.itcall.jte.spring.config.web.listener;

import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

import kr.co.itcall.jte.common.code.ComnCodeService;
import kr.co.itcall.jte.common.code.repository.ComnCodeRepository;
import kr.co.itcall.jte.common.util.CodeUtil;
import lombok.extern.slf4j.Slf4j;

/********************************************************
 * ServletContext가 로드된 후 수행되는 리스너.
 * @Primay등으로 선언된것들을 포함하여 필수 컨테이너가
 * 로드된 이후 호출된다.
 * 즉, ServletContext가 생성된 후 호출된다.
 * Application이 모두 로드된(완성된) 이후 수행하고자 하는 
 * 로직들은 ApplicationListener에서 구현해야한다.
 * 여기는 업무로직 전 먼저 수행하고자 하는 로직을 구현한다.
 * ServletContext > 
 * @author 91094035
 ********************************************************/
@Slf4j
@Component("JteApplicationListener")
//@Configuration
//@WebListener("JteApplicationListener") // 이건 WebListener가 아니므로 에러가 발생한다.
public class JteApplicationListener implements ApplicationListener<ApplicationReadyEvent> {

	@Resource
	private ApplicationContext ctx;

	@Resource
	private MessageSource messageSource;
	@Resource
	private MessageSourceAccessor messageSourceAccessor;

	@Autowired
	private ComnCodeRepository codeRepository;
	@Autowired
	private ComnCodeService comnCodeService;

	@Override
	public void onApplicationEvent(ApplicationReadyEvent event) {

		log.info("JteApplicationListener.Started");

		/*** 최초 로드될때 현재 this오브젝트에 Container참조 개체를 주입한다. ***/
		if(this.ctx==null) {
			AutowireCapableBeanFactory autowireCapableBeanFactory = event.getApplicationContext().getAutowireCapableBeanFactory();
			autowireCapableBeanFactory.autowireBean(this);
		}

		// 환경초기화...

		log.info("initializeCacheManager Before loading...");
		// Cache등의 로딩...
		log.info("initializeCacheManager After loaded... CacheList[{}]", "Ecache에 대한 설정이 필요함.");


		log.info("MessageSource Test ::: test.msg[{}], test.msg for LocaleEn[{}], test.msg for Accessor[{}]"
				, messageSource.getMessage("test.msg", new Object[] {"1번인수", "2번인수"}, "메시지를 찾지 못했습니다.", Locale.getDefault())
				, messageSource.getMessage("test.msg", new Object[] {"1번인수", "2번인수"}, "메시지를 찾지 못했습니다.", Locale.ENGLISH)
				, messageSourceAccessor.getMessage("test.msg", new String[] {"1번인수", "2번인수"}, "메시지를 찾지 못했습니다."));
		log.info("MessageSource.CANADA ::: test.msg[{}]", messageSource.getMessage("test.msg", new String[] {"1번인수", "2번인수"}, Locale.CANADA));
		log.info("MessageSource.KOREA ::: test.msg[{}]", messageSource.getMessage("test.msg", new String[] {"1번인수", "2번인수"}, Locale.KOREA));
		log.info("MessageSource.KOREAN ::: test.msg[{}]", messageSource.getMessage("test.msg", new String[] {"1번인수", "2번인수"}, Locale.KOREAN));

		log.info("MessageSource.CANADA ::: fmcs.logoutMsg[{}]", messageSource.getMessage("fmcs.logoutMsg", new String[] {"1번인수", "2번인수"}, Locale.CANADA));
		log.info("MessageSource.KOREA ::: fmcs.logoutMsg[{}]", messageSource.getMessage("fmcs.logoutMsg", new String[] {"1번인수", "2번인수"}, Locale.KOREA));
		log.info("MessageSource.KOREAN ::: fmcs.logoutMsg[{}]", messageSource.getMessage("fmcs.logoutMsg", new String[] {"1번인수", "2번인수"}, Locale.KOREAN));
		log.info("MessageSource.ENGLISH ::: fmcs.logoutMsg[{}]", messageSource.getMessage("fmcs.logoutMsg", new String[] {"1번인수", "2번인수"}, Locale.ENGLISH));

		log.info("MessageSource.CANADA ::: fmcs.wellcome[{}]", messageSource.getMessage("fmcs.wellcome", new String[] {"1번인수", "2번인수"}, Locale.CANADA));
		log.info("MessageSource.KOREA ::: fmcs.wellcome[{}]", messageSource.getMessage("fmcs.wellcome", new String[] {"1번인수", "2번인수"}, Locale.KOREA));
		log.info("MessageSource.KOREAN ::: fmcs.wellcome[{}]", messageSource.getMessage("fmcs.wellcome", new String[] {"1번인수", "2번인수"}, Locale.KOREAN));
		log.info("MessageSource.ENGLISH ::: fmcs.wellcome[{}]", messageSource.getMessage("fmcs.wellcome", new String[] {"1번인수", "2번인수"}, Locale.ENGLISH));

//		log.info("코드정보를 읽어옵니다. sys.flag 코드조회(캐쉬되지 않음)[{}]",comnCodeService.getComnCode("sys.flag"));
		log.info("코드정보를 읽어옵니다. Root코드리스트 조회(캐쉬되지 않음)[{}]",codeRepository.findByUpCdIdNull());
//		log.info("코드정보를 읽어옵니다. blank코드 조회(캐쉬)[{}]",CodeUtil.getCode("blank", "test.blank없음."));
//		log.info("코드정보를 읽어옵니다. sys코드 조회(캐쉬)[{}]",CodeUtil.getCode("sys", "sys없음."));
//		log.info("코드정보를 읽어옵니다. sys.flag코드 조회(캐쉬)[{}]",CodeUtil.getCode("sys.flag", "sys.flag없음"));
//		log.info("코드정보를 읽어옵니다. cacheRefreshTime코드 조회(캐쉬)[{}]",CodeUtil.getCode("cacheRefreshTime", 1235));
//
//		log.info("코드정보를 읽어옵니다. blank코드 조회(캐쉬)[{}]",CodeUtil.getCode("blank", "test.blank없음."));
//		log.info("코드정보를 읽어옵니다. sys코드 조회(캐쉬)[{}]",CodeUtil.getCode("sys", "sys없음."));
//		log.info("코드정보를 읽어옵니다. sys.flag코드 조회(캐쉬)[{}]",CodeUtil.getCode("sys.flag", "sys.flag없음"));
//		log.info("코드정보를 읽어옵니다. cacheRefreshTime코드 조회(캐쉬)[{}]",CodeUtil.getCode("cacheRefreshTime", 2325));

		log.info("JteApplicationListener.Ended ======= Ready to Server...");


//		ComnCodeVo codeVo = new ComnCodeVo("rms", "rms", "Y", "rms", "rms", "", 1, "Hi-TIMMS의 회사구분 코드");
//		comnCodeService.addComnCode(codeVo);
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia", "rms.Columbia", "Y", "Columbia", "Columbia", "", 1, "콜롬비아", "rms"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia", "rms.Columbia.Axia", "Y", "Axia", "Axia", "", 1, "콜롬비아의 Axia회사", "rms.Columbia"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte", "rms.Columbia.Axia.Termonorte", "Y", "Termonorte", "Termonorte", "", 1, "콜롬비아.Axia회사.Termonorte지역", "rms.Columbia.Axia"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.model", "rms.Columbia.Axia.Termonorte.model", "Y", "Model", "Model", "", 1, "콜롬비아.Axia회사.Termonorte지역.엔진모델", "rms.Columbia.Axia.Termonorte"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.model.20H35DFV", "rms.Columbia.Axia.Termonorte.model.20H35DFV", "Y", "20H35DFV", "20H35DFV", "", 1, "콜롬비아.Axia회사.Termonorte지역.엔진모델.20H35DFV", "rms.Columbia.Axia.Termonorte.model"));
//								// 추가되는 모델은 여기에 계속 넣으면 된다. 대부분의 엔진모델은 하나다.
//								//...
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine", "rms.Columbia.Axia.Termonorte.engine", "Y", "Engine", "Engine", "", 2, "콜롬비아.Axia회사.Termonorte지역.설치엔진순번(고유번호)", "rms.Columbia.Axia.Termonorte"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no01", "rms.Columbia.Axia.Termonorte.engine.no01", "Y", "No1.Engine", "No1.Engine", "", 1, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No1.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no02", "rms.Columbia.Axia.Termonorte.engine.no02", "Y", "No1.Engine", "No2.Engine", "", 2, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No2.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no03", "rms.Columbia.Axia.Termonorte.engine.no03", "Y", "No1.Engine", "No3.Engine", "", 3, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No3.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no04", "rms.Columbia.Axia.Termonorte.engine.no04", "Y", "No1.Engine", "No4.Engine", "", 4, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No4.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no05", "rms.Columbia.Axia.Termonorte.engine.no05", "Y", "No1.Engine", "No5.Engine", "", 5, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No5.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no06", "rms.Columbia.Axia.Termonorte.engine.no06", "Y", "No1.Engine", "No6.Engine", "", 6, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No6.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no07", "rms.Columbia.Axia.Termonorte.engine.no07", "Y", "No1.Engine", "No7.Engine", "", 7, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No7.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no08", "rms.Columbia.Axia.Termonorte.engine.no08", "Y", "No1.Engine", "No8.Engine", "", 8, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No8.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no09", "rms.Columbia.Axia.Termonorte.engine.no09", "Y", "No1.Engine", "No9.Engine", "", 9, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No9.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no10", "rms.Columbia.Axia.Termonorte.engine.no10", "Y", "No10.Engine", "No10.Engine", "", 10, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No10.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//
//
//
//		log.debug("comnCodeService.getComnCodeList(null, null) = [{}]", this.comnCodeService.getComnCodeList(null, null));
//		log.debug("comnCodeService.getActivedComnCd(\"menu.OperMgt\") = [{}]", this.comnCodeService.getActivedComnCd("menu.OperMgt"));
//		log.debug("comnCodeService.getActivedComnCd(\"rms.Columbia.Axia.Termonorte.engine\") = [{}]", this.comnCodeService.getActivedComnCd("rms.Columbia.Axia.Termonorte.engine"));

	}

}
