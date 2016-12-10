<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>心动慈露-后台管理</title>
<link href="${rc.contextPath}/pages/js/jquery-easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/pages/js/jquery-easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="${rc.contextPath}/pages/js/jquery-easyui-1.4/jquery.min.js"></script>
<script src="${rc.contextPath}/pages/js/jquery-easyui-1.4/jquery.easyui.min.js"></script>
<script src="${rc.contextPath}/pages/js/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
<script src="${rc.contextPath}/pages/js/My97DatePicker/WdatePicker.js"></script>

<style type="text/css">
	#myCss span {
		font-size:12px;
		padding-right:20px;
	}
</style>

</head>
<body class="easyui-layout">

<div data-options="region:'west',title:'menu',split:true" style="width:180px;">
<input type="hidden" value="${nodes!0}" id="nowNode"/>
	<#include "../common/menu.ftl" >
</div>

<div data-options="region:'center',title:'批量修改供货价管理'" style="padding:5px;">
	<form id="methodForm" action="" method="post">
		<input type=hidden id="dataKey" name="dataKey" value="0" />
		<input type=hidden id="type" name="type" value="" />
		<input type=hidden id="isRight" name="isRight" value="0" />
		<input id="orderFileBox" type="text" name="importFile" style="width:300px" />&nbsp;&nbsp;&nbsp;
		<a id="searchBtn" onclick="downFile()" href="javascript:;" class="easyui-linkbutton" >下载导入模板</a><br/><br/>
		<a id="searchBtn" onclick="doFormAction(1)" href="javascript:;" class="easyui-linkbutton" >模拟导入结果</a>&nbsp;&nbsp;&nbsp;
		<a id="searchBtn" onclick="downResult()" href="javascript:;" class="easyui-linkbutton" >导出模拟结果</a><br/><br/>
		<a id="searchBtn" onclick="doFormAction(2)" href="javascript:;" class="easyui-linkbutton" >确认批量修改</a>&nbsp;&nbsp;&nbsp;
	</form>
	<br/>
	<div>
		<span style="color:red">成功：<span id="okNum"> 0</span></span>&nbsp;&nbsp;
		<span style="color:red">失败：<span id="failNum"> 0</span></span>
		<table id="s_data"> </table>		
	</div>
</div>

<script>

function doFormAction(type) {
	$('#type').val(type);
	if(type == 1){
		$('#methodForm').attr("action", "importBatchUpdateProductCostPrice").attr("enctype", "multipart/form-data").submit();
	}else if(type == 2){
		$('#methodForm').attr("action", "importBatchUpdateProductCostPrice").submit();
	}
}

function downFile() {
	window.location.href = '${rc.contextPath}/productBase/downloadBatchUpdateProductCostPrice';
}

function downResult() {
	window.location.href = '${rc.contextPath}/productBase/downloadBatchUpdateProductCostPriceResult?dataKey='+$("#dataKey").val();
}

$(function (){
	$('#s_data').datagrid({
		nowrap : false,
		striped : true,
		collapsible : true,
		idField : 'pid',
		url : '${rc.contextPath}/productBase/jsonBatchUpdateProductCostPriceResult',
		queryParams : {
			dataKey:0
		},
		loadMsg : '正在装载数据...',
		fitColumns : true,
		remoteSort : true,
		singleSelect : true,
		columns : [ [
				{field : 'status', title : '导入状态', width : 70, align : 'center'},
				{field : 'msg', title : '说明', width : 70, align : 'center'},
				{field : 'productBaseId', title : '基本商品ID', width : 70, align : 'center'},
				{field : 'submitType', title : '商品结算类型', width : 70, align : 'center'},	
				{field : 'wholesalePrice', title : '供货价', width : 70, align : 'center'},
				{field : 'deduction', title : '扣点', width : 70, align : 'center'},
				{field : 'proposalPrice', title : '建议售价', width : 70, align : 'center'},
				{field : 'selfPurchasePrice', title : '自营采购价', width : 70, align : 'center'}
				] ]
		});
	
	$('#methodForm').form({
		url:'',   
		onSubmit: function(){   
			var type = $('#type').val();
			var orderFile = $('#orderFileBox').filebox("getValue");
			if(orderFile == ""){
				$.messager.alert("info","请选择文件","warn");
				return false;
			}
			if(type == 2){
				//确定导入
				var isRight = $('#isRight').val();
				if(isRight == 0){
					$.messager.alert("提示","当前状态不允许确认导入","error");
					return false;
				}
			}
			$.messager.progress();
		},   
		success:function(data){
			$.messager.progress('close');
			var data = eval('(' + data + ')');  // change the JSON string to javascript object   
			if (data.status == 1){
				$('#isRight').val(data.isRight);
				$('#okNum').html(data.okNum);
				$('#failNum').html(data.failNum);
				$("#dataKey").val(data.dataKey);
				$('#s_data').datagrid('load',{dataKey:data.dataKey});
			}else{
				$('#isRight').val(0);
				$('#okNum').html(0);
				$('#failNum').html(0);
				$("#dataKey").val(0);
				$('#s_data').datagrid('load',{dataKey:0});
				$.messager.alert("提示",data.msg,"info");
			}
		}   
	});
	
	$('#orderFileBox').filebox({
		buttonText: '打开导入文件',
		buttonAlign: 'right'
	});
});

</script>

</body>
</html>