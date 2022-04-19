 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" style="width:100%;">
	<div style="width:39%; float:left;">
		<div id="jteSingleGrid" style="height:70%;"></div>
		<div id="attachArea" style="height:30%;"></div>
	</div>
	<div id="jteProdWorkForm" class="wrkinWrkerMgtForm-right-content-box">   <!-- style="display:inline-block; width:59%; height:100%;" -->
		<table class="wrkinWrkerMgtForm right-content-table"><tr><td>   <!-- style="height:100%; width:100%;" -->
				<form id="jteProdWorkForm_form" class="wrkinWrkerMgtForm jteProdWorkForm_form">   <!-- style="height:100%; display:none;" -->
				<!-- 기본정보 -->
					<div class="pop_title top_pop_title"><spring:message code = "pop_baseInfo"></spring:message></div>
					<table class="jteProdWorkForm_table jteProdWorkForm_table_1">   <!-- style="width:100%; background:#E2ECFF; padding:15px 0 15px 0; margin:10px 0 10px 0;" -->
						<colgroup>   <!-- 원래 col 4개에 각각 width 14 36 14 36 -->
							<col class="col-left-title">
							<col class="col-left-content-1">
							<col class="col-left-content-2">
							<col class="col-right-title">
							<col class="col-right-content-1">
							<col class="col-right-content-2">
						</colgroup>
<!-- 						<tr class="pop_title">
							<td colspan="4">
								기본정보
							</td>
						</tr> -->
						<tr>
						<!-- 공정정보 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_routType"></spring:message> : </td>
							<td>
								<label for="routingType"></label>
								<input id="routingType" class="left-input" name="routingType" format="selBox" msg="process_type" style="display:none;"/>
								<input type="hidden" name="routingId" id="routingId" class="left-input btn-input"/>
							</td>
							<td>
							<!-- 전체보기 -->
								<button class="k-button k-primary full-search-btn-left" type="button"  onclick="lfn_routingPop_Open()"><spring:message code = "pop_viewAll"></spring:message></button>
							</td>
						<!-- 설비정보 -->
							<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_eqmtInfo"></spring:message> : </td>
							<td>
								<label for="eqmtMgtNm"></label>
								<input type="hidden" id="eqmtMgtNm" class="right-input" name="eqmtMgtNm" style="display:none;"/>
								<input type="hidden" name="eqmtMgtId" id="eqmtMgtId" class="right-input btn-input"/>
							</td>
							<td>
							<!-- 공구조회/교체-->
								<button class="k-button k-primary full-search-btn-right" type="button" id="eqipToolChangeBtn" onclick="lfn_jteEquipToolPop_open()"><spring:message code = "pop_toolSrhChange"></spring:message></button>
							</td>
						</tr>
						<tr>
							<!-- 부품명 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
							<td colspan="2">
								<label for="itemNm"></label>
								<input class="left-input" type="hidden" name="itemId"/>
								<input class="left-input" type="hidden" name="itemNm"/>
							</td>
							<!-- 긴급여부 -->
							<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_prodEmj"></spring:message> : </td>
							<td colspan="2">
								<label for="prodAsmEmj"></label>
								<input name="prodAsmEmj" id="prodAsmEmj" class="right-input" format="selBox" msg="prod_emj" style="display:none;"/>
							</td>
						</tr>
						<tr>
							<!-- 재질 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_qomtrl"></spring:message> : </td>
							<td colspan="2">
								<label for="itemMtrl"></label>
								<input name="itemMtrl" id="itemMtrl" class="left-input" format="selBox" msg="comn_qomtrl" style="display:none;"/>
							</td>
							<!-- 공제량 -->
							<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_deduction"></spring:message> : </td>
							<td colspan="2">
								<label for="itemDeduction"></label>
								<input name="itemDeduction" id="itemDeduction" class="right-input" format="currency" style="display:none;"/>
							</td>
						</tr>
						<tr>
							<!-- 작업지시량 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkAsmQty"></spring:message> : </td>
							<td colspan="2">
								<label for="prodWorkQty"></label>
								<input name=prodWorkQty id="prodWorkQty" class="left-input" format="currency" style="display:none;"/>
							</td>
							<!-- 작업자 -->
							<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_worker"></spring:message> : </td>
							<td colspan="2">
								<label for="prodWorkUserNm"></label>
								<input type="hidden" id="prodWorkUserNm" class="right-input" name="prodWorkUserNm"/>
								<input type="hidden" name="prodWorkUser" id="prodWorkUser" class="right-input"/>
							</td>
						</tr>
						<tr>
						<!-- 작업지시 비고 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderDesc"></spring:message> : </td>
							<td colspan="5">
								<label for="prodWorkDesc"></label>
								<input name=prodWorkDesc id="prodWorkQty" class="left-input" style="display:none;"/>
							</td>
						</tr>
					</table>
					<!-- 작업정보 -->
					<div class="pop_title bottom_pop_title"><spring:message code = "pop_workInfo"></spring:message></div>
					<table class="jteProdWorkForm_table jteProdWorkForm_table_2">  <!-- style="width:100%;" -->
						<colgroup>   <!-- 원래 col 4개에 각각 width 14 36 14 36 -->
							<col class="col-left-title">
							<col class="col-left-content">
							<col class="col-right-title">
							<col class="col-right-content">
						</colgroup>
<!-- 						<tr class="pop_title">
							<td colspan="4">
								작업정보
							</td>
						</tr> -->
						<tr>
							<!-- 양품량 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_prodQuan"></spring:message> : </td>
							<td>
								<label for="prodWorkGood" class="custom-label-success"></label>
								<input id="prodWorkGood" class="left-input" name="prodWorkGood" format="currency" />
							</td>
							<!-- 불량량 -->
							<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_badProdQuan"></spring:message> : </td>
							<td>
								<label for="prodWorkBad" class="custom-label-fail"></label>
								<input id="prodWorkBad" class="right-input" name="prodWorkBad" format="currency" />
							</td>
						</tr>
						<tr>
							<!-- 작업시작시간 -->
							<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkStartTime"></spring:message> : </td>
							<td>
								<label for="prodWorkStart"></label>
								<input id="prodWorkStart" class="left-input" name="prodWorkStart" format="datetimepicker" />
							</td>
							<!-- 작업종료시간 -->
							<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_wrkEndTime"></spring:message> : </td>
							<td>
								<label for="prodWorkEnd"></label>
								<input id="prodWorkEnd" class="right-input" name="prodWorkEnd" format="datetimepicker" />
							</td>
						</tr>
						</table>
						<div class="final-btn-area">
							<!-- <button class="k-button k-primary final-btn" type="button" id = "prodWorkStartBtn_T" onclick="lfn_workStartPop_Open()">작업시작</button>
							<button class="k-button k-primary final-btn" type="button" id = "prodWorkEndBtn_T" onclick="lfn_workEndPop_Open()">작업종료</button> -->
							<button class="k-button k-primary final-btn" type="button" id = "prodWorkStartBtn" style="display:none;"><spring:message code = "pop_workStart"></spring:message></button>			<!-- 작업시작 -->
							<button class="k-button k-primary final-btn" type="button" id = "prodWorkEndBtn" style="display:none;"><spring:message code = "pop_workEnd"></spring:message></button>				<!-- 작업종료 -->
						</div>
						<table class="jteProdWorkForm_table jteProdWorkForm_table_3">  <!-- style="width:100%;" -->
						<colgroup>   <!-- 원래 col 4개에 각각 width 14 36 14 36 -->
							<col class="col-left-title">
							<col class="col-left-content">
							<col class="col-right-title">
							<col class="col-right-content">
						</colgroup>
						<tr style="display:hidden;">
							<td>
								<input type="hidden" name = "lotId"/>
								<input type="hidden" name = "prodWorkId"/>
								<input type="hidden" name = "prodAsmId"/>
								<input type="hidden" name="prodPlanId"/>
								<input type="hidden" name="prodPlanYear"/>
								<input type="hidden" name="prodPlanMonth"/>
								<input type="hidden" name="prodPlanDay"/>
								<input type="hidden" name="prodAsmDate"/>
								<input type="hidden" name="use"/>
							</td>
						</tr>
					</table>
				</form>
			</td></tr></table>
	</div>
	<input type="hidden" id="workFlag"/>
</div>

<!-- 라우팅 전체조회 POP(같은 작업지시에 포함된 라우팅만 조회한다.) -->
<div style="display:none;">
	<div id="jteRoutingAllPop" class="jteRoutingAllPop">
	<!-- 라우팅 조회 -->
		<div class="pop_title"><spring:message code = "pop_routingSearch"></spring:message></div>
		<div id="jteRoutingAllPop_grid" class="jteRoutingAllPop_grid" style="height:430px;"></div>
	</div>
</div>

<!-- 작업시작 팝업-->
<div style="display:none;">
	<div id="jteWorkStartPop" class="wrkinWrkerMgtForm jteWorkStartPop">
		<form id="jteWorkStartPop_form" class="wrkinWrkerMgtForm jteWorkStartPop_form">
			<table class="workStartToolArea jteWorkStartPop_table jteWorkStartPop_table_left"> <!-- 200513 LYM 안정적인 배치를 위해 좌측 우측 하단 세 테이블로 나눔 -->
				<colgroup>
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 공구점검 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_toolInspec"></spring:message></td>
				<tr>
				<tr>
					<td class="toolReady">
						<span id="toolReady" class="left-input btn-input"></span>
						<input type="hidden" id="hidToolReady"> 
					</td>
					<td>
					<!-- 공구확인 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_jteEquipToolPop_open('CHK')"><spring:message code = "pop_toolConfirm"></spring:message></button>
					</td>
				</tr>
			</table>
			<table class="workStartMtrlArea jteWorkStartPop_table jteWorkStartPop_table_right" style="display:none;">
				<colgroup>
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 자재 재고 파악-->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_mtrlStockSeize"></spring:message></td>
				<tr>
				<tr>
					<td class="workStartMtrlArea" style="display:none;">
						<span id="mtrlReady" class="right-input btn-input"></span>
						<input type="hidden" id="hidMtrlReady" class="right-input btn-input">
					</td>
					<td>
					<!-- 재고확인 -->
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_mtrlChkPop_Open()"><spring:message code = "pop_stockConfirm"></spring:message></button>
					</td>
				</tr>
			</table>
			<table class="jteWorkStartPop_table jteWorkStartPop_table_bottom">
				<colgroup>
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 작업시작 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_workStart"></spring:message></td>
				<tr>
				<tr>
					<td colspan="2">
					<!-- 미입력시 현재시간이 입력됩니다. -->
						<input class="center-input" name="prodWorkStart" format="datetimepicker" placeholder="<spring:message code = "pop_noEnterCurrentTime"></spring:message>"/>
					</td>
				</tr>	
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "itemId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name="eqmtMgtId"/>
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name="qtyAction"/>
						<input type="hidden" name="action"/>
						<input type="hidden" name="use"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteWorkStartPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
		</form>
	</div>
</div>

<!-- 작업종료 팝업 --> <!-- 200513 JJW 230번째 줄부터 인라인 스타일 제거 -->
<div style="display:none;">
	<div id="jteWorkEndPop">
	<div class="wrkinWrkerMgtForm jteWorkEndPop_all_div"> <!-- 200514 LYM #jteWorkEndPop이 부품 양품/불량 입력까지 이어지지 않는 오류 해결을 위해 추가-->
	<div id="mtrlUseTotal_grid" class="mtrlUseTotal-single-grid" style="display: none; width: 100%; height: 180px; min-height: 180px;"></div>
		<div class="pop_title">	<spring:message code = "pop_goodBadInput"></spring:message></div>
		<form id="jteWorkEndPop_form" class="wrkinWrkerMgtForm jteWorkEndPop_form">	
			<table class="jteWorkEndPop_table jteWorkEndPop_table_left"> <!-- 200513 LYM 안정적인 배치를 위해 좌측 우측 하단 세 테이블로 나눔 -->
				<colgroup> <!-- 50 50 -->
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 양품량 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "col_goodProdQuan"></spring:message></td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="left-input" name="prodWorkGood" format="currency"/>
					</td>
				</tr>
			</table>	
			<table class="jteWorkEndPop_table jteWorkEndPop_table_right">	
				<colgroup> <!-- 50 50 -->
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 불량량 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i>	<spring:message code = "col_badProdQuan"></spring:message></td>
				<tr>
				<tr>
					<td>
						<input class="right-input btn-input" name="prodWorkBad" format="currency" readonly/>
					</td>
					<td>
					<!-- 불량확인 -->
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_itemBadListPop_Open()"><spring:message code = "pop_badConfirm"></spring:message></button>
					</td>
				</tr>
			</table>			
			<table class="jteWorkEndPop_table jteWorkEndPop_table_bottom">
				<colgroup> <!-- 50 50 -->
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 작업종료 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_workEnd"></spring:message></td>
				<tr>
				<tr>
					<td colspan="2">
					<!-- 미입력시 현재시간이 입력됩니다 -->
						<input class="center-input" name="prodWorkEnd" format="datetimepicker" placeholder="<spring:message code = "pop_noEnterCurrentTime"></spring:message>"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "itemId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name="eqmtMgtId"/>
						<input type="hidden" name = "routingId"/>
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name="qtyAction"/>
						<input type="hidden" name="action"/>
						<input type="hidden" name="use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary jte-tempSave final-btn" type="button" onclick="lfn_workEndPop_TempSave()"><spring:message code = "pop_interStorage"></spring:message></button>			<!-- 중간저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteWorkEndPop');"><spring:message code = "pop_cancel"></spring:message></button>						<!-- 취소 -->
		</div>
	</div>
	</div>
</div>

<!-- 현재 설비에 장착되어 있는 팝업 조회 -->
<div style="display:none;">
	<div id="jteEquipToolPop" class="wrkinWrkerMgtForm jteEquipToolPop">
		<div id="jteEquipToolPop_grid" class="jteEquipToolPop-single-grid" style="height:410px;"></div>
		<!--버튼 -->
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-check final-btn" type="button" style="display:none;"><spring:message code = "pop_inspecComplete"></spring:message></button>				<!-- 점검완료 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteEquipToolPop');"><spring:message code = "pop_close"></spring:message></button>			<!-- 닫기 -->
		</div>
	</div>
</div>

<!-- 장착가능한 공구 조회 -->
<div style="display:none;">
	<div id="jteToolPosForm" class="wrkinWrkerMgtForm jteToolPosForm">
		<div id="jteToolPosForm_grid" class="jteToolPosForm-single-grid"  style="height:410px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_save"></spring:message></button>												<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteToolPosForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 자재 재고 파악 팝업-->
<div style="display:none;">
	<div id="jteMtrlChkPop" class="wrkinWrkerMgtForm jteMtrlChkPop">
		<div id="jteMtrlChkPop_MtGrid" class="jteMtrlChkPop-left-grid" style="display: inline-block; width:44%; height:345px; float: left;"></div>
		<div id="jteMtrlChkPop_SbGrid" class="jteMtrlChkPop-right-grid" style="display:inline-block; width:55%; height:345px; float: right;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-check final-btn" type="button"><spring:message code = "pop_inspecComplete"></spring:message></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlChkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 자재 재고 파악 팝업-->
<div style="display:none;">
	<div id="mtrlUseDetailPop" class="wrkinWrkerMgtForm mtrlUseDetailPop">
		<div id="mtrlUseDetail_grid" class="mtrlUseDetailPop-top-grid" style="width:100%; height:250px; min-height:250px;"></div>
		<div id="mtrlUseBad_grid" class="mtrlUseDetailPop-bottom-grid" style="display:none; width:100%; height:250px; min-height:250px; padding-top: 1px;"></div>
		<div class="final-btn-area" style="text-align:center;">
<!-- 			<button class="k-button k-primary jte-check" type="button"></button> -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlUseDetailPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 자재투입 등록/조회 팝업 -->
<div style="display:none;">
	<div id="mtrlUseSavePop">
		<form id="mtrlUseSavePop_form" class="wrkinWrkerMgtForm mtrlUseSavePop_form">
			<table class="mtrlUseSavePop_table">
				<colgroup> <!-- 20 80 -->
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-content">
				</colgroup>
				<!-- 자재투입정보 -->
				<div class="pop_title"><spring:message code = "pop_mtrlInputInfo"></spring:message></div>
				<tr>
					<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td>
					<!-- 조회버튼을 눌러 등록해주세요 -->
						<input type="text" class="left-input btn-input" name="mtrlNm" placeholder = "<spring:message code = "pop_clickButtonInput"></spring:message>" readonly/>
						<input type="hidden"  name="mtrlMgtId" />
						<input type="hidden"  name="mtrlId" />
					</td>
					<td>
						<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button" id="mtrlUseDetailSaveBtn" style="display:none;">
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
					<!-- 자재구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2">
						<input id="mtrlDiv" name="mtrlDiv" class="center-input" format="text" readonly/>
					</td>
				</tr>
				<tr>
					<!-- 투입량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inputQuan"></spring:message> : </td>
					<td colspan="2">
						<input  name="mtrlUseInput" class="center-input" format="currency"/>
					</td>
				</tr>
				<tr>
					<!-- 사용량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_useQuan"></spring:message>: </td>
					<td colspan="2">
						<input  name="mtrlUseCnt" class="center-input" format="currency"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "mtrlUseId"/>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodWorkStart"/>
						<input type="hidden" name = "prodWorkEnd"/>
						<input type="hidden" name = "prodWorkUser"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "action"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button"><spring:message code = "pop_mtrlInput"></spring:message></button>											<!-- 자재투입 -->
			<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_inputQuanChange"></spring:message></button>									<!-- 투입량변경 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlUseSavePop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 개발품목용 자재불량 리스트 팝업 -->
<div style="display:none;">
	<div id="mtrlUseBadPop" class="wrkinWrkerMgtForm mtrlUseDetailPop">
		<div id="mtrlUseBad_devItem_grid" class="mtrlUseDetailPop-bottom-grid" style="width:100%; height:250px; min-height:250px; padding-top: 1px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlUseBadPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 자재불량 등록/확인팝업 -->
<div style="display:none;">
	<div id="mtrlUseBadSavePop">
		<form id="mtrlUseBadSavePop_form" class="wrkinWrkerMgtForm mtrlUseBadSavePop_form">
			<table class="mtrlUseBadSavePop_table">
			<colgroup> <!-- 17 33 17 33 -->
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
			<!-- 불량품 정보 -->
				<div class="pop_title"><spring:message code = "pop_badInfo"></spring:message></div>
				<tr>
				<!-- 불량아이디 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : 
					</td>
					<td colspan="3"><input type="text" id="badId" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input id="badCode" class="left-input" name="badCode"  format = "selBox" msg="qual_MTRLCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 불량량 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_badProdQuan"></spring:message> : 
					</td>
					<td><input id="badQty" class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm" class="left-input" name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" id="chkUser"/>
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<!-- 	 						조회 -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
					
				<!-- 검사일 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input id="chkDate" class="right-input" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
					<td>
						<!-- 설명 -->
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input id="badDesc" class="center-input" name="badDesc"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "mtrlUseId"/>
						<input type="hidden" name = "badTarget"/>
						<input type="hidden" name = "badTargetCode"/>
						<input type="hidden" name = "mtrlId"/>
						<input type="hidden" name = "mtrlMgtId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodWorkStart"/>
						<input type="hidden" name = "prodWorkEnd"/>
						<input type="hidden" name = "prodWorkUser"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "action"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlUseBadSavePop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 부품 불량 리스트  팝업-->
<div style="display:none;">
	<div id="itemBadListPop" class="wrkinWrkerMgtForm itemBadListPop">
		<div id="itemBadListPop_grid" class="itemBadListPop-single-grid" style="width:100%; height:280px; min-height:280px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('itemBadListPop');">닫기</button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 부품 불량 등록/확인팝업 -->
<div style="display:none;">
	<div id="itemBadSavePop">
		<form id="itemBadSavePop_form" class="wrkinWrkerMgtForm itemBadSavePop_form">
		<!-- 불량품 정보 -->
			<table class="itemBadSavePop_table">
			<colgroup> <!-- 17 33 17 33 -->
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<!-- 불량품정보 -->
				<div class="pop_title"><spring:message code = "pop_badInfo"></spring:message></div> <!-- tr을 div로 변경 -->
				<tr>
				<!-- 불량아이디 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : 
					</td>
					<td colspan="3"><input type="text" id="badId" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input id="badCode" class="left-input" name="badCode"  format = "selBox" msg="qual_ITEMCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 수량 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_quantity"></spring:message> : 
					</td>
					<td><input id="badQty" class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm" class="left-input" name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" id="chkUser"/>
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<!-- 	 						조회 -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
				<!-- 검사일 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input id="chkDate" class="right-input" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input id="badDesc" class="center-input" name="badDesc"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "badTarget"/>
						<input type="hidden" name = "badTargetCode"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodWorkStart"/>
						<input type="hidden" name = "prodWorkEnd"/>
						<input type="hidden" name = "prodWorkUser"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "itemId"/>
						<input type="hidden" name = "itemMgtId"/>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "action"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('itemBadSavePop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mfgMgt/wrkinWrkerMgt/wrkinWrkerMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/wrkinWrkerMgt/wrkinWrkerMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200513 LYM&JJW -->


<script>

var lfo_checkedDate = {};

var lfo_common = {};//메인 그리드 Object 

var lfo_prodWorkStart =  {}; //작업시작 팝업

var lfo_prodWorkEnd =  {}; //작업종료 팝업

var lfo_routingAll = {}; //현재 소속되어 있는 라우팅 정보 그리드 Object

var lfo_equipTool = {}; //현재 설비에 장착된 공구 

var lfo_toolPos = {}; //장착가능한 공구

var lfo_MtMtrlChk = {}; //재고확인 팝업 그리드 - 마스터

var lfo_SbMtrlChk = {}; //재고확인 팝업 그리드 - 서브

var lfo_mtrlUseTotal = {}; //자재투입현황 - 종합

var lfo_mtrlUseDetail = {}; //자재투입현황 - 상세

var lfo_mtrlUseBad = {}; //자재투입현황 - 불량

var lfo_itemBad = {}; //부품 - 불량

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//해당날짜의 작업정보를 조회하기 위한 date 세팅
	lfn_jteWorkDate_dateSave();
	
	//그리드 생성
	//lfn_jteSgGrd_setGrd();
	
};


//해당날짜의 작업정보를 조회하기 위한 date 세팅
this.lfn_jteWorkDate_set = function(){
	//저장된 데이터가 있으면 지정한 날짜 세팅
	var savedDate = kendo.parseDate(lfo_checkedDate.year + "-" + lfo_checkedDate.month + "-" + lfo_checkedDate.day);
	
	//초기 오늘 데이터를 매핑
	if($("#prodWorkDate").attr("data-role") != "datepicker"){
		$("#prodWorkDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(savedDate) ==true ? new Date():savedDate,
			change : function(){
				lfn_jteWorkDate_dateSave();
			}
		});
	}
}


//날짜 정보 매핑 후 그리드 로드
this.lfn_jteWorkDate_dateSave = function(){
	//날짜 정보  쪼개서 변수에 저장
	var chkDate = ""
	
	if($("#prodWorkDate").attr("data-role") != "datepicker"){
		chkDate = gfn_getDate(new Date(),"yyyy-MM-dd");
	}else{
		chkDate = gfn_getDate($("#prodWorkDate").data("kendoDatePicker").value(),"yyyy-MM-dd");
	}
	
	lfo_checkedDate.user = $("#_loginUserId").val();
 	lfo_checkedDate.year = chkDate.split("-")[0];
	lfo_checkedDate.month = chkDate.split("-")[1];
	lfo_checkedDate.day = chkDate.split("-")[2];
	
	
	//작업정보 비활성
	$("#jteProdWorkForm").hide();
	
	//그리드 리로드
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
	
	//새로고침 추가 이벤트 바인딩
	$("#jteSingleGrid .jte-refresh").on("click",function(){
		$("#jteProdWorkForm").hide();
	});
}

//main-grid  현재 자신의 작업정보를 grid로 표시한다.
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jteProdWorkForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_common.crud  = {
		read:{url:"/getProdWorkList", auth:"", prmt:{
// 			prodPlanYear : "2020",
// 			prodPlanMonth : "01",
// 			prodPlanDay : "01",
 			prodPlanYear : lfo_checkedDate.year,
 			prodPlanMonth : lfo_checkedDate.month,
 			prodPlanDay : lfo_checkedDate.day,
			prodWorkUser : lfo_checkedDate.user
		},search:false, paging:false}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		update:{url:"", auth:"", openFunc : lfn_jteSgGrid_dblclick, callback:""},
		//destroy:{url:"", auth:"", callback:""}
		excel:{url:"" ,auth:"", fileName: "작업일보_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
	};
	
	//기존 검색창 제거, 커스텀타이틀 추가.
	lfo_common.customTitle = {html:"<input id='prodWorkDate' name='prodWorkDate' />", callback : lfn_jteWorkDate_set};
	
	//5.
	lfo_common.model = {
			id: "prodWorkId",
			fields: {
				orderId: { type: "string" },
				lotId: { type: "string" },
				lotNm: { type: "string" },
				
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemDeduction: { type: "int" },
				itemDayTarget: { type: "int" },
				itemTotalStock: { type: "int" },
				itemStd01: { type: "int" },
				itemStd02: { type: "int" },
				itemStd03: { type: "int" },
				itemStd04: { type: "int" },
				itemStd05: { type: "int" },
				itemStdStr01: { type: "string" },
				itemStdStr02: { type: "string" },
				itemStdStr03: { type: "string" },
				itemStdStr04: { type: "string" },
				itemStdStr05: { type: "string" },
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				
				prodPlanId: { type: "string" },
				prodPlanYear: { type: "int" },
				prodPlanMonth: { type: "int" },
				prodPlanDay: { type: "int" },
				prodPlanQty: { type: "int" },
				prodPlanDesc: { type: "string" },
				prodAsmId: { type: "string" },
				prodAsmNm: { type: "string" },
				prodAsmDate: { type: "date" },
				prodAsmQty: { type: "int" },
				prodAsmDesc: { type: "string" },
				prodAsmUser: { type: "string" },
				prodAsmUserNm: { type: "string" },
				prodAsmEmj: { type: "string" },
				prodAsmState: { type: "string" },
				createdAt: { type: "date" },
				creatorId: { type: "string" },
				deptId: { type: "string" },
				deptNm: { type: "string" },
				prodWorkId: { type: "string" },
				routingId: { type: "string" },
				routingSeq: { type: "int" },
				routingType: { type: "string" },
				bomTarget: { type: "string" },
				eqmtMgtId: { type: "string" },
				eqmtMgtNm: { type: "string" },
				placeId : { type: "string" },
				placeNm : { type: "string" },
				prodWorkUser: { type: "string" },
				prodWorkUserNm: { type: "string" },
				prodWorkQty: { type: "int" },
				prodWorkGood: { type: "int" },
				prodWorkBad: { type: "int" },
				prodWorkStart: { type: "date" },
				prodWorkEnd: { type: "date" },
				prodWorkDesc: { type: "string" },
				planAction: { type: "string" },
				workAction: { type: "string" }
			}
		};
	
	//6.
		//6.
	lfo_common.columns = [
		//{selectable : true, width:"50px"},
// 		{field: "prodAsmNm", title:"생산지시명", width: 150},
// 		{field: "prodAsmUserNm", title:"지시자", width: 110},
// 		{field: "prodAsmState", title:"상태", width: 100},
// 		{field: "deptNm", title:"부서명", width: 120},
 		{field: "prodAsmId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jteSgGrid_dblclick(\'NEW\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:gfn_getMsg("col_workSearch"), width: "120px"},											//작업조회
		{field: "prodWorkStart", template:"# var item = gfn_isNull(prodWorkStart)== true ? '작업대기' : gfn_isNull(prodWorkEnd) == true ? '진행중' : '작업완료' #  #= item #",
				title : gfn_getMsg("col_progress"), width: "110px"},										//진행여부
 		{field: "itemNm", title:gfn_getMsg("col_productionItem"), width: "160px"},							//생산품
 		{field: "routingType", template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #", 
			title:gfn_getMsg("col_routType"), width: "160px"},												//공정유형
 		{field: "routingSeq", format:"{0:n0}", attributes : { style : "text-align : right;"},title:gfn_getMsg("col_routSeq"), width: "100px"},				//차수
 		{field: "prodWorkQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_asmQuan"), width: "110px"},			//지시량
 		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",
 			title:gfn_getMsg("col_prodEmj"), width: "110px"},												//긴급여부
 		//{field: "prodWorkId", title:"작업정보코드", width: 120},
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "180px"},								//라우팅코드
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "160px"},							//설비명
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "140px"},								//위치명
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "130px"},							//작업자
		//{field: "prodAsmDesc", title:gfn_getMsg("col_desc"), width: 300},
		{field: "prodWorkDesc", title:gfn_getMsg("col_desc"), width: "300px"}								//설명
		//{field: "prodWorkGood", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:"생산량", width: 120},
		//{field: "prodWorkBad", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:"불량량", width: 120},
		
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//메인그리드 더블클릭 콜백 > 작업정보 상세조회 - 우측화면 
this.lfn_jteSgGrid_dblclick = function(mode, target){
	
	var dataItem = {};
	
	//상세정보 활성화
	$("#jteProdWorkForm").show();
	
	if(mode =="NEW"){
		//작업지시 목록에서 선택한 값 저장
		dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	}else if(mode =="EDT"){
		//저장 후 리로드 시
		dataItem = target;
	}
	
	//선택한 버튼 선택 표시(버튼 색변경)
	$("#"+ lfo_common.layoutId +" .pop-on").removeClass("pop-on");
	lfo_common.grid.dataSource.data().forEach(function(item,index){
		if(item["prodWorkId"] == dataItem.prodWorkId){
			setTimeout(function(){
				$("#" + lfo_common.layoutId + " .k-grid-content").find("tr").eq(index).find(".k-button").addClass("pop-on");
			},500);
		}
	});
	
	//버튼 초기화
	$("#prodWorkStartBtn").hide();
	$("#prodWorkEndBtn").hide();
	$("#eqipToolChangeBtn").hide();
	$("#prodWorkStartBtn").off('click');
	$("#prodWorkEndBtn").off('click');
	
	//필요데이터 담기
	lfo_common.gridSelected={
		eqmtMgtId : dataItem.eqmtMgtId,
		itemId : dataItem.itemId,
		itemNm : dataItem.itemNm,
		prodPlanId : dataItem.prodPlanId, 
		prodPlanYear : dataItem.prodPlanYear, 
		prodPlanMonth : dataItem.prodPlanMonth, 
		prodPlanDay : dataItem.prodPlanDay,
		prodAsmId : dataItem.prodAsmId,
		prodWorkId : dataItem.prodWorkId,
		lotId : dataItem.lotId,
		routingId : dataItem.routingId,
		prodWorkUser: dataItem.prodWorkUser,
		prodWorkStart: dataItem.prodWorkStart,
		prodWorkEnd: dataItem.prodWorkEnd
	}
	
	//ajax호출하여 최신 정보 세팅 
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getProdWorkPop",
		type: "POST",
		data: lfo_common.gridSelected,
		success: function(data){
			//작업정보화면 세팅(메인우측)
			gfn_popform_set(lfo_common, "EDT", data.rows[0]);
			
			//초기 - 작업시작전
			if(gfn_isNull(data.rows[0].prodWorkStart)){
				$("#workFlag").val("start");
				//작업시작 버튼 활성화
				$("#prodWorkStartBtn").show();
				$("#prodWorkStartBtn").on('click',function(){
					lfn_workStartPop_Open();
				});
			//작업시작 후 
			}else if(gfn_isNull(data.rows[0].prodWorkEnd)){
				$("#workFlag").val("end");
				//공구 조회/교체 버튼 활성화
				$("#eqipToolChangeBtn").show();
				
				//작업종료 버튼 활성화
				$("#prodWorkEndBtn").show();
				$("#prodWorkEndBtn").on('click',function(){
					lfn_workEndPop_Open();
				});
				
			}else{
				$("#workFlag").val("finish");
			}
			//개발품목 예외처리
			if(!gfn_isEmpty(gfn_getCode("devItem")) && lfo_common.gridSelected.itemId == gfn_getCode("devItem").cdVal){
				$("#eqipToolChangeBtn").hide();
			}
			/* else if(gfn_isNull(data.rows[0].prodWorkStart)){
				$("#prodWorkEndBtn").show();
				$("#prodWorkEndBtn").on('click',function(){
					lfn_workEndPop_Open();
				});
			} */
			$("#"+lfo_common.popId+"_form").show();
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
	
	gfn_fileLoad("attachArea",lfo_common.gridSelected.routingId);
}

// 전체 공정 보기 버튼 클릭 (팝업 오픈)
this.lfn_routingPop_Open = function(){
	var options = {
		modal:true, 
		width: "900px", 
		height: "470px", 
		id : "jteRoutingAllPop", 
		title:gfn_getMsg("pop_allProcessConfirm"),			//전체 공정확인
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//전체 공정 그리드 세팅
		this.lfn_jteRoutingAll_setGrd();
		
		//그리드가 정상적으로 생성되었다면 show();
		if(gfn_isEmpty(lfo_routingAll.grid)){
			$("#jteRoutingAllPop").show();
		}
	};
	
	this.gfn_winOpen(options);
}

//라우팅 전체 조회 팝업 내부 그리드 세팅
this.lfn_jteRoutingAll_setGrd = function(){
	lfo_routingAll = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_routingAll.layoutId = "jteRoutingAllPop_grid";
	
	//2.
	//lfo_routingAll.popId = "jteProdWorkForm";
	
	//3.
	lfo_routingAll.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_routingAll.crud  = {
		read:{url:"/getProdWorkList", auth:"", prmt:{
 			prodPlanYear : lfo_common.gridSelected.prodPlanYear,
 			prodPlanMonth : lfo_common.gridSelected.prodPlanMonth,
 			prodPlanDay : lfo_common.gridSelected.prodPlanDay,
 			lotId : lfo_common.gridSelected.lotId,
 			prodAsmId : lfo_common.gridSelected.prodAsmId
 			},search:false}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"", auth:"", openFunc : lfn_jteSgGrid_dblclick, callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
	lfo_routingAll.model = {
			id: "prodWorkId",
			fields: {
				orderId: { type: "string" },
				lotId: { type: "string" },
				lotNm: { type: "string" },
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemDeduction: { type: "int" },
				itemDayTarget: { type: "int" },
				itemTotalStock: { type: "int" },
				itemStd01: { type: "int" },
				itemStd02: { type: "int" },
				itemStd03: { type: "int" },
				itemStd04: { type: "int" },
				itemStd05: { type: "int" },
				itemStdStr01: { type: "string" },
				itemStdStr02: { type: "string" },
				itemStdStr03: { type: "string" },
				itemStdStr04: { type: "string" },
				itemStdStr05: { type: "string" },
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				prodPlanId: { type: "string" },
				prodPlanYear: { type: "int" },
				prodPlanMonth: { type: "int" },
				prodPlanDay: { type: "int" },
				prodPlanQty: { type: "int" },
				prodPlanDesc: { type: "string" },
				prodAsmId: { type: "string" },
				prodAsmNm: { type: "string" },
				prodAsmDate: { type: "date" },
				prodAsmQty: { type: "int" },
				prodAsmDesc: { type: "string" },
				prodAsmUser: { type: "string" },
				prodAsmUserNm: { type: "string" },
				prodAsmEmj: { type: "string" },
				prodAsmState: { type: "string" },
				createdAt: { type: "date" },
				creatorId: { type: "string" },
				deptId: { type: "string" },
				deptNm: { type: "string" },
				prodWorkId: { type: "string" },
				routingId: { type: "string" },
				routingSeq : { type: "int" },
				routingType :  { type: "string" },
				bomTarget: { type: "string" },
				eqmtMgtId: { type: "string" },
				eqmtMgtNm: { type: "string" },
				prodWorkUser: { type: "string" },
				prodWorkUserNm: { type: "string" },
				prodWorkQty: { type: "int" },
				prodWorkGood: { type: "int" },
				prodWorkBad: { type: "int" },
				prodWorkStart: { type: "date" },
				prodWorkEnd: { type: "date" },
				planAction: { type: "string" },
				workAction: { type: "string" }
			}
		};
	
	//6.
	lfo_routingAll.columns = [
		{field: "routingSeq", template:"# var item = gfn_isNull(prodWorkUser) == true ? '' : prodWorkUser == '"+lfo_common.gridSelected.prodWorkUser+"' ?   ' < 내 작업'  : '' # #=  routingSeq + item #" 
			,title:gfn_getMsg("col_routSeq"), width: "110px"},												//차수
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "170px"},								//라우팅코드
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routType"), width: "160px"},												//공정유형
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "160px"},							//설비명
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "130px"},							//작업자
		{field: "prodWorkQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_asmQuan"), width: "110px"}			//지시량
		//{selectable : true, width:"50px"},
		//{field: "prodAsmNm", title:"생산지시명", width: 150},
		//{field: "prodAsmUserNm", title:"지시자", width: 110},
		//{field: "prodAsmState", title:"상태", width: 100},
		//{field: "deptNm", title:"부서명", width: 120},
 		//{field: "prodAsmId", title:"생산지시코드", width: 150},
 		//{field: "prodAsmNm", title:"생산지시명", width: 150},
 		//{field: "itemNm", title:"생산품", width: 150},
 		//{field: "prodAsmEmj",template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",title:"긴급여부", width: 100},
 		//{field: "prodWorkId", title:"작업정보코드", width: 120},
		//{field: "prodAsmDesc", title:"생산지시 비고", width: 300}
		//{field: "prodWorkGood", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:"생산량", width: 120},
		//{field: "prodWorkBad", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:"불량량", width: 120},
		//{field: "prodWorkStart", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"작업시작", width: 120},
		//{field: "prodWorkEnd", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"작업종료", width: 120}
	];
	
	//7.
	lfo_routingAll.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];
	
	//공통 그리드 세팅 호출 
	lfo_routingAll.grid = gfn_grid_set(lfo_routingAll);
}

//더블클릭 콜백(팝업) -- 선택한 설비에 장착된 공구 팝업
this.lfn_jteEquipToolPop_open = function(mode){
	var options = {
		modal:true, 
		width: "950px", 
		height: "480px", // 200515 JJW 설비 장착 공구 높이 팝업 460-> 480
		id : 'jteEquipToolPop', 
		title:gfn_getMsg("pop_eqmtToolMount"),			//설비 장착 공구
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = gfn_serializeObject('jteProdWorkForm_form')
		
		//그리드 조회
		lfn_jteEquipToolPop_setGrd();
		
		//점검모드 활성화
		if(mode == "CHK"){
			//버튼 보이기
			$("#jteEquipToolPop .jte-check").show();
			//버튼 이벤트 할당
			$("#jteEquipToolPop .jte-check").on('click',function(){
				lfn_jteEquipToolPop_check();
			});
		}else{
			$("#jteEquipToolPop .jte-check").hide();
		}
	};
	this.gfn_winOpen(options);
}

//점검완료 버튼 수행
this.lfn_jteEquipToolPop_check = function(){
	//점검확인 상태값
	var toolChkFlag = true;
	
	//등록된 모든 행에 대해 공구상태값이 eqipState01(정상)이 아니면 점검이 되지 않게 한다.
	$("#jteEquipToolPop_grid .k-grid-content").find("tr").each(function(){
		var rows = lfo_equipTool.grid.dataItem($(this));
		if(rows.eqipState != 'eqipState01'){
			alert(rows.toolLocation + "의 공구를 확인해주세요.");
			toolChkFlag = false;
			return false;
		}
	});
	
	//모든항목이 사용가능한 공구이면 점검완료!
	if(toolChkFlag){
		lfn_workStartPop_set("TOOLCHK");
		
		gfn_closePop("jteEquipToolPop");
	}
}

//팝업내부 그리드 - 선택한 설비에 장착된 공구 조회
this.lfn_jteEquipToolPop_setGrd = function(){
	
	lfo_equipTool = {};
	
	//1.
	lfo_equipTool.layoutId = "jteEquipToolPop_grid";
	
	//2.
	lfo_equipTool.popId = "jteToolPosForm";
	
	//3.
	lfo_equipTool.ctrlUrl = "/form/facilMgt/facilToolMgt"
	
	//4.
	lfo_equipTool.crud  = {
		read:{url:"/getRoutingToolCurList", auth:"", prmt:{eqmtMgtId: lfo_common.gridSelected.eqmtMgtId, routingId: lfo_common.gridSelected.routingId}
			,paging : false, search : false},
		create:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_jteToolPos_popOpen, callback : lfn_toolPos_save},
		//update:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_toolPos_save, callback : lfn_toolPos_save},
		destroy:{url:"/setEqmtToolDelete", auth:"", callback : lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_equipTool.model = {
		id: "toolId",
		fields: {
			toolId: { type: "string" },
			toolLocation: { type: "string" },
			eqipId: { type: "string" },
			eqipNm: { type: "string" },
			toolCount: { type: "float" },
			toolRpm: { type: "int" },
			toolMgtId: { type: "string" },
			toolMgtPurchase: { type: "string" },
			toolMgtState: { type: "string" },
			toolMgtLimit: { type: "int" },
			toolMgtUse: { type: "int" },
			toolMgtVerif: { type: "date" },
			toolMgtGbn: { type: "string" },
			toolMgtDesc: { type: "string" },
			compId: { type: "string" },
			compNm: { type: "string" },
			toolNm: { type: "string" },
			eqipState : { type: "string" }
		}
	};
	
	//개발품목 예외처리를 위함
	var eqipState_devItem = {field: "eqipState", template:"# var item = gfn_isNull(gfn_getCode(eqipState))== true ? eqipState : gfn_getMsg('bc_'+ gfn_getCode(eqipState).cdId , gfn_getCode(eqipState).cdNm) # #= item #",
			title : gfn_getMsg("col_mountStatus"), width: "220px"};																//장착상태
	if(!gfn_isEmpty(gfn_getCode("devItem")) && lfo_common.gridSelected.itemId == gfn_getCode("devItem").cdVal){
		eqipState_devItem = "";
	}
	//6.
	lfo_equipTool.columns = [
		{selectable : true, width:"50px"},
		{field: "toolLocation", title : gfn_getMsg("col_mountPosition"), width: "110px"},										//장착위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: "160px"},													//공구명
		{field: "toolMgtId", title : gfn_getMsg("col_toolIndivCd"), width: "170px"},											//공구개별코드
		eqipState_devItem,
		{field: "eqipState", template:"# var stock = Math.ceil((toolMgtLimit - toolMgtUse)/toolCount); var item = gfn_isNull(toolMgtId) == true ? '' :  eqipState != 'eqipState01' ? '' : "+
				"stock > "+ lfo_common.gridSelected.prodWorkQty +" ? stock +'개 생산가능':"+
				 "stock+'개 생산후 교체요망(' + Math.ceil((" + lfo_common.gridSelected.prodWorkQty + " * toolCount - stock) * toolCount) +' 이상 공구 교체)' # #= item #",
				title : gfn_getMsg("col_lifeMgt"), width: "150px"},																//수명관리
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_useLimit"), width: "110px"},							//사용한도
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_toolUse"), width: "110px"},								//사용량
		{field: "toolCount", format:"{0:n}", title : gfn_getMsg("col_feedrate"), width: "110px"},								//FEEDRATE
		{field: "toolRpm", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_toolRpm"), width: "110px"},									//RPM
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? toolMgtGbn : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
				title : gfn_getMsg("col_toolDiv"), width: "160px"},																//공구구분
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? toolMgtState : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: "140px"},															//공구상태
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "180px"},			//입고일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_verifyPeriod"), width: "140px"},				//검증기간
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: "170px"},													//업체명
		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: "300px"}													//설명
	];
	
	//7.
	lfo_equipTool.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_equipTool.grid = gfn_grid_set(lfo_equipTool);
}

//설비장착공구  장착해제 - 작업을 시작했다면 사용량 입력 받게 함
this.lfn_jtePopGrd_delete = function(){
	if($("#workFlag").val() == "start"){
		lfn_jtePopGrd_delete_callback();
	}else{
		gfn_dialBox({msg:"현재 생산량 입력", title:"공구사용정보", yes : lfn_jtePopGrd_delete_callback, no: function(){}});
	}
}

//설비장착공구  장착해제 콜백- 작업을 시작했다면 사용량 입력 받게 함
this.lfn_jtePopGrd_delete_callback = function(resultObj){
	
	//생산량입력이 있는 경우 취소나 값을 입력하지 않는 경우 실행하지 않는다.
	if(!gfn_isEmpty(resultObj) && typeof(resultObj) == "function"){
		if(typeof(resultObj.result) != "int"){
			return false;
		}
	}
	
	var delPrmt = [];
	$("#"+ lfo_equipTool.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			
			delItem = lfo_equipTool.grid.dataItem($(this).closest('tr'));
			if(!gfn_isNull(delItem.eqipId)){//장착되지 않은 공구 삭제 에러 예외처리
				delItem.eqipPosition = delItem.toolLocation;
				delItem.eqmtMgtId = lfo_common.gridSelected.eqmtMgtId;
				if($("#workFlag").val() == "start"){
					delItem.historyYN = "N";
				}else{
					delItem.prodWorkId = lfo_common.gridSelected.prodWorkId;
					delItem.prodWorkStart = lfo_common.gridSelected.prodWorkStart;
					delItem.lotId = lfo_common.gridSelected.lotId;
					delItem.toolUseQty = resultObj.result;
					delItem.historyYN = "Y";
				}
				delPrmt.push(delItem);
			}
		}
	});
	
	$.ajax({
		async:false,
		url : "/form/mfgMgt/wrkinWrkerMgt/setEqmtToolDelete",
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_equipTool.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

// 장착 가능한 공구 조회 팝업
this.lfn_jteToolPos_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "650px", 
		height: "490px", /* 200515 JJW 장착 가능 공구 조회 팝업 높이(&공구조회/교체 추가버튼 팝업) 460-> 490px */
		id : lfo_equipTool.popId, 
		title : gfn_getMsg("col_possToolSrh","장착가능공구조회"),			//장착 가능 공구 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){		
		//그리드 세팅
		$("#jteToolPosForm_grid").html();
		lfn_jteToolPos_setGrd();
		
	};
	this.gfn_winOpen(options);	
}

//그리드 - 장착 가능한 공구 조회 그리드 
this.lfn_jteToolPos_setGrd = function(){
	
	lfo_toolPos = {};
	
	//1.
	lfo_toolPos.layoutId = "jteToolPosForm_grid";
	
	//2.
	//lfo_toolPos.popId = "jteToolPosForm";
	
	//3.
	lfo_toolPos.ctrlUrl = "/form/facilMgt/facilToolMgt"

	//4.
	lfo_toolPos.crud  = {
		read:{url:"/getEqmtToolPosList", auth:"", prmt:{itemId : lfo_common.gridSelected.itemId, routingId : lfo_common.gridSelected.routingId},
			search : false, paging : false}
	};
	
	//5.
	lfo_toolPos.model = {
		id: "toolMgtId",
		fields: {
			toolRpm: { type: "int" },
			toolLocation: { type: "string" },
			toolCount: { type: "int" },
			routingId: { type: "string" },
			routingType: { type: "string" },
			toolMgtId: { type: "string" },
			toolMgtPurchase: { type: "string" },
			toolMgtState: { type: "string" },
			toolMgtLimit: { type: "int" },
			toolMgtUse: { type: "int" },
			toolMgtVerif: { type: "date" },
			toolMgtGbn: { type: "string" },
			toolMgtDesc: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" },
			compId: { type: "string" },
			compNm: { type: "string" },
			toolId: { type: "string" },
			toolNm: { type: "string" }
		}
	};
	
	//6.
	lfo_toolPos.columns = [
		{selectable : true, width:"50px"},
		{field: "toolLocation", title : gfn_getMsg("col_mountPosition"), width: "110px"},										//장착위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: "160px"},													//공구명
		{field: "toolRpm", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_toolRpm"), width: "110px"},									//RPM
		{field: "toolCount", format:"{0:n}", title : gfn_getMsg("col_feedrate"), width: "110px"},								//FEEDRATE
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_useLimit"), width: "110px"},							//사용한도
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_toolUse"), width: "110px"},								//사용량
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
			title : gfn_getMsg("col_toolDiv"), width: "160px"},																	//공구구분
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: "170px"},															//공구상태
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "170px"},			//입고일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_verifyPeriod"), width: "140px"},				//검증기간
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: "140px"},													//업체명
		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: "300px"}													//설명
	];
	
	//7.
	lfo_toolPos.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_toolPos.grid = gfn_grid_set(lfo_toolPos);
	
	$("#"+lfo_equipTool.popId+" .jte-update").on("click",function(){
		lfn_toolPos_save();
	});
}

//설비에 장착가능한 공구 저장
this.lfn_toolPos_save = function(mode,selectedItem){
	var savePrmt = [];
	$("#"+ lfo_toolPos.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var item = lfo_toolPos.grid.dataItem($(this).closest('tr'));
			item.eqipNm = item.itemNm;
			item.eqipPosition = item.toolLocation;
			item.eqmtMgtId = lfo_common.gridSelected.eqmtMgtId;
			savePrmt.push(item);
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_toolPos.ctrlUrl + "/setEqmtToolSave",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//이전 그리드 리로드
				lfo_equipTool.grid.dataSource.read();
				//현재팝업 종료
				gfn_closePop(lfo_equipTool.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//작업시작 팝업 - 오픈
this.lfn_workStartPop_Open = function(){
	
	//pop가 두개라 커스텀 오브젝트
	lfo_prodWorkStart = {
		popId : "jteWorkStartPop",
		ctrlUrl : "/form/mfgMgt/wrkinWrkerMgt",
		crud : {
			read:{url:"/getProdWorkList"},  
			update:{url:"/setProdWorkStartSave", auth:"", callback : lfn_workStartPop_Save}
		}
	};
	
	var options = {
		modal:true, 
		width: "570px", 
		height: "340px", /* 200515 JJW 290 -> 340 */
		id : lfo_prodWorkStart.popId, 
		title:gfn_getMsg("pop_wrkStartCheck"),			//작업시작 전 점검사항
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_workStartPop_set('NEW');
	};
	this.gfn_winOpen(options);	
}

//작업시작 팝업 - 세팅
this.lfn_workStartPop_set = function(mode){
	if(mode == "NEW"){
		$(".workStartMtrlArea").hide();
		
		
		//미점검 상태 
		$("#jteWorkStartPop #toolReady").text("미점검"); // 200514 JJW & LYM 공구 미 점검 상태 버튼 디자인 추가 (개별 css)
		$("#jteWorkStartPop #toolReady").css({"font-weight":"bold","color":"red"});
		$("#jteWorkStartPop #hidToolReady").val("");
		$("#jteWorkStartPop #mtrlReady").text("미점검");
		$("#jteWorkStartPop #mtrlReady").css({"font-weight":"bold","color":"red"});
		$("#jteWorkStartPop #hidMtrlReady").val("");
		
		//ajax호출하여 최신 정보 세팅 
		$.ajax({
			async:false,
			url : lfo_prodWorkStart.ctrlUrl + lfo_prodWorkStart.crud.read.url,
			type: "POST",
			data: lfo_common.gridSelected,
			success: function(data){
				//작업정보화면 세팅(메인우측)
				gfn_popform_set(lfo_prodWorkStart, "EDT", data.rows[0]);
				
				//개발품목 예외처리
				if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_common.gridSelected.itemId != gfn_getCode("devItem").cdVal){
					//해당 라우팅에서 자재를 입력하는 경우(라우팅 - bom) 
					if(!gfn_isNull(data.rows[0].bomTarget) && data.rows[0].bomTarget.indexOf('prcs_bom02') != -1){
						$(".workStartMtrlArea").show();
					}else{
						$("#jteWorkStartPop #mtrlReady").text("점검완료");
						$("#jteWorkStartPop #hidMtrlReady").val("CHK");
					}
				}else{
					$(".workStartMtrlArea").hide();
					$(".workStartToolArea").hide();
					
					$("#jteWorkStartPop #mtrlReady").text("점검완료");
					$("#jteWorkStartPop #hidMtrlReady").val("CHK");
					$("#jteWorkStartPop #toolReady").text("점검완료");
					$("#jteWorkStartPop #hidToolReady").val("CHK");
				}
				
			},
			error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		
	}else if(mode == "TOOLCHK"){
		//공구 점검완료 상태 
		$("#jteWorkStartPop #toolReady").text("점검완료"); // 200514 JJW & LYM 공구 점검 완료 상태 버튼 디자인 추가
		$("#jteWorkStartPop #toolReady").css({"font-weight":"bold","color":"#00bd26","border":"2px solid #00bd26","background-color":"rgba(0, 230, 46, 0.25)","border-radius":"4px","padding-top":"4px","padding-bottom":"4px","padding-left":"4px","padding-right":"5px","text-align":"center"});
		$("#jteWorkStartPop #hidToolReady").val("CHK");
	}else if(mode == "MTRLCHK"){
		//자재 점검완료 상태
		$("#jteWorkStartPop #mtrlReady").text("점검완료");
		$("#jteWorkStartPop #mtrlReady").css({"font-weight":"bold","color":"#00bd26","border":"2px solid #00bd26","background-color":"rgba(0, 230, 46, 0.25)","border-radius":"4px","padding-top":"4px","padding-bottom":"4px","padding-left":"4px","padding-right":"5px","text-align":"center"});
		$("#jteWorkStartPop #hidMtrlReady").val("CHK");
	}
}


//작업시작 팝업 -저장
this.lfn_workStartPop_Save = function(){
	
	//공구,자재 점검완료시에만 실행된다.
	if($("#jteWorkStartPop #hidToolReady").val() == "CHK" && $("#jteWorkStartPop #hidMtrlReady").val() == "CHK"){
		
		var savePrmt = gfn_serializeObject(lfo_prodWorkStart.popId+"_form");
		//시간 값 없는 경우 현재시간 세팅
		savePrmt.prodWorkStart = gfn_isNull(savePrmt.prodWorkStart) == true ? gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss") : savePrmt.prodWorkStart;
		
		$.ajax({
			async:false,
			url : lfo_prodWorkStart.ctrlUrl + lfo_prodWorkStart.crud.update.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//마스터테이블 리로드
					lfo_common.grid.dataSource.read();
					
					//작업정보 리로드
					lfn_jteSgGrid_dblclick("EDT",lfo_common.gridSelected)
					
					//현재팝업 종료
					gfn_closePop(lfo_prodWorkStart.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}else{
		alert(gfn_getMsg("pop_checkCompleteWork"));			//점검을 완료후 작업을 시작해주세요
	}
}

//작업종료  팝업 - 오픈
this.lfn_workEndPop_Open = function(){
	var options = {
		modal:true, 
		width: "700px", 
		height: "500px", // 200512 JJW 작업종료 팝업 높이 270 -> 600px;
		id : "jteWorkEndPop", 
		title:gfn_getMsg("pop_wrkEndConfirmList"),			//작업종료 전 확인사항
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_workEndPop_set();
	};
	this.gfn_winOpen(options);	
}

//작업종료 팝업 - 세팅
this.lfn_workEndPop_set = function(keepData){
	
	$("#mtrlUseTotal_grid").hide();
	
	//pop가 두개라 커스텀 오브젝트
	lfo_prodWorkEnd = {
		popId : "jteWorkEndPop",
		ctrlUrl : "/form/mfgMgt/wrkinWrkerMgt",
		crud : {
			read:{url:"/getProdWorkList"},  
			update:{url:"/setProdWorkEndSave", auth:"", callback : lfn_workEndPop_Save}
		}
	};
	
	//ajax호출하여 최신 정보 세팅 
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud.read.url,
		type: "POST",
		data: lfo_common.gridSelected,
		success: function(data){
			var rtnData = data.rows[0];
			
			//불량등록시 이전에 입력된 데이터 초기화 되므로 예외처리
			if(!gfn_isNull(keepData)){
				for(key in keepData){
					rtnData[key] = keepData[key];
				}
			}
			
			//작업정보화면 세팅(메인우측)
			gfn_popform_set(lfo_prodWorkEnd, "EDT", rtnData);
			
			//해당 라우팅에서 자재를 입력하는 경우(라우팅 - bom) 
			if(!gfn_isNull(data.rows[0].bomTarget) && data.rows[0].bomTarget.indexOf('prcs_bom02') != -1){
				$("#mtrlUseTotal_grid").show();
				
				//개발품목 예외처리
				if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_common.gridSelected.itemId != gfn_getCode("devItem").cdVal){
					lfn_mtrlUseTotal_gridSet();
				}else{
					lfn_mtrlUseTotal_devItem_gridSet();
				}
				
				gfn_resizePop(lfo_prodWorkEnd.popId,{width:700, height:570}) /*200515 JJW 작업종료 팝업 높이 500에서 570로*/
			}
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//작업 종료 팝업 - 저장
this.lfn_workEndPop_Save = function(){
	
	var savePrmt = gfn_serializeObject(lfo_prodWorkEnd.popId+"_form");
	//시간 값 없는 경우 현재시간 세팅
	savePrmt.prodWorkEnd = gfn_isNull(savePrmt.prodWorkEnd) == true ? gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss") : savePrmt.prodWorkEnd;
	savePrmt.prodWorkStart = gfn_isNull(lfo_common.gridSelected.prodWorkStart) == true ? gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss") :
		typeof(lfo_common.gridSelected.prodWorkStart) == "string" ? lfo_common.gridSelected.prodWorkStart : gfn_getDate(lfo_common.gridSelected.prodWorkStart,"yyyy-MM-dd HH:mm:ss");
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud.update.url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//현재팝업 종료
				gfn_closePop(lfo_prodWorkEnd.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
				//마스터테이블 리로드
				lfo_common.grid.dataSource.read();
				
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT",lfo_common.gridSelected)
				
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//작업 종료 팝업 - 중간저장
this.lfn_workEndPop_TempSave = function(){
	
	var savePrmt = gfn_serializeObject(lfo_prodWorkEnd.popId+"_form");
	savePrmt.action = "TEMP";
	
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + "/setProdWorkEndPgSave",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//현재팝업 종료
				gfn_closePop(lfo_prodWorkEnd.popId);
				
				gfn_msgBox({msg : gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT",lfo_common.gridSelected)
				
				
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//자재재고파악 팝업 오픈
this.lfn_mtrlChkPop_Open = function(){
	var options = {
			modal:true, 
			width: "1250px", 
			height: "430px", //200518 JJW 자재재고파악 팝업 높이 390 -> 430
			id : "jteMtrlChkPop", 
			title:gfn_getMsg("pop_mtrlStockConfirm"),			//자재 재고확인
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			//그리드 그리기
			lfn_mtrlChkPop_mtGridSet();
			
			//버튼 보이기
			$("#jteMtrlChkPop .jte-check").show();
			
			//버튼 이벤트 할당
			$("#jteMtrlChkPop .jte-check").on('click',function(){
				lfn_workStartPop_set("MTRLCHK");
				
				gfn_closePop("jteMtrlChkPop");
			});
		
		};
		this.gfn_winOpen(options);	
}

//자재재고 파악 팝업 세팅 - 마스터
this.lfn_mtrlChkPop_mtGridSet = function(){
	lfo_MtMtrlChk = {};
	
	//1.
	lfo_MtMtrlChk.layoutId = "jteMtrlChkPop_MtGrid";
	
	//2.
	//lfo_MtMtrlChk.popId = "jteToolPosForm";
	
	//3.
	lfo_MtMtrlChk.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_MtMtrlChk.crud  = {
		read:{url:"/getProdMtrlChkList", auth:"", prmt:{routingId : lfo_common.gridSelected.routingId},
			search : false, paging:false}, 
		//create:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback : lfn_jtePopGrd_save},
		update:{auth:"", openFunc : lfn_mtrlChkPop_sbGridSet, callback : ""}
		//destroy:{url:"/setEqmtToolDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//커스텀 타이틀
	lfo_MtMtrlChk.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("pop_needMtrlInfo")+'</span>'			//필요자재정보
	}
	
	//5.
	lfo_MtMtrlChk.model = {
		id: "mtrlId",
		fields: {
			routingId : {type:"string"},
			itemId : {type:"string"}, 
			bomId : {type:"string"},
			bomTargetCnt : {type:"int"},
			mtrlId : {type:"string"},
			mtrlNm : {type:"string"},
			mtrlType : {type:"string"},
			mtrlHCD : {type:"string"},			
			mtrlStd01 : {type:"int"}, 
			mtrlStd02 : {type:"int"}, 
			mtrlStd03 : {type:"int"}, 
			mtrlStd04 : {type:"string"},
			mtrlStd05 : {type:"int"}, 
			mtrlUseday : {type:"int"}, 
			mtrlCost : {type:"int"}, 
			isUse : {type:"bool"},  
			description : {type:"string"},
			mtrlQual : {type:"string"}, 
			mtrlUnit : {type:"string"}
		}
	};
	
	//6.
	lfo_MtMtrlChk.columns = [
		//{field: "mtrlId", title : "자재코드", width: 120},
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "120px"},									//자재명
		{field: "bomTargetCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_needQty"), width: "120px"},			//필요수량
		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #"
				, title : gfn_getMsg("col_mtrlHCD"), width: "110px"},											//HCD구분
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #"
			,title : gfn_getMsg("col_mtrlType"), width: "140px"},												//자재유형
		{field: "mtrlStd01", format:"{0:n}", title : gfn_getMsg("col_width"), width: "110px"},					//소재Φ
		{field: "mtrlStd02", format:"{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},				//본당기장
		{field: "mtrlStd03", format:"{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},					//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},														//단위
	];
	
	//공통 그리드 세팅 호출 
	lfo_MtMtrlChk.grid = gfn_grid_set(lfo_MtMtrlChk);
}

//자재재고 파악 팝업 세팅 -- 서브
this.lfn_mtrlChkPop_sbGridSet = function(mode, selectedItem){
	
	lfo_MtMtrlChk.gridSelected ={};
	lfo_MtMtrlChk.gridSelected = selectedItem;
	
	lfo_SbMtrlChk = {};
	
	//1.
	lfo_SbMtrlChk.layoutId = "jteMtrlChkPop_SbGrid";
	
	//2.
	//lfo_SbMtrlChk.popId = "jteToolPosForm";
	
	//3.
	lfo_SbMtrlChk.ctrlUrl = "/form/mtrl/mtrlMgt"

	//4.
	lfo_SbMtrlChk.crud  = {
		read:{url:"/getMtrlMgtList", auth:"", prmt:{mtrlId : lfo_MtMtrlChk.gridSelected.mtrlId, isDel : false}
		, search : false, paging:false}, 
	};
	
	//커스텀 타이틀
	lfo_SbMtrlChk.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("pop_mtrlStockStatus")+'</span>'			//자재 재고 현황
	}

	//5.
	lfo_SbMtrlChk.model = {
		id: "mtrlMgtId",
		fields: {
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtPrescription: { type: "date" },
			mtrlMgtCnt: { type: "int" },
			mtrlMgtDesc: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" },
			mtrlId: { type: "string" },
			mtrlNm: { type: "string" },
			mtrlType: { type: "string" },
			mtrlHCD: { type: "string" },
			mtrlStd01 : { type: "int" }, 
			mtrlStd02 : { type: "int" }, 
			mtrlStd03 : { type: "int" }, 
			mtrlStd04 : { type: "string" },
			mtrlStd05 : { type: "int" },
			mtrlUseday : { type: "int" },
			mtrlCost : { type: "int" },
			description: { type: "string" }, 
			mtrlQual: { type: "string" }, 
			mtrlUnit: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_SbMtrlChk.columns = [
		//{field: "mtrlMgtId", title:gfn_getMsg("col_mtrlIndivCd"), width: 120},												//자재개별코드
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},														//자재명
		{field: "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtrlQty"), width: "120px"},								//자재수량
		{field: "mtrlMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "140px"},				//입고일
		{field: "mtrlMgtDesc", title:gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_SbMtrlChk.grid = gfn_grid_set(lfo_SbMtrlChk);
}

//투입현황 토탈 그리드 세팅
this.lfn_mtrlUseTotal_gridSet = function(){
	
	//1.
	lfo_mtrlUseTotal.layoutId = "mtrlUseTotal_grid";
	
	//2.
	lfo_mtrlUseTotal.popId = "mtrlUseDetailPop";
	
	//3.
	lfo_mtrlUseTotal.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_mtrlUseTotal.crud  = {
		read:{url:"/getMtrlUseList", auth:"", prmt:{prodWorkId : lfo_common.gridSelected.prodWorkId, action : "TOTAL"}
		, search : false, paging:false}, 
	};
	
	//커스텀 타이틀
	lfo_mtrlUseTotal.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("pop_mtrlInputStatus")+'</span>'			//자재 퉁비 현황
	}
	
	//5.
	lfo_mtrlUseTotal.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			description : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlUseTotal.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "120px",									//상세정보
		template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseDetailPop_open(this)" style="width:60px;">'+"투입/조회"+'</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},										//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},											//자재명
		{field: "mtrlUseInput", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_totalInputQty"), width: "140px"},			//총투입량
		{field: "mtrlUseCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_totalUseQty"), width: "140px"},				//총사용량
		{field: "badQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "110px"},					//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "140px"},													//자재유형
		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},														//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},						//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},					//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},					//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},															//단위
		{field: "description", title : gfn_getMsg("col_desc"), width: "250px"}										//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_mtrlUseTotal.grid = gfn_grid_set(lfo_mtrlUseTotal);
}

//투입현황 상세 조회/등록 팝업 오픈
this.lfn_mtrlUseDetailPop_open = function(target){
	var options = {
		modal:true, 
		width: "900px", 
		height: "340px", /* 200515 JJW 330 -> 340 */
		id : lfo_mtrlUseTotal.popId, 
		title:gfn_getMsg("pop_mtrlInputDetailStatus"),			//자재투입 상세현황
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#"+lfo_mtrlUseTotal.popId).show();
		//선택값 저장
		lfo_mtrlUseTotal.gridSelected = lfo_mtrlUseTotal.grid.dataItem($(target).closest("tr"));
		
		//자재 투입 현황 그리드 세팅(DETAIL)
		lfn_mtrlUseDetail_gridSet();
	};
	this.gfn_winOpen(options);	
}

//자재 투입 현황 그리드 세팅(DETAIL)
this.lfn_mtrlUseDetail_gridSet = function(){
	//초기화
	lfo_mtrlUseDetail = {};
	
	//1.
	lfo_mtrlUseDetail.layoutId = "mtrlUseDetail_grid";
	
	//2.
	lfo_mtrlUseDetail.popId = "mtrlUseSavePop";
	
	//3.
	lfo_mtrlUseDetail.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_mtrlUseDetail.crud  = {
		read:{url:"/getMtrlUseList", auth:"", prmt:{prodWorkId : lfo_common.gridSelected.prodWorkId, mtrlId :lfo_mtrlUseTotal.gridSelected.mtrlId , action : "DETAIL"}
		, search : false, paging:false},
		create : {url:"/setMtrlUseSave", openFunc : lfn_mtrlUseSavePop_open, callback : lfn_mtrlUseSavePop_save},
		update : {url:"/setMtrlUseSave", callback : lfn_mtrlUseSavePop_save}
	};
	
	//커스텀 타이틀
	lfo_mtrlUseDetail.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("pop_mtrlInputStatus")+'</span>'			//자재투입현황
	}
	
	//5.
	lfo_mtrlUseDetail.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			description : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlUseDetail.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "160px",												//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseSavePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'
			+'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseBadList_gridSet(this); " style="min-width:60px;">' + "불량확인" + '</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},													//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},														//자재명
		{field: "mtrlMgtId", title:gfn_getMsg("col_mtrlIndivCd"), width: "170px"},												//자재개별코드
		{field: "mtrlUseInput", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_inputQuan"), width: "110px"},							//투입량
		{field: "mtrlUseCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_useQuan"), width: "110px"},								//사용량
		{field: "badQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "110px"},								//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "140px"},																//자재유형
		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},																	//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},									//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},								//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},								//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},																		//단위
		{field: "mtrlMgtPurchase", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "120px"},			//입고일
		{field: "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_stockQty"), width: "110px"},							//재고량
		{field: "mtrlMgtDesc", title : gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_mtrlUseDetail.grid = gfn_grid_set(lfo_mtrlUseDetail);
}

//자재투입 등록 팝업
this.lfn_mtrlUseSavePop_open = function(mode,target){
	var options = {
		modal:true, 
		width: "500px", //200515 JJW 350->500
		height: "330px", // 200515 JJW 250-> 300
		id : lfo_mtrlUseDetail.popId, 
		title:gfn_getMsg("pop_mtrlInput"),			//자재투입
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			selectedItem = {
				prodWorkId : lfo_mtrlUseTotal.gridSelected.prodWorkId,
				mtrlId : lfo_mtrlUseTotal.gridSelected.mtrlId ,
				mtrlUseId : lfo_mtrlUseTotal.gridSelected.mtrlUseId
			}
			
			//팝업 세팅
			gfn_popform_set(lfo_mtrlUseDetail, mode,selectedItem);
			//조회버튼 이벤트 생성
			$("#mtrlUseDetailSaveBtn").on("click",function(){
				lfn_openMtrlMgtUse();
			});
			$("#mtrlUseDetailSaveBtn").show();
			
		}else if(mode == 'EDT'){
			//선택 값 가져오기
			var dataItem = lfo_mtrlUseDetail.grid.dataItem($(target).closest("tr"));
			
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_mtrlUseDetail.ctrlUrl + lfo_mtrlUseDetail.crud.read.url,
				type: "POST",
				data: {
					prodWorkId : dataItem.prodWorkId,
					mtrlId : dataItem.mtrlId ,
					mtrlMgtId : dataItem.mtrlMgtId,
					mtrlUseId : dataItem.mtrlUseId,
					action :"DETAIL"
				},success: function(data){
					gfn_popform_set(lfo_mtrlUseDetail, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
			$("#mtrlUseDetailSaveBtn").hide();
		}
	};
	this.gfn_winOpen(options);	
}

//자재투입 등록 팝업 - 자재관리 조회
this.lfn_openMtrlMgtUse = function(){
	//검색조건
	var searchPrmt ={
		mtrlId : $("#"+lfo_mtrlUseDetail.popId+"_form [name=mtrlId]").val(),
		isDel:false
	}
	
	//공통 자재관리 조회 팝업 호출
	gfn_openCustomPop('materialMgt',lfn_mtrlMgtPop_callback,searchPrmt);
	
	
}

//자재투입 등록 팝업 - 자재관리 콜백
this.lfn_mtrlMgtPop_callback = function(dataItem){
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlNm]").val(dataItem.mtrlNm);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlMgtId]").val(dataItem.mtrlMgtId);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlId]").val(dataItem.mtrlId);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlDiv]").val(dataItem.mtrlDiv);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlUseInput]").data("kendoNumericTextBox").value(dataItem.mtrlMgtCnt);
}

//자재투입 등록 팝업 - 등록/수정
this.lfn_mtrlUseSavePop_save = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_mtrlUseDetail.popId+"_form");
	
	$.ajax({
		async:false,
		url : lfo_mtrlUseDetail.ctrlUrl + lfo_mtrlUseDetail.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT",lfo_common.gridSelected)
				
				//작업종료 팝업 - 자재투입현황(TOTAL) 리로드
				lfo_mtrlUseTotal.grid.dataSource.read();
				
				//자재투입 상세현황 - 자재투입현황(DETAIL) 리로드
				lfo_mtrlUseDetail.grid.dataSource.read();
				
				//현재팝업 종료
				gfn_closePop(lfo_mtrlUseDetail.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//투입자재현황 - 불량 리스트 조회
this.lfn_mtrlUseBadList_gridSet = function(target){
	
	//선택 항목 값 가져오기
	lfo_mtrlUseDetail.gridSelected = lfo_mtrlUseDetail.grid.dataItem($(target).closest("tr"));
	
	//초기화
	lfo_mtrlUseBad = {};
	$("#mtrlUseBad_grid").html("");
	
	//1.
	lfo_mtrlUseBad.layoutId = "mtrlUseBad_grid";
	
	//2.
	lfo_mtrlUseBad.popId = "mtrlUseBadSavePop";
	
	//3.
	lfo_mtrlUseBad.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_mtrlUseBad.crud  = {
		read:{url:"/getMtrlUseList",
			auth:"",
			prmt:{
				prodWorkId : lfo_mtrlUseDetail.gridSelected.prodWorkId,
				mtrlUseId : lfo_mtrlUseDetail.gridSelected.mtrlUseId,
				action : "BAD"
			},
			search : false,
			paging:false
		},
		//다른 컨트롤러에 있는 서비스를 호출하기 위하여 풀경로 매핑
		create : {url:"/form/qualMgt/infergodsMgt/setMtrlBadSave", openFunc : lfn_mtrlUseBadSavePop_open, callback : lfn_mtrlUseBadSavePop_Save},
		update : {url:"/form/qualMgt/infergodsMgt/setMtrlBadSave", callback : lfn_mtrlUseBadSavePop_Save}
	};
	
	
	//커스텀 타이틀
	lfo_mtrlUseBad.customTitle = {
		html : '<span class="pop_title">'+''+gfn_getMsg("pop_badStatus")+': '+lfo_mtrlUseDetail.gridSelected.mtrlNm + '</span>'			//불량현황
	}
	
	//5.
	lfo_mtrlUseBad.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	//6.
	lfo_mtrlUseBad.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "120px",							//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseBadSavePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},								//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},									//자재명
		{field: "badId", title:gfn_getMsg("col_badId"), width: "170px"},									//불량아이디
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "220px"},											//불량원인
		{field: "badQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
		{field: "badDesc", title : gfn_getMsg("col_desc"), width: "250px"}									//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_mtrlUseBad.grid = gfn_grid_set(lfo_mtrlUseBad);
	
	//그리드 show, 사이즈 변환
	$("#"+lfo_mtrlUseBad.layoutId).show();
	gfn_resizePop(lfo_mtrlUseBad.layoutId,{width:900, height:570})
}
//자재투입 불량 등록,수정 팝업
this.lfn_mtrlUseBadSavePop_open = function(mode,target){
	//선택 값 가져오기
	var options = {
		modal:true, 
		width: "570px", //200515 JJW 585 -> 570
		height: "310px", //200515 JJW 285 -> 310
		id : lfo_mtrlUseBad.popId, 
		title:gfn_getMsg("pop_mtrlBadRegist"),			//자재불량 등록
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			var selectedItem = {
				prodWorkId : lfo_mtrlUseDetail.gridSelected.prodWorkId,
				mtrlId : lfo_mtrlUseDetail.gridSelected.mtrlId ,
				mtrlMgtId : lfo_mtrlUseDetail.gridSelected.mtrlMgtId,
				mtrlUseId : lfo_mtrlUseDetail.gridSelected.mtrlUseId,
				chkUser : $("#_loginUserId").val(),
				chkUserNm : $("#_loginUserName").val(),
				chkDate : new Date()
			} 
			
			//팝업 세팅
			gfn_popform_set(lfo_mtrlUseBad, mode,selectedItem);
			
		}else if(mode == 'EDT'){
			var dataItem = lfo_mtrlUseBad.grid.dataItem($(target).closest("tr"));
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_mtrlUseBad.ctrlUrl + lfo_mtrlUseBad.crud.read.url,
				type: "POST",
				data: {
					prodWorkId : dataItem.prodWorkId,
					mtrlId : dataItem.mtrlId ,
					mtrlMgtId : dataItem.mtrlMgtId,
					mtrlUseId : dataItem.mtrlUseId,
					badId : dataItem.badId,
					action :"BAD"
				},success: function(data){
					gfn_popform_set(lfo_mtrlUseBad, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
		}
	};
	this.gfn_winOpen(options);	
}

//자재투입 불량 등록,수정
this.lfn_mtrlUseBadSavePop_Save = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_mtrlUseBad.popId+"_form");
	savePrmt.badTarget = "qual_spec02";
	savePrmt.badTargetCode = $("#" + lfo_mtrlUseBad.popId + " [name=mtrlUseId]").val();
	
	$.ajax({
		async:false,
		url : lfo_mtrlUseBad.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//현재팝업 종료
				
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT", lfo_common.gridSelected)
				
				//작업종료 팝업 - 자재투입현황(TOTAL) 리로드
				lfo_mtrlUseTotal.grid.dataSource.read();
				
				//자재투입 상세현황 - 자재투입현황(DETAIL) 리로드
				lfo_mtrlUseDetail.grid.dataSource.read();
				
				//자재투입 불량현항(BAD) 리로드
				lfo_mtrlUseBad.grid.dataSource.read();
				//팝업종료
				gfn_closePop(lfo_mtrlUseBad.popId);
				//성공메세지
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//투입현황 토탈 그리드 세팅 - 개밮품목
this.lfn_mtrlUseTotal_devItem_gridSet = function(){
	
	//1.
	lfo_mtrlUseTotal.layoutId = "mtrlUseTotal_grid";
	
	//2.
	lfo_mtrlUseTotal.popId = "mtrlUseSavePop";
	
	//3.
	lfo_mtrlUseTotal.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_mtrlUseTotal.crud  = {
		read:{url:"/getMtrlUseList", auth:"", prmt:{prodWorkId : lfo_common.gridSelected.prodWorkId, action : "DEVITEM"}
		, search : false, paging:false},
		create : {url:"/setMtrlUseSave", openFunc : lfn_mtrlUseSavePop_devItem_open, callback : lfn_mtrlUseSavePop_devItem_save},
		update : {url:"/setMtrlUseSave", callback : lfn_mtrlUseSavePop_devItem_save}
	};
	
	//커스텀 타이틀
	lfo_mtrlUseTotal.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("pop_mtrlInputStatus")+'</span>'			//자재투입현황
	}
	
	//5.
	lfo_mtrlUseTotal.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			description : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlUseTotal.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "160px",												//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseSavePop_devItem_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'
			+'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseBadPop_devItem_open(this); " style="min-width:60px;">' + "불량확인" + '</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},													//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},														//자재명
		{field: "mtrlMgtId", title:gfn_getMsg("col_mtrlIndivCd"), width: "170px"},												//자재개별코드
		{field: "mtrlUseInput", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_inputQuan"), width: "110px"},							//투입량
		{field: "mtrlUseCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_useQuan"), width: "110px"},								//사용량
		{field: "badQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "110px"},								//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "140px"},																//자재유형
		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},																	//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},									//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},								//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},								//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},																		//단위
		{field: "mtrlMgtPurchase", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "120px"},			//입고일
		{field: "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_stockQty"), width: "110px"},							//재고량
		{field: "mtrlMgtDesc", title : gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_mtrlUseTotal.grid = gfn_grid_set(lfo_mtrlUseTotal);
}

//자재투입 등록 팝업 - 개밮품목
this.lfn_mtrlUseSavePop_devItem_open = function(mode,target){
	var options = {
		modal:true, 
		width: "500px", //200515 JJW 350->500
		height: "330px", // 200515 JJW 250-> 300
		id : lfo_mtrlUseTotal.popId, 
		title:gfn_getMsg("pop_mtrlInput"),			//자재투입
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			
			//팝업 세팅
			gfn_popform_set(lfo_mtrlUseTotal, mode, lfo_common.gridSelected);
			//자재 조회버튼 이벤트생성
			$("#mtrlUseDetailSaveBtn").on("click",function(){
				lfn_openMtrlMgtUse_devItem();
			});
			
			$("#mtrlUseDetailSaveBtn").show();
		}else if(mode == 'EDT'){
			//선택 값 가져오기
			var dataItem = lfo_mtrlUseTotal.grid.dataItem($(target).closest("tr"));
			
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_mtrlUseTotal.ctrlUrl + lfo_mtrlUseTotal.crud.read.url,
				type: "POST",
				data: {
					prodWorkId : dataItem.prodWorkId,
					mtrlId : dataItem.mtrlId ,
					mtrlMgtId : dataItem.mtrlMgtId,
					mtrlUseId : dataItem.mtrlUseId,
					action :"DEVITEM"
				},success: function(data){
					gfn_popform_set(lfo_mtrlUseTotal, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
			$("#mtrlUseDetailSaveBtn").hide();
		}
	};
	this.gfn_winOpen(options);	
}

//자재투입 등록 팝업 - 자재관리 조회  - 개밮품목
this.lfn_openMtrlMgtUse_devItem = function(){
	//공통 자재관리 조회 팝업 호출
	gfn_openCustomPop('materialMgt',lfn_mtrlMgtPop_devItem_callback);
}

//자재투입 등록 팝업 - 자재관리 콜백  - 개밮품목
this.lfn_mtrlMgtPop_devItem_callback = function(dataItem){
	$("#"+lfo_mtrlUseTotal.popId+"_form [name = mtrlNm]").val(dataItem.mtrlNm);
	$("#"+lfo_mtrlUseTotal.popId+"_form [name = mtrlMgtId]").val(dataItem.mtrlMgtId);
	$("#"+lfo_mtrlUseTotal.popId+"_form [name = mtrlId]").val(dataItem.mtrlId);
	$("#"+lfo_mtrlUseTotal.popId+"_form [name = mtrlDiv]").val(dataItem.mtrlDiv);
	$("#"+lfo_mtrlUseTotal.popId+"_form [name = mtrlUseInput]").data("kendoNumericTextBox").value(dataItem.mtrlMgtCnt);
}

//자재투입 등록 팝업 - 등록/수정 - 개밮품목
this.lfn_mtrlUseSavePop_devItem_save = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_mtrlUseTotal.popId+"_form");
	
	$.ajax({
		async:false,
		url : lfo_mtrlUseTotal.ctrlUrl + lfo_mtrlUseTotal.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT",lfo_common.gridSelected)
				
				//작업종료 팝업 - 자재투입현황(TOTAL) 리로드
				lfo_mtrlUseTotal.grid.dataSource.read();
				
				//현재팝업 종료
				gfn_closePop(lfo_mtrlUseTotal.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//자재투입 등록 팝업 - 개밮품목
this.lfn_mtrlUseBadPop_devItem_open = function(target){
	var options = {
		modal:true, 
		width: "500px", //200515 JJW 350->500
		height: "330px", // 200515 JJW 250-> 300
		id : "mtrlUseBadPop", 
		title : "자재불량리스트",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택 항목 값 가져오기
		lfo_mtrlUseTotal.gridSelected = lfo_mtrlUseTotal.grid.dataItem($(target).closest("tr"));

		lfn_mtrlUseBadList_devItem_gridSet();
	};
	this.gfn_winOpen(options);	
}

//투입자재현황 - 불량 리스트 조회
this.lfn_mtrlUseBadList_devItem_gridSet = function(){
	//초기화
	lfo_mtrlUseBad = {};
	$("#mtrlUseBad_devItem_grid").html("");
	
	//1.
	lfo_mtrlUseBad.layoutId = "mtrlUseBad_devItem_grid";
	
	//2.
	lfo_mtrlUseBad.popId = "mtrlUseBadSavePop";
	
	//3.
	lfo_mtrlUseBad.ctrlUrl = "/form/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_mtrlUseBad.crud  = {
		read:{url:"/getMtrlUseList",
			auth:"",
			prmt:{
				prodWorkId : lfo_mtrlUseTotal.gridSelected.prodWorkId,
				mtrlUseId : lfo_mtrlUseTotal.gridSelected.mtrlUseId,
				action : "DEVITEMBAD"
			},
			search : false,
			paging:false
		},
		//다른 컨트롤러에 있는 서비스를 호출하기 위하여 풀경로 매핑
		create : {url:"/form/qualMgt/infergodsMgt/setMtrlBadSave", openFunc : lfn_mtrlUseBadSavePop_devItem_open, callback : lfn_mtrlUseBadSavePop_devItem_Save},
		update : {url:"/form/qualMgt/infergodsMgt/setMtrlBadSave", callback : lfn_mtrlUseBadSavePop_devItem_Save}
	};
	
	
	//커스텀 타이틀
	lfo_mtrlUseBad.customTitle = {
		html : '<span class="pop_title">'+''+gfn_getMsg("pop_badStatus")+': '+lfo_mtrlUseTotal.gridSelected.mtrlNm + '</span>'			//불량현황
	}
	
	//5.
	lfo_mtrlUseBad.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	//6.
	lfo_mtrlUseBad.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "120px",							//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseBadSavePop_devItem_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},								//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},									//자재명
		{field: "badId", title:gfn_getMsg("col_badId"), width: "170px"},									//불량아이디
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "220px"},											//불량원인
		{field: "badQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
		{field: "badDesc", title : gfn_getMsg("col_desc"), width: "250px"}									//설명
	];
	//공통 그리드 세팅 호출 
	lfo_mtrlUseBad.grid = gfn_grid_set(lfo_mtrlUseBad);
}

//자재투입 불량 등록,수정 팝업 - 개밮품목
this.lfn_mtrlUseBadSavePop_devItem_open = function(mode,target){
	//선택 값 가져오기
	var options = {
		modal:true, 
		width: "570px", //200515 JJW 585 -> 570
		height: "310px", //200515 JJW 285 -> 310
		id : lfo_mtrlUseBad.popId, 
		title:gfn_getMsg("pop_mtrlBadRegist"),			//자재불량 등록
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			var selectedItem = {
				prodWorkId : lfo_mtrlUseTotal.gridSelected.prodWorkId,
				mtrlId : lfo_mtrlUseTotal.gridSelected.mtrlId ,
				mtrlMgtId : lfo_mtrlUseTotal.gridSelected.mtrlMgtId,
				mtrlUseId : lfo_mtrlUseTotal.gridSelected.mtrlUseId,
				chkUser : $("#_loginUserId").val(),
				chkUserNm : $("#_loginUserName").val(),
				chkDate : new Date()
			} 
			
			//팝업 세팅
			gfn_popform_set(lfo_mtrlUseBad, mode,selectedItem);
			
		}else if(mode == 'EDT'){
			var dataItem = lfo_mtrlUseBad.grid.dataItem($(target).closest("tr"));
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_mtrlUseBad.ctrlUrl + lfo_mtrlUseBad.crud.read.url,
				type: "POST",
				data: {
					prodWorkId : dataItem.prodWorkId,
					mtrlId : dataItem.mtrlId ,
					mtrlMgtId : dataItem.mtrlMgtId,
					mtrlUseId : dataItem.mtrlUseId,
					badId : dataItem.badId,
					action :"DEVITEMBAD"
				},success: function(data){
					gfn_popform_set(lfo_mtrlUseBad, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
		}
	};
	this.gfn_winOpen(options);	
}

//자재투입 불량 등록,수정 - 개밮품목
this.lfn_mtrlUseBadSavePop_devItem_Save = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_mtrlUseBad.popId+"_form");
	savePrmt.badTarget = "qual_spec02";
	savePrmt.badTargetCode = $("#" + lfo_mtrlUseBad.popId + " [name=mtrlUseId]").val();
	
	$.ajax({
		async:false,
		url : lfo_mtrlUseBad.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//현재팝업 종료
				
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT", lfo_common.gridSelected)
				
				//작업종료 팝업 - 자재투입현황(TOTAL) 리로드
				lfo_mtrlUseTotal.grid.dataSource.read();
				
				//자재투입 불량현항(BAD) 리로드
				lfo_mtrlUseBad.grid.dataSource.read();
				//팝업종료
				gfn_closePop(lfo_mtrlUseBad.popId);
				//성공메세지
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//폼묵 불량 조회 팝업 조회
this.lfn_itemBadListPop_Open = function(){
	var options = {
			modal:true, 
			width: "650px", 
			height: "350px", 
			id : "itemBadListPop", 
			title:gfn_getMsg("pop_itemBadSrh"),			//부품불량조회
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			
			//부품 불량 리스트 조회 그리드 셋
			lfn_itemBadListPop_gridSet();
		}

		this.gfn_winOpen(options);	
}

//부품 불량  --  그리드 세팅
this.lfn_itemBadListPop_gridSet = function(){
	
	//1.
	lfo_itemBad.layoutId = "itemBadListPop_grid";
	
	//2.
	lfo_itemBad.popId = "itemBadSavePop";
	
	//3.
	lfo_itemBad.ctrlUrl = "/form/qualMgt/infergodsMgt"

	//4.
	lfo_itemBad.crud  = {
		read:{url:"/getItemBadList",
			auth:"",
			prmt:{
				badTarget : 'qual_spec03',
				badTargetCode : lfo_common.gridSelected.prodWorkId,
			},
			search : false,
			paging:false
		},
		//다른 컨트롤러에 있는 서비스를 호출하기 위하여 풀경로 매핑
		create : {url:"/setItemBadPgSave", openFunc : lfn_itemBadSavePop_Open, callback : lfn_itemBadSavePop_Save},
		update : {url:"/setItemBadPgSave", callback : lfn_itemBadSavePop_Save}
	};
	
	
	//커스텀 타이틀
	lfo_itemBad.customTitle = {
		html : '<span class="pop_title">'+''+gfn_getMsg("pop_badStatus")+' : ' + lfo_common.gridSelected.itemNm + '</span>'			//불량현황
	}
	
	//5.
	lfo_itemBad.model = {
		id: "badId",
		fields: {
			badId : { type: "string" },
			lotId : { type: "string" },	
			badCode : { type: "string" },
			badQty : { type: "string" },
			chkUser : { type: "string" },
			chkUserNm : { type: "string" },
			chkDate : { type: "string" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badTargetNm : { type: "string" },
			badDesc : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			badPgUser : { type: "string" },
			badPgUserNm : { type: "string" },
			badPgDate : { type: "string" }
		}
	};
	//6.
	lfo_itemBad.columns = [
		{field: "lotId", title: gfn_getMsg("col_detailInfo"), width: "120px",								//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_itemBadSavePop_Open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'},
		{field: "badId", title:gfn_getMsg("col_badId"), width: "170px"},									//불량아이디
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "220px"},											//불량원인
		{field: "badQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
		{field: "badDesc", title : gfn_getMsg("col_desc"), width: "250px"}									//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_itemBad.grid = gfn_grid_set(lfo_itemBad);

}
//부품 불량팝업
this.lfn_itemBadSavePop_Open = function(mode,target){
	//선택 값 가져오기
	var options = {
		modal:true, 
		width: "590px", // 200515 JJW 585->590
		height: "340px", /* 200515 JJW 285->340 */
		id : lfo_itemBad.popId, 
		title:gfn_getMsg("pop_itemBadRegist"),			//부품불량 등록
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			var selectedItem = {
				prodWorkId : lfo_common.gridSelected.prodWorkId,
				chkUser : $("#_loginUserId").val(),
				chkUserNm : $("#_loginUserName").val(),
				chkDate : new Date()
			} 
			
			//팝업 세팅
			gfn_popform_set(lfo_itemBad, mode,selectedItem);
			
		}else if(mode == 'EDT'){
			var dataItem = lfo_itemBad.grid.dataItem($(target).closest("tr"));
			
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_itemBad.ctrlUrl + lfo_itemBad.crud.read.url,
				type: "POST",
				data: {
					prodWorkId : dataItem.prodWorkId,
					badId : dataItem.badId
				},success: function(data){
					//조회결과에 prodWorkId없어서 직접매핑
					data.rows[0].prodWorkId = lfo_common.gridSelected.prodWorkId;
					
					gfn_popform_set(lfo_itemBad, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
		}
	};
	this.gfn_winOpen(options);	
}

//부품 불량 - 저장/수정
this.lfn_itemBadSavePop_Save = function(mode){
	var savePrmt = gfn_serializeObject(lfo_itemBad.popId+"_form");
	savePrmt.badTarget = "qual_spec03";
	savePrmt.badTargetCode = savePrmt.prodWorkId;
	savePrmt.lotId = lfo_common.gridSelected.lotId;
	$.ajax({
		async:false,
		url : lfo_itemBad.ctrlUrl + lfo_itemBad.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//작업정보 리로드
				lfn_jteSgGrid_dblclick("EDT", lfo_common.gridSelected)
				
				//불량등록시 이전에 입력된 데이터 초기화 되므로 예외처리
				//팝업창 리로드 시 이전데이터 복사
				var endPopKeep = {
					prodWorkGood : $("#"+lfo_prodWorkEnd.popId+"_form [name=prodWorkGood]").data("kendoNumericTextBox").value()
				}
				var prodWorkEnd =$("#"+lfo_prodWorkEnd.popId + "_form [name=prodWorkEnd]").data("kendoDateTimePicker").value();
				if(!gfn_isNull(prodWorkEnd)){
					endPopKeep.prodWorkEnd = prodWorkEnd;
				}
				
				//작업종료팝업 리로드
				lfn_workEndPop_set(endPopKeep);
				
				//부품불량 현항(BAD) 리로드
				lfo_itemBad.grid.dataSource.read();
				
				//현재팝업 종료
				gfn_closePop(lfo_itemBad.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
</script>