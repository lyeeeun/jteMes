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

import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtMapper;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.NewWrkinWrkerMgtMapper;
import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.common.cache.CacheUtil;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//defalut
@Service
public class NewMfgplanService{
	
	@Resource
	NewMfgplanMapper newPlanMapper;
	
	@Resource
	NewWrkinTeamMgtMapper newWrkinTeamMgtMapper;
	
	@Resource
	NewWrkinWrkerMgtMapper newWrkinWrkerMgtMapper;
	
	@Autowired AlarmMgtService alarmMgtService; 
	
	
	public PageInfo<NewMfgplanDto> getMonthPlanList(NewMfgplanDto newPlanDto, PageRequestVo pageRequestVo){
		List<NewMfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		newPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newPlanMapper.selectMonthPlanListCount(newPlanDto);
			if (rowCount > 0) {
				//List
				planList = newPlanMapper.selectMonthPlanList(newPlanDto);
			}
		} catch (Exception e) {
			throw new BusinessException("연간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<NewMfgplanDto>();
		}
		return new PageInfo<NewMfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<NewMfgplanDto> getDayPlanList(NewMfgplanDto newPlanDto, PageRequestVo pageRequestVo){
		List<NewMfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		newPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newPlanMapper.selectDayPlanListCount(newPlanDto);
			if (rowCount > 0) {
				//List
				planList = newPlanMapper.selectDayPlanList(newPlanDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<NewMfgplanDto>();
		}
		return new PageInfo<NewMfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<NewProductPlanDto> getPlanDetail(NewProductPlanDto newProductPlanDto, PageRequestVo pageRequestVo){
		List<NewProductPlanDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		newProductPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newProductPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = newPlanMapper.selectPlanDetail(newProductPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<NewProductPlanDto>();
		}
		return new PageInfo<NewProductPlanDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	
	public String setPlanCnt(NewProductPlanDto newProductPlanDto){
		String returnKey = "";
		try {
			newProductPlanDto.setCreatorId(JteUtils.getUserId());
			newProductPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(newProductPlanDto.getAction().equals("C")) { 
				newPlanMapper.insertPlanCnt(newProductPlanDto);
				returnKey = newProductPlanDto.getProdPlanId();
			}else if(newProductPlanDto.getAction().equals("U")){ 
				newPlanMapper.updatePlanCnt(newProductPlanDto);
				returnKey = newProductPlanDto.getProdPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//일괄처리 가능여부 조회
	
	public NewProductPlanDto getBulkPos(NewProductPlanDto newProductPlanDto){
		NewProductPlanDto bulkDto = null;
		try {
			if(newProductPlanDto.getProdPlanType().equals("prod_plan01")) { 
				bulkDto = newPlanMapper.selectBulkMonthPos(newProductPlanDto);
			}else if(newProductPlanDto.getProdPlanType().equals("prod_plan02")){ 
				bulkDto = newPlanMapper.selectBulkDayPos(newProductPlanDto);
			}
		} catch (Exception e) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + e.getMessage());
		}
		
		return bulkDto;
	}
	
	//일괄처리 저장
	@Transactional
	
	public String setBulkSave(NewProductPlanDto newProductPlanDto){
		String returnKey = "";
		NewProductPlanDto newInsertPlanDto = null;
		try {
			//월간등록인 경우
			if(newProductPlanDto.getProdPlanType().equals("prod_plan01")) {
				
				//기준날짜에 등록된 데이터가 있는지 조회
				NewWrkinTeamMgtDto bulkSearchPrmt = new NewWrkinTeamMgtDto();
				bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
				List<NewWrkinTeamMgtDto> planList = newWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
				if(planList.size() > 0) {
					//조회한 데이터 담기
					NewWrkinTeamMgtDto newPlanDto = planList.get(0);
					if(newProductPlanDto.getBulkPeriodYN().equals("N")) {//기간 자동등록
						int calcPlanCnt = 0;
						boolean loopYN = false;
						calcPlanCnt = newPlanMapper.selectBulkPlanCnt(newProductPlanDto);
						if(calcPlanCnt > 0) {
							loopYN = true;
						}
						
						//기준일
						DateFormat df = new SimpleDateFormat("yyyy-MM");
						Date stdt = df.parse(newProductPlanDto.getBaseDate());
						Calendar calStdt = Calendar.getInstance();
						calStdt.setTime(stdt);
						calStdt.add(Calendar.MONTH, 1);
						
						//기간내 날짜에 등록
						while(loopYN){
							int planCnt = 0;
							
							if(calcPlanCnt < newPlanDto.getProdPlanQty()) {
								planCnt = calcPlanCnt; 
							}else {
								planCnt = newPlanDto.getProdPlanQty();
							}
							
							String strStdt = df.format(calStdt.getTime());
							String[] baseDate = strStdt.split("-");
							
							//데이터가 등록되어 있는지 조회
							newProductPlanDto.setBulkStdt(strStdt);
							newProductPlanDto.setBulkEddt(strStdt);
							NewProductPlanDto newBulkQtyDto = newPlanMapper.selectBulkMonthPeriod(newProductPlanDto);
							
							//데이터가 이미 등록되어 있다면 강제 예외처리
							if(newBulkQtyDto.getPlanCnt() != 0) {
								returnKey = "bulk_plan_err02";
								throw new Exception();
							}
							
							//월간 생산계획 생성자
							newInsertPlanDto = new NewProductPlanDto(null, newPlanDto.getProdPlanType(), baseDate[0], baseDate[1],
									null, planCnt, newPlanDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), newPlanDto.getLotId());
							
							//생산계획 등록
							newPlanMapper.insertPlanCnt(newInsertPlanDto);
							
							calcPlanCnt = newPlanMapper.selectBulkPlanCnt(newProductPlanDto);
							
							if(calcPlanCnt <= 0) {
								loopYN = false;
							}
							//시작날짜 + 1개월
							calStdt.add(Calendar.MONTH, 1);
						}
						returnKey = "success";
					}else {//기간직접입력
						//기간내에 등록된 데이터가 있는지 조회
						NewProductPlanDto newBulkQtyDto = newPlanMapper.selectBulkMonthPeriod(newProductPlanDto);
						if(newBulkQtyDto.getPlanCnt() == 0) {
							
							//시작날짜  ~ 종료날짜 사이에 날짜를 구하기 위함
							DateFormat df = new SimpleDateFormat("yyyy-MM");
							Date stdt = df.parse(newProductPlanDto.getBulkStdt());
							Date eddt = df.parse(newProductPlanDto.getBulkEddt());
							Calendar calStdt = Calendar.getInstance();
							calStdt.setTime(stdt);
							Calendar calEddt = Calendar.getInstance();
							calEddt.setTime(eddt);
							
							//기간내 날짜에 등록
							while(calStdt.compareTo( calEddt ) !=1 ){
								String strStdt = df.format(calStdt.getTime());
								String[] baseDate = strStdt.split("-");
								//월간 생산계획 생성자
								newInsertPlanDto = new NewProductPlanDto(null, newPlanDto.getProdPlanType(), baseDate[0], baseDate[1],
										null, newPlanDto.getProdPlanQty(), newPlanDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), newPlanDto.getLotId());
								
								//생산계획 등록
								newPlanMapper.insertPlanCnt(newInsertPlanDto);
								newInsertPlanDto.getProdPlanId();
								
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
			}else if(newProductPlanDto.getProdPlanType().equals("prod_plan02")){
				
				//기준날짜에 등록된 데이터가 있는지 조회
				NewWrkinTeamMgtDto bulkSearchPrmt = new NewWrkinTeamMgtDto();
				bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
				List<NewWrkinTeamMgtDto> planList = newWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
				
				if(planList.size() > 0) {
					//조회한 데이터 담기
					NewWrkinTeamMgtDto newPlanDto = planList.get(0);
				
						if(newProductPlanDto.getBulkPeriodYN().equals("N")) {//기간 자동등록
							int calcPlanCnt = 0;
							boolean loopYN = false;
							calcPlanCnt = newPlanMapper.selectBulkPlanCnt(newProductPlanDto);
							if(calcPlanCnt > 0) {
								loopYN = true;
							}
							
							//기준일
							DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
							Date stdt = df.parse(newProductPlanDto.getBaseDate());
							Calendar calStdt = Calendar.getInstance();
							calStdt.setTime(stdt);
							calStdt.add(Calendar.DATE, 1);
							
							//기간내 날짜에 등록
							while(loopYN){
								if(calStdt.get(Calendar.DAY_OF_WEEK) != 1) {//일요일 제외
									int planCnt = 0;
									
									if(calcPlanCnt < newPlanDto.getProdPlanQty()) {
										planCnt = calcPlanCnt; 
									}else {
										planCnt = newPlanDto.getProdPlanQty();
									}
									
									String strStdt = df.format(calStdt.getTime());
									String[] baseDate = strStdt.split("-");
									
									//데이터가 등록되어 있는지 조회
									newProductPlanDto.setBulkStdt(strStdt);
									newProductPlanDto.setBulkEddt(strStdt);
									NewProductPlanDto newBulkQtyDto = newPlanMapper.selectBulkMonthPeriod(newProductPlanDto);
									
									//데이터가 이미 등록되어 있다면 강제 예외처리
									if(newBulkQtyDto.getPlanCnt() != 0) {
										returnKey = "bulk_plan_err02";
										throw new Exception();
									}
									
									//일간 생산계획 생성자
									newInsertPlanDto = new NewProductPlanDto(null, newPlanDto.getProdPlanType(), baseDate[0], baseDate[1],
											baseDate[2], planCnt, newPlanDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), newPlanDto.getLotId());
									
									//생산계획 등록
									newPlanMapper.insertPlanCnt(newInsertPlanDto);
									
									//체크박스에 생산지시가 체크되어 있을때만 실행
									if(Arrays.asList(newProductPlanDto.getBulkTarget()).contains("asgn")) {
										//해당 날짜에 등록된 데이터가 있는지 조회(생산지시)
										bulkSearchPrmt = new NewWrkinTeamMgtDto();
										bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
										bulkSearchPrmt.setAction("asgn");
										List<NewWrkinTeamMgtDto> asgnList = newWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
										
										for(NewWrkinTeamMgtDto newAsgnDto : asgnList) {
											
											//생산지시 생성자
											NewWrkinTeamMgtDto newInsertAsgnDto = new NewWrkinTeamMgtDto(null, newAsgnDto.getProdAsmNm(), strStdt, planCnt, 
													newAsgnDto.getProdAsmDesc(), newAsgnDto.getProdAsmUser(), newAsgnDto.getProdAsmEmj(), newAsgnDto.getProdAsmState(),
													JteUtils.getUserId(), newAsgnDto.getDeptId(), newInsertPlanDto.getProdPlanId(), newAsgnDto.getLotId());
											//생성지시 등록
											newWrkinTeamMgtMapper.insertAsgn(newInsertAsgnDto);
											
											//체크박스에 작업지시가 체크되어 있을때만 실행
											if(Arrays.asList(newProductPlanDto.getBulkTarget()).contains("work")) {
												//해당 날짜에 등록된 데이터가 있는지 조회(작업지시)
												bulkSearchPrmt = new NewWrkinTeamMgtDto();
												bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
												bulkSearchPrmt.setProdAsmId(newAsgnDto.getProdAsmId());
												bulkSearchPrmt.setAction("work");
												List<NewWrkinTeamMgtDto> workList = newWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
												for(NewWrkinTeamMgtDto newWorkDto : workList) {
													NewWrkinTeamMgtDto newInsertWorkDto = new NewWrkinTeamMgtDto(newInsertAsgnDto.getProdAsmId(), newInsertPlanDto.getProdPlanId(),
															newWorkDto.getLotId(), null, newWorkDto.getRoutingId(), newWorkDto.getEqmtMgtId(), newWorkDto.getProdWorkUser(),
															planCnt, newWorkDto.getProdWorkDesc());
													newWrkinWrkerMgtMapper.insertProdWork(newInsertWorkDto);
													
													//알람관련
													if(CacheUtil.getCode("alarmYN").getCdVal().equals("Y")) {
														BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_mfgplan_C");
														if(alarmBCD.getUseYn().equals("Y")) {
															SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
															Date alarmDate = format1.parse(strStdt);
															String reserveDate = format1.format(alarmDate) + " " + alarmBCD.getCdReserve04();
															AlarmMgtDto alarmMgtDto = new AlarmMgtDto(alarmBCD.getCdId(), newInsertWorkDto.getProdWorkId(), String.format(alarmBCD.getCdReserve01(),""),
																	String.format(alarmBCD.getCdReserve02(),newInsertWorkDto.getProdWorkId()), alarmBCD.getCdReserve03(), JteUtils.getUserId(), reserveDate,
																	newAsgnDto.getProdWorkUser(), "NEW", null, JteUtils.getUserId());
															
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
								calcPlanCnt = newPlanMapper.selectBulkPlanCnt(newProductPlanDto);
								if(calcPlanCnt <= 0) {
									loopYN = false;
								}
								//시작날짜 + 1일
								calStdt.add(Calendar.DATE, 1);
							}
							returnKey = "success";
						}else {//기간직접입력
							//기간내에 등록된 데이터가 있는지 조회
							
							
							
							
							
							
							
							
							NewProductPlanDto newBulkQtyDto = newPlanMapper.selectBulkDayPeriod(newProductPlanDto);
							
							// 생산계획/생산지시/작업지시 체크박스에 따른 확인
							int totalQty = newBulkQtyDto.getPlanCnt();
							if(Arrays.asList(newProductPlanDto.getBulkTarget()).contains("asgn")) { totalQty += newBulkQtyDto.getAsgnCnt(); }
							if(Arrays.asList(newProductPlanDto.getBulkTarget()).contains("work")) { totalQty += newBulkQtyDto.getWorkCnt(); }
							
							if(totalQty == 0) {
								//시작날짜  ~ 종료날짜 사이에 날짜를 구하기 위함
								DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
								Date stdt = df.parse(newProductPlanDto.getBulkStdt());
								Date eddt = df.parse(newProductPlanDto.getBulkEddt());
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
										newInsertPlanDto = new NewProductPlanDto(null, newPlanDto.getProdPlanType(), baseDate[0], baseDate[1],
												baseDate[2], newPlanDto.getProdPlanQty(), newPlanDto.getProdPlanDesc(), JteUtils.getUserId(), JteUtils.getUserId(), newPlanDto.getLotId());
										
										//생산계획 등록
										newPlanMapper.insertPlanCnt(newInsertPlanDto);
										
										//체크박스에 생산지시가 체크되어 있을때만 실행
										if(Arrays.asList(newProductPlanDto.getBulkTarget()).contains("asgn")) {
											//해당 날짜에 등록된 데이터가 있는지 조회(생산지시)
											bulkSearchPrmt = new NewWrkinTeamMgtDto();
											bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
											bulkSearchPrmt.setAction("asgn");
											List<NewWrkinTeamMgtDto> asgnList = newWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
											
											for(NewWrkinTeamMgtDto newAsgnDto : asgnList) {
												//생산지시 생성자
												NewWrkinTeamMgtDto newInsertAsgnDto = new NewWrkinTeamMgtDto(null, newAsgnDto.getProdAsmNm(), strStdt, newAsgnDto.getProdAsmQty(), 
														newAsgnDto.getProdAsmDesc(), newAsgnDto.getProdAsmUser(), newAsgnDto.getProdAsmEmj(), newAsgnDto.getProdAsmState(),
														JteUtils.getUserId(), newAsgnDto.getDeptId(), newInsertPlanDto.getProdPlanId(), newAsgnDto.getLotId());
												//생성지시 등록
												newWrkinTeamMgtMapper.insertAsgn(newInsertAsgnDto);
												
												//체크박스에 작업지시가 체크되어 있을때만 실행
												if(Arrays.asList(newProductPlanDto.getBulkTarget()).contains("work")) {
													//해당 날짜에 등록된 데이터가 있는지 조회(작업지시)
													bulkSearchPrmt = new NewWrkinTeamMgtDto();
													bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
													bulkSearchPrmt.setProdAsmId(newAsgnDto.getProdAsmId());
													bulkSearchPrmt.setAction("work");
													List<NewWrkinTeamMgtDto> workList = newWrkinWrkerMgtMapper.selectbulkCopyList(bulkSearchPrmt);
													for(NewWrkinTeamMgtDto newWorkDto : workList) {
														NewWrkinTeamMgtDto newInsertWorkDto = new NewWrkinTeamMgtDto(newInsertAsgnDto.getProdAsmId(), newInsertPlanDto.getProdPlanId(),
																newWorkDto.getLotId(), null, newWorkDto.getRoutingId(), newWorkDto.getEqmtMgtId(), newWorkDto.getProdWorkUser(),
																newWorkDto.getProdWorkQty(), newWorkDto.getProdWorkDesc());
														newWrkinWrkerMgtMapper.insertProdWork(newInsertWorkDto);
														
														//알람관련
														if(CacheUtil.getCode("alarmYN").getCdVal().equals("Y")) {
															BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_mfgplan_C");
															if(alarmBCD.getUseYn().equals("Y")) {
																SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
																Date alarmDate = format1.parse(strStdt);
																String reserveDate = format1.format(alarmDate) + " " + alarmBCD.getCdReserve04();
																AlarmMgtDto alarmMgtDto = new AlarmMgtDto(alarmBCD.getCdId(), newInsertWorkDto.getProdWorkId(), String.format(alarmBCD.getCdReserve01(),""),
																		String.format(alarmBCD.getCdReserve02(),newInsertWorkDto.getProdWorkId()), alarmBCD.getCdReserve03(), JteUtils.getUserId(), reserveDate,
																		newAsgnDto.getProdWorkUser(), "NEW", null, JteUtils.getUserId());
																
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
	
	public String setBulkDelete(NewProductPlanDto newProductPlanDto){
		String returnKey = "";
		try {
			
			//해당 날짜에 등록된 데이터가 조회
			NewWrkinTeamMgtDto bulkSearchPrmt = new NewWrkinTeamMgtDto();
			bulkSearchPrmt.setLotId(newProductPlanDto.getLotId());
			bulkSearchPrmt.setProdPlanId(newProductPlanDto.getProdPlanId());
			bulkSearchPrmt.setProdPlanType(newProductPlanDto.getProdPlanType());
			bulkSearchPrmt.setBulkStdt(newProductPlanDto.getBulkStdt());
			bulkSearchPrmt.setBulkEddt(newProductPlanDto.getBulkEddt());
			bulkSearchPrmt.setAction("plan");
			
			List<NewWrkinTeamMgtDto> planList = newWrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
			if(planList.size() > 0) {
				//기간내 날짜에 등록
				for(NewWrkinTeamMgtDto newPlanDto : planList) {
					bulkSearchPrmt = new NewWrkinTeamMgtDto();
					bulkSearchPrmt.setLotId(newProductPlanDto.getLotId());
					bulkSearchPrmt.setProdPlanId(newPlanDto.getProdPlanId());
					bulkSearchPrmt.setProdAsmId(newPlanDto.getProdAsmId());
					bulkSearchPrmt.setAction("asgn");
					List<NewWrkinTeamMgtDto> asgnList = newWrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
					if(asgnList.size() > 0) {
						//기간내 날짜에 등록
						for(NewWrkinTeamMgtDto newAsgnDto : asgnList) {
							bulkSearchPrmt = new NewWrkinTeamMgtDto();
							bulkSearchPrmt.setLotId(newProductPlanDto.getLotId());
							bulkSearchPrmt.setProdPlanId(newAsgnDto.getProdPlanId());
							bulkSearchPrmt.setProdAsmId(newAsgnDto.getProdAsmId());
							bulkSearchPrmt.setAction("work");
							List<NewWrkinTeamMgtDto> workList = newWrkinWrkerMgtMapper.selectbulkDeleteList(bulkSearchPrmt);
							if(workList.size() > 0) {
								returnKey = "bulk_planDelete_err03";
								//기간내 날짜에 등록
								for(NewWrkinTeamMgtDto newWorkDto : workList) {
									newWrkinWrkerMgtMapper.deleteProdWork(newWorkDto);
									
								}
							}
							returnKey = "bulk_planDelete_err02";
							newWrkinTeamMgtMapper.deleteAsgn(newAsgnDto);
						}
					}
					returnKey = "bulk_planDelete_err01";
					//생산계획 삭제
					NewProductPlanDto newProdPlanDto = new NewProductPlanDto();
					newProdPlanDto.setProdPlanId(newPlanDto.getProdPlanId());
					newPlanMapper.deletePlan(newProdPlanDto);
				}
				returnKey = "success";
			}
		} catch (Exception e) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + e.getMessage());
		}
		return returnKey;
		
	}
}
