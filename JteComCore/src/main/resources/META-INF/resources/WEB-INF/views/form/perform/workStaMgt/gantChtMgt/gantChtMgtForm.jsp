<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="gantChtMgtForm gantt" > <!-- style="width: 100%;" -->
		<div id="gantt"></div>
	</div>
</div>


<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/qualMgt/infergodsMgt/infergodsMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/prcesMgt/gantChtMgt/gantChtMgtForm.css' rel="stylesheet"> -->

<!-- 내부 스타일 외부로 이동_200518 JJW  -->

<!--  200811 youmi CSS -->
<link href='/resources/mes/css/contents/prcesMgt/gantChtMgt/gantChtMgtForm_JJW.css' rel="stylesheet"> 


<script>

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_setGanttChart();
};

this.lfn_setGanttChart = function(){
	var ganttData = new Array();
	
	$.ajax({
		async:false,
		url : '/form/perform/workStaMgt/gantChtMgt/getGanttChart',
		type: "POST",
		data: "",
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			$.each(data.rows, function(index, item){
				if(item.parentId == "0") {
					delete item.parentId
				}
				ganttData.push(item);
			});
	
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$("#gantt").kendoGantt({
		dataSource: new kendo.data.GanttDataSource({
			data: ganttData,
			schema: {
				model: {
					id: "id",
					fields: {
						id: { from: "id", type: "string" },
						orderId: { from: "orderID", type: "number", validation: { required: true } },
						parentId: { from: "parentId", type: "string", defaultValue: null },
						start: { from: "start", type: "date" },
						end: { from: "end", type: "date" },
						summary: { from: "summary", type: "boolean" },
						expanded: { from: "expanded", type: "boolean", defaultValue: true },
						title: { from: "title", defaultValue: "", type: "string" }
					}
				}
			}
		}),
		snap: false,
		editable: false,
		views: [{ type: "week", selected: true },"month"],
		columns: [
			{ field: "title", title: "작업", sortable: true, width: "30px" }
		],
		rowHeight: 30,
		showWorkHours: false,
		showWorkDays: false,
		listWidth: "250px",
		dataBound: function() {
			var gantt = this;
		
			gantt.element.find(".k-task").each(function(e) {
				var dataItem = gantt.dataSource.getByUid($(this).attr("data-uid"));
				
				// 여기 색 변경 하시면 됩니다 By 박건우 /* 200518 JJW 작업 완료 색상 */
				$(this).find(".k-task-complete").css("backgroundColor", "#3367D6");
		
			});
		}
	});
	
} 
</script>
