<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;" class="shopSchdMgtForm">
	<div class="shopSchdMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input class="k-textbox" id="lotId" readonly>
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= 'lfn_lotInfo("select");'><spring:message code = "btn_search"/></button>
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= 'lfn_lotInfo("all");'>전체보기</button>
	</div>
	<div class="shopSchdMgtForm shopSchdMgtForm-gird"> <!-- style="width:100%;" -->
		<div id="gantt" class="shopSchdMgtForm"></div>
	</div>
</div>




<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/qualMgt/infergodsMgt/infergodsMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/prcesMgt/gantChtMgt/gantChtMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200518 JJW  -->

<script>

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
   /* lfn_setGanttChart(); */
};
var selectlotId;

this.lfn_lotInfo = function(mode) {
	
	if(mode == "select"){
		var callback = function(selectedItem){
			$('#gantt').empty();
			$('#lotId').val(selectedItem.lotId);
			selectlotId = $('#lotId').val();
			lfn_setGanttChart();
		};
	gfn_openCustomPop('lotInfo',callback);
	}else if(mode =="all"){
		$('#gantt').empty();
		$('#lotId').val("");
		selectlotId = "";
		lfn_setGanttChart();
	}
}

this.lfn_setGanttChart = function(){
   var ganttData = new Array();

   $.ajax({
      async:false,
      url : '/cform/prcesMgt/gantChtMgt/getGanttChart',
      type: "POST",
      data: JSON.stringify({ lotId: selectlotId }),
      traditional :true,
      contentType : 'application/json',
      dataType : 'json',
      success: function(data){
         console.log(data);
         $.each(data.rows, function(index, item){
            if(item.parentId == "0") {
            	 item.parentId = null;
            }
            ganttData.push(item);
         });
   
      },error: function(ex){
         gfn_loading(false);
         gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});         //오류가 발생했습니다.
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
      views: [  { type: "week", selected: true, slotSize: 150 },
         { type: "month", selected: true, slotSize: 170 }],
      columns: [
         { field: "title", title: "작업", sortable: true, width: "30px" }
      ],
      tooltip: {
         visible: false
      },
      rowHeight: 25,
      showWorkHours: false,
      showWorkDays: false,
      listWidth: "250px",
      dataBound: function() {
         var gantt = this;
      
         gantt.element.find(".k-task").each(function(e) {
            var dataItem = gantt.dataSource.getByUid($(this).attr("data-uid"));
            
            // 여기 색 변경 하시면 됩니다 By 박건우
            $(this).find(".k-task-complete").css("backgroundColor", "#2A58BB"); /* 20.08.31 JJW 작업자퍼센트 색상 */
            $(this).find(".k-task-summary-complete").css("backgroundColor", "#0D358A"); /* 20.08.31 JJW 그래프 기본*/
            $(this).find(".k-task-summary-complete").css("border-color", "#0D358A");
         });
      }
   });
   
} 
</script>