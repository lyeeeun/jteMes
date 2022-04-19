package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtMapper;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.ZinixWrkinWrkerMgtMapper;
import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.common.cache.CacheUtil;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//defalut
@Service
public class ZinixMfgplanService{
	
	@Resource
	ZinixMfgplanMapper zinixPlanMapper;
	
	@Resource
	ZinixWrkinTeamMgtMapper zinixWrkinTeamMgtMapper;
	
	@Resource
	ZinixWrkinWrkerMgtMapper zinixWrkinWrkerMgtMapper;
	
	@Autowired AlarmMgtService alarmMgtService; 
	
	
	public PageInfo<ZinixMfgplanDto> getMonthPlanList(ZinixMfgplanDto planDto, PageRequestVo pageRequestVo){
		List<ZinixMfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixPlanMapper.selectMonthPlanListCount(planDto);
			if (rowCount > 0) {
				//List
				planList = zinixPlanMapper.selectMonthPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("연간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<ZinixMfgplanDto>();
		}
		return new PageInfo<ZinixMfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<ZinixMfgplanDto> getDayPlanList(ZinixMfgplanDto planDto, PageRequestVo pageRequestVo){
		List<ZinixMfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixPlanMapper.selectDayPlanListCount(planDto);
			if (rowCount > 0) {
				//List
				planList = zinixPlanMapper.selectDayPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<ZinixMfgplanDto>();
		}
		return new PageInfo<ZinixMfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<ZinixProductPlanDto> getPlanDetail(ZinixProductPlanDto productPlanDto, PageRequestVo pageRequestVo){
		List<ZinixProductPlanDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		productPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		productPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = zinixPlanMapper.selectPlanDetail(productPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<ZinixProductPlanDto>();
		}
		return new PageInfo<ZinixProductPlanDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	
	public String setPlanCnt(ZinixProductPlanDto productPlanDto){
		String returnKey = "";
		try {
			productPlanDto.setCreatorId(JteUtils.getUserId());
			productPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(productPlanDto.getAction().equals("C")) { 
				zinixPlanMapper.insertPlanCnt(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}else if(productPlanDto.getAction().equals("U")){ 
				zinixPlanMapper.updatePlanCnt(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//일괄처리 가능여부 조회
	
	public ZinixProductPlanDto getBulkPos(ZinixProductPlanDto productPlanDto){
		ZinixProductPlanDto bulkDto = null;
		try {
			if(productPlanDto.getProdPlanType().equals("prod_plan01")) { 
				bulkDto = zinixPlanMapper.selectBulkMonthPos(productPlanDto);
			}else if(productPlanDto.getProdPlanType().equals("prod_plan02")){ 
				bulkDto = zinixPlanMapper.selectBulkDayPos(productPlanDto);
			}
		} catch (Exception e) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + e.getMessage());
		}
		
		return bulkDto;
	}
	
	//일괄처리 저장
	@Transactional
	
	public String setBulkSave(ZinixProductPlanDto productPlanDto){
		String returnKey = "";
		ZinixProductPlanDto insertPlanDto = null;
		try {
			//월간등록인 경우
			if(productPlanDto.getProdPlanType().equals("prod_plan01")) {
				
				//기준날짜에 등록된 데이터가 있는지 조회
				ZinixWrkinTeamMgtDto bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
				bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
				List<ZinixWrkinTeamMgtDto> planList = zinixWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
				if(planList.size() > 0) {
					//조회한 데이터 담기
					ZinixWrkinTeamMgtDto planDto = planList.get(0);
					if(productPlanDto.getBulkPeriodYN().equals("N")) {//기간 자동등록
						int calcPlanCnt = 0;
						boolean loopYN = false;
						calcPlanCnt = zinixPlanMapper.selectBulkPlanCnt(productPlanDto);
						if(calcPlanCnt > 0) {
							loopYN = true;
						}
						
						//기준일
						DateFormat df = new SimpleDateFormat("yyyy-MM");
						Date stdt = df.parse(productPlanDto.getBaseDate());
						Calendar calStdt = Calendar.getInstance();
						calStdt.setTime(stdt);
						calStdt.add(Calendar.MONTH, 1);
						
						//기간내 날짜에 등록
						while(loopYN){
							int planCnt = 0;
							
							if(calcPlanCnt < planDto.getProdPlanQty()) {
								planCnt = calcPlanCnt; 
							}else {
								planCnt = planDto.getProdPlanQty();
							}
							
							String strStdt = df.format(calStdt.getTime());
							String[] baseDate = strStdt.split("-");
							
							//데이터가 등록되어 있는지 조회
							productPlanDto.setBulkStdt(strStdt);
							productPlanDto.setBulkEddt(strStdt);
							ZinixProductPlanDto bulkQtyDto = zinixPlanMapper.selectBulkMonthPeriod(productPlanDto);
							
							//데이터가 이미 등록되어 있다면 강제 예외처리
							if(bulkQtyDto.getPlanCnt() != 0) {
								returnKey = "bulk_plan_err02";
								throw new Exception();
							}
							
							//월간 생산계획 생성자
							insertPlanDto = new ZinixProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
									null, planCnt, planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
							
							//생산계획 등록
							zinixPlanMapper.insertPlanCnt(insertPlanDto);
							
							calcPlanCnt = zinixPlanMapper.selectBulkPlanCnt(productPlanDto);
							
							if(calcPlanCnt <= 0) {
								loopYN = false;
							}
							//시작날짜 + 1개월
							calStdt.add(Calendar.MONTH, 1);
						}
						returnKey = "success";
					}else {//기간직접입력
						//기간내에 등록된 데이터가 있는지 조회
						ZinixProductPlanDto bulkQtyDto = zinixPlanMapper.selectBulkMonthPeriod(productPlanDto);
						if(bulkQtyDto.getPlanCnt() == 0) {
							
							//시작날짜  ~ 종료날짜 사이에 날짜를 구하기 위함
							DateFormat df = new SimpleDateFormat("yyyy-MM");
							Date stdt = df.parse(productPlanDto.getBulkStdt());
							Date eddt = df.parse(productPlanDto.getBulkEddt());
							Calendar calStdt = Calendar.getInstance();
							calStdt.setTime(stdt);
							Calendar calEddt = Calendar.getInstance();
							calEddt.setTime(eddt);
							
							//기간내 날짜에 등록
							while(calStdt.compareTo( calEddt ) !=1 ){
								String strStdt = df.format(calStdt.getTime());
								String[] baseDate = strStdt.split("-");
								//월간 생산계획 생성자
								insertPlanDto = new ZinixProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
										null, planDto.getProdPlanQty(), planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
								
								//생산계획 등록
								zinixPlanMapper.insertPlanCnt(insertPlanDto);
								insertPlanDto.getProdPlanId();
								
								//시작날짜 + 1개월
								calStdt.add(Calendar.MONTH, 1);
							}
							returnKey = "success";
						}else {
							returnKey = "bulk_plan_err02";
							throw new Exception();
						}
					}
				}else {
					returnKey = "bulk_plan_err01";
					throw new Exception();
				}
				
			//일간등록인경우
			}else if(productPlanDto.getProdPlanType().equals("prod_plan02")){
				
				//기준날짜에 등록된 데이터가 있는지 조회
				ZinixWrkinTeamMgtDto bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
				bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
				List<ZinixWrkinTeamMgtDto> planList = zinixWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
				
				if(planList.size() > 0) {
					//조회한 데이터 담기
					ZinixWrkinTeamMgtDto planDto = planList.get(0);
				
						if(productPlanDto.getBulkPeriodYN().equals("N")) {//기간 자동등록
							int calcPlanCnt = 0;
							boolean loopYN = false;
							calcPlanCnt = zinixPlanMapper.selectBulkPlanCnt(productPlanDto);
							if(calcPlanCnt > 0) {
								loopYN = true;
							}
							
							//기준일
							DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
							Date stdt = df.parse(productPlanDto.getBaseDate());
							Calendar calStdt = Calendar.getInstance();
							calStdt.setTime(stdt);
							calStdt.add(Calendar.DATE, 1);
							
							//기간내 날짜에 등록
							while(loopYN){
								if(calStdt.get(Calendar.DAY_OF_WEEK) != 1) {//일요일 제외
									int planCnt = 0;
									
									if(calcPlanCnt < planDto.getProdPlanQty()) {
										planCnt = calcPlanCnt; 
									}else {
										planCnt = planDto.getProdPlanQty();
									}
									
									String strStdt = df.format(calStdt.getTime());
									String[] baseDate = strStdt.split("-");
									
									//데이터가 등록되어 있는지 조회
									productPlanDto.setBulkStdt(strStdt);
									productPlanDto.setBulkEddt(strStdt);
									ZinixProductPlanDto bulkQtyDto = zinixPlanMapper.selectBulkMonthPeriod(productPlanDto);
									
									//데이터가 이미 등록되어 있다면 강제 예외처리
									if(bulkQtyDto.getPlanCnt() != 0) {
										returnKey = "bulk_plan_err02";
										throw new Exception();
									}
									
									//일간 생산계획 생성자
									insertPlanDto = new ZinixProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
											baseDate[2], planCnt, planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
									
									//생산계획 등록
									zinixPlanMapper.insertPlanCnt(insertPlanDto);
									
									//체크박스에 생산지시가 체크되어 있을때만 실행
									if(Arrays.asList(productPlanDto.getBulkTarget()).contains("asgn")) {
										//해당 날짜에 등록된 데이터가 있는지 조회(생산지시)
										bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
										bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
										bulkSearchPrmt.setAction("asgn");
										List<ZinixWrkinTeamMgtDto> asgnList = zinixWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
										
										for(ZinixWrkinTeamMgtDto asgnDto : asgnList) {
											
											//생산지시 생성자
											ZinixWrkinTeamMgtDto insertAsgnDto = new ZinixWrkinTeamMgtDto(null, asgnDto.getProdAsmNm(), strStdt, String.valueOf(planCnt), 
													asgnDto.getProdAsmDesc(), asgnDto.getProdAsmUser(), asgnDto.getProdAsmEmj(), asgnDto.getProdAsmState(),
													JteUtils.getUserId(), asgnDto.getDeptId(), insertPlanDto.getProdPlanId(), asgnDto.getLotId());
											//생성지시 등록
											zinixWrkinTeamMgtMapper.insertAsgn(insertAsgnDto);
											
											//체크박스에 작업지시가 체크되어 있을때만 실행
											if(Arrays.asList(productPlanDto.getBulkTarget()).contains("work")) {
												//해당 날짜에 등록된 데이터가 있는지 조회(작업지시)
												bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
												bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
												bulkSearchPrmt.setProdAsmId(asgnDto.getProdAsmId());
												bulkSearchPrmt.setAction("work");
												List<ZinixWrkinTeamMgtDto> workList = zinixWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
												for(ZinixWrkinTeamMgtDto workDto : workList) {
													ZinixWrkinTeamMgtDto insertWorkDto = new ZinixWrkinTeamMgtDto(insertAsgnDto.getProdAsmId(), insertPlanDto.getProdPlanId(),
															workDto.getLotId(), null, workDto.getRoutingId(), workDto.getEqmtMgtId(), workDto.getProdWorkUser(),
															String.valueOf(planCnt), workDto.getProdWorkDesc());
													zinixWrkinWrkerMgtMapper.insertProdWork(insertWorkDto);
													
													//알람관련
													if(CacheUtil.getCode("alarmYN").getCdVal().equals("Y")) {
														BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_mfgplan_C");
														if(alarmBCD.getUseYn().equals("Y")) {
															SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
															Date alarmDate = format1.parse(strStdt);
															String reserveDate = format1.format(alarmDate) + " " + alarmBCD.getCdReserve04();
															AlarmMgtDto alarmMgtDto = new AlarmMgtDto(alarmBCD.getCdId(), insertWorkDto.getProdWorkId(), String.format(alarmBCD.getCdReserve01(),""),
																	String.format(alarmBCD.getCdReserve02(),insertWorkDto.getProdWorkId()), alarmBCD.getCdReserve03(), JteUtils.getUserId(), reserveDate,
																	asgnDto.getProdWorkUser(), "NEW", null, JteUtils.getUserId());
															
															alarmMgtDto.setAction("C");
															//생산계획 알람등록
															alarmMgtService.setAlarmMgt(alarmMgtDto);
														}
													}
												}
											}
										}
									}
								}
								calcPlanCnt = zinixPlanMapper.selectBulkPlanCnt(productPlanDto);
								if(calcPlanCnt <= 0) {
									loopYN = false;
								}
								//시작날짜 + 1일
								calStdt.add(Calendar.DATE, 1);
							}
							returnKey = "success";
						}else {//기간직접입력
							//기간내에 등록된 데이터가 있는지 조회
							ZinixProductPlanDto bulkQtyDto = zinixPlanMapper.selectBulkDayPeriod(productPlanDto);
							
							// 생산계획/생산지시/작업지시 체크박스에 따른 확인
							int totalQty = bulkQtyDto.getPlanCnt();
							if(Arrays.asList(productPlanDto.getBulkTarget()).contains("asgn")) { totalQty += bulkQtyDto.getAsgnCnt(); }
							if(Arrays.asList(productPlanDto.getBulkTarget()).contains("work")) { totalQty += bulkQtyDto.getWorkCnt(); }
							
							if(totalQty == 0) {
								//시작날짜  ~ 종료날짜 사이에 날짜를 구하기 위함
								DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
								Date stdt = df.parse(productPlanDto.getBulkStdt());
								Date eddt = df.parse(productPlanDto.getBulkEddt());
								Calendar calStdt = Calendar.getInstance();
								calStdt.setTime(stdt);
								Calendar calEddt = Calendar.getInstance();
								calEddt.setTime(eddt);
								
								//기간내 날짜에 등록
								while(calStdt.compareTo( calEddt ) !=1 ){
									if(calStdt.get(Calendar.DAY_OF_WEEK) != 1) {//일요일 제외
										String strStdt = df.format(calStdt.getTime());
										String[] baseDate = strStdt.split("-");
										//일간 생산계획 생성자
										insertPlanDto = new ZinixProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
												baseDate[2], planDto.getProdPlanQty(), planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
										
										//생산계획 등록
										zinixPlanMapper.insertPlanCnt(insertPlanDto);
										
										//체크박스에 생산지시가 체크되어 있을때만 실행
										if(Arrays.asList(productPlanDto.getBulkTarget()).contains("asgn")) {
											//해당 날짜에 등록된 데이터가 있는지 조회(생산지시)
											bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
											bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
											bulkSearchPrmt.setAction("asgn");
											List<ZinixWrkinTeamMgtDto> asgnList = zinixWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
											
											for(ZinixWrkinTeamMgtDto asgnDto : asgnList) {
												//생산지시 생성자
												ZinixWrkinTeamMgtDto insertAsgnDto = new ZinixWrkinTeamMgtDto(null, asgnDto.getProdAsmNm(), strStdt, asgnDto.getProdAsmQty(), 
														asgnDto.getProdAsmDesc(), asgnDto.getProdAsmUser(), asgnDto.getProdAsmEmj(), asgnDto.getProdAsmState(),
														JteUtils.getUserId(), asgnDto.getDeptId(), insertPlanDto.getProdPlanId(), asgnDto.getLotId());
												//생성지시 등록
												zinixWrkinTeamMgtMapper.insertAsgn(insertAsgnDto);
												
												//체크박스에 작업지시가 체크되어 있을때만 실행
												if(Arrays.asList(productPlanDto.getBulkTarget()).contains("work")) {
													//해당 날짜에 등록된 데이터가 있는지 조회(작업지시)
													bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
													bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
													bulkSearchPrmt.setProdAsmId(asgnDto.getProdAsmId());
													bulkSearchPrmt.setAction("work");
													List<ZinixWrkinTeamMgtDto> workList = zinixWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
													for(ZinixWrkinTeamMgtDto workDto : workList) {
														ZinixWrkinTeamMgtDto insertWorkDto = new ZinixWrkinTeamMgtDto(insertAsgnDto.getProdAsmId(), insertPlanDto.getProdPlanId(),
																workDto.getLotId(), null, workDto.getRoutingId(), workDto.getEqmtMgtId(), workDto.getProdWorkUser(),
																workDto.getProdWorkQty(), workDto.getProdWorkDesc());
														zinixWrkinWrkerMgtMapper.insertProdWork(insertWorkDto);
														
														//알람관련
														if(CacheUtil.getCode("alarmYN").getCdVal().equals("Y")) {
															BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_mfgplan_C");
															if(alarmBCD.getUseYn().equals("Y")) {
																SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
																Date alarmDate = format1.parse(strStdt);
																String reserveDate = format1.format(alarmDate) + " " + alarmBCD.getCdReserve04();
																AlarmMgtDto alarmMgtDto = new AlarmMgtDto(alarmBCD.getCdId(), insertWorkDto.getProdWorkId(), String.format(alarmBCD.getCdReserve01(),""),
																		String.format(alarmBCD.getCdReserve02(),insertWorkDto.getProdWorkId()), alarmBCD.getCdReserve03(), JteUtils.getUserId(), reserveDate,
																		asgnDto.getProdWorkUser(), "NEW", null, JteUtils.getUserId());
																
																alarmMgtDto.setAction("C");
																//생산계획 알람등록
																alarmMgtService.setAlarmMgt(alarmMgtDto);
															}
														}
													}
												}
											}
										}
									}
									//시작날짜 + 1일
									calStdt.add(Calendar.DATE, 1);
								}
								returnKey = "success";
							}else {
								returnKey = "bulk_plan_err02";
								throw new Exception();
							}
						}
					
				}else {
					returnKey = "bulk_plan_err01";
					throw new Exception();
				}
			}
		} catch (Exception e) {
			if(StringUtils.isEmpty(returnKey)) {
				returnKey = "error";
				e.printStackTrace();
			}
		}
		
		return returnKey;
	}
	
	
	//일괄처리 삭제
	@Transactional
	
	public String setBulkDelete(ZinixProductPlanDto productPlanDto){
		String returnKey = "";
		try {
			
			//해당 날짜에 등록된 데이터가 조회
			ZinixWrkinTeamMgtDto bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
			bulkSearchPrmt.setLotId(productPlanDto.getLotId());
			bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
			bulkSearchPrmt.setProdPlanType(productPlanDto.getProdPlanType());
			bulkSearchPrmt.setBulkStdt(productPlanDto.getBulkStdt());
			bulkSearchPrmt.setBulkEddt(productPlanDto.getBulkEddt());
			bulkSearchPrmt.setAction("plan");
			
			List<ZinixWrkinTeamMgtDto> planList = zinixWrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
			if(planList.size() > 0) {
				//기간내 날짜에 등록
				for(ZinixWrkinTeamMgtDto planDto : planList) {
					bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
					bulkSearchPrmt.setLotId(productPlanDto.getLotId());
					bulkSearchPrmt.setProdPlanId(planDto.getProdPlanId());
					bulkSearchPrmt.setProdAsmId(planDto.getProdAsmId());
					bulkSearchPrmt.setAction("asgn");
					List<ZinixWrkinTeamMgtDto> asgnList = zinixWrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
					if(asgnList.size() > 0) {
						//기간내 날짜에 등록
						for(ZinixWrkinTeamMgtDto asgnDto : asgnList) {
							bulkSearchPrmt = new ZinixWrkinTeamMgtDto();
							bulkSearchPrmt.setLotId(productPlanDto.getLotId());
							bulkSearchPrmt.setProdPlanId(asgnDto.getProdPlanId());
							bulkSearchPrmt.setProdAsmId(asgnDto.getProdAsmId());
							bulkSearchPrmt.setAction("work");
							List<ZinixWrkinTeamMgtDto> workList = zinixWrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
							if(workList.size() > 0) {
								returnKey = "bulk_planDelete_err03";
								//기간내 날짜에 등록
								for(ZinixWrkinTeamMgtDto workDto : workList) {
									zinixWrkinWrkerMgtMapper.deleteProdWork(workDto);
									
								}
							}
							returnKey = "bulk_planDelete_err02";
							zinixWrkinTeamMgtMapper.deleteAsgn(asgnDto);
						}
					}
					returnKey = "bulk_planDelete_err01";
					//생산계획 삭제
					ZinixProductPlanDto prodPlanDto = new ZinixProductPlanDto();
					prodPlanDto.setProdPlanId(planDto.getProdPlanId());
					zinixPlanMapper.deletePlan(prodPlanDto);
				}
				returnKey = "success";
			}
		} catch (Exception e) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + e.getMessage());
		}
		return returnKey;
		
	}
}
