package jin.mes.common.msg;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class MsgViewService {

	@Autowired
	private MsgViewRepository msgViewRepository;
	
	public List<MsgViewModel> getMsgView(String msgId, Locale locale){
		return getMsgView(msgId, locale.getLanguage());
	}
	public List<MsgViewModel> getMsgView(String msgId, String langCd){
		List<MsgViewModel> result = new ArrayList<MsgViewModel>();
		if(StringUtils.isEmpty(msgId) && StringUtils.isEmpty(langCd)) {
			result.addAll(this.msgViewRepository.findAll(Sort.by(Order.asc("msgId"), Order.asc("langCd"))));
		} else if(StringUtils.isEmpty(msgId)) {
			result.addAll(this.msgViewRepository.findAllByLangCd(langCd));
		} else if(StringUtils.isEmpty(langCd)) {
			result.addAll(this.msgViewRepository.findByMsgViewPkMsgId(msgId)); 
		} else {
			result.add(this.msgViewRepository.findById(new MsgViewPk(msgId, langCd)).get());
		}
		return result;
	}
	
	public List<MsgViewModel> getMsgViewByLang(Locale locale){
		return getMsgView(null, locale);
	}
	public List<MsgViewModel> getMsgViewByLang(String langCd){
		return getMsgView(null, langCd);
	}
	public List<MsgViewModel> getMsgView(String msgId){
		return getMsgView(msgId, "");
	}

}
