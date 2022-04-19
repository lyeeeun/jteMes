<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="/static/js/kendo.timezones.min.js"></script>

<div style="width:100%;">
	<div class="eqmtOperationPlanForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input type="text" class="k-textbox" id="lotId" style="margin-left: 10px;" readonly/>
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_lotInfo();"><spring:message code = "btn_search"/></button>
		<input type="text" class="k-textbox" id="prodAsmNm" readonly/>
		<input type="hidden" class="k-textbox" id="prodAsmId" readonly/>
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_routingSheet();"><spring:message code = "btn_search"/></button>
		
		<input id="performanceRate"></input>
		<div style="float:right; font-weight:bold; margin-right: 10px;">
			<label>예상 완료 일자: </label>
			<input type="text" class="k-textbox" id="estimatedDate" readonly />
		</div>
	</div>
	<div id="grid-content" class="eqmtOperationPlanForm k-content">
		<div id="scheduler"></div>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/mfgMgt/analsMgt/analsMgtForm.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200810 youmi -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfn_setSelBox();
	lfn_setScheduler();
};

this.lfn_setSelBox = function() {
	var shBoxItem = gfn_getCode('eqmt_performance_rate');

	$("#performanceRate").kendoDropDownList({
		dataTextField: "cdNm",
		dataValueField: "cdVal",
		dataSource: shBoxItem,
		index: 1
	});
}

this.lfn_lotInfo = function() {
	var callback = function(selectedItem){
		$('#lotId').val(selectedItem.lotId);
	};
	gfn_openCustomPop('lotInfo', callback);
}

this.lfn_routingSheet = function() {
	var callback = function(selectedItem){
		$('#scheduler').empty();
		
		$('#prodAsmId').val(selectedItem.prodAsmId);
		$('#prodAsmNm').val(selectedItem.prodAsmNm);
		lfn_setScheduler();
	};
	gfn_openCustomPop('assignInfo', callback, {lotId: $('#lotId').val()});
}

this.lfn_setScheduler = function() {
	var eqmtList = new Array();
	var operationList = new Array();
	
	var maxDate = new Date();
	
	var workStartDate = new Date();
	var workEndDate = new Date();
	
	var eqmtPerformRate = parseFloat($("#performanceRate").data("kendoDropDownList").value());
	$.ajax({
		async:false,
		url : "/form/mfgMgt/analsMgt/selectRoutingSheet",
		type: "POST",
		data: { prodAsmId: $('#prodAsmId').val()},
		success: function(data){
			
			$.each(data.rows, function(index, item) {
				
				item.dayTarget = parseInt(item.prodWorkQty/(item.dayTarget * eqmtPerformRate));
				
				eqmtList.push({ text: item.routingId + " / " + item.eqmtMgtNm, value: item.eqmtMgtId, color: "#F6C0D5" });
				
				if(item.prodWorkStart == null) {
					workStartDate = new Date(maxDate);
					workEndDate.setDate(maxDate.getDate() + item.dayTarget);
					operationList.push({ Title:"", Start: new Date(workStartDate), End: new Date(workEndDate), eqmtId: item.eqmtMgtId, Attendees:[1], isAllDay: true });
					maxDate = new Date(workEndDate);
					maxDate.setDate(maxDate.getDate() + 1);
				} else if(item.prodWorkStart != null && item.prodWorkEnd == null) {
					workStartDate = new Date(item.prodWorkStart);
					workEndDate.setDate(workStartDate.getDate() + item.dayTarget);
					operationList.push({ Title:"", Start: new Date(workStartDate), End: new Date(workEndDate), eqmtId: item.eqmtMgtId, Attendees:[1], isAllDay: true });
					
					if((maxDate-workEndDate) < 0) {
						maxDate = new Date(workEndDate);
						maxDate.setDate(maxDate.getDate() + 1);
					}	
				} else if(item.prodWorkStart != null && item.prodWorkEnd != null) {
					workEndDate = new Date(item.prodWorkEnd)
					operationList.push({ Title:"", Start: new Date(item.prodWorkStart), End: new Date(item.prodWorkEnd), eqmtId: item.eqmtMgtId, Attendees:[1], isAllDay: true });
					if((maxDate-workEndDate) < 0) {
						maxDate = new Date(workEndDate);
						maxDate.setDate(maxDate.getDate() + 1);
					}
				}
				
			});
		}, 
		error: function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		}
	});
	
	maxDate.setDate(maxDate.getDate() - 1);
	$('#estimatedDate').val(gfn_getDate(maxDate,'yyyy-MM-dd'));
	
	$("#scheduler").kendoScheduler({
		date: gfn_getDate("yyyy-MM-dd"),
		startTime: gfn_getDate("yyyy-MM-dd 00:00:00"),
		endTime: gfn_getDate("yyyy-MM-dd 22:00:00"),
		height: 700,
		eventHeight: 25,
		majorTick: 60,
		dateHeaderTemplate: kendo.template("<strong>#=kendo.toString(date, 'MM-dd')#</strong>"),
		views: [{
			type: "timelineMonth",
			startTime: gfn_getDate("yyyy-MM-dd 00:00:00"),
			majorTick: 1440,
			columnWidth: 110,
			selectedDateFormat: "{0:yyyy/MM/dd} - {1:yyyy/MM/dd}",
			selectedShortDateFormat: "{0:yyyy/MM/dd} - {1:yyyy/MM/dd/}"
		}],
		timezone: "Etc/GMT",
		dataBinding: function(e) {
			var view = this.view();
			view.timesHeader.hide();
			$( ".k-scheduler-header-wrap > table > tbody > tr:eq(1)" ).hide();
		},
		dataSource: {
			data: operationList,
			schema: {
				model: {
					fields: {
						start: { type: "date", from: "Start" },
						end: { type: "date", from: "End" },
						title: { from: "Title", defaultValue: "No title", validation: { required: true } },
						startTimezone: { from: "StartTimezone" },
						endTimezone: { from: "EndTimezone" },
						description: { from: "Description" },
						recurrenceId: { from: "RecurrenceID" },
						recurrenceRule: { from: "RecurrenceRule" },
						recurrenceException: { from: "RecurrenceException" },
						eqmtId: { type:"string", from: "eqmtId", nullable: true },
						attendees: { from: "Attendees", nullable: true },
						isAllDay: { type: "boolean", from: "isAllDay" }
					}
				}
			}
		},
		editable: false,
		group: {
			resources: ["Equipment", "Attendees"],
			orientation: "vertical"
		},
		resources: [
			{
				field: "eqmtId",
				name: "Equipment",
				dataSource: eqmtList,
				title: "Equipment"
			},
			{
				field: "attendees",
				name: "Attendees",
				dataSource: [
					{ text: "", value: 1, color: "#F6C0D5" },
				
				],
				multiple: true,
				title: "Attendees"
			}
		]
	});
}
</script>