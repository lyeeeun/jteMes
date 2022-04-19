<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 마스터 그리드 영역 -->
<div id="grid-content"></div>
<script>
var lfo_page = {};

this.lfn_init = function(){
	$.ajax({
		async:false,
		url : "/form/basMgt/codMgt/pageSet/getPageSetList",
		type: "POST",
		success: function(data){
			if(data.rows != ""){
				console.log(data);
				lfo_page.data = data.rows[0];
			}
		},error: function(ex){
			gfn_loading(false);
			console.log("페이지 로그 조회 에러발생")
		}
	});
	
	if(!gfn_isEmpty(lfo_page.data.gridId)){
		lfo_page.grid = {}
		lfo_page.grid[lfo_page.data.gridId] = {};
		var gridHtml = "";
		//그리드 아이디
		lfo_page.grid[lfo_page.data.gridId].html = " id='" + lfo_page.data.gridId + "'";
		
		//그리드 클래스
		if(!gfn_isEmpty(lfo_page.data.gridClass))lfo_page.grid[lfo_page.data.gridId].html += " class='" + lfo_page.data.gridClass + "'";
		
		//그리드 스타일
		if(!gfn_isEmpty(lfo_page.data.gridStyle))lfo_page.grid[lfo_page.data.gridId].html += " style='" + lfo_page.data.gridStyle + "'";
		
		gridHtml += "<div" + lfo_page.grid[lfo_page.data.gridId].html + "></div>"
		
		$("#grid-content").html(gridHtml);
	}
	
	
	$.ajax({
		async:false,
		url : "/form/basMgt/codMgt/pageSet/getPageFieldList",
		type: "POST",
		success: function(data){
			if(data.rows != ""){
				console.log(data);
				lfo_page.data = data.rows[0];
			}
		},error: function(ex){
			gfn_loading(false);
			console.log("페이지 로그 조회 에러발생")
		}
	});
	
	gfn_myTab()["lfn_test"] = function(){}
}
</script>