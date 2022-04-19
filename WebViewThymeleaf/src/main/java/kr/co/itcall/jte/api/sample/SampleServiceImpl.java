package kr.co.itcall.jte.api.sample;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.itcall.jte.util.RestClient;

@Service
public class SampleServiceImpl implements SampleService {

	@Resource
	private MessageSourceAccessor messageSourceAccessor;

	@SuppressWarnings("unchecked")
	@Override
	public Object doRestCall(String url, Object params) {
		String result = RestClient.postForObject(url, params);
		Map<String, Object> map = new ObjectMapper().convertValue(result, Map.class);
		map.put("result.msg", messageSourceAccessor.getMessage("test.msg", new String[] {"1stParam","2stParam"}));
		return map;
	}

}
