//var reader = new FileReader();
//
//var filedata = "";
//
//reader.onload = function(e) {
//	filedata = reader.result;
//}
$(document).ready( function () {
	var data1 = new Array();
	var data2 = new Array();
	var data3 = new Array();
	var data4 = new Array();
	var temp = new Array();
	var f_data = "";
	var flag = -1;
	var sumTime = 0;
	//
	
	var startTime = new Date().getTime();
	$.get("/js/rms/graph/file1.txt", function(data) {
		f_data = data;
		var lines = data.split("\n");
		$.each(lines, function(n, elem) {
			if(n > 0 && n < 10001) {
				temp = elem.split(',');
				if(parseFloat(temp[0]) == 0) {
					flag ++;
				}
				data1[n-1] = temp[0];
				data2[n-1] = temp[1];
				data3[n-1] = temp[2];
				data4[n-1] = "";
				 if(flag == 2){
					sumTime += 3.333;
					data4[n-1] = "" + sumTime + "(ms)";
					flag = 0;
					console.log("3.333"); 
				}
				
			}
		})
		
		 $("#chart").kendoChart({
			 chartArea: {
				    height: 330
				 },
	         title: {
	             text: "Fig.4.2 Pulse width modulation #1"
	         },
	         legend: {
	             position: "bottom"
	         },
	         series: [{
	        	 dashType: "solid",
	        	 type: "line",
	        	 width: 1,
	             data: data1,
	             name: "sin Value",
	             axis: "value",
	             markers: {
	                 visible: false,
	             }
	         },{
	        	 dashType: "solid",
	             type: "line",
	             width: 1,
	             data: data2,
	             name: "Tri Value",
	             color: "#007eff",
	             axis: "value",
	             markers: {
	                 visible: false,
	             }
	         }],
	         valueAxes: [{
	             name: "value",
	             color: "black",
	             min: -1.2,
	             max: 1.2
	         }],
	         categoryAxis: {
	        	title: {
	        		text: "time(ms)",
	        	},
	        	categories:data4,
	        	labels: {
	                position: "start"
	            },
	            
//	           
	         },
	         tooltip: {
	             visible: true,
	             format: "{0}"
//	             template: "#= category #/03: #= value #"
	         }
	     });
		
		 $("#chart2").kendoChart({
			 chartArea: {
			    height: 330
			 },
	         title: {
	             text: "Fig.4.2 Pulse width modulation #2"
	         },
	         legend: {
	             position: "bottom"
	         },
	         series: [{
	        	 dashType: "solid",
	        	 type: "line",
	        	 style: "step",
	        	 width: 1,
	             data: data3,
	             name: "On Off Signal",
	             axis: "value",
	             markers: {
	                 visible: false,
	             }
	         }],
	         valueAxes: [{
	             name: "value",
	             color: "black",
	             min: -0.2,
	             max: 1.2,
	             axisCrossingValue: 0.5
	         }],
	         categoryAxis: {
	        	 title: {
		        		text: "time(ms)",
		        },
	        	 categories:data4,
	        	 labels: {
		                position: "start"
	        	 },
	         },
	         tooltip: {
	             visible: true,
	             format: "{0}"
	         }
	     });
		 
		 var endTime = new Date().getTime() - startTime;
		 $("#headerT").text("측정 시간");
		 $("#startTime").text("StartTime : 1582608727 , 75330");
		 $("#endTime").text("EndTime : 1582608729 , 81821");
		 $("#elapsedTime").text("Elapsed Time : 2 , 6491");
		 $("#graphDisplayTime").text("Graph Display Time : " + endTime + "ms");
	
	})
});
