$(document).ready(function(){
	//검색 Select 박스 생성
	setSearchCombo();
	
	var orderGrid = $('#partsGridTable');
	orderGrid.datagrid({
		pageSize:20,
		columns:[[
			{field:'pms_cd_01',title:'Code',width:15,formatter: function(value,row,index){
					return row.pmsCd01 +" "+row.pmsCd02+" "+row.pmsCd03+" "+row.pmsCd04+" "+row.pmsCd05;
				}
			},
			{field:'desc_tech',title:'PMS Descript',width:30,sortable:true,
				formatter: function(value,row,index){
					if(row.descTech != null){
						return row.descTech;
					}else{
						return "-";
					}
				}
			},
			{field:'part.prod_std',title:'PMS Name',width:30,sortable:true,
				formatter: function(value,row,index){
					if(row.prodStd != null){
						return row.prodStd;
					}else{
						return "-";
					}
				}
			},
			{field:'part.plate_no',title:'PMS Plate No',width:15,sortable:true,
				formatter: function(value,row,index){
					if(row.plateNo != null){
						return row.plateNo;
					}else{
						return "-";
					}
				}
			},
			{field:'pms_qty',title:'Q`ty',width:5,
				formatter: function(value,row,index){
					var strReutrn = "-";
					var jsonData = "";
					if(row.needPlateInfoJson != null){
						jsonData = JSON.parse(row.needPlateInfoJson);
						if(row.plateNo != null){
							if(jsonData[row.plateNo] != undefined){
								strReutrn =  jsonData[row.plateNo].pmsQty;
							}
						}
					}
					return strReutrn;
				}
			},
			{field:'pms_unit',title:'Unit',width:5,
				formatter: function(value,row,index){
					var strReutrn = "-";
					var jsonData = "";
					if(row.needPlateInfoJson != null){
						jsonData = JSON.parse(row.needPlateInfoJson);
						if(row.plateNo != null){
							if(jsonData[row.plateNo] != undefined){
								strReutrn =  jsonData[row.plateNo].pmsUnit;
							}
						}	
					}
					return strReutrn;
				}
			}
			]]
	});
	orderGrid.datagrid({pagePosition:'bottom'});
	orderGrid.datagrid('getPager').pagination({
		layout:['list','sep','first','prev','sep','links','sep','next','last','sep','refresh','info'],
	});
});

//검색 엔터 이벤트
$('#partsText').textbox({
	inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		keyup:function(e){
			if (e.keyCode == 13) {
				doSearch();
			}
		}
	})
});

//검색 Combo 박스 생성
function setSearchCombo(){
	var comboData = [
		{"id":"desc_tech","text":"Part Descript","selected":true},
		{"id":"part.prod_std","text":"PMS Name"},
		{"id":"part.plate_no","text":"PMS Plate No"}
	];
	//if($("#hidCombo").val() == "code"){
	//	comboData = [{"id":"name","text":"NAME"},{"id":"code","text":"CODE","selected":true}];
	//}
	$("#partsCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

//검색
function doSearch(){
	$('#partsGridTable').datagrid('load',{
		searchGubun: $("#partsCombo").val(),
		searchText:$("#partsText").val()
	});
}