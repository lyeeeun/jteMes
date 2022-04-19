package jin.mes.form.mfgMgt.mfgplanMgt.mfgplan;

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
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.mapper.mfgMgt.mfgplanMgt.mfgplan.MfgplanMapper;
import jin.mes.mapper.mfgMgt.wrkinTeamMgt.WrkinTeamMgtMapper;
import jin.mes.mapper.mfgMgt.wrkinWrkerMgt.WrkinWrkerMgtMapper;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//defalut
@Service
public class MfgplanServiceImpl implements MfgplanService{
	
	@Resource
	MfgplanMapper planMapper;
	
	@Resource
	WrkinTeamMgtMapper wrkinTeamMgtMapper;
	
	@Resource
	WrkinWrkerMgtMapper wrkinWrkerMgtMapper;
	
	@Autowired AlarmMgtService alarmMgtService; 
	
	@Override
	public PageInfo<MfgplanDto> getMonthPlanList(MfgplanDto planDto, PageRequestVo pageRequestVo){
		List<MfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = planMapper.selectMonthPlanListCount(planDto);
			if (rowCount > 0) {
				//List
				planList = planMapper.selectMonthPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("연간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<MfgplanDto>();
		}
		return new PageInfo<MfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	@Override
	public PageInfo<MfgplanDto> getDayPlanList(MfgplanDto planDto, PageRequestVo pageRequestVo){
		List<MfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = planMapper.selectDayPlanListCount(planDto);
			if (rowCount > 0) {
				//List
				planList = planMapper.selectDayPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<MfgplanDto>();
		}
		return new PageInfo<MfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	@Override
	public PageInfo<ProductPlanDto> getPlanDetail(ProductPlanDto productPlanDto, PageRequestVo pageRequestVo){
		List<ProductPlanDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		productPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		productPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = planMapper.selectPlanDetail(productPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<ProductPlanDto>();
		}
		return new PageInfo<ProductPlanDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	@Override
	public String setPlanCnt(ProductPlanDto productPlanDto){
		String returnKey = "";
		try {
			productPlanDto.setCreatorId(JteUtils.getUserId());
			productPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(productPlanDto.getAction().equals("C")) { 
				planMapper.insertPlanCnt(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}else if(productPlanDto.getAction().equals("U")){ 
				planMapper.updatePlanCnt(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//일괄처리 가능여부 조회
	@Override
	public ProductPlanDto getBulkPos(ProductPlanDto productPlanDto){
		ProductPlanDto bulkDto = null;
		try {
			if(productPlanDto.getProdPlanType().equals("prod_plan01")) { 
				bulkDto = planMapper.selectBulkMonthPos(productPlanDto);
			}else if(productPlanDto.getProdPlanType().equals("prod_plan02")){ 
				bulkDto = planMapper.selectBulkDayPos(productPlanDto);
			}
		} catch (Exception e) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + e.getMessage());
		}
		
		return bulkDto;
	}
	
	//일괄처리 저장
	@Transactional
	@Override
	public String setBulkSave(ProductPlanDto productPlanDto){
		String returnKey = "";
		ProductPlanDto insertPlanDto = null;
		try {
			//월간등록인 경우
			if(productPlanDto.getProdPlanType().equals("prod_plan01")) {
				
				//기준날짜에 등록된 데이터가 있는지 조회
				WrkinTeamMgtDto bulkSearchPrmt = new WrkinTeamMgtDto();
				bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
				List<WrkinTeamMgtDto> planList = wrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
				if(planList.size() > 0) {
					//조회한 데이터 담기
					WrkinTeamMgtDto planDto = planList.get(0);
					if(productPlanDto.getBulkPeriodYN().equals("N")) {//기간 자동등록
						int calcPlanCnt = 0;
						boolean loopYN = false;
						calcPlanCnt = planMapper.selectBulkPlanCnt(productPlanDto);
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
							ProductPlanDto bulkQtyDto = planMapper.selectBulkMonthPeriod(productPlanDto);
							
							//데이터가 이미 등록되어 있다면 강제 예외처리
							if(bulkQtyDto.getPlanCnt() != 0) {
								returnKey = "bulk_plan_err02";
								throw new Exception();
							}
							
							//월간 생산계획 생성자
							insertPlanDto = new ProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
									null, planCnt, planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
							
							//생산계획 등록
							planMapper.insertPlanCnt(insertPlanDto);
							
							calcPlanCnt = planMapper.selectBulkPlanCnt(productPlanDto);
							
							if(calcPlanCnt <= 0) {
								loopYN = false;
							}
							//시작날짜 + 1개월
							calStdt.add(Calendar.MONTH, 1);
						}
						returnKey = "success";
					}else {//기간직접입력
						//기간내에 등록된 데이터가 있는지 조회
						ProductPlanDto bulkQtyDto = planMapper.selectBulkMonthPeriod(productPlanDto);
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
								insertPlanDto = new ProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
										null, planDto.getProdPlanQty(), planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
								
								//생산계획 등록
								planMapper.insertPlanCnt(insertPlanDto);
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
				WrkinTeamMgtDto bulkSearchPrmt = new WrkinTeamMgtDto();
				bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
				List<WrkinTeamMgtDto> planList = wrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
				
				if(planList.size() > 0) {
					//조회한 데이터 담기
					WrkinTeamMgtDto planDto = planList.get(0);
				
						if(productPlanDto.getBulkPeriodYN().equals("N")) {//기간 자동등록
							int calcPlanCnt = 0;
							boolean loopYN = false;
							calcPlanCnt = planMapper.selectBulkPlanCnt(productPlanDto);
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
									ProductPlanDto bulkQtyDto = planMapper.selectBulkMonthPeriod(productPlanDto);
									
									//데이터가 이미 등록되어 있다면 강제 예외처리
									if(bulkQtyDto.getPlanCnt() != 0) {
										returnKey = "bulk_plan_err02";
										throw new Exception();
									}
									
									//일간 생산계획 생성자
									insertPlanDto = new ProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
											baseDate[2], planCnt, planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
									
									//생산계획 등록
									planMapper.insertPlanCnt(insertPlanDto);
									
									//체크박스에 생산지시가 체크되어 있을때만 실행
									if(Arrays.asList(productPlanDto.getBulkTarget()).contains("asgn")) {
										//해당 날짜에 등록된 데이터가 있는지 조회(생산지시)
										bulkSearchPrmt = new WrkinTeamMgtDto();
										bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
										bulkSearchPrmt.setAction("asgn");
										List<WrkinTeamMgtDto> asgnList = wrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
										
										for(WrkinTeamMgtDto asgnDto : asgnList) {
											
											//생산지시 생성자
											WrkinTeamMgtDto insertAsgnDto = new WrkinTeamMgtDto(null, asgnDto.getProdAsmNm(), strStdt, planCnt, 
													asgnDto.getProdAsmDesc(), asgnDto.getProdAsmUser(), asgnDto.getProdAsmEmj(), asgnDto.getProdAsmState(),
													JteUtils.getUserId(), asgnDto.getDeptId(), insertPlanDto.getProdPlanId(), asgnDto.getLotId());
											//생성지시 등록
											wrkinTeamMgtMapper.insertAsgn(insertAsgnDto);
											
											//체크박스에 작업지시가 체크되어 있을때만 실행
											if(Arrays.asList(productPlanDto.getBulkTarget()).contains("work")) {
												//해당 날짜에 등록된 데이터가 있는지 조회(작업지시)
												bulkSearchPrmt = new WrkinTeamMgtDto();
												bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
												bulkSearchPrmt.setProdAsmId(asgnDto.getProdAsmId());
												bulkSearchPrmt.setAction("work");
												List<WrkinTeamMgtDto> workList = wrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
												for(WrkinTeamMgtDto workDto : workList) {
													WrkinTeamMgtDto insertWorkDto = new WrkinTeamMgtDto(insertAsgnDto.getProdAsmId(), insertPlanDto.getProdPlanId(),
															workDto.getLotId(), null, workDto.getRoutingId(), workDto.getEqmtMgtId(), workDto.getProdWorkUser(),
															planCnt, workDto.getProdWorkDesc());
													wrkinWrkerMgtMapper.insertProdWork(insertWorkDto);
													
													//알람관련
													if(CodeUtil.getCode("alarmYN").getCdVal().equals("Y")) {
														ComnCodeVo alarmBCD = CodeUtil.getCode("alarm_mfgplan_C");
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
								calcPlanCnt = planMapper.selectBulkPlanCnt(productPlanDto);
								if(calcPlanCnt <= 0) {
									loopYN = false;
								}
								//시작날짜 + 1일
								calStdt.add(Calendar.DATE, 1);
							}
							returnKey = "success";
						}else {//기간직접입력
							//기간내에 등록된 데이터가 있는지 조회
							ProductPlanDto bulkQtyDto = planMapper.selectBulkDayPeriod(productPlanDto);
							
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
										insertPlanDto = new ProductPlanDto(null, planDto.getProdPlanType(), baseDate[0], baseDate[1],
												baseDate[2], planDto.getProdPlanQty(), planDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), planDto.getLotId());
										
										//생산계획 등록
										planMapper.insertPlanCnt(insertPlanDto);
										
										//체크박스에 생산지시가 체크되어 있을때만 실행
										if(Arrays.asList(productPlanDto.getBulkTarget()).contains("asgn")) {
											//해당 날짜에 등록된 데이터가 있는지 조회(생산지시)
											bulkSearchPrmt = new WrkinTeamMgtDto();
											bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
											bulkSearchPrmt.setAction("asgn");
											List<WrkinTeamMgtDto> asgnList = wrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
											
											for(WrkinTeamMgtDto asgnDto : asgnList) {
												//생산지시 생성자
												WrkinTeamMgtDto insertAsgnDto = new WrkinTeamMgtDto(null, asgnDto.getProdAsmNm(), strStdt, asgnDto.getProdAsmQty(), 
														asgnDto.getProdAsmDesc(), asgnDto.getProdAsmUser(), asgnDto.getProdAsmEmj(), asgnDto.getProdAsmState(),
														JteUtils.getUserId(), asgnDto.getDeptId(), insertPlanDto.getProdPlanId(), asgnDto.getLotId());
												//생성지시 등록
												wrkinTeamMgtMapper.insertAsgn(insertAsgnDto);
												
												//체크박스에 작업지시가 체크되어 있을때만 실행
												if(Arrays.asList(productPlanDto.getBulkTarget()).contains("work")) {
													//해당 날짜에 등록된 데이터가 있는지 조회(작업지시)
													bulkSearchPrmt = new WrkinTeamMgtDto();
													bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
													bulkSearchPrmt.setProdAsmId(asgnDto.getProdAsmId());
													bulkSearchPrmt.setAction("work");
													List<WrkinTeamMgtDto> workList = wrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
													for(WrkinTeamMgtDto workDto : workList) {
														WrkinTeamMgtDto insertWorkDto = new WrkinTeamMgtDto(insertAsgnDto.getProdAsmId(), insertPlanDto.getProdPlanId(),
																workDto.getLotId(), null, workDto.getRoutingId(), workDto.getEqmtMgtId(), workDto.getProdWorkUser(),
																workDto.getProdWorkQty(), workDto.getProdWorkDesc());
														wrkinWrkerMgtMapper.insertProdWork(insertWorkDto);
														
														//알람관련
														if(CodeUtil.getCode("alarmYN").getCdVal().equals("Y")) {
															ComnCodeVo alarmBCD = CodeUtil.getCode("alarm_mfgplan_C");
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
	@Override
	public String setBulkDelete(ProductPlanDto productPlanDto){
		String returnKey = "";
		try {
			
			//해당 날짜에 등록된 데이터가 조회
			WrkinTeamMgtDto bulkSearchPrmt = new WrkinTeamMgtDto();
			bulkSearchPrmt.setLotId(productPlanDto.getLotId());
			bulkSearchPrmt.setProdPlanId(productPlanDto.getProdPlanId());
			bulkSearchPrmt.setProdPlanType(productPlanDto.getProdPlanType());
			bulkSearchPrmt.setBulkStdt(productPlanDto.getBulkStdt());
			bulkSearchPrmt.setBulkEddt(productPlanDto.getBulkEddt());
			bulkSearchPrmt.setAction("plan");
			
			List<WrkinTeamMgtDto> planList = wrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
			if(planList.size() > 0) {
				//기간내 날짜에 등록
				for(WrkinTeamMgtDto planDto : planList) {
					bulkSearchPrmt = new WrkinTeamMgtDto();
					bulkSearchPrmt.setLotId(productPlanDto.getLotId());
					bulkSearchPrmt.setProdPlanId(planDto.getProdPlanId());
					bulkSearchPrmt.setProdAsmId(planDto.getProdAsmId());
					bulkSearchPrmt.setAction("asgn");
					List<WrkinTeamMgtDto> asgnList = wrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
					if(asgnList.size() > 0) {
						//기간내 날짜에 등록
						for(WrkinTeamMgtDto asgnDto : asgnList) {
							bulkSearchPrmt = new WrkinTeamMgtDto();
							bulkSearchPrmt.setLotId(productPlanDto.getLotId());
							bulkSearchPrmt.setProdPlanId(asgnDto.getProdPlanId());
							bulkSearchPrmt.setProdAsmId(asgnDto.getProdAsmId());
							bulkSearchPrmt.setAction("work");
							List<WrkinTeamMgtDto> workList = wrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
							if(workList.size() > 0) {
								returnKey = "bulk_planDelete_err03";
								//기간내 날짜에 등록
								for(WrkinTeamMgtDto workDto : workList) {
									wrkinWrkerMgtMapper.deleteProdWork(workDto);
									
								}
							}
							returnKey = "bulk_planDelete_err02";
							wrkinTeamMgtMapper.deleteAsgn(asgnDto);
						}
					}
					returnKey = "bulk_planDelete_err01";
					//생산계획 삭제
					ProductPlanDto prodPlanDto = new ProductPlanDto();
					prodPlanDto.setProdPlanId(planDto.getProdPlanId());
					planMapper.deletePlan(prodPlanDto);
				}
				returnKey = "success";
			}
		} catch (Exception e) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + e.getMessage());
		}
		return returnKey;
		
	}
}
