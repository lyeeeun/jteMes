<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="/static/js/kendo.timezones.min.js"></script>

<div style="width:100%;">
	<div class="eqmtOperationPlanForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input type="text" class="k-textbox" id="placeNm" readonly/>
		<input type="hidden" id="placeId">
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_placeInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="eqmtOperationPlanForm k-content">
		<div id="scheduler"></div>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/eqmtOperationPlan/eqmtOperationPlanForm.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200810 youmi -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_setScheduler();
};

this.lfn_placeInfo = function() {
	var callback = function(selectedItem){
		$('#scheduler').empty();
		$('#placeId').val(selectedItem.placeId);
		$('#placeNm').val(selectedItem.placeNm);
		
		lfn_setScheduler();
	};
	gfn_openCustomPopTree('place', callback);
}

this.lfn_setScheduler = function() {
	var eqmtList = new Array();
	var operationList = new Array();
	
	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/facilMgt/getEqmtMgtListAll",
		type: "POST",
		data: { placeId: $('#placeId').val()},
		success: function(data){
			$.each(data.result, function(index, item) {
				eqmtList.push({ text: item.eqmtMgtNm, value: item.eqmtMgtId, color: "#F6C0D5" });
			});
		}, 
		error: function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		}
	});
	
	
	$.ajax({
		async:false,
		url : "/form/mfgMgt/mfgplanMgt/eqmtOperationPlan/selectEqmtOperationPlan",
		type: "POST",
		data: { placeId: $('#placeId').val()},
		success: function(data){
			$.each(data.rows, function(index, item) {
				operationList.push({ Title:"", Start: new Date(item.prodAsmDate), End: new Date(item.prodAsmDate), eqmtId: item.eqmtMgtId, Attendees:[1], isAllDay: true });
			});
		}, 
		error: function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		}
	});
	
	$("#scheduler").kendoScheduler({
		date: gfn_getDate("yyyy-MM-dd"),
		startTime: gfn_getDate("yyyy-MM-dd 00:00:00"),
		endTime: gfn_getDate("yyyy-MM-dd 22:00:00"),
		height: 700,
		eventHeight: 25,
		majorTick: 60,
		dateHeaderTemplate: kendo.template("<strong>#=kendo.toString(date, 'd')#</strong>"),
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