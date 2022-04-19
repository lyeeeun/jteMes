 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid" class="wrkinAdminMgtForm-left-content-box"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
</div>

<div style="display:none;">
	<div id="jteProdWorkForm" class="wrkinAdminMgtForm-right-content-box">   <!-- style="display:inline-block; width:59%; height:100%;" -->
		<form id="jteProdWorkForm_form" class="wrkinAdminMgtForm jteProdWorkForm_form">   <!-- style="height:100%; display:none;" -->
			<div class="pop_title top_pop_title">
				<!-- 기본정보 -->
				<spring:message code = "pop_baseInfo"></spring:message>
			</div>
			<table class="jteProdWorkForm_table jteProdWorkForm_table_1">
				<colgroup>   <!-- 원래 col 4개에 각각 width 14 36 14 36 -->
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
				<!-- 공정정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_routType"></spring:message> : </td>
					<td>
						<input id="routingType" name="routingType" format="selBox" msg="process_type" style="width:65%" readonly/>
						<input type="hidden" name="routingId" id="routingId" class="left-input btn-input"/>
						<button class="k-button k-primary full-search-btn" type="button"  onclick="lfn_routingPop_Open()" style="width:30%">
							<!-- 전체보기 -->
							<spring:message code = "pop_viewAll"></spring:message>
						</button>
					</td>
				<!-- 설비정보 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_eqmtInfo"></spring:message> : </td>
					<td>
						<input id="eqmtMgtNm" class="right-input" name="eqmtMgtNm" readonly/>
						<input type="hidden" name="eqmtMgtId" id="eqmtMgtId"/>
					</td>
				</tr>
				<tr>
					<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input class="left-input" name="itemId" readonly/>
						<input type="hidden" name="itemNm"/>
					</td>
					<!-- 긴급여부 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_prodEmj"></spring:message> : </td>
					<td>
						<input name="prodAsmEmj" class="right-input" format="selBox" msg="prod_emj" readonly/>
					</td>
				</tr>
				<tr>
					<!-- 재질 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_qomtrl"></spring:message> : </td>
					<td>
						<input name="itemMtrl"  class="left-input" format="selBox" msg="comn_qomtrl" readonly/>
					</td>
					<!-- 공제량 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_deduction"></spring:message> : </td>
					<td>
						<input name="itemDeduction"  class="right-input" format="currency" readonly/>
					</td>
				</tr>
				<tr>
					<!-- 작업지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkAsmQty"></spring:message> : </td>
					<td>
						<input name=prodWorkQty id="prodWorkQty" class="left-input" format="currency" readonly/>
					</td>
					<!-- 작업자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_worker"></spring:message> : </td>
					<td>
						<input id="prodWorkUserNm" class="right-input" name="prodWorkUserNm" readonly/>
						<input type="hidden" name="prodWorkUser" id="prodWorkUser" class="right-input"/>
					</td>
				</tr>
				<tr>
				<!-- 작업지시 비고 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderDesc"></spring:message> : </td>
					<td colspan="3">
						<input name=prodWorkDesc id="prodWorkDesc" class="center-input" readonly/>
					</td>
				</tr>
			</table>
			<div id="mtrlUseArea" style="display:none; width:100%;">
				<div style="margin-bottom: 5px;">
				<!-- 자재 투입 정보 -->
					<span class="pop_title top_pop_title"><spring:message code = "pop_mtrlInputInfo"></spring:message></span>
					<button class="k-button k-primary hidden-show-button" type="button" id="mtrlUseToggle">
					<!-- 펼치기/숨기기 -->
					<spring:message code = "pop_expHide"></spring:message></button>
				</div>
				<div id="mtrlUseTotal_grid" class="mtrlUseTotal-single-grid" style="display: none; width: 100%; height: 180px;"></div>
			</div>
			<div id="toolUseArea" style="margin-top: 5px; margin-bottom: 5px;">
			<!-- 공구 사용 정보 -->
				<span class="pop_title top_pop_title"><spring:message code = "pop_toolUseInfo"></spring:message></span>
				<button class="k-button k-primary hidden-show-button" type="button" id="toolUseToggle">
				<!-- 펼치기/숨기기 -->
				<spring:message code = "pop_expHide"></spring:message></button>
			</div>
			<div id="jteEquipToolPop_grid" class="jteEquipToolPop-single-grid" style="display: none; width: 100%; height: 300px;"></div>
			
			<div class="pop_title bottom_pop_title" style="margin-top: 5px;">
				<!-- 작업정보 -->
				<spring:message code = "pop_workInfo"></spring:message>
			</div>
			<table class="jteProdWorkForm_table jteProdWorkForm_table_2">  <!-- style="width:100%;" -->
				<colgroup>   <!-- 원래 col 4개에 각각 width 14 36 14 36 -->
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
					<td>
						<!-- 양품량 -->
						<i class="fas fa-caret-right"></i><spring:message code = "col_prodQuan"></spring:message> : 
					</td>
					<td>
						<input id="prodWorkGood" class="left-input" name="prodWorkGood" format="currency" />
					</td>
					
					<td class="td-right-title">
						<!-- 불량량 -->
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_badProdQuan"></spring:message> : 
					</td>
					<td>
						<input id="prodWorkBad" class="right-input" name="prodWorkBad" format="currency" style="width:60%" readonly/>
						<!-- 불량확인 -->
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_itemBadListPop_Open()" style="width:35%">
							<spring:message code = "pop_badConfirm"></spring:message>
						</button>
<!-- 					</td> -->
				</tr>
				<tr>
					<!-- 작업시작시간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkStartTime"></spring:message> : </td>
					<td>
						<input id="prodWorkStart" class="left-input" name="prodWorkStart" format="datetimepicker" />
					</td>
					<!-- 작업종료시간 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_wrkEndTime"></spring:message> : </td>
					<td>
						<input id="prodWorkEnd" class="right-input" name="prodWorkEnd" format="datetimepicker" />
					</td>
				</tr>
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
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name="qtyAction"/>
						<input type="hidden" name="action"/>
						<input type="hidden" name="use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_save"></spring:message></button>												<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteProdWorkForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
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

<!-- 장착가능한 공구 조회 -->
<div style="display:none;">
	<div id="jteToolPosForm" class="wrkinAdminMgtForm jteToolPosForm">
		<div id="jteToolPosForm_grid" class="jteToolPosForm-single-grid"  style="height:410px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_save"></spring:message></button>												<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteToolPosForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 자재 재고 파악 팝업-->
<div style="display:none;">
	<div id="mtrlUseDetailPop" class="wrkinAdminMgtForm mtrlUseDetailPop">
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
		<form id="mtrlUseSavePop_form" class="wrkinAdminMgtForm mtrlUseSavePop_form">
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
		<form id="mtrlUseBadSavePop_form" class="wrkinAdminMgtForm mtrlUseBadSavePop_form">
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
					<td colspan="3"><input type="text" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input class="left-input" name="badCode"  format = "selBox" msg="qual_MTRLCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 불량량 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_badProdQuan"></spring:message> : 
					</td>
					<td><input class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input class="left-input" name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" />
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<!-- 	 						조회 -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
					
				<!-- 검사일 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input class="right-input" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
					<td>
						<!-- 설명 -->
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input class="center-input" name="badDesc"/>
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
	<div id="itemBadListPop" class="wrkinAdminMgtForm itemBadListPop">
		<div id="itemBadListPop_grid" class="itemBadListPop-single-grid" style="width:100%; height:280px; min-height:280px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('itemBadListPop');">닫기</button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 부품 불량 등록/확인팝업 -->
<div style="display:none;">
	<div id="itemBadSavePop">
		<form id="itemBadSavePop_form" class="wrkinAdminMgtForm itemBadSavePop_form">
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
					<td colspan="3"><input type="text" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input class="left-input" name="badCode"  format = "selBox" msg="qual_ITEMCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 수량 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_quantity"></spring:message> : 
					</td>
					<td><input class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input class="left-input" name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" />
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<!-- 	 						조회 -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
				<!-- 검사일 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input class="right-input" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input class="center-input" name="badDesc"/>
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

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/wrkinAdminMgt/wrkinAdminMgtForm_JJW.css' rel="stylesheet">


<script>

var lfo_checkedDate = {};

var lfo_common = {};//메인 그리드 Object 

var lfo_equipTool = {}; //현재 설비에 장착된 공구 

var lfo_toolPos = {}; //장착가능한 공구

var lfo_mtrlUseTotal = {}; //자재투입현황 - 종합

var lfo_mtrlUseDetail = {}; //자재투입현황 - 상세

var lfo_mtrlUseBad = {}; //자재투입현황 - 불량

var lfo_itemBad = {}; //부품 - 불량

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//해당날짜의 작업정보를 조회하기 위한 date 세팅
	lfn_jteWorkDate_dateSave();
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
	
	//그리드 리로드
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
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
 			prodPlanYear : lfo_checkedDate.year,
 			prodPlanMonth : lfo_checkedDate.month,
 			prodPlanDay : lfo_checkedDate.day
		},search:false, paging:false},  
		update:{url:"/setProdWorkAdminSave", auth:"", openFunc : "", callback : lfn_jtePop_Save},
		excel:{url:"" ,auth:"", fileName: "작업지시서_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
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
				mtrlMgtId: { type: "string" },
				mtrlNm: { type: "string" },
				mtrlDiv: { type: "string" },
				mtrUseInput: { type: "int" },
				mtrlUseCnt: { type: "int" },
				
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
 		{field: "prodAsmId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:gfn_getMsg("col_workSearch"), width: "110px"},												//작업조회
		{field: "prodWorkStart", template:"# var item = gfn_isNull(prodWorkStart)== true ? '작업대기' : gfn_isNull(prodWorkEnd) == true ? '진행중' : '작업완료' #  #= item #",
				title : gfn_getMsg("col_progress"), width: "110px"},											//진행여부
 		{field: "itemNm", title:gfn_getMsg("col_productionItem"), width: "180px"},								//생산품
 		{field: "routingType", template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #", 
			title:gfn_getMsg("col_routType"), width: "140px"},													//공정유형
 		{field: "routingSeq", format:"{0:n0}",title:gfn_getMsg("col_routSeq"), width: "100px"},					//차수
 		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "110px"},				//지시량
 		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},
 		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},
 		{field: "mtrUseInput", format:"{0:n0}", title : gfn_getMsg("col_inputQuan"), width: "110px"},			//투입량
 		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_useQuan"), width: "110px"},				//사용량
 		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",
 			title:gfn_getMsg("col_prodEmj"), width: "110px"},													//긴급여부
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "180px"},									//라우팅코드
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "140px"},								//설비명
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "120ㅔㅌ"},									//위치명
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "130px"},								//작업자
		//{field: "prodAsmDesc", title:gfn_getMsg("col_desc"), width: 300},
		{field: "prodWorkDesc", title:gfn_getMsg("col_desc"), width: "250px"}									//설명
		//{field: "prodWorkGood", format:"{0:n0}", title:"생산량", width: 120},
		//{field: "prodWorkBad", format:"{0:n0}", title:"불량량", width: 120},
		
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "790px",
		height: "630px", 
		id : lfo_common.popId, 
		title : gfn_getMsg("pop_workInfo"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
		
		//자재 투입정보 펼치기 / 보이기
		$("#mtrlUseToggle").click(function(){
			if($("#mtrlUseTotal_grid").css("display") == "none"){
				$("#mtrlUseTotal_grid").show();
			}else{
				$("#mtrlUseTotal_grid").hide();
			}
		});
		
		//공구사용정보 펼치기 / 보이기
		$("#toolUseToggle").click(function(){
			if($("#jteEquipToolPop_grid").css("display") == "none"){
				$("#jteEquipToolPop_grid").show();
			}else{
				$("#jteEquipToolPop_grid").hide();
			}
		});
	};
	
	this.gfn_winOpen(options);
}

//메인그리드 더블클릭 콜백 > 작업정보 상세조회 - 우측화면 
this.lfn_jtePop_set = function(mode, target, keepData){
	
	var dataItem = {};
	
	if(mode =="NEW"){
		//작업지시 목록에서 선택한 값 저장
		dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	}else if(mode =="EDT"){
		//저장 후 리로드 시
		dataItem = target;
	}
	
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
			var rtnData = data.rows[0];
			
			//불량등록시 이전에 입력된 데이터 초기화 되므로 예외처리
			if(!gfn_isEmpty(keepData)){
				for(key in keepData){
					rtnData[key] = keepData[key];
				}
			}
			
			//작업정보화면 세팅(메인우측)
			gfn_popform_set(lfo_common, "EDT", rtnData);
			
			//공구정보 그리드 세팅
			
			if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_common.gridSelected.itemId != gfn_getCode("devItem").cdVal){
				$("#toolUseArea").show();
				lfn_jteEquipToolPop_setGrd();				
			}else{
				$("#toolUseArea").hide();
			}
			

			//자재투입  그리드 세팅
			if(!gfn_isNull(rtnData.bomTarget) && rtnData.bomTarget.indexOf('prcs_bom02') != -1){
				$("#mtrlUseArea").show();
				//개발품목 예외처리
				if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_common.gridSelected.itemId != gfn_getCode("devItem").cdVal){
					lfn_mtrlUseTotal_gridSet();
				}else{
					lfn_mtrlUseTotal_devItem_gridSet();
				}
			}
			
			//초기 - 작업시작전
			if(gfn_isNull(rtnData.prodWorkStart)){
				$("#workFlag").val("start");
			//작업시작 후 
			}else if(gfn_isNull(rtnData.prodWorkEnd)){
				$("#workFlag").val("end");
			}else{
				$("#workFlag").val("finish");
			}
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//작업 종료 팝업 - 저장
this.lfn_jtePop_Save = function(){
	var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//현재팝업 종료
				gfn_closePop(lfo_common.popId);
				
				gfn_msgBox({msg : gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
				//마스터테이블 리로드
				lfo_common.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
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
	//lfo_routingAll.popId = "";
	
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
 			},
 		search:false}
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
			,title:gfn_getMsg("col_routSeq"), width: "120px"},												//차수
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "180px"},								//라우팅코드
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routType"), width: "140px"},												//공정유형
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "140px"},							//설비명
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "130px"},							//작업자
		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "110px"}			//지시량
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
		//{field: "prodWorkGood", format:"{0:n0}", title:"생산량", width: 120},
		//{field: "prodWorkBad", format:"{0:n0}", title:"불량량", width: 120},
		//{field: "prodWorkStart", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"작업시작", width: 120},
		//{field: "prodWorkEnd", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"작업종료", width: 120}
	];
	
	//7.
	lfo_routingAll.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];
	
	//공통 그리드 세팅 호출 
	lfo_routingAll.grid = gfn_grid_set(lfo_routingAll);
}

//공구사용정보 그리드 - 사용했던 공구정보 조회 
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
		read:{url:"/getWorkToolAdminList", auth:"", prmt:{prodWorkId: lfo_common.gridSelected.prodWorkId}
			,paging : false, search : false},
		create:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_jteToolPos_popOpen, callback : lfn_toolPos_save},
		//update:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_toolPos_save, callback : lfn_toolPos_save},
		destroy:{url:"", auth:"", callback : lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_equipTool.model = {
		id: "toolMgtId",
		fields: {
			toolRpm: { type: "int" },
			toolLocation: { type: "string" },
			toolCount: { type: "int" },
			routingId: { type: "string" },
			toolId: { type: "string" },
			toolNm: { type: "string" },
			toolMgtId: { type: "string" },
			toolMgtPurchase: { type: "string" },
			toolMgtState: { type: "string" },
			toolMgtLimit: { type: "int" },
			toolMgtUse: { type: "int" },
			toolMgtVerif: { type: "string" },
			toolMgtGbn: { type: "string" },
			toolMgtDesc: { type: "string" },
			toolMgtId: { type: "string" },
			toolUseStart: { type: "string" },
			toolUseEnd: { type: "string" },
			toolUseQty: { type: "int" },
			toolMgtId: { type: "string" }
		}
	};
	
	//6.
	lfo_equipTool.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_toolPos_Update(this); " style="min-width:60px;">' + "수량변경" + '</button>',
			title : gfn_getMsg("col_workSearch"), width: "140px"},																//작업조회
		{field: "toolLocation", title : gfn_getMsg("col_mountPosition"), width: "120px"},										//장착위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: "170px"},													//공구명
		{field: "toolMgtId", template:"# var item = gfn_isNull(toolMgtId)== true ? '장착된 공구 없음' : toolMgtId # #= item #",
				title : gfn_getMsg("col_toolIndivCd"), width: "180px"},															//공구개별코드
		{field: "toolMgtLimit", format:"{0:n0}", title : gfn_getMsg("col_useLimit"), width: "120px"},							//사용한도
		{field: "toolUseQty", format:"{0:n0}", title : gfn_getMsg("col_toolUse"), width: "120px"},								//사용량
		{field: "toolCount", format:"{0:n}", title : gfn_getMsg("col_feedrate"), width: "120px"},								//FEEDRATE
		{field: "toolRpm", format:"{0:n0}", title : gfn_getMsg("col_toolRpm"), width: "120px"},									//RPM
		/* {field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? toolMgtGbn : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
				title : gfn_getMsg("col_toolDiv"), width: 180},
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? toolMgtState : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: 180}, */
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "140px"},			//입고일
		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	
	//7.
	lfo_equipTool.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_equipTool.grid = gfn_grid_set(lfo_equipTool);
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
		read:{url:"/getWorkToolAdminPosList", auth:"", prmt:{routingId : lfo_common.gridSelected.routingId},
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
		{field: "toolLocation", title : gfn_getMsg("col_mountPosition"), width: "120px"},										//장착위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: "160px"},													//공구명
		{field: "toolMgtId", title :  gfn_getMsg("col_toolIndivCd"), width: "170px"},											//공구개별코드
		{field: "toolRpm", format:"{0:n0}", title : gfn_getMsg("col_toolRpm"), width: "110px"},									//RPM
		{field: "toolCount", format:"{0:n}", title : gfn_getMsg("col_feedrate"), width: "110px"},								//FEEDRATE
		{field: "toolMgtLimit", format:"{0:n0}", title : gfn_getMsg("col_useLimit"), width: "110px"},							//사용한도
		{field: "toolMgtUse", format:"{0:n0}", title : gfn_getMsg("col_toolUse"), width: "110px"},								//사용량
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
			title : gfn_getMsg("col_toolDiv"), width: "200px"},																	//공구구분
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: "140px"},															//공구상태
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "180px"},			//입고일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_verifyPeriod"), width: "140px"},				//검증기간
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: "180px"},													//업체명
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

//공구 입력(관리자는 직접 선택해서 수량을 입력한다.)사용수량 입력받게 함
this.lfn_toolPos_save = function(mode,selectedItem){
	gfn_dialBox({msg:"선택한 공구로 부품을 생산한 수량을 입력하세요.(공구카운트 자동계산)", title:"공구사용정보", 
		yes : function(qtyObj){
			if(qtyObj.result != "DONE"){
				
				//작업정보 팝업 데이터 불러오기
				var prodWorkPrmt = gfn_serializeObject(lfo_common.popId+"_form");
				
				var savePrmt = [];
				$("#"+ lfo_toolPos.layoutId +" .k-checkbox").each(function(index,item){
					if($(this).attr("aria-checked") == "true"){
						var item = lfo_toolPos.grid.dataItem($(this).closest('tr'));
						
						//필요한 데이터만 담기
						var prmt ={
							eqipNm : item.itemNm,
							eqipPosition : item.toolLocation,
							eqmtMgtId : lfo_common.gridSelected.eqmtMgtId,
							prodWorkId : lfo_common.gridSelected.prodWorkId,
							lotId : lfo_common.gridSelected.lotId,
							toolId : item.toolId,
							toolMgtId : item.toolMgtId,
							toolUseStart : gfn_isNull(prodWorkPrmt.prodWorkStart) == true ? gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss") : prodWorkPrmt.prodWorkStart,
							toolUseEnd : gfn_isNull(prodWorkPrmt.toolUseEnd) == true ? gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss") : prodWorkPrmt.toolUseEnd,
							toolUseQty : qtyObj.result * item.toolCount
						}
						savePrmt.push(prmt);
					}
				});
				
				$.ajax({
					async:false,
					url : "/form/mfgMgt/wrkinWrkerMgt/setProdWorkAdminInsert",
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
		}, no : function(){}
	});
}

//공구 사용량 수정(관리자는 직접 선택해서 수량을 입력한다.)
this.lfn_toolPos_Update = function(target){
	gfn_dialBox({msg:"선택한 공구로 부품을 생산한 수량을 입력하세요.(공구카운트 자동계산)", title:"공구사용정보", 
		yes : function(qtyObj){
			var item = lfo_equipTool.grid.dataItem($(target).closest("tr"));
			if(gfn_isNull(item.toolMgtId)){
				gfn_warnBox({msg : "장착된 공구가 없습니다."});
				return false;
			}
			if(qtyObj.result != "DONE"){
				//필요한 데이터만 담기
				var savePrmt ={
					eqipNm : item.itemNm,
					eqipPosition : item.toolLocation,
					eqmtMgtId : lfo_common.gridSelected.eqmtMgtId,
					prodWorkId : lfo_common.gridSelected.prodWorkId,
					lotId : lfo_common.gridSelected.lotId,
					toolMgtId : item.toolMgtId,
					toolUseQty : qtyObj.result * item.toolCount
				}
				
				$.ajax({
					async:false,
					url : "/form/mfgMgt/wrkinWrkerMgt/setProdWorkAdminUpdate",
					type: "POST",
					data: JSON.stringify(savePrmt),
					traditional :true,
					contentType : 'application/json',
					dataType : 'json',
					success: function(data){
						if(data != ""){
							//이전 그리드 리로드
							lfo_equipTool.grid.dataSource.read();
							
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
		}, no : function(){}
	});
}

//공구사용정보 - 완전삭제
this.lfn_jtePopGrd_delete = function(resultObj){
	var delPrmt = [];
	$("#"+ lfo_equipTool.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delItem = lfo_equipTool.grid.dataItem($(this).closest('tr'));
			delItem.prodWorkId = lfo_common.gridSelected.prodWorkId;
			delItem.eqmtMgtId = lfo_common.gridSelected.eqmtMgtId;
			delItem.eqipPosition = delItem.toolLocation;
			delPrmt.push(delItem);
		}
	});
	
	$.ajax({
		async:false,
		url : "/form/mfgMgt/wrkinWrkerMgt/setProdWorkAdminDelete",
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
		{field: "mtrlUseInput", format: "{0:n0}", title : gfn_getMsg("col_totalInputQty"), width: "140px"},			//총투입량
		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_totalUseQty"), width: "140px"},				//총사용량
		{field: "badQty", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},					//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "120px"},													//자재유형
		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},														//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},						//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},					//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},					//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},															//단위
		{field: "mtrlDesc", title : gfn_getMsg("col_desc"), width: "300px"}											//설명
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
			mtrlDiv : { type: "string" },
			mtrlNm : { type: "string" },
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
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "180px",												//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseSavePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'
			+'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseBadList_gridSet(this); " style="min-width:60px;">' + "불량확인" + '</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},													//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},														//자재명
		{field: "mtrlMgtId", title:gfn_getMsg("col_mtrlIndivCd"), width: "170px"},												//자재개별코드
		{field: "mtrlUseInput", format: "{0:n0}", title : gfn_getMsg("col_inputQuan"), width: "110px"},							//투입량
		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_useQuan"), width: "110px"},								//사용량
		{field: "badQty", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},								//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "120px"},																//자재유형
		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},																	//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},									//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},								//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},								//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},																		//단위
		{field: "mtrlMgtPurchase", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "120px"},			//입고일
		{field: "mtrlMgtCnt", format: "{0:n0}", title : gfn_getMsg("col_stockQty"), width: "110px"},							//재고량
		{field: "mtrlMgtDesc", title : gfn_getMsg("col_desc"), width: "300px"}													//설명
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
			//자재 조회버튼 이벤트생성
			$("#mtrlUseDetailSaveBtn").on("click",function(){
				lfn_openMtrlMgtUse();
			});
			//팝업 세팅
			gfn_popform_set(lfo_mtrlUseDetail, mode,selectedItem);
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
				
				// 작업정보 리로드(메인)
				lfo_common.grid.dataSource.read()
				
				//자재투입현황 그리드 리로드
				lfo_mtrlUseTotal.grid.dataSource.read();
				
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
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "110px",							//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseBadSavePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},								//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},									//자재명
		{field: "badId", title:gfn_getMsg("col_badId"), width: "170px"},									//불량아이디
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "220px"},											//불량원인
		{field: "badQty", format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
		{field: "badDesc", title : gfn_getMsg("col_desc"), width: "300px"}									//설명
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
				
				// 작업정보 리로드(메인)
				lfo_common.grid.dataSource.read()
				
				//작업정보 팝업 - 자재투입현황(TOTAL) 리로드
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
		{field: "mtrlUseInput", format: "{0:n0}", title : gfn_getMsg("col_inputQuan"), width: "110px"},							//투입량
		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_useQuan"), width: "110px"},								//사용량
		{field: "badQty", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},								//불량량
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
		{field: "mtrlMgtCnt", format: "{0:n0}", title : gfn_getMsg("col_stockQty"), width: "110px"},							//재고량
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
				lfo_common.grid.dataSource.read();
				
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
		{field: "badQty", format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
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
				lfo_common.grid.dataSource.read();
				
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
			title : gfn_getMsg("col_badCause"), width: "200px"},											//불량원인
		{field: "badQty", format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
		{field: "badDesc", title : gfn_getMsg("col_desc"), width: "300px"}									//설명
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
				//불량등록시 이전에 입력된 데이터 초기화 되므로 예외처리
				//팝업창 리로드 시 이전데이터 복사
				var endPopKeep = {
					prodWorkGood : $("#"+lfo_common.popId+"_form [name=prodWorkGood]").data("kendoNumericTextBox").value(),
					prodWorkStart : $("#"+lfo_common.popId + "_form [name=prodWorkStart]").data("kendoDateTimePicker").value(),
					prodWorkEnd : $("#"+lfo_common.popId + "_form [name=prodWorkEnd]").data("kendoDateTimePicker").value()
				}
				//작업정보 리로드
				lfo_common.grid.dataSource.read();
				
				//작업정보 팝업 리로드
				lfn_jtePop_set("EDT",lfo_common.gridSelected,endPopKeep);
				
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