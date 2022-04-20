package kr.co.itcall.jte.rms.configuration;

import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class elasticConfig {
	@Value("#{biz['elasticsearch.host']?:''}")
	private String host;
	
	@Value("#{biz['elasticsearch.port']?:''}")
	private int port;
	
	@Bean
	public RestHighLevelClient getRestClient() {
		RestClientBuilder builder = RestClient.builder(new HttpHost(host, port, "http"));
		return new RestHighLevelClient(builder);
	}

}