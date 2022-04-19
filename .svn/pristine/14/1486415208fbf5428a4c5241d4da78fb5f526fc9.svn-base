<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="comnPopupLayer" style="overflow: hidden;">
	<div class="container-fluid ma-t-10 padd-10" style="width: 95%;">
		<div class="row padd-10 bor-1-e3 ">
			<ul class="fc-red clboth">
				<li id="_comn_popup_msg" class="" style="height: 60px; overflow-y: auto;min-width: 455px;"></li>
				<li id="_comn_popup_dtl_vewer_btn">
					<span class="fl-r padd-t-10">
						<button id="_comn_popup_dtl_btn" style="background-color: #1760C5; border: 1px solid #1760C5; border-radius: 5px; color: #ffffff; font-size: 16px; font-weight: 800;">펼치기</button> <!-- 04.01 JJW 수정  -->
					</span>
				</li>
			</ul>
		</div>
	</div>

	<div id="_comn_popup_input_msg_viewer" class="container-fluid padd-10" style="width: 95%;">
		<div class="row padd-10 bor-1-e3 ">
			<ul class="fc-red clboth">
				<li class="padd-10 " style="width: 450px;">
					<input type="text" id="_comn_popup_input_msg" name="_comn_popup_input_msg" class="form-control k-textbox">
				</li>
			</ul>
		</div>
	</div>

	<div id="_comn_popup_dtl_vewer" class="container-fluid ma-t-10 padd-10" style="width: 95%;">
		<div class="row padd-10 bor-1-e3 ">
			<ul class="fc-red clboth">
				<li id="_comn_popup_dtl_msg" class="" style="height: 60px; overflow-y: auto;max-width: 450px;min-width: 450px;"></li>
			</ul>
		</div>
	</div>

	<div class="container-fluid text-center" style="clear: both;">
		<span class="fl-r padd-t-10"><button class="btn-typ-4" id="_comn_popup_btn_ok" style="margin-right: 14px">확인</button></span>
		<span class="fl-r padd-t-10"><button class="btn-typ-4 ma-r-10" id="_comn_popup_btn_cls">취소</button></span>
	</div>

</div>



<script type="text/javascript">
/**
 * /common/popup/comPopup
*/

this.lfn_init = function(args) {

	if(!args){
		args = {target:""};
	}
	if(!args.result){ // 기본값 입력이 없으면...
		args.result = "DONE"; // 초기화 값 DONE. (기본값)
	}

	if(args.msg){
		$("#" + args.target + " #_comn_popup_msg").html(args.msg.replace(/\n/gi,"<br>"));
	}

	if(args.detail){
		$("#" + args.target + " #_comn_popup_dtl_msg").html(args.detail);//.replace(/\\r/gi,"").replace(/\\n/gi,"<br>").replace(/\\t/gi,"").replace(/</gi,"&lt;").replace(/>/gi,"&gt;"));
	}else{
		$("#" + args.target + " #_comn_popup_dtl_vewer_btn").css("display","none");
	}

	$("#" + args.target + " #_comn_popup_btn_ok").on("click", function(){
		args.result = "YES";
	});
	
	$("#" + args.target + " #_comn_popup_btn_cls").on("click", function(){
		args.result = "NO";
	});
	
	$("#" + args.target + " #_comn_popup_dtl_btn").on("click", function() {
		if(args.isDetail == false){
			// alert("여기서 펼치기 해야함.");
			$("#" + args.target + " #_comn_popup_dtl_vewer").css("display","block");
			$("#" + args.target + " #_comn_popup_dtl_msg").css("display","block");
			if(document.location.pathname!="/om" && document.location.pathname!="/om/"){
				var popHeight = '350px';
			}else{
				var popHeight = '312px';
			}
			parent.$("#"+args.target).data("kendoWindow").setOptions({
				width : args.width
				, height : popHeight
			});
			args.isDetail = true;
		}else{
			// alert("여기서 접히기 해야함.");
			$("#" + args.target + " #_comn_popup_dtl_vewer").css("display","none");
			$("#" + args.target + " #_comn_popup_dtl_msg").css("display","none");
			parent.$("#"+args.target).data("kendoWindow").setOptions({
				width : args.width
				, height : args.height
			});
			args.isDetail = false;
		}
	});

	// 팝업 기능개선. Enter를 누르면 확인/YES을 누른것으로 처리한다.
	$("#" + args.target).keyup(
			function(e){
				if(e.keyCode==13){
					$("#" + args.target + " #_comn_popup_btn_ok").trigger("click");
				}else if(e.kcode == 27){
					parent.$("#"+args.target).data("kendoWindow").close();
				}
			});

	$("#" + args.target + " #_comn_popup_btn_ok").on("click", function() {
		if(args.typeCd=="P"){
			args.result = $("#" + args.target + " input[name='_comn_popup_input_msg']").val()
		}else{
			args.result = "YES";
			//2019-12-27 jkkim - conBox에서 리턴값 없음
		}
		parent.$("#"+args.target).data("kendoWindow").close();
	});

	$("#" + args.target + " #_comn_popup_btn_cls").on("click", function() {
		args.result = "NO";
		parent.$("#"+args.target).data("kendoWindow").close();
	});

	if(args.typeCd == "Q"){
		$("#" + args.target + " #_comn_popup_btn_ok").html("확인");
		$("#" + args.target + " #_comn_popup_btn_cls").html("취소");
		$("#" + args.target + " #_comn_popup_dtl_vewer_btn").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_vewer").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_msg").css("display","none");
		$("#" + args.target + " #_comn_popup_input_msg_viewer").css("display","none");
	}else if(args.typeCd == "P"){
// 		$("#" + args.target + " #_comn_popup_msg").html($("#" + args.target + " #_comn_popup_msg").html() + "<br/>"
// 				+ "<input type=\"text\" id=\"_comn_popup_input_msg\" name=\"_comn_popup_input_msg\" class=\"form-control\">");
		$("#" + args.target + " input[name='_comn_popup_input_msg']").val("");
		$("#" + args.target + " #_comn_popup_btn_ok").html("확인");
		$("#" + args.target + " #_comn_popup_btn_cls").html("취소");
		$("#" + args.target + " input[name='_comn_popup_input_msg']").prop("disabled",false);
		$("#" + args.target + " input[name='_comn_popup_input_msg']").css("margin-bottom","15px");
		// if(!args.detail){
			$("#" + args.target + " #_comn_popup_dtl_vewer_btn").css("display","none");
		//}
		$("#" + args.target + " #_comn_popup_dtl_vewer").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_msg").css("display","none");
	}else if(args.typeCd == "E"){
		$("#" + args.target + " #_comn_popup_btn_ok").html("확인");
		$("#" + args.target + " #_comn_popup_btn_cls").css("display","none");
		$("#" + args.target + " #_comn_popup_input_msg_viewer").css("display","none");
		args.isDetail = false;
		$("#" + args.target + " #_comn_popup_dtl_vewer").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_msg").css("display","none");
	}else{
		$("#" + args.target + " #_comn_popup_btn_ok").html("확인");
		$("#" + args.target + " #_comn_popup_btn_cls").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_vewer_btn").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_vewer").css("display","none");
		$("#" + args.target + " #_comn_popup_dtl_msg").css("display","none");
		$("#" + args.target + " #_comn_popup_input_msg_viewer").css("display","none");
	}


};



</script>

