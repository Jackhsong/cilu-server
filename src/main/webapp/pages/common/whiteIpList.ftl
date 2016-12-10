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

</head>
<body class="easyui-layout">

<div data-options="region:'west',title:'menu',split:true" style="width:180px;">
<input type="hidden" value="${nodes!0}" id="nowNode"/>
	<#include "../common/menu.ftl" >
</div>

<div data-options="region:'center'" style="padding:5px;">
	<div id="cc" class="easyui-layout" data-options="fit:true" >
		<div data-options="region:'north',title:'自定义版块管理',split:true" style="height: 90px;">
			<br/>
			<table>
				<tr>
					<td>IP：</td>
					<td><input id="searchIp" name="searchIp" value=""/></td>
					<td>是否可用：</td>
					<td>
						<select id="searchIsAvailable">
							<option value="-1">全部</option>
							<option value="1">可用</option>
							<option value="0">停用</option>
						</select>
					</td>
					<td><a id="searchBtn" onclick="searchIp()" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a></td>
				</tr>
			</table>
			
		</div>
		
		<div data-options="region:'center'" >
			<!--数据表格-->
    		<table id="s_data" style=""></table>
    		
		    <!-- 新增 begin -->
		    <div id="editWhiteIpDiv" class="easyui-dialog" style="width:450px;height:250px;padding:15px 20px;">
		        <form id="editWhiteIpForm" method="post">
					<input id="editWhiteIpForm_id" type="hidden" name="id" value="" >
					<p>
						<span>&nbsp;&nbsp;&nbsp;IP：</span>
						<span><input type="text" name="ip" id="editWhiteIpForm_ip" value="" maxlength="32" style="width: 300px;"/></span>
					</p>
					<p>
						<span>&nbsp;&nbsp;备注：</span>
						<span><input type="text" name="remark" id="editWhiteIpForm_remark" value="" maxlength="100" style="width: 300px;"/></span>
					</p>
					<p>
						<span>可用状态：</span>
						<span><input type="radio" name="isAvailable" id="editWhiteIpForm_isAvailable1" checked value="1"/>可用&nbsp;&nbsp;</span>
						<span><input type="radio" name="isAvailable" id="editWhiteIpForm_isAvailable0" value="0"/>停用</span>
					</p>
		    	</form>
		    </div>
		    <!-- 新增 end -->
    		
		</div>
        
	</div>
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

	function searchIp(){
    	$('#s_data').datagrid('load',{
    		ip:$("#searchIp").val(),
    		isAvailable:$("#searchIsAvailable").val()
    	});
	}

	function cleanEditWhiteIpDiv(){
		$("#editWhiteIpForm_id").val('');
		$("#editWhiteIpForm input[type='text']").each(function(){
			$(this).val('');
		});
		$("input[name='isAvailable']").each(function(){
			$(this).prop('checked',false);
		});
	}
	
	function editIt(index){
		cleanEditWhiteIpDiv();
		var arr=$("#s_data").datagrid("getData");
		var id = arr.rows[index].id;
		var ip = arr.rows[index].ip;
		var remark = arr.rows[index].remark;
		var isAvailable = arr.rows[index].isAvailableCode;
    	$('#editWhiteIpForm_id').val(id);
    	$('#editWhiteIpForm_ip').val(ip);
    	$('#editWhiteIpForm_remark').val(remark);
    	$("input[name='isAvailable']").each(function(){
    		if($(this).val()==isAvailable){
    			$(this).prop('checked',true);
    		}
    	});
    	$('#editWhiteIpDiv').dialog('open');
	}
	
	function availableIt(id,code){
		var tips = '';
		if(code == 1){
			tips = '确定启用吗？';
		}else{
			tips = '确定停用吗？'
		}
    	$.messager.confirm("提示信息",tips,function(re){
        	if(re){
            	$.messager.progress();
            	$.post("${rc.contextPath}/sysConfig/updateWhiteIpStatus",{id:id,isAvailable:code},function(data){
                	$.messager.progress('close');
                	if(data.status == 1){
                        $('#s_data').datagrid('reload');
                	} else{
                    	$.messager.alert('响应信息',data.msg,'error');
                	}
            	})
        	}
    	});
	}

	$(function(){
		
		$('#s_data').datagrid({
            nowrap: false,
            striped: true,
            collapsible:true,
            idField:'id',
            url:'${rc.contextPath}/sysConfig/jsonWhiteIpInfo',
            loadMsg:'正在装载数据...',
            singleSelect:false,
            fitColumns:true,
            remoteSort: true,
            pageSize:50,
            pageList:[50],
            columns:[[
            	{field:'id',    title:'ID', width:20, align:'center',checkbox:true},
                {field:'ip',    title:'IP地址', width:50, align:'center'},
                {field:'isAvailable',    title:'可见状态', width:70, align:'center'},
                {field:'createUser',    title:'创建人', width:50, align:'center'},
                {field:'createTime',    title:'创建时间', width:50, align:'center'},
                {field:'remark',    title:'备注', width:60, align:'center'},
                {field:'hidden',  title:'操作', width:80,align:'center',
                    formatter:function(value,row,index){
                 		var a = '<a href="javascript:;" onclick="editIt(' + index + ')">编辑</a> | ';
                      	var b = '';
                 		if(row.isAvailableCode == 1){
                      		b = '<a href="javaScript:;" onclick="availableIt(' + row.id + ',' + 0 + ')">停用</a>';
                      	}else if(row.isAvailableCode == 0) {
                      		b = '<a href="javaScript:;" onclick="availableIt(' + row.id + ',' + 1 + ')">启用 </a>';
                      	}
                      	return a + b;
                    }
                }
            ]],
            toolbar:[{
                id:'_add',
                text:'新增IP',
                iconCls:'icon-add',
                handler:function(){
                	cleanEditWhiteIpDiv();
                	$('#editWhiteIpDiv').dialog('open');
                }
            }],
            pagination:true
        });
		
		
	    $('#editWhiteIpDiv').dialog({
	    	title:'IP白名单',
	    	collapsible: true,
	    	closed: true,
	    	modal: true,
	    	buttons: [
	    	{
	    		text: '保存',
	    		iconCls: 'icon-ok',
	    		handler: function(){
	    			$('#editWhiteIpForm').form('submit',{
	    				url: "${rc.contextPath}/sysConfig/saveOrUpdateWhiteIp",
	    				onSubmit:function(){
	    					var ip = $('#editWhiteIpForm_ip').val();
	    					var reg = /^\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}$/;
	    					var remark = $('#editWhiteIpForm_remark').val();
	    					if($.trim(ip)==''){
	    						$.messager.alert('提示','请输入Ip','info');
	    						return false;
	    					}else if(!reg.test(ip)){
	    						$.messager.alert('提示','请输入正确的Ip','info');
	    						return false;
	    					}else if($.trim(remark) == ''){
	    						$.messager.alert('提示','请输入备注','info');
	    						return false;
	    					}
	    					$.messager.progress();
	    				},
	    				success: function(data){
	    					$.messager.progress('close');
	                        var res = eval("("+data+")");
	                        if(res.status == 1){
	                            $.messager.alert('响应信息',"保存成功",'info',function(){
	                                $('#s_data').datagrid('load');
	                                $('#editWhiteIpDiv').dialog('close');
	                            });
	                        } else if(res.status == 0){
	                            $.messager.alert('响应信息',res.msg,'error');
	                        } 
	    				},
	    				error: function(xhr){
				         	$.messager.progress('close');
				        	$.messager.alert("提示",'服务器忙，请稍后再试。('+xhr.status+')',"error");
				       }
	    			});
	    		}
	    	},
	    	{
	    		text:'取消',
	            align:'left',
	            iconCls:'icon-cancel',
	            handler:function(){
	                $('#editWhiteIpDiv').dialog('close');
	            }
	    	}]
	    });	
	});
</script>

</body>
</html>