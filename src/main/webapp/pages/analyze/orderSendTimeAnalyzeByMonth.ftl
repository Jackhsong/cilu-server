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
<link href="${rc.contextPath}/pages/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<style>
	
</style>
</head>
<body class="easyui-layout">
<!-- 
<div data-options="region:'west',title:'menu',split:true" style="width:180px;">
	<#include "../common/menu.ftl" >
</div>
 -->
<div data-options="region:'center',title:'content'" style="padding:5px;">
	
	<div id="searchDiv" class="datagrid-toolbar" style="height: 30px; padding: 15px">
		<form id="searchDivForm" action="${rc.contextPath}/analyze/orderSendTimeAnalyzeByMonth" method="post">
			<table>
				<tr>
					<td>查询日期</td>
					<td><input value="${selectDate}" id="selectDate" name="selectDate" onClick="WdatePicker({dateFmt: 'yyyy-MM',minDate:'2015-03'})"/></td>
					<td>&nbsp;&nbsp;<a id="searchBtn" onclick="searchAll()" href="javascript:;" class="easyui-linkbutton" >查询</a></td>
					<td>&nbsp;&nbsp;<a id="exportBtn" onclick="exportAll()" href="javascript:;" class="easyui-linkbutton" >导出结果</a></td>
				</tr>
			</table>
		<form>
	</div>
	<br/>
	
	<!-- 数据表格 -->
	<table class="table table-bordered table-striped" width="100%">
		<tr>
			<th >日期</th>
			<th >应发订单量</th>
			<th >准时发货</th>
			<th >超时发货</th>
			<th >超时未发货</th>
			<th >未超时未发货</th>
			<th >发货准时率</th>
			<th >最优发货准时率</th>
			<th >发货进度</th>
		</tr>
		<#list  rows as r >
			<tr>
				<td >${r.date}</td>
				<td >${r.totalAmount}</td>
				<td >${r.ontimeAmount}</td>
				<td >${r.timeoutSendAmount}</td>
				<td >${r.timeoutNoSendAmount}</td>
				<td >${r.waitSendAmount}</td>
				<td >${r.sendOntimePercent}</td>
				<td >${r.bestSendOntimePercent}</td>
				<td >${r.sendProgressPercent}</td>
			</tr>
		</#list>
	</table>
	
</div>
<script>
$(function(){
	$(document).keydown(function(e){
		if (!e){
		   e = window.event;  
		}  
		if ((e.keyCode || e.which) == 13) {  
		      $("#searchBtn").click();  
		}
	});
});

function searchAll() {
	$('#searchDivForm').attr("action", "orderSendTimeAnalyzeByMonth").submit();
}

function exportAll() {
	$('#searchDivForm').attr("action", "exportOrderSendTimeAnalyzeByMonth").submit();
}
</script>

</body>
</html>