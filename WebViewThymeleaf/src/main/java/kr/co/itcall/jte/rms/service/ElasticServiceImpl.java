package kr.co.itcall.jte.rms.service;

import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.persistence.Convert;

import org.apache.http.HttpHost;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.bucket.filter.Filter;
import org.elasticsearch.search.aggregations.bucket.histogram.DateHistogramInterval;
import org.elasticsearch.search.aggregations.bucket.histogram.Histogram;
import org.elasticsearch.search.aggregations.metrics.avg.Avg;
import org.elasticsearch.search.aggregations.metrics.sum.Sum;
import org.elasticsearch.search.aggregations.metrics.tophits.TopHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import kr.co.itcall.jte.rms.model.ElasticVO;

@Service
public class ElasticServiceImpl implements ElasticService {

	@Autowired
	private RestHighLevelClient restClient;// 연결정보
	
	private RestHighLevelClient restClient_notimeout = new RestHighLevelClient(RestClient.builder(new HttpHost("ojooy.iptime.org", 9200, "http")).setMaxRetryTimeoutMillis(600000)
			.setRequestConfigCallback(requestConfigBuilder -> requestConfigBuilder.setConnectTimeout(60000)
            .setSocketTimeout(600000)));
	// header
	
	public String GetData_graph(ElasticVO elasticVO) {
		return "";
	}
	@Override
	public String GetData_Header(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		Map<String, String> tempMap = new HashMap<String, String>();
		String jsonResult = "";
		try {
			for (String index : elasticVO.getIndex()) {// index 만큼 반복
				// 검색 조건 설정
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().query(QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())));
				searchSourceBuilder.size(1);
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
				String[] includeFields = elasticVO.getField1();
				String[] excludeFields = new String[] { "column*" };
				searchSourceBuilder.fetchSource(includeFields, excludeFields);
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				SearchRequest searchRequest = new SearchRequest().indices(index).source(searchSourceBuilder);
	
				// 검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
	
				// 검색 처리
				if (searchResponse.getHits().getHits().length != 0) {
					searchResponse.getHits().forEach(source -> {
						// field에 index명이 없어 추가
						source.getSourceAsMap().put("_index", source.getIndex());
						totalList.add(source.getSourceAsMap());
					});
				} else {
					tempMap.put("data_exist", "no_data");
					totalList.add(tempMap);
				}
			}
			// JSON 변환
			Gson gson = new Gson();
			if (!totalList.isEmpty()) {
				jsonResult = gson.toJson(totalList);
			} else {
				jsonResult = "noData";
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// OverView
	@Override
	public String GetData_OverView(ElasticVO elasticVO) {
		// index명:{source:{data},aggs:{...})
		List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("Overview", date_format.format(s_time) + "@@@ Request \r\n");
			
			while (true) {
				// 검색 조건 설정1
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					searchSourceBuilder.query(QueryBuilders.matchAllQuery());
				} else {
					searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())));
				}

				for (String index : elasticVO.getIndex()) {// index 만큼 반복
					// source + aggs를 하나의 map으로 합치기 위함
					Map<String, List> indexMap = new HashMap<String, List>();
					// 검색 조건 설정2
					searchSourceBuilder.size(1);
					String[] includeFields = elasticVO.getField1();
					String[] excludeFields = new String[] { "column*" };
					searchSourceBuilder.fetchSource(includeFields, excludeFields);// 검색 필드, 검색안할 필드
					searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
					searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
					// aggregation
					/*searchSourceBuilder.aggregation(AggregationBuilders.avg("avg_score").field("EA0172")); searchSourceBuilder.aggregation(AggregationBuilders.sum("cnt_score").field("ED1035")); */
					

					SearchRequest searchRequest = new SearchRequest().indices(index).source(searchSourceBuilder);
					SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
					/* String[] start_date = searchResponse.getHits().getHits(); */
					
					// 검색 처리
					List<Map> list = new ArrayList();
					if (searchResponse.getHits().getHits().length != 0) {// 검색결과가 없을 경우 예외처리
						// source
						searchResponse.getHits().forEach(source -> {
							// field에 index명이 없어 추가
							source.getSourceAsMap().put("_index", source.getIndex());
							list.add(source.getSourceAsMap());
						});
						indexMap.put("source", list);
						// aggs
						/* List<Map> list2 = new ArrayList(); list2.add(searchResponse.getAggregations().getAsMap()); indexMap.put("aggs",list2); */
						// source + aggs에 index명 붙여주기

						totalList.add(indexMap);
					}
				}
				// json 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {// 데이터 없는 경우 에외처리
					jsonResult = gson.toJson(totalList);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("Overview", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}
	
	//OverView_MonthlyGraph
	@Override
	public String GetData_OverView_MonthlyGraph(ElasticVO elasticVO) {
		//index명:{source:{data},aggs:{...}) 
		List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {
			while(true) {
				//검색 조건 설정
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
			
				searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())));
				
				searchSourceBuilder.size(0);
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS)); 
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				searchSourceBuilder.aggregation(AggregationBuilders.dateHistogram("agg").field("DATE").dateHistogramInterval(DateHistogramInterval.MONTH)
								.subAggregation(AggregationBuilders.sum("avg_value").field("EA0172"))
								.subAggregation(AggregationBuilders.avg("availability_value").field("EA0145")));
				/* .subAggregation(AggregationBuilders.avg("avg_value").field("EA0126")) */
				
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);
				//검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
				
				//검색 처리
				
				Histogram agg = searchResponse.getAggregations().get("agg");
				
				if(!agg.getBuckets().isEmpty()) {
					for(Histogram.Bucket bucket : agg.getBuckets()) {
						Map<String, String> map = new HashMap<String, String>();
						map.put("montly_date", bucket.getKeyAsString());
						Sum sum = bucket.getAggregations().get("avg_value");
						map.put("montly_load_value", sum.getValueAsString());
						Avg avg = bucket.getAggregations().get("availability_value");
						map.put("montly_availability_value", avg.getValueAsString());
						totalList.add(map);
					}
				}
				//JSON 변환
				Gson gson = new Gson();
				if(!totalList.isEmpty()) {
					jsonResult= gson.toJson(totalList);
					break;
				}else {
					jsonResult="noData";
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult="error";
		}
		return jsonResult;
	}
	
	//EngineStatus - RealValue/ProcessDiagram
	@Override
	public String GetData_EngineStatus(ElasticVO elasticVO) {
		Map<String, Map> totalMap = new HashMap<String, Map>();
		String jsonResult = "";
		try {
			//Log 속도 측정
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("Engine_Status", date_format.format(s_time) + "@@@ Request \r\n");
			while (true) {
				// 검색 조건 설정
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					searchSourceBuilder.query(QueryBuilders.matchAllQuery());
				} else {
					searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
				}
				searchSourceBuilder.size(1);
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);
				String value = elasticVO.getIndex()[0];
				//검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
				
				// 검색 처리
				if (searchResponse.getHits().getHits().length != 0) {
					searchResponse.getHits().forEach(source -> {
						totalMap.put("source", source.getSourceAsMap());
					});
				}
				
				// JSON 변환
				Gson gson = new Gson();
				if (!totalMap.isEmpty()) {
					jsonResult = gson.toJson(totalMap);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("Engine_Status", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// EngineStatus - alarm data
	@Override
	public String GetData_EngineStatus_Alarm(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		Map<String, String> tempMap = new HashMap<String, String>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("Engine_Alarm", date_format.format(s_time) + "@@@ Request \r\n");
			while (true) {
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					searchSourceBuilder.query(QueryBuilders.matchAllQuery());
				} else {
					searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
				}
				for (String index : elasticVO.getIndex()) {// index 만큼 반복
					// 검색 조건 설정
					searchSourceBuilder.size(1);
					searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
					String[] includeFields = elasticVO.getField1();
					String[] excludeFields = new String[] { "column*" };
					searchSourceBuilder.fetchSource(includeFields, excludeFields);
					searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
					searchSourceBuilder.sort(new FieldSortBuilder("_index").order(SortOrder.DESC));
					SearchRequest searchRequest = new SearchRequest().indices(index).source(searchSourceBuilder);
	
					// 검색
					SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
	
					// 검색 처리
					if (searchResponse.getHits().getHits().length != 0) {
						searchResponse.getHits().forEach(source -> {
							source.getSourceAsMap().put("_index", source.getIndex());
							totalList.add(source.getSourceAsMap());
						});
					} else {
						tempMap.put("data_exist", "no_data");
						totalList.add(tempMap);
					}
				}		
					// JSON 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {
					jsonResult = gson.toJson(totalList);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("Engine_Alarm", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}
	
	// ElectricalStatus - overall / MV (Engine)
	@Override
	public String GetData_ElecStatus(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		Map<String, String> tempMap = new HashMap<String, String>();
		String jsonResult = "";
		try {
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("ElecStatus", date_format.format(s_time) + "@@@ Request \r\n");
			while (true) {
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					searchSourceBuilder.query(QueryBuilders.matchAllQuery());
				} else {
					searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
				}
				for (String index : elasticVO.getIndex()) {// index 만큼 반복
					// 검색 조건 설정
					searchSourceBuilder.size(1);
					searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
					String[] includeFields = elasticVO.getField1();
					String[] excludeFields = new String[] { "column*" };
					searchSourceBuilder.fetchSource(includeFields, excludeFields);
					searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
					searchSourceBuilder.sort(new FieldSortBuilder("_index").order(SortOrder.DESC));
					SearchRequest searchRequest = new SearchRequest().indices(index).source(searchSourceBuilder);
	
					// 검색
					SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
	
					// 검색 처리
					if (searchResponse.getHits().getHits().length != 0) {
						searchResponse.getHits().forEach(source -> {
							source.getSourceAsMap().put("_index", source.getIndex());
							totalList.add(source.getSourceAsMap());
						});
					} else {
						tempMap.put("data_exist", "no_data");
						totalList.add(tempMap);
					}
				}		
					// JSON 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {
					jsonResult = gson.toJson(totalList);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("ElecStatus", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// ElectricalStatus - overall / MV (Common)
	// 2019-08-27 AuxEquipment Discription 데이터도 호출(소스 수정 x)
	@Override
	public String GetData_ElecStatus_Common(ElasticVO elasticVO) {
		Map<String, Map> totalMap = new HashMap<String, Map>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("Elec_Common", date_format.format(s_time) + "@@@ Request \r\n");
			// 검색 조건 설정
			SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
			searchSourceBuilder.size(1);
			searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
			searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
			SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);

			// 검색
			SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);

			// 검색 처리
			if (searchResponse.getHits().getHits().length != 0) {
				searchResponse.getHits().forEach(source -> {
					totalMap.put(source.getIndex(), source.getSourceAsMap());
				});
			} 
			// JSON 변환
			Gson gson = new Gson();
			if (!totalMap.isEmpty()) {
				jsonResult = gson.toJson(totalMap);
				//Log 속도 측정
				Date e_time = new Date();
				Log_write("Elec_Common", date_format.format(e_time) + "@@@ Response \r\n");
			} else {
				jsonResult = "noData";
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// ElectricalStatus, AuxEquipmentStatus - LV / AuxEquipment(Common)
	@Override
	public String GetData_Aux_Common(ElasticVO elasticVO) {
		Map<String, Map> totalMap = new HashMap<String, Map>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("Aux_Common", date_format.format(s_time) + "@@@ Request \r\n");
			while (true) {
				// 검색 조건 설정
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					searchSourceBuilder.query(QueryBuilders.matchAllQuery());
				} else {
					searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
				}
				searchSourceBuilder.size(1);
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);

				// 검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);

				// 검색 처리
				if (searchResponse.getHits().getHits().length != 0) {
					searchResponse.getHits().forEach(source -> {
						totalMap.put(source.getIndex(), source.getSourceAsMap());
					});
				}
				// JSON 변환
				Gson gson = new Gson();
				if (!totalMap.isEmpty()) {
					jsonResult = gson.toJson(totalMap);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("Aux_Common", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// EngineAlarm - AlarmList
	@Override
	public String GetData_AlarmList(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("AlarmList", date_format.format(s_time) + "@@@ Request \r\n");
			// 검색 조건 설정
			while (true) {
				BoolQueryBuilder quryBuilders = new BoolQueryBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					// bool - 스코어를 계산하지 않기 때문에 성능이 빠르다.
					quryBuilders = QueryBuilders.boolQuery().filter(QueryBuilders.matchAllQuery());
				} else {
					// bool - 스코어를 계산하지 않기 때문에 성능이 빠르다.
					quryBuilders = QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").lte(elasticVO.getStartTime()));
				}
				// should > or 기능
				for (String shouldField : elasticVO.getField2()) {
					quryBuilders.should(QueryBuilders.matchQuery(shouldField, true));
				}
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().query(quryBuilders);
				searchSourceBuilder.size(elasticVO.getSize());
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
				String[] includeFields = elasticVO.getField1();
				String[] excludeFields = new String[] { "column*" };
				searchSourceBuilder.fetchSource(includeFields, excludeFields);
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);

				// 검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);

				// 검색 처리
				if (searchResponse.getHits().getHits().length != 0) {
					searchResponse.getHits().forEach(source -> {
						// field에 index명이 없어 추가
						source.getSourceAsMap().put("_index", source.getIndex());
						totalList.add(source.getSourceAsMap());
					});
				}

				// JSON 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {
					jsonResult = gson.toJson(totalList);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("AlarmList", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// EngineAlarm - EventRanking
	@Override
	public String GetData_EventRanking(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();

		// List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("EventRanking", date_format.format(s_time) + "@@@ Request \r\n");
			while (true) {
				// 검색 조건 설정
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					searchSourceBuilder.query(QueryBuilders.matchAllQuery());
				} else {
					searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").lte(elasticVO.getStartTime())));
				}
				searchSourceBuilder.size(elasticVO.getSize());
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
				String[] includeFields = elasticVO.getField1();
				/* String[] includeFields = new String[] {"DATE"}; */
				String[] excludeFields = new String[] { "column*" };
				searchSourceBuilder.fetchSource(includeFields, excludeFields);
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);
				// 검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);

				// 검색 처리
				if (searchResponse.getHits().getHits().length != 0) {
					// 검색
					searchResponse.getHits().forEach(source -> {
						source.getSourceAsMap().put("_index", source.getIndex());
						totalList.add(source.getSourceAsMap());
					});
				}
				// JSON 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {
					jsonResult = gson.toJson(totalList);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("EventRanking", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}

	// EngineAlarm - ActionList(추후)
	@Override
	public String GetData_ActionList(ElasticVO elasticVO) {
		Map<String, Map> totalMap = new HashMap<String, Map>();
		String jsonResult = "";

		return jsonResult;
	}

	// TrendView - Engine
	@Override
	public String GetData_EngineTrend(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {
			//속도 측정 위한 Log찍기
			Date s_time = new Date();
			SimpleDateFormat date_format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
			Log_write("EventRanking", date_format.format(s_time) + "@@@ Request \r\n");
			while (true) {
				BoolQueryBuilder quryBuilders = new BoolQueryBuilder();
				if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
					// bool - 스코어를 계산하지 않기 때문에 성능이 빠르다.
					quryBuilders = QueryBuilders.boolQuery().filter(QueryBuilders.matchAllQuery());
				} else {
					// bool - 스코어를 계산하지 않기 때문에 성능이 빠르다.
					quryBuilders = QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime()));
				}
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().query(quryBuilders);
				searchSourceBuilder.size(3600);
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
				String[] includeFields = elasticVO.getField1();
				String[] excludeFields = new String[] { "column*" };
				searchSourceBuilder.fetchSource(includeFields, excludeFields);
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));

				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);

				// 검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);

				// 검색 처리
				if (searchResponse.getHits().getHits().length != 0) {
					searchResponse.getHits().forEach(source -> {
						totalList.add(source.getSourceAsMap());
					});
				}

				// JSON 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {
					jsonResult = gson.toJson(totalList);
					//Log 속도 측정
					Date e_time = new Date();
					Log_write("EventRanking", date_format.format(e_time) + "@@@ Response \r\n");
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}
	
	//loss data 확인용
	@Override
	public String GetData_loss(ElasticVO elasticVO) {
		//index명:{source:{data},aggs:{...}) 
		List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {
			while(true) {
				//검색 조건 설정
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
			
			//	searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())));
				
				searchSourceBuilder.size(0);
				searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS)); 
//				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
//				searchSourceBuilder.aggregation(AggregationBuilders.dateHistogram("agg").field("DATE").dateHistogramInterval(DateHistogramInterval.MONTH)
//								.subAggregation(AggregationBuilders.sum("avg_value").field("EA0172"))
//								.subAggregation(AggregationBuilders.avg("availability_value").field("EA0145")));
				/* .subAggregation(AggregationBuilders.avg("avg_value").field("EA0126")) */
				
				searchSourceBuilder.aggregation(AggregationBuilders.filter("filterByDate", QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte("2019-06-01 00:00:00").lte("2019-06-20 00:00:00")))
						.subAggregation(AggregationBuilders.dateHistogram("aggs").field("DATE").dateHistogramInterval(DateHistogramInterval.minutes(30))));
				
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
				
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);
				//검색
				SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
				
				//검색 처리
				Filter aggs = searchResponse.getAggregations().get("filterByDate");
				Histogram agg = aggs.getAggregations().get("aggs");
				
				if(!agg.getBuckets().isEmpty()) {
					for(Histogram.Bucket bucket : agg.getBuckets()) {
						Map<String, String> map = new HashMap<String, String>();
						map.put("DATE", bucket.getKeyAsString());
						map.put("DOC_COUNT", Long.toString(bucket.getDocCount()));
						totalList.add(map);
					}
				}
				//JSON 변환
				Gson gson = new Gson();
				if(!totalList.isEmpty()) {
					jsonResult= gson.toJson(totalList);
					break;
				}else {
					jsonResult="noData";
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult="error";
		}
		return jsonResult;
	}
	
	// TrendView - EngineTrendPeriod(HGS 장현성 차장님 사용)
	@Override
	public String GetData_EngineTrend_periodically(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		String jsonResult = "";
		try {

			String[] includeFields = elasticVO.getField1(); 
			String[] excludeFields = new String[] { "column*" };
			String[] interval_unit = elasticVO.getField3();
			String[] interval_unit_sec = elasticVO.getField2();
			
			
			while (true) {
				BoolQueryBuilder quryBuilders = new BoolQueryBuilder();
				/*
				 * if (jsonResult == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다. // bool - 스코어를 계산하지
				 * 않기 때문에 성능이 빠르다. quryBuilders =
				 * QueryBuilders.boolQuery().filter(QueryBuilders.matchAllQuery()); } else { //
				 * bool - 스코어를 계산하지 않기 때문에 성능이 빠르다. quryBuilders =
				 * QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(
				 * elasticVO.getStartTime()).lte(elasticVO.getEndTime())); }
				 */
				/*
				String StartTime = elasticVO.getStartTime();
			    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    int i = 0;
				while(i < 500) { 
			    Calendar cal = Calendar.getInstance();
			    Date date = format.parse(StartTime);
			    cal.setTime(date);
			    cal.add(Calendar.HOUR, -1); // 분을 더한다
			    */
				//SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
				SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().query(quryBuilders);
				
				//searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", format.format(cal.getTime()))));
				searchSourceBuilder.size(1);
			
				/**/
				searchSourceBuilder.fetchSource(includeFields, excludeFields); 
				searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));

				if(interval_unit[0].equals("sec")) {
					searchSourceBuilder.aggregation(AggregationBuilders.filter("filterByDate", QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())))
							.subAggregation(AggregationBuilders.dateHistogram("aggs").field("DATE").dateHistogramInterval(DateHistogramInterval.seconds(Integer.parseInt(interval_unit_sec[0]))).subAggregation(AggregationBuilders.topHits("Viwers").size(1).sort("DATE").fetchSource(includeFields,excludeFields))));
				} else if(interval_unit[0].equals("min")) {
					searchSourceBuilder.aggregation(AggregationBuilders.filter("filterByDate", QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())))
							.subAggregation(AggregationBuilders.dateHistogram("aggs").field("DATE").dateHistogramInterval(DateHistogramInterval.minutes(Integer.parseInt(interval_unit_sec[0])/60)).subAggregation(AggregationBuilders.topHits("Viwers").size(1).sort("DATE").fetchSource(includeFields,excludeFields))));
				} else if(interval_unit[0].equals("hour")) {
					searchSourceBuilder.aggregation(AggregationBuilders.filter("filterByDate", QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())))
							.subAggregation(AggregationBuilders.dateHistogram("aggs").field("DATE").dateHistogramInterval(DateHistogramInterval.hours(Integer.parseInt(interval_unit_sec[0])/60/60)).subAggregation(AggregationBuilders.topHits("Viwers").size(1).sort("DATE").fetchSource(includeFields,excludeFields))));
				} else if(interval_unit[0].equals("day")) {
					searchSourceBuilder.aggregation(AggregationBuilders.filter("filterByDate", QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())))
							.subAggregation(AggregationBuilders.dateHistogram("aggs").field("DATE").dateHistogramInterval(DateHistogramInterval.days(Integer.parseInt(interval_unit_sec[0])/60/60/24)).subAggregation(AggregationBuilders.topHits("Viwers").size(1).sort("DATE").fetchSource(includeFields,excludeFields))));
				} else {
					searchSourceBuilder.aggregation(AggregationBuilders.filter("filterByDate", QueryBuilders.boolQuery().filter(QueryBuilders.rangeQuery("DATE").gte(elasticVO.getStartTime()).lte(elasticVO.getEndTime())))
							.subAggregation(AggregationBuilders.dateHistogram("aggs").field("DATE").dateHistogramInterval(DateHistogramInterval.days(1)).subAggregation(AggregationBuilders.topHits("Viwers").size(1).sort("DATE").fetchSource(includeFields,excludeFields))));
				}
			/* searchSourceBuilder.timeout(new TimeValue(600, TimeUnit.SECONDS)); */

				/*.aggregation(AggregationBuilders.dateHistogram("agg").field("DATE").dateHistogramInterval(DateHistogramInterval.MONTH)
						.subAggregation(AggregationBuilders.sum("avg_value").field("EA0172"))
						.subAggregation(AggregationBuilders.avg("availability_value").field("EA0145")));*/
				
				SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);

				// 검색
				SearchResponse searchResponse = restClient_notimeout.search(searchRequest, RequestOptions.DEFAULT);
				/*
				if (searchResponse.getHits().getHits().length != 0) {
					searchResponse.getHits().forEach(source -> {
					totalList.add(source.getSourceAsMap()); }); }
				*/
				
				/*
				StartTime = format.format(cal.getTime()).toString();
				i++;
				*/
				//}
				// 검색 처리
				
				Filter aggs = searchResponse.getAggregations().get("filterByDate");
				Histogram agg = aggs.getAggregations().get("aggs");
				
				if(!agg.getBuckets().isEmpty()) {
					for(Histogram.Bucket bucket : agg.getBuckets()) {
						TopHits tophits = bucket.getAggregations().get("Viwers");
						if(tophits.getHits().getHits().length != 0) {
							tophits.getHits().forEach(source -> {
								totalList.add(source.getSourceAsMap()); }); 
						}
					}
				}
				
				// JSON 변환
				Gson gson = new Gson();
				if (!totalList.isEmpty()) {
					jsonResult = gson.toJson(totalList);
					break;
				} else {
					if (jsonResult == "noData") {// 최신데이터도 없는 경우
						break;
					} else {
						jsonResult = "noData";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult = "error";
		}
		return jsonResult;
	}
	
	//PMS - RunningHour구하기
	@Override
	public Map<String,Map> GetData_RunningHour(ElasticVO elasticVO) {
		Map<String,Map> resultMap = new HashMap<String, Map>();
		
		try {
			for(String indexName: elasticVO.getIndex()) {
				String searchData = "";
				while (true) {
					
					
					// 검색 조건 설정
					SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
					if (searchData == "noData") {// 데이터가 없는 경우 최신데이터를 조회한다.
						searchSourceBuilder.query(QueryBuilders.matchAllQuery());
					} else {
						searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
					}
					searchSourceBuilder.size(1);
					searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
					String[] includeFields = elasticVO.getField1();
					String[] excludeFields = new String[] { "column*" };
					searchSourceBuilder.fetchSource(includeFields, excludeFields);
					searchSourceBuilder.sort(new FieldSortBuilder("DATE").order(SortOrder.DESC));
					SearchRequest searchRequest = new SearchRequest().indices(indexName).source(searchSourceBuilder);

					//검색
					SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
					// 검색 처리
					if (searchResponse.getHits().getHits().length != 0) {
						searchResponse.getHits().forEach(source -> {
							resultMap.put(indexName, source.getSourceAsMap());
						});
					}
					
					if (resultMap.get(indexName) == null) {
						searchData = "noData";
					} else {
						break;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	//reportData - DataDownload 데이터 
	@Override
	public List<Map> GetData_DataDownload(ElasticVO elasticVO) {
		List<Map> totalList = new ArrayList<Map>();
		try {
			String searchData = "";
			// 검색 조건 설정
			SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
			searchSourceBuilder.query(QueryBuilders.boolQuery().filter(QueryBuilders.matchQuery("DATE", elasticVO.getStartTime())));
			//searchSourceBuilder.size(1);
			searchSourceBuilder.timeout(new TimeValue(30, TimeUnit.SECONDS));
			String[] includeFields = elasticVO.getField1();
			String[] excludeFields = new String[] { "column*" };
			searchSourceBuilder.fetchSource(includeFields, excludeFields);
			searchSourceBuilder.sort(new FieldSortBuilder("_index").order(SortOrder.ASC));
			SearchRequest searchRequest = new SearchRequest().indices(elasticVO.getIndex()).source(searchSourceBuilder);

			//검색
			SearchResponse searchResponse = restClient.search(searchRequest, RequestOptions.DEFAULT);
			// 검색 처리
			if (searchResponse.getHits().getHits().length != 0) {
				searchResponse.getHits().forEach(source -> {
					// field에 index명이 없어 추가
					if(!source.getIndex().equals("common01")) {
						source.getSourceAsMap().put("_index", source.getIndex());
					}
					totalList.add(source.getSourceAsMap());
				});
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalList;
	}
	
	public static void Log_write(String fileName, String txt) {
		
		// 파일 객체 생성
        File file = new File("D:\\" + fileName + ".txt");
        
        try {
        // true 지정시 파일의 기존 내용에 이어서 작성
        FileWriter fw = new FileWriter(file, true) ;
         
        // 파일안에 문자열 쓰기
        fw.write(txt);
        fw.flush();

        // 객체 닫기
        fw.close();
        } catch(Exception e) {
        	e.printStackTrace();
        }
	}
}
