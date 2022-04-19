<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<div id="grid-content" class="sparePartsMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="sparePartsMgtForm sparePartsMgtForm-jteSingleGrid"></div>
</div>

<!-- ������ ���� �۾� CSS -->
<!--  <link href='/resources/mes/css/contents/mtrl/sparePartsMgt/sparePartsMgtForm_lym.css' rel="stylesheet">  -->

<!-- ���ֿ� ���� �۾� CSS -->
<link href='/resources/mes/css/contents/mtrl/sparePartsMgt/sparePartsMgtForm_JJW.css' rel="stylesheet">

<!-- ���� ��Ÿ�� �ܺη� �̵�_200512 JJW  -->


<script>
var lfo_common = {};//Form ���ο��� ���� Object 
//���� �̺�Ʈ(�����ڵ忡�� ����)
this.lfn_init = function(){
	//�׸��� ����
	lfn_jteSgGrd_setGrd();

};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form ���ο��� ���� Object 
	/* 
		1. gridObject.layoutId = gridId
		2. gridObject.popId = popId
		3. gridObject.ctrlUrl = ��ȸ url
		4. gridObject.crud  = {
			read:{url:"",auth:"", prmt:{}}, 
			create:{url:"",auth:"",openFunc:function, callback:function}, 
			update:{url:"",auth:"",openFunc:function, callback:function}, 
			delete:{url:"",auth:"", callback:function}}
		5. gridObject.model = fieldType
		6. gridObject.columns = foeldColumns
		7. gridObject.selectBox = SelectBox ���� �� 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	//lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/mtrl/sparePartsMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{use:false}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
	lfo_common.model = {
		id: "toolId",
		fields: {
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			toolCount : { type: "int"},
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "toolId", title:gfn_getMsg("col_toolCd"), width: "160px"},									//�����ڵ�
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '�����ڵ� ����' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType"), width: "140px;"},												//��������
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "180px"},									//������
		{field: "toolPrice",format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: "90px"},					//���
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit"), width: "120px"},			//����ѵ�
		{field: "toolDesc", title:gfn_getMsg("col_desc"), width: "250px"},
		{field: "toolCount", title:"���", width: "250px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },				//������
		{ text: gfn_getMsg("col_toolCd"), value: "toolInfo.tool_id" },				//�����ڵ�
		/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" },			//�������� */
		{ text: gfn_getMsg("col_desc"), value: "toolInfo.tool_desc" }				//����
	];
	
	//���� �׸��� ���� ȣ�� 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


</script>
