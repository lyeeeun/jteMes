package jin.mes.common.msg;

import java.util.List;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.lang.Nullable;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import jin.mes.common.cache.CacheUtil;
import kr.co.itcall.jte.common.util.CodeUtil;

public class ReloadableResourceBundleMessageSourceFromDatabase extends ReloadableResourceBundleMessageSource {

	private static final int SYS_FLAG_REFLASH_SECONDS = 10 * 60; // 10분.
	private final ConcurrentMap<String, PropertiesHolder> cachedProperties = new ConcurrentHashMap<>();

	@Autowired
	private MsgViewRepository msgViewRepository;

	@Autowired
	private SessionLocaleResolver localeResolver;

	@Override
	protected PropertiesHolder refreshProperties(String filename, @Nullable PropertiesHolder propHolder) {
		if(filename.startsWith("dataSource")) {
			PropertiesHolder propertiesHolder = cachedProperties.get(filename);
			long refreshTimestamp = (getCacheMillis() < 0 ? -1 : System.currentTimeMillis());
			if (propertiesHolder == null || propertiesHolder.getRefreshTimestamp() <= refreshTimestamp) {
				String langCd = filename.substring(filename.indexOf("_") + 1);
				if(StringUtils.isEmpty(langCd)) {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
					langCd = localeResolver.resolveLocale(request).getLanguage();
				}
				if(!StringUtils.isEmpty(langCd)) {
					List<MsgViewModel> msgViewModels = msgViewRepository.findAllByLangCd(langCd);
					Properties properties = new Properties();
					msgViewModels.forEach( m -> properties.put(m.getMsgViewPk().getMsgId(), m.getMsgView()));
					// 캐쉬저장주기 갱신(코드에서 읽어옴)
					// cdNum => cdVal로 통합, 코드 ID sys.flag.reflash -> cacheRefreshTime 변경
					setCacheSeconds(Integer.parseInt(CacheUtil.getCode("cacheRefreshTime", SYS_FLAG_REFLASH_SECONDS).getCdVal()));
					propertiesHolder = new PropertiesHolder(properties, refreshTimestamp + getCacheMillis());
					propertiesHolder.setRefreshTimestamp(refreshTimestamp + getCacheMillis());
					this.cachedProperties.put(filename, propertiesHolder);
					return propertiesHolder;
				}
			} else {
				return propertiesHolder;
			}
		}
		return super.refreshProperties(filename, propHolder);
	}

}
