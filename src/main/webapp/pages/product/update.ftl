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
textarea{ 
	resize:none;
}
</style>
</head>
<body class="easyui-layout">
<#if productId?exists>${productId?c}<#else><#assign productId = 12 > </#if>

<div data-options="region:'center',title:'商品信息'" style="padding:5px;">
	<form id="saveProduct"  method="post">
		<fieldset>
			<input type="hidden" value="<#if productId?exists>${productId?c}<#else>0</#if>" id="id" name="id" />
			<input type="hidden" value="1" id="type" name="type"/>
			<legend>商品信息</legend>
			基本商品Id：<input id="productBaseId" name="productBaseId" maxlength="10" value="<#if product.productBaseId?exists && (product.productBaseId != 0)>${product.productBaseId?c}</#if>" <#if sellAmount?exists && (sellAmount>0)>readonly="readonly"</#if>/>
			<font color="red" style="italic">必填&nbsp;<span id="productBaseTips"></span></font>&nbsp;&nbsp;<a onclick="editProductBase();" href="javascript:;" class="easyui-linkbutton">编辑基本商品</a><br/><br/>
			商品条码：<span id="span_barcode"><#if product.barcode?exists>${product.barcode}</#if></span><input type="hidden" id="barcode" name="barcode" value="<#if product.barcode?exists>${product.barcode}</#if>" /><br/><br/>
    		商品名称：<span id="productBaseName"><#if productBase.name?exists>${productBase.name}</#if></span><br/><br/>
    		商家发货名称：<input maxlength="44" type="text" id="sellerProductName" name="sellerProductName" style="width:300px;"  value="<#if product.sellerProductName?exists>${product.sellerProductName}</#if>" />
    		 <span style="color:red">提供给商家的发货表中，商家将只能看到该名称</span> <br/><br/>
    		商品类别：&nbsp;&nbsp;<br/>
			<table id="categoryTab">
    			<thead>
	    			<tr><td>一级分类</td><td>二级分类</td><td>三级分类</td></tr>
    			</thead>
    			<tbody>
    				<#if (categoryList?size>0)>
    				<#list categoryList as category>
    				<tr><td>${category.categoryFirstName!""}</td><td>${category.categorySecondName!""}</td><td>${category.categoryThirdName!""}</td>
    				</tr>
    				</#list>
    				</#if>
    			</tbody>
    		</table>
            <!-- 使用渠道：<input id="productUseScope" name="productUseScopeId" value="" /> -->
    		<br/><br/>
    		<hr/>
    		商品编码：<span id="span_code"><#if product.code?exists>${product.code}</#if></span><input type="hidden" id="code" name="code" value="<#if product.code?exists>${product.code}</#if>" readonly="readonly" style="width: 300px;"/><br/><br/>
    		商品商家备注：<span id="productBaseRemark"><#if product.remark?exists>${product.remark}</#if></span><br/><br/>
    		前台展示商家名称：
    		<input type="hidden" name="sellerId" id="sellerId" value="<#if productRelationSeller.id?exists>${productRelationSeller.id}</#if>"/>
    		<span id="sellerName"><#if productRelationSeller.sellerName?exists>${productRelationSeller.sellerName}</#if></span>&nbsp;&nbsp;
    		真实商家名称：<span id="realSellerName"><#if productRelationSeller.realSellerName?exists>${productRelationSeller.realSellerName}</#if></span>
    		<br/><br/>
    		发货类型：<span id="sellerType"><#if sellerType?exists>${sellerType}</#if></span><br/><br/> 
    		发货地：<span id="sendAddress"><#if productRelationSeller.sendAddress?exists>${productRelationSeller.sendAddress}</#if></span><br/><br/> 
    		商家发货时效：<span id="sendTimeRemark"><#if productRelationSeller.sendTimeRemark?exists>${productRelationSeller.sendTimeRemark}</#if></span><br/><br/> 
			<hr/>
			
			特卖信息:<br/><br/>
    		特卖商品备注：<input maxlength="100" type="text" id="remark" name="remark" value="<#if product.remark?exists>${product.remark}</#if>" style="width:400px;"/><br/><br/>
    		特卖商品长名称：<input maxlength="44" type="text" id="productName" name="name" value="<#if product.name?exists>${product.name}</#if>" style="width:400px;"/><font color="red" style="italic">必填</font><br/><br/>
    		特卖商品短名称：<input maxlength="25" type="text" id="shortName" name="shortName" style="width:400px;"  value="<#if product.shortName?exists>${product.shortName}</#if>" /><font color="red" style="italic">必填</font><br/><br/>
    		<!-- 特卖商品卖点&nbsp;：<input maxlength="11" type="text" id="sellingPoint" name="sellingPoint" style="width:400px;"  value="<#if product.sellingPoint?exists>${product.sellingPoint}</#if>" />&nbsp;<font>注：仅在组合专场展示</font><br/><br/><br/> -->
    		详情页格格说：
				<textarea id="desc" name="desc" onkeydown="checkEnter(event)" style="height: 60px;width: 400px"><#if product.desc?exists>${product.desc}</#if></textarea>
				&nbsp;&nbsp;长度（&lt; 140）：<span style="color:red" id="counter">0 字</span><font>(注：从基本商品带过来，但是可以修改后独立保存)</font><br/><br/>
    		左岸网络头像:<select id="gegeImageId" name="gegeImageId">
    					<#list gegeImageList as glist>
    		 			  	<option value="${glist.id?c}"<#if product.gegeImageId?exists && (product.gegeImageId == glist.id)>selected</#if>>${glist.categoryName}</option>
    		 			</#list>
    				</select>
    		<hr/>
    		商品结算：<span id="submitType"><#if submitType?exists>${submitType}</#if></span>&nbsp;<#if productBase?? && (productBase.submitType == 1) && (productId >0)><a id="setActivityPrice" href="#" onclick="updateActivityPrice();" class="easyui-linkbutton">设置活动供货价</a></#if><br/><br/>
    		运费结算：<span id="freightType"><#if freightType?exists>${freightType}</#if></span><br/><br/>
    		<#if productId?? && (productId>0)>
    		特卖库存：可用<span id="span_lock"><#if stock?exists>${stock}</#if></span>&nbsp;<a onclick="refreshStock(<#if product.id?exists && (product.id != 0)>${product.id?c}<#else>0</#if>)" href="javascript:;" class="easyui-linkbutton">刷新</a><br/><br/>
 			</#if>
 			<hr/>
			
			开始时间:<input value="<#if product.startTime?exists>${product.startTime}</#if>" id="startTime" name="startTime" onClick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')}'})"/>&nbsp;&nbsp;&nbsp;
			 结束时间:<input value="<#if product.endTime?exists>${product.endTime}</#if>" id="endTime" name="endTime" onClick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}'})"/><br/><br/>
			市场价&nbsp;：<input maxlength="10" type="number" id="marketPrice" name="marketPrice" value="<#if marketPrice?exists>${marketPrice}</#if>" />&nbsp;<font color="red" style="italic">必填</font>&nbsp;&nbsp;&nbsp;
    		售价&nbsp;&nbsp;：<input maxlength="10" type="number" id="salesPrice" name="salesPrice" value="<#if salesPrice?exists>${salesPrice}</#if>" />&nbsp;<font color="red" style="italic">必填</font><br/><br/>
    		行动派分销佣金：<input maxlength="10" type="number" id="bsCommision" name="bsCommision" value="<#if product.bsCommision?exists>${product.bsCommision}</#if>" /><font color="red" style="italic">必填</font>
    		对应佣金/售价比例:
    		<font color="red"><span id="bil"><#if bil?exists>${bil}</#if></font></span>%
    		&nbsp;对应盈亏:
    		<font color="red"><span id="yk"><#if yk?exists>${yk}</#if></font>元</span>
    		&nbsp;(
    		<font color="red"><span id="ykb"><#if ykb?exists>${ykb}</#if></font></span>%
    		)
    		<br/><br/>
            合伙人返分销毛利:
			<input type="hidden" id="returnDistributionProportionType" value="${returnDistributionProportionType}"/>
            <input type="radio" disabled name="returnDistributionProportionType" id="returnDistributionProportionType_1" value="1" <#if returnDistributionProportionType==1 >checked</#if>>返25%&nbsp;&nbsp;&nbsp;
            <input type="radio" disabled name="returnDistributionProportionType" id="returnDistributionProportionType_2" value="2" <#if returnDistributionProportionType==2 >checked</#if>>返100%<br/><br/>
			分销供货价：<input maxlength="10" type="number" id="partnerDistributionPrice" name="partnerDistributionPrice" value="<#if partnerDistributionPrice?exists>${partnerDistributionPrice}</#if>"/>&nbsp;<font color="red" style="italic">必填</font>
			&nbsp;&nbsp;分销毛利：￥<span id="partnerDistributionPrice_cal_maoli"></span>
			&nbsp;&nbsp;合伙人分成：￥<span id="partnerDistributionPrice_cal_fenc"></span>
			&nbsp;&nbsp;对应<span style="color:red" id="partnerDistributionPrice_cal_jifen">商品推荐积分</span>
			<br/><br/>
			减库存方式：<input type="radio" name="stockAlgorithm" value="1" checked> 付款减库存 <br/><br/>
			限购数量：<input maxlength="10" type="number" name="restriction" id="restriction" value="<#if restriction?exists>${restriction}</#if>" /><font color="red" style="italic">必填</font><br/><br/>
			运费：<input type="radio" name="freight" id="freight_baoyou" value="1" <#if product.freightTemplateId?exists && (product.freightTemplateId == 1) >checked</#if>> 卖家包邮&nbsp;&nbsp;&nbsp; 
					<input type="radio" name="freight" id="freight_muban" value="2" <#if product.freightTemplateId?exists && (product.freightTemplateId != 1) >checked</#if>>运费模板
					<select name="freightTemplate" id="freightTemplate">
								<option value="0">请选择</option>
						<#list  templateList as bl >
								<option value="${bl.id?c}" <#if product.freightTemplateId?exists && (product.freightTemplateId == bl.id) >selected</#if>>${bl.name}</option>							
			 			</#list>
					</select><br/><br/>
			是否自动调库存：<input type="radio" name="isAutomaticAdjustStock" id="isAutomaticAdjustStock1" value="1" <#if product.isAutomaticAdjustStock?exists && (product.isAutomaticAdjustStock==1)>checked</#if>/>是&nbsp;&nbsp;&nbsp;
						<input type="radio" name="isAutomaticAdjustStock" id="isAutomaticAdjustStock0" value="0" <#if product.isAutomaticAdjustStock?exists && (product.isAutomaticAdjustStock==0)>checked</#if>/>否<br/><br/>
			<hr/>
			品牌&nbsp;&nbsp;：<span id="brandName"><#if brandName?exists>${brandName}</#if></span><input type="hidden" id="brandId" name="brandId" value="<#if product.brandId?exists>${product.brandId?c}</#if>" /><br/><br/>
			净含量&nbsp;：<span id="span_netVolume"><#if product.netVolume?exists>${product.netVolume}</#if></span><input type="hidden"  id="netVolume" name="netVolume" value="<#if product.netVolume?exists>${product.netVolume}</#if>"/><br/><br/>
			产地&nbsp;&nbsp;：<span id="span_placeOfOrigin"><#if product.placeOfOrigin?exists>${product.placeOfOrigin}</#if></span><input type="hidden"  id="placeOfOrigin" name="placeOfOrigin" value="<#if product.placeOfOrigin?exists>${product.placeOfOrigin}</#if>"/><br/><br/>
			储存方法：<span id="span_storageMethod"><#if product.storageMethod?exists>${product.storageMethod}</#if></span><input type="hidden" id="storageMethod" name="storageMethod" value="<#if product.storageMethod?exists>${product.storageMethod}</#if>" /><br/><br/>
			生产日期：<span id="span_manufacturerDate"><#if product.manufacturerDate?exists>${product.manufacturerDate}</#if></span><input type="hidden" id="manufacturerDate" name="manufacturerDate" value="<#if product.manufacturerDate?exists>${product.manufacturerDate}</#if>" /><br/><br/>
			保质期&nbsp;：<span id="span_durabilityPeriod"><#if product.durabilityPeriod?exists>${product.durabilityPeriod}</#if></span><input type="hidden" maxlength="15" id="durabilityPeriod" name="durabilityPeriod" value="<#if product.durabilityPeriod?exists>${product.durabilityPeriod}</#if>" /><br/><br/>
			适用人群：<span id="span_peopleFor"><#if product.peopleFor?exists>${product.peopleFor}</#if></span><input type="hidden" id="peopleFor" name="peopleFor" value="<#if product.peopleFor?exists>${product.peopleFor}</#if>" /><br/><br/>
			食用方法：<span id="span_foodMethod"><#if product.foodMethod?exists>${product.foodMethod}</#if></span><input type="hidden" id="foodMethod" name="foodMethod" value="<#if product.foodMethod?exists>${product.foodMethod}</#if>" /><br/><br/>
			使用方法：<span id="span_useMethod"><#if product.useMethod?exists>${product.useMethod}</#if></span><input type="hidden" id="useMethod" name="useMethod" value="<#if product.useMethod?exists>${product.useMethod}</#if>" /><br/><br/>
			温馨提示: 
			<textarea name="tip" id="tip" onkeydown="checkEnter(event)" style="height: 60px;width: 400px"><#if product.tip?exists>${product.tip}</#if></textarea>
			&nbsp;&nbsp;<span>注：温馨提示内容从基本商品复制过来，可以修改后独立保存</span>（长度&lt; 200；当前字数：<font id="tipCounter" color="red">0</font>）<br/><br/>
			关联自定义页面:<br/><br/>
			<input type="hidden" value="<#if relationPageMap?exists && relationPageMap.id0?exists>${relationPageMap.id0?c}</#if>" name="relationProAndPageId1" />
			显示标题：<input type="text" name="pageCustomName1" value="<#if relationPageMap?exists && relationPageMap.name0?exists>${relationPageMap.name0}</#if>" />
    		选择自定义页面：<select name="pageCustomId1" id="pageCustomId1">
    					<option value="-1">请选择</option>
			 				<#list  pageCustomList as bl >
			 					<option value="${bl.id?c}" <#if relationPageMap?exists && relationPageMap.name0?exists && (relationPageMap.pageId0==bl.id) >selected</#if>>${bl.name}</option>
			 				</#list>
			 	 			</select><br/><br/>
			<input type="hidden" value="<#if relationPageMap?exists && relationPageMap.id1?exists>${relationPageMap.id1?c}</#if>" name="relationProAndPageId2" />
			显示标题：<input type="text" name="pageCustomName2" value="<#if relationPageMap?exists && relationPageMap.name1?exists>${relationPageMap.name1}</#if>" />
    		选择自定义页面：<select name="pageCustomId2" id="pageCustomId2">
    						<option value="-1">请选择</option>
			 				<#list  pageCustomList as bl >
			 					<option value="${bl.id?c}" <#if relationPageMap?exists && relationPageMap.name1?exists && (relationPageMap.pageId1==bl.id) >selected</#if>>${bl.name}</option>
			 				</#list>
			 	 		</select><br/><br/>
			<hr/>
			商品图片：&nbsp;<a onclick="copyInfo(1)" href="javascript:;" class="easyui-linkbutton">从基本商品表复制</a>&nbsp;&nbsp;
			<a onclick="uploadAllImage()" href="javascript:;" class="easyui-linkbutton">上传图片压缩包</a><br/><br/>
				
			上传商品详情主图，尺寸要求 640x640<br/><br/>
			
			商品详情主图1：<input type="text" id="pic_1" name="image1" style="width:450px;" value="<#if product.image1?exists>${product.image1}</#if>"  />
			<a onclick="picDialogOpen('pic_1')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_1')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a>
			&nbsp;<span style="color:red">必须，图片大小不得超过400KB</span><br/><br/>
			
			商品详情主图2：<input type="text" id="pic_2" name="image2" style="width:450px;" value="<#if product.image2?exists>${product.image2}</#if>"  />
			<a onclick="picDialogOpen('pic_2')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_2')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a><br/><br/>	
			
			商品详情主图3：<input type="text" id="pic_3" name="image3" style="width:450px;" value="<#if product.image3?exists>${product.image3}</#if>" />
			<a onclick="picDialogOpen('pic_3')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_3')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a>
			<br/><br/>
			
			商品详情主图4：<input type="text" id="pic_4" name="image4" style="width:450px;" value="<#if product.image4?exists>${product.image4}</#if>"  />
			<a onclick="picDialogOpen('pic_4')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_4')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a>
			<br/><br/>
			
			商品详情主图5：<input type="text" id="pic_5" name="image5" style="width:450px;" value="<#if product.image5?exists>${product.image5}</#if>" />
			<a onclick="picDialogOpen('pic_5')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_5')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a>
			<br/><br/>
			
			<input type="hidden" value="<#if productCommon?exists && productCommon.id?exists && (productCommon.id != 0)>${productCommon.id?c}</#if>" name="productCommonId" />
			
			<div style="display:none;">
			组合特卖图6&nbsp;：<input type="text" id="pic_6" name="mediumImage" style="width:450px;" value="<#if productCommon?exists && productCommon.mediumImage?exists>${productCommon.mediumImage}</#if>" />
			<a onclick="picDialogOpen('pic_6')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_6')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a>&nbsp;<span style="color:red">必须，图片大小不得超过400KB</span><br/><br/>
			
			购物车小图7&nbsp;：<input type="text" id="pic_7" name="smallImage" style="width:450px;" value="<#if productCommon?exists && productCommon.smallImage?exists>${productCommon.smallImage}</#if>" />
			<a onclick="picDialogOpen('pic_7')" href="javascript:;" class="easyui-linkbutton" name="uploadPicture" >上传图片</a>
			<a onclick="viewPicture('pic_7')" href="javascript:;" class="easyui-linkbutton" name="viewPicture">打开图片</a>
			&nbsp;<span style="color:red">必须，图片大小不得超过400KB</span><br/><br/>
            </div>
			<hr/>		
			详情页图片：&nbsp;<a onclick="copyInfo(2)" href="javascript:;" class="easyui-linkbutton">从基本商品表复制</a><br/><br/>
				
           	 移动端详情页编辑:<br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id1?exists>${mobileDetailMap.id1?c}<#else>0</#if>" name="detail_id_1" />
			<textarea style="display:none" name="detail_text_1" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text1?exists>${mobileDetailMap.text1}</#if></textarea>
			图片8&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic1?exists>${mobileDetailMap.pic1}</#if>" id="detail_pic_1" name="detail_pic_1" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_1')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_1')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<span style="color:red">图片大小不得超过400KB，以下同理</span><br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id2?exists>${mobileDetailMap.id2?c}<#else>0</#if>" name="detail_id_2" />
			<textarea style="display:none" name="detail_text_2" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text2?exists>${mobileDetailMap.text2}</#if></textarea>
			图片9&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic2?exists>${mobileDetailMap.pic2}</#if>" id="detail_pic_2" name="detail_pic_2" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_2')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_2')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id3?exists>${mobileDetailMap.id3?c}<#else>0</#if>" name="detail_id_3" />
			<textarea style="display:none" name="detail_text_3" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text3?exists>${mobileDetailMap.text3}</#if></textarea>
			图片10&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic3?exists>${mobileDetailMap.pic3}</#if>" id="detail_pic_3" name="detail_pic_3" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_3')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_3')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id4?exists>${mobileDetailMap.id4?c}<#else>0</#if>" name="detail_id_4" />
			<textarea style="display:none" name="detail_text_4" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text4?exists>${mobileDetailMap.text4}</#if></textarea>
			图片11&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic4?exists>${mobileDetailMap.pic4}</#if>" id="detail_pic_4" name="detail_pic_4" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_4')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_4')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id5?exists>${mobileDetailMap.id5?c}<#else>0</#if>" name="detail_id_5" />
			<textarea style="display:none" name="detail_text_5" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text5?exists>${mobileDetailMap.text5}</#if></textarea>
			图片12&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic5?exists>${mobileDetailMap.pic5}</#if>" id="detail_pic_5" name="detail_pic_5" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_5')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_5')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id6?exists>${mobileDetailMap.id6?c}<#else>0</#if>" name="detail_id_6" />
			<textarea style="display:none" name="detail_text_6" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text6?exists>${mobileDetailMap.text6}</#if></textarea>
			图片13&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic6?exists>${mobileDetailMap.pic6}</#if>" id="detail_pic_6" name="detail_pic_6" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_6')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_6')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
            <input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id7?exists>${mobileDetailMap.id7?c}<#else>0</#if>" name="detail_id_7" />
			<textarea style="display:none" name="detail_text_7" style="height: 60px;width: 500px"><#if mobileDetailMap?exists && mobileDetailMap.text7?exists>${mobileDetailMap.text7}</#if></textarea>
			图片14&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic7?exists>${mobileDetailMap.pic7}</#if>" id="detail_pic_7" name="detail_pic_7" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_7')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail"  >上传图片</a>
			<a onclick="viewPicture('detail_pic_7')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id8?exists>${mobileDetailMap.id8?c}<#else>0</#if>" name="detail_id_8" />
			<textarea style="display:none" name="detail_text_8" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text8?exists>${mobileDetailMap.text8}</#if></textarea>
			图片15&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic8?exists>${mobileDetailMap.pic8}</#if>"  id="detail_pic_8" name="detail_pic_8" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_8')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_8')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id9?exists>${mobileDetailMap.id9?c}<#else>0</#if>" name="detail_id_9" />
			<textarea style="display:none" name="detail_text_9" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text9?exists>${mobileDetailMap.text9}</#if></textarea>
			图片16&nbsp;: <input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic9?exists>${mobileDetailMap.pic9}</#if>"  id="detail_pic_9" name="detail_pic_9" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_9')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_9')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id10?exists>${mobileDetailMap.id10?c}<#else>0</#if>" name="detail_id_10" />
			<textarea style="display:none" name="detail_text_10" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text10?exists>${mobileDetailMap.text10}</#if></textarea>
			图片17&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic10?exists>${mobileDetailMap.pic10}</#if>"  id="detail_pic_10" name="detail_pic_10" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_10')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_10')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id11?exists>${mobileDetailMap.id11?c}<#else>0</#if>" name="detail_id_11" />
			<textarea style="display:none" name="detail_text_11" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text11?exists>${mobileDetailMap.text11}</#if></textarea>
			图片18&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic11?exists>${mobileDetailMap.pic11}</#if>"  id="detail_pic_11" name="detail_pic_11" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_11')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_11')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id12?exists>${mobileDetailMap.id12?c}<#else>0</#if>" name="detail_id_12" />
			<textarea style="display:none" name="detail_text_12" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text12?exists>${mobileDetailMap.text12}</#if></textarea>
			图片19&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic12?exists>${mobileDetailMap.pic12}</#if>"  id="detail_pic_12" name="detail_pic_12" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_12')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_12')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id13?exists>${mobileDetailMap.id13?c}<#else>0</#if>" name="detail_id_13" />
			<textarea style="display:none" name="detail_text_13" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text13?exists>${mobileDetailMap.text13}</#if></textarea>
			图片20&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic13?exists>${mobileDetailMap.pic13}</#if>"  id="detail_pic_13" name="detail_pic_13" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_13')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_13')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id14?exists>${mobileDetailMap.id14?c}<#else>0</#if>" name="detail_id_14" />
			<textarea style="display:none" name="detail_text_14" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text14?exists>${mobileDetailMap.text14}</#if></textarea>
			图片21&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic14?exists>${mobileDetailMap.pic14}</#if>"  id="detail_pic_14" name="detail_pic_14" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_14')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_14')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id15?exists>${mobileDetailMap.id15?c}<#else>0</#if>" name="detail_id_15" />
			<textarea style="display:none" name="detail_text_15" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text15?exists>${mobileDetailMap.text15}</#if></textarea>
			图片22&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic15?exists>${mobileDetailMap.pic15}</#if>"  id="detail_pic_15" name="detail_pic_15" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_15')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_15')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id16?exists>${mobileDetailMap.id16?c}<#else>0</#if>" name="detail_id_16" />
			<textarea style="display:none" name="detail_text_16" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text16?exists>${mobileDetailMap.text16}</#if></textarea>
			图片23&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic16?exists>${mobileDetailMap.pic16}</#if>"  id="detail_pic_16" name="detail_pic_16" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_16')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_16')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id17?exists>${mobileDetailMap.id17?c}<#else>0</#if>" name="detail_id_17" />
			<textarea style="display:none" name="detail_text_17" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text17?exists>${mobileDetailMap.text17}</#if></textarea>
			图片24&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic17?exists>${mobileDetailMap.pic17}</#if>"  id="detail_pic_17" name="detail_pic_17" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_17')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_17')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id18?exists>${mobileDetailMap.id18?c}<#else>0</#if>" name="detail_id_18" />
			<textarea style="display:none" name="detail_text_18" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text18?exists>${mobileDetailMap.text18}</#if></textarea>
			图片25&nbsp;: <input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic18?exists>${mobileDetailMap.pic18}</#if>"  id="detail_pic_18" name="detail_pic_18" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_18')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_18')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id19?exists>${mobileDetailMap.id19?c}<#else>0</#if>" name="detail_id_19" />
			<textarea style="display:none" name="detail_text_19" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text19?exists>${mobileDetailMap.text19}</#if></textarea>
			图片26&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic19?exists>${mobileDetailMap.pic19}</#if>"  id="detail_pic_19" name="detail_pic_19" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_19')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_19')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id20?exists>${mobileDetailMap.id20?c}<#else>0</#if>" name="detail_id_20" />
			<textarea style="display:none" name="detail_text_20" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text20?exists>${mobileDetailMap.text20}</#if></textarea>
			图片27&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic20?exists>${mobileDetailMap.pic20}</#if>"  id="detail_pic_20" name="detail_pic_20" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_20')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_20')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id21?exists>${mobileDetailMap.id21?c}<#else>0</#if>" name="detail_id_21" />
			<textarea style="display:none" name="detail_text_21" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text21?exists>${mobileDetailMap.text21}</#if></textarea>
			图片28&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic21?exists>${mobileDetailMap.pic21}</#if>"  id="detail_pic_21" name="detail_pic_21" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_21')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_21')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<input type="hidden" value="<#if mobileDetailMap?exists && mobileDetailMap.id22?exists>${mobileDetailMap.id22?c}<#else>0</#if>" name="detail_id_22" />
			<textarea style="display:none" name="detail_text_22" style="height: 60px;width: 500px" value=""><#if mobileDetailMap?exists && mobileDetailMap.text22?exists>${mobileDetailMap.text22}</#if></textarea>
			图片29&nbsp;：<input type="text" value="<#if mobileDetailMap?exists && mobileDetailMap.pic22?exists>${mobileDetailMap.pic22}</#if>"  id="detail_pic_22" name="detail_pic_22" style="width:450px;" />
			<a onclick="picDialogOpen('detail_pic_22')" href="javascript:;" class="easyui-linkbutton" name="uploadDetail" >上传图片</a>
			<a onclick="viewPicture('detail_pic_22')" href="javascript:;" class="easyui-linkbutton" name="viewDetails">打开图片</a>
			<br/><br/>
			<hr/>		
			商品使用状态:
			<input type="radio" name="isAvailable" value="1" <#if product.isAvailable?exists && (product.isAvailable == 1) >checked</#if>> 可用&nbsp;&nbsp;&nbsp;
			<input type="radio" name="isAvailable" value="0" <#if product.isAvailable?exists && (product.isAvailable == 0) >checked</#if>> 停用<br/><br/>
			
			<input style="width: 150px" type="button" id="saveButton" value="保存"/>
		</fieldset>	
	</form>
	
	<div id="uploadAllImage_div" class="easyui-dialog" style="width:500px;height:400px;padding:20px 20px;">
           <form id="uploadAllImage_form" method="post" enctype="multipart/form-data">
	           <input type="file" name="imageZipFile" />
       	</form>
       	<p>
       		1:压缩格式必须为.zip，可用“360压缩”或者“好压”等软件压缩。<br><br>
       		2:压缩文件中不能包含文件夹。<br><br>
       		3:压缩文件中“文件名（不包括后缀）”必须是数字且不可重复命名。<br><br>
       		4:文件名1-5代表“商品详情主图”，可选，若有，则命名必须连续。<br><br>
       		5:文件名6-7代表“组合特卖图 和 购物车小图”，可选。<br><br>
       		6:文件名8-29代表“详情页图片”，可选，若有，则命名必须连续。<br><br>
       		7:不支持除以上外的其他文件名。<br><br>
       		8:图片后缀只允许(*.jpg)|(*.png)|(*.gif)|(*.bmp)|(*.jpeg)<br><br>
       		9:图片大小不得超过400KB。
       	</p>
	</div>

    <!-- 改活动供货价begin -->
    <div id="updateActivityPriceDiv" class="easyui-dialog" style="width:500px;height:200px;padding:10px 10px;">
        <input type="hidden" id="updateActivityPriceDiv_productId" value="<#if productId?exists>${productId?c}<#else>0</#if>"/>
        <p>该基本商品供货价为：<span id="updateActivityPriceDiv_wholesalePrice"><#if productBase?exists && (productBase.submitType == 1)>${productBase.wholesalePrice}<#else>0.00</#if></span>元</p>
        <p>
			生效时间：<input value="" id="activityWholesalePriceStartTime" name="activityWholesalePriceStartTime" onClick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'activityWholesalePriceEndTime\')}'})"/>
			-
            <input value="" id="activityWholesalePriceEndTime" name="activityWholesalePriceEndTime" onClick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'activityWholesalePriceStartTime\')}'})"/>
		</p>
        <p>&nbsp;供货价：<input type="number" id="updateActivityPriceDiv_activityWholesalePrice"/></p>
    </div>
    <!-- 改活动供货价end -->
</div>

<div id="picDia" class="easyui-dialog" icon="icon-save" align="center"
     style="padding: 5px; width: 300px; height: 150px;">
    <form id="picForm" method="post" enctype="multipart/form-data">
        <input id="picFile" type="file" name="picFile" />&nbsp;&nbsp;<br/>    <br/>
        <a href="javascript:;" onclick="picUpload()" class="easyui-linkbutton" iconCls='icon-reload'>提交图片</a>
    </form>
    <br><br>
</div>
<script type="text/javascript">

function uploadAllImage(index){
    $('#uploadAllImage_div').dialog('open');
}
	function copyInfo(type){
		var id = $("#productBaseId").val();
		if($.trim(id) != ''){
			$.ajax({
	    		url: '${rc.contextPath}/productBase/copyImageFromProductBase',
		        type: 'post',
		        dataType: 'json',
		        data: {'id':id},
		        success: function(data){
		            	if(data.status == 1){
		            		if(type===1){
			                    $("#pic_1").val(data.image1);
			                    $("#pic_2").val(data.image2);
			            		$("#pic_3").val(data.image3);
			            		$("#pic_4").val(data.image4);
			            		$("#pic_5").val(data.image5);
			            		$("#pic_6").val(data.mediumImage);
			            		$("#pic_7").val(data.smallImage);
		            		}else if(type===2){
		            			$("input[id^='detail_pic_']").val('');
			            		$.each(data.mobileDetails,function(i,item){
			            			$("#detail_pic_"+(i+1)).val(item.pic);
			            		});	
		            		}
		            	}
		        }
	    	});
		}
	}
	
	//清空所有图片
	function clearImage(){
		for (var i=1;i<8;i++)
		{
			$("#pic_"+i).val("");
		}
		for (var i=1;i<23;i++)
		{
			$("#detail_pic_"+i).val("");
		}
	}
	
    $(function(){
        $('#productUseScope').combobox({
            url:'${rc.contextPath}/productUseScope/jsonproductUseScope',
            valueField:'code',
            textField:'text',
            onLoadSuccess :function(){
			<#if product.productUseScopeId?exists && (product.productUseScopeId > 0) >
	            $('#productUseScope').combobox('select', ${product.productUseScopeId?c});
			</#if>
        }
        });

        $('#picDia').dialog({
            title:'又拍图片上传窗口',
            collapsible:true,
            closed:true,
            modal:true
//            draggable:true
        });
        
        $("#gegeImageId").change(function(){
        	var imageId = $(this).val();
        	var $image = $(this).next('img');
        	$.ajax({
        		url: '${rc.contextPath}/image/getGegeImageById',
		            type: 'post',
		            dataType: 'json',
		            data: {'imageId':imageId, 'isAvailable':1,type:'product'},
		            success: function(data){
		            	if(data.status == 1){
		            		$image.attr('src',data.url);	
		            	}
		            }
        	});
        });
    })
    
    $('#uploadAllImage_div').dialog({
            title:'批量上传图片',
            collapsible:true,
            closed:true,
            modal:true,
            buttons:[{
                text:'确认上传',
                iconCls:'icon-ok',
                handler:function(){
					$('#uploadAllImage_form').form('submit',{
						url:"${rc.contextPath}/pic/upZip",
					    onSubmit: function(){
					    	$.messager.progress();
					    },
					    success:function(data){
					    	clearImage();//清空图片
					    	$.messager.progress('close');
					    	var data = eval('(' + data + ')');  
							if(data.status == 1){
								$.messager.alert("提示",data.msg,"info",function(){
									$('#uploadAllImage_div').dialog('close');
								});	
								for(var p in data.fileUrlMap){
									$("#"+p).val(data.fileUrlMap[p]);
								}
							}else{
								$.messager.alert("提示",data.msg,"warning");
							}
					    }
					});
                }
            },{
                text:'取消',
                align:'left',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#uploadAllImage_div').dialog('close');
                }
            }]
        });


	$('#updateActivityPriceDiv').dialog({
		title:'设置活动供货价',
		collapsible:true,
		closed:true,
		modal:true,
		buttons:[{
			text:'保存',
			iconCls:'icon-ok',
			handler:function(){
				var productId = $("#updateActivityPriceDiv_productId").val();
				var startTime = $.trim($("#activityWholesalePriceStartTime").val());
				var endTime = $.trim($("#activityWholesalePriceEndTime").val());
				var wholesalePrice = $.trim($("#updateActivityPriceDiv_activityWholesalePrice").val());

                var params = {};
                if(startTime == '' || endTime == ''){
					$.messager.alert("提示",'请选择活动生效时间',"error");
				}else if(wholesalePrice == ''){
                    $.messager.alert("提示",'请输入活动供货价',"error");
				}else{
					params.id = productId;
					params.startTime = startTime;
					params.endTime = endTime;
					params.wholesalePrice = wholesalePrice;
					$.messager.progress();
					$.ajax({
						url: '${rc.contextPath}/product/updateProductActivityWholesalePrice',
						type: 'post',
						dataType: 'json',
						data: params,
						success: function(data){
							$.messager.progress('close');
							if(data.status == 1){
								$('#updateActivityPriceDiv').dialog('close');
								$.messager.alert("提示",data.message,"info");
							}else{
								$.messager.alert("提示",data.message,"error");
							}
						},
						error: function(xhr){
							$.messager.progress('close');
							$.messager.alert("提示",'服务器忙，请稍后再试。('+xhr.status+')',"info");
						}
					});
				}

			}
		},{
			text:'取消',
			align:'left',
			iconCls:'icon-cancel',
			handler:function(){
				$('#updateActivityPriceDiv').dialog('close');
			}
		}]
	});

    var inputId;
    function picDialogOpen($inputId) {
        inputId = $inputId;
        $("#picDia").dialog("open");
        $("#yun_div").css('display','none');
    }
    function picDialogClose() {
       $("#picDia").dialog("close");
    }
    function picUpload() {
        $('#picForm').form('submit',{
            url:"${rc.contextPath}/pic/fileUpLoad",
            success:function(data){
                var res = eval("("+data+")")
                if(res.status == 1){
                    $.messager.alert('响应信息',"上传成功...",'info',function(){
                        $("#picDia").dialog("close");
                        if(inputId) {
                            $("#"+inputId).val(res.url);
                            $("#picFile").val("");
                        }
                        return
                    });
                } else{
                    $.messager.alert('响应信息',res.msg,'error',function(){
                        return ;
                    });
                }
            }
        })
    }
    
    function viewPicture(id){
    	var url = $("#"+id).val();
    	if($.trim(url)==''){
    		$.messager.alert('提示','请上传图片后再查看','info');
    	}else{
    		window.open(url,"_blank");
    	}
    }
</script>

<script>
	$(document).keyup(function() { 
		var text=$("#desc").val(); 
		var counter=text.length;
		$("#counter").text(counter+" 字");
	});
	
	$(function(){
		$("#tip").keyup(function(){
			var text = $("#tip").val();
			$("#tipCounter").text(text.length);
		});
	});

	function checkEnter(e){
		var et=e||window.event;
		var keycode=et.charCode||et.keyCode;
		if(keycode==13){
			if(window.event)
				window.event.returnValue = false;
			else
				e.preventDefault();//for firefox
		}
	}

	function refreshStock(id){
		if(id != 0 && id != '' && id != null && id != undefined){
			$.post("${rc.contextPath}/product/refreshStock",{
				id:id,
				productType:2
			},function(data){
				if(data.status == 1){
					$('#span_lock').text(data.stock);
				}
			},"json");
		}
	}
	$(function(){
        $("#productBaseId").change(function(){
        	var id = $.trim($(this).val());
        	if(id!=''){
		    	$.messager.progress();		    	
		    	$.ajax({
		    		url:'${rc.contextPath}/productBase/getProductBaseInfo?id='+id,
		    		type:'post',
		    		dataType: 'json',
		            success: function(data){
		            	$.messager.progress('close');
		            	if(data.status == 1){
		            		$("#productBaseTips").html('');
		            		$("#code").val(data.code);
		            		$("#span_code").html(data.code);
		            		$("#barcode").val(data.barcode);
		            		$("#span_barcode").html(data.barcode);
		            		$("#sellerId").val(data.sellerId);
		            		$("#sellerName").html(data.sellerName);
		            		$("#realSellerName").html(data.realSellerName);
		            		$("#sendAddress").html(data.sendAddress);
		            		$("#sellerType").html(data.sellerType);
		            		$("#sendTimeRemark").html(data.sendTimeRemark);
		            		$("#productBaseRemark").html(data.remark);
                            $('#returnDistributionProportionType').val(data.returnDistributionProportionType);
							if(data.returnDistributionProportionType == 1){
                            	$('#returnDistributionProportionType_1').prop("checked",true);
                            	$('#returnDistributionProportionType_2').prop("checked",false);
                            }else{
                                $('#returnDistributionProportionType_2').prop("checked",true);
                                $('#returnDistributionProportionType_1').prop("checked",false);
							}
		            		$("#categoryTab tbody").empty();
		            		var row = "<tr><td></td><td></td><td></td></tr>";
		            		$.each(data.categoryList,function(index,category){
		            			$("#categoryTab tbody").append(row);
		            			$("#categoryTab tbody").find("tr").last().find("td").eq(0).text(category.categoryFirstName);
		            			$("#categoryTab tbody").find("tr").last().find("td").eq(1).text(category.categorySecondName);
		            			$("#categoryTab tbody").find("tr").last().find("td").eq(2).text(category.categoryThirdName);
		            		});
		            		
		            		$("#brandId").val(data.brandId); 
		            		$("#brandName").html(data.brandName); 
		            		$("#gegeImageId").val(data.gegeImageId);
		            		$("#desc").val(data.gegeSay);
		            		$("#productBaseName").html(data.name);
							if(data.submitType == 1) {
								$("#setActivityPrice").show();
								$("#updateActivityPriceDiv_wholesalePrice").html(data.submitContent);
                                $("#submitType").html('供货价 '+data.submitContent);
							}else if(data.submitType == 2){
                                $("#setActivityPrice").hide();
                                $("#submitType").html('扣点 '+data.submitContent);
							}else if(data.submitType == 3){
                                $("#setActivityPrice").hide();
                                $("#submitType").html('自营采购价 '+data.submitContent);
							}
		            		$("#freightType").html(data.freightType);
		            		$("#netVolume").val(data.netVolume);
		            		$("#span_netVolume").html(data.netVolume);
		            		$("#placeOfOrigin").val(data.placeOfOrigin);
		            		$("#span_placeOfOrigin").html(data.placeOfOrigin);
		            		$("#manufacturerDate").val(data.manufacturerDate);
		            		$("#span_manufacturerDate").html(data.manufacturerDate);
		            		$("#storageMethod").val(data.storageMethod);
		            		$("#span_storageMethod").html(data.storageMethod);
		            		$("#durabilityPeriod").val(data.durabilityPeriod);
		            		$("#span_durabilityPeriod").html(data.durabilityPeriod);
		            		$("#peopleFor").val(data.peopleFor);
		            		$("#span_peopleFor").html(data.peopleFor);
		            		$("#foodMethod").val(data.foodMethod);
		            		$("#span_foodMethod").html(data.foodMethod);
		            		$("#useMethod").val(data.useMethod);
		            		$("#span_useMethod").html(data.useMethod);
		            		$("#tip").val(data.tip);
		            		$("#gegeImageId").find("option[value='"+data.gegeImageId+"']").attr('selected',true);
		            		$("#gegeImageView").attr('src',data.gegeImageUrl);
		            	}else{
		            		$("#productBaseTips").html('不存在 id='+id+' 的基本商品');
		            		$("#code").val('');
		            		$("#span_code").html('');
		            		$("#barcode").val('');
		            		$("#span_barcode").html('');
		            		$("#sellerId").val('');
		            		$("#sellerName").html('');
		            		$("#realSellerName").html('');
		            		$("#sendAddress").html('');
		            		$("#sellerType").html('');
		            		$("#sendTimeRemark").html('');
		            		$("#productBaseRemark").html('');
		            		$("#categoryTab tr").empty();
		            		$("#brandId").val(''); 
		            		$("#brandName").html(''); 
		            		$("#gegeImageId").val('');
		            		$("#desc").val('');
		            		$("#productBaseName").html('');
		            		$("#submitType").html('');
                            $("#setActivityPrice").hide();
		            		$("#freightType").html('');
		            		$("#netVolume").val('');
		            		$("#span_netVolume").html('');
		            		$("#placeOfOrigin").val('');
		            		$("#span_placeOfOrigin").html('');
		            		$("#manufacturerDate").val('');
		            		$("#span_manufacturerDate").html('');
		            		$("#storageMethod").val('');
		            		$("#span_storageMethod").html('');
		            		$("#durabilityPeriod").val('');
		            		$("#span_durabilityPeriod").html('');
		            		$("#peopleFor").val('');
		            		$("#span_peopleFor").html('');
		            		$("#foodMethod").val('');
		            		$("#span_foodMethod").html('');
		            		$("#useMethod").val('');
		            		$("#span_useMethod").html('');
		            		$("#tip").val('');
		            		$("#gegeImageId").val('');
		            		$("#gegeImageView").attr('src','http://m.gegejia.com:80/ygg/pages/images/userimg/gege.png');
		            	}
		            },
		            error: function(xhr){
		            	$.messager.progress('close');
		            	$("#code").val('');
	            		$("#span_code").html('');
	            		$("#barcode").val('');
	            		$("#span_barcode").html('');
	            		$("#sellerId").val('');
	            		$("#sellerName").html('');
	            		$("#realSellerName").html('');
	            		$("#sendAddress").html('');
	            		$("#sellerType").html('');
	            		$("#sendTimeRemark").html('');
	            		$("#productBaseRemark").html('');
	            		$("#categoryTab tr").empty();
	            		$("#brandId").val(''); 
	            		$("#brandName").html(''); 
	            		$("#gegeImageId").val('');
	            		$("#desc").val('');
	            		$("#productBaseName").html('');
	            		$("#submitType").html('');
                        $("#setActivityPrice").hide();
	            		$("#freightType").html('');
	            		$("#netVolume").val('');
	            		$("#span_netVolume").html('');
	            		$("#placeOfOrigin").val('');
	            		$("#span_placeOfOrigin").html('');
	            		$("#manufacturerDate").val('');
	            		$("#span_manufacturerDate").html('');
	            		$("#storageMethod").val('');
	            		$("#span_storageMethod").html('');
	            		$("#durabilityPeriod").val('');
	            		$("#span_durabilityPeriod").html('');
	            		$("#peopleFor").val('');
	            		$("#span_peopleFor").html('');
	            		$("#foodMethod").val('');
	            		$("#span_foodMethod").html('');
	            		$("#useMethod").val('');
	            		$("#span_useMethod").html('');
	            		$("#tip").val('');
	            		$("#gegeImageId").val('');
	            		$("#gegeImageView").attr('src','http://m.gegejia.com:80/ygg/pages/images/userimg/gege.png');
		            }
		    	});
        	}
        });
		
		$('#saveProduct').form({   
		    url:'${rc.contextPath}/product/${toAction}',   
		    onSubmit: function(){   
		        $.messager.progress();
		    },   
		    success:function(data){
		    	$.messager.progress('close');
		    	var data = eval('(' + data + ')');  // change the JSON string to javascript object   
		        if (data.status == 1){
		            window.location.href = "${rc.contextPath}/product/list?productType=1";
		        }else{
		        	$.messager.alert("提示",data.msg,"error");	
		        }
		    }
		}); 
	
	    $("#saveButton").click(function(){
	    	var pic_1 = $("#pic_1").val();
	    	var productBaseId = $.trim($("#productBaseId").val());
	    	var productName = $.trim($("#productName").val());
	    	var sellerProductName = $.trim($("#sellerProductName").val());
	    	var shortName = $.trim($("#shortName").val());
	    	var marketPrice = $.trim($("#marketPrice").val());
	    	var salesPrice = $.trim($("#salesPrice").val());
	    	var restriction = $.trim($('#restriction').val());
	    	var smallImage = $("#pic_7").val();
	    	var mediumImage = $("#pic_6").val();
	    	var partnerDistributionPrice = $("#partnerDistributionPrice").val();
	    	var text=$("#desc").val(); 
	    	var tip = $("#tip").val();
	    	var bsCommision = $("#bsCommision").val();
			var counter=text.length;
			// var productUseScopeId = $.trim($("#productUseScope").combobox("getValue"));
			if(productBaseId == ''){
				$.messager.alert("提示","请输入基本商品Id","info");
			}else if(!/^[0-9.]+$/.test(marketPrice) || !/^[0-9.]+$/.test(salesPrice) || !/^[0-9.]+$/.test(partnerDistributionPrice)){
				$.messager.alert("提示","价格不能保护除数字和.外的其他符号。","info");
			}else if(counter > 140){
	    		$.messager.alert("提示","格格说字数不得超过140","info");
	    	}else if(bsCommision == ""){
	    		$.messager.alert("提示","行动派分销佣金必填","info");
	    	}else if(!/^[0-9.]+$/.test(bsCommision)){
	    		$.messager.alert("提示","行动派分销佣金不能包括除数字和.外的其他符号","info");
	    	}else if(productName == "" || shortName == "" || sellerProductName == ""){
	    		$.messager.alert("提示","商品名称或者短名称或者商家发货名称都必填","info");
	    	}else if(marketPrice == "" || salesPrice == ""){
	    		$.messager.alert("提示","商品售价必填","info");
	    	}else if(parseFloat(marketPrice) < parseFloat(salesPrice)){
	    		$.messager.alert("提示","售价必须小于市场价","info");
	    	}else if($.trim(partnerDistributionPrice)==''){
	    		$.messager.alert("提示","分销供货价必填","info");
	    	}else if((parseFloat(partnerDistributionPrice) < parseFloat(salesPrice)*0.6) || (parseFloat(partnerDistributionPrice) > parseFloat(salesPrice))){
	    		$.messager.alert("提示","分销供货价必须大于或等于售价的60%<br/>并且小于或等于售价，否则无法保存","error");
	    	}else if(restriction == ""){
	    		$.messager.alert("提示","限购数量必填","info");
	    	}else if(tip.length > 200){
	    		$.messager.alert("提示","温馨提示字数不得超过100","info");
	    	}else if(pic_1 == ""){
	    		$.messager.alert("提示","商品详情主图1必填","info");
	    	}else if(typeof($('input[name=isAvailable]:checked').val()) == 'undefined'){
	    		$.messager.alert("提示","商品商品使用状态必填","info");
	    	}/*else if(productUseScopeId == ''){
                $.messager.alert("提示","商品使用渠道必选","info");
			}*/
			else{
	    		$('#saveProduct').submit();
	    	}
    	});
	
		$("#freightTemplate").change(function(){
			$("#freight_muban").prop("checked", true);
			$("#freight_baoyou").prop("checked", false);
		});
		
		$("#pageCustomId2").change(function(){
			var id = $("#pageCustomId2").val();
			if(id == -1){
				return;
			}else{
				$.post("${rc.contextPath}/product/ajaxPageCustomInfo", 
				{id: id},
				function(data){
					if(data.status != 1){
						$.messager.alert("提示",data.msg,"info");
						$("#pageCustomId2").val("-1");
					}
				}, "json");
			}
		});
		$("#pageCustomId1").change(function(){
			var id = $("#pageCustomId1").val();
			if(id == -1){
				return;
			}else{
				$.post("${rc.contextPath}/product/ajaxPageCustomInfo", 
				{id: id},
				function(data){
					if(data.status != 1){
						$.messager.alert("提示",data.msg,"info");
						$("#pageCustomId1").val("-1");
					}
				}, "json");
			}
		});
		

		$('#code').change(function (){
			var code = $('#code').val();
            var index = code.lastIndexOf("%");
            if(index != -1){
            	var num = code.substring(index+1);
                var reg = new RegExp("^[0-9]*$");
    			if(index == (code.length-1)){
                    $.messager.alert("确认信息","您输入了一个以%结尾的商品编码哦。"+num,"info");
    			}else{
                    if(reg.test(num)){
                        $.messager.alert("确认信息","该商品发货时数量会默认乘以"+num+"哦，请确认。","warn");
                    }
    			}
            }
		});
		
		$("#partnerDistributionPrice").change(function(){
			$("#partnerDistributionPrice_cal_fenc").text("");
			$("#partnerDistributionPrice_cal_maoli").text("");
			$("#partnerDistributionPrice_cal_jifen").text("");
			var returnDistributionProportionType = $('#returnDistributionProportionType').val();
			var salesPrice = $("#salesPrice").val();
	    	var partnerDistributionPrice = $("#partnerDistributionPrice").val();
	    	if(!/^[0-9.]+$/.test(salesPrice) || !/^[0-9.]+$/.test(partnerDistributionPrice)){
	    		return;
			}else if(parseFloat(partnerDistributionPrice) > parseFloat(salesPrice)){
	    		$.messager.alert("提示","分销供货价必须大于或等于售价的60%<br/>并且小于或等于售价，否则无法保存","info");
	    	}else{
				if(returnDistributionProportionType == 2){
                    var salesPrice_double = parseFloat(salesPrice);
                    var partnerDistributionPrice_double = parseFloat(partnerDistributionPrice);
                    var _d1 = Math.round((salesPrice_double - partnerDistributionPrice_double)*100);
                    $("#partnerDistributionPrice_cal_maoli").text(_d1 / 100);
                    $("#partnerDistributionPrice_cal_fenc").text(_d1 / 100);
                    $("#partnerDistributionPrice_cal_jifen").text("商品推荐积分"+Math.round(_d1));
				}else{
                    var salesPrice_double = parseFloat(salesPrice);
                    var partnerDistributionPrice_double = parseFloat(partnerDistributionPrice);
                    var _d1 = Math.round((salesPrice_double - partnerDistributionPrice_double)*100);
                    $("#partnerDistributionPrice_cal_maoli").text(_d1 / 100);
                    $("#partnerDistributionPrice_cal_fenc").text(_d1 / 400);
                    $("#partnerDistributionPrice_cal_jifen").text("商品推荐积分"+Math.round(_d1 / 4));
				}
	    	}
		});
		$("#partnerDistributionPrice").change();
	});
	
	function editProductBase(){
		var productBaseId = $("#productBaseId").val();
		var url="${rc.contextPath}/productBase/toAddOrUpdate?id="+productBaseId;
		window.open(url,"_blank");
	};
	$("#salesPrice").change(function(){
    	var id = $.trim($("#productBaseId").val());
    	if(id == ''){
			$.messager.alert("提示","请输入基本商品Id","info");
			return;
		}
    	var salesPrice = $.trim($("#salesPrice").val());
    	if(salesPrice == ""){
    		$.messager.alert("提示","请填写售价","info");
    		return;
    	}else if(!/^[0-9.]+$/.test(salesPrice)){
			$.messager.alert("提示","售价不能包括除数字和.外的其他符号。","info");
			return;
    	}
    	if(id!=''){
	    	$.messager.progress();		    	
	    	$.ajax({
	    		url:'${rc.contextPath}/productBase/getInfoBySalesPrice?id='+id+'&salesPrice='+salesPrice,
	    		type:'post',
	    		dataType: 'json',
	            success: function(data){
	            	$.messager.progress('close');
	            	if(data.status == 1){
	            		$("#bil").html(data.bil);
	            		$("#yk").html(data.yk);
	            		$("#ykb").html(data.ykb);
	            		$("#bsCommision").val(data.bsCommision); 
	            	}else{
	            		
	            	}
	            },
	            error: function(xhr){
	            	$.messager.progress('close');
	            }
	    	});
    	}
    });
    $("#bsCommision").change(function(){
    	var id = $.trim($("#productBaseId").val());
    	if(id == ''){
			$.messager.alert("提示","请输入基本商品Id","info");
			return;
		}
    	var salesPrice = $.trim($("#salesPrice").val());
    	if(salesPrice == ""){
    		$.messager.alert("提示","请填写售价","info");
    		return;
    	}else if(!/^[0-9.]+$/.test(salesPrice)){
			$.messager.alert("提示","售价不能包括除数字和.外的其他符号。","info");
			return;
    	}
    	var bsCommision = $.trim($("#bsCommision").val());
    	if(id!=''){
	    	$.messager.progress();		    	
	    	$.ajax({
	    		url:'${rc.contextPath}/productBase/getInfoByBsCommision?id='+id+'&salesPrice='+salesPrice+'&bsCommision='+bsCommision,
	    		type:'post',
	    		dataType: 'json',
	            success: function(data){
	            	$.messager.progress('close');
	            	if(data.status == 1){
	            		$("#bil").html(data.bil);
	            		$("#yk").html(data.yk);
	            		$("#ykb").html(data.ykb);
	            	}else{
	            		
	            	}
	            },
	            error: function(xhr){
	            	$.messager.progress('close');
	            }
	    	});
    	}
    });

	function updateActivityPrice(){
		$('#activityWholesalePriceStartTime').val('');
		$('#activityWholesalePriceEndTime').val('');
		$('#updateActivityPriceDiv_activityWholesalePrice').val('');
		$('#updateActivityPriceDiv').dialog('open');
	}
</script>

</body>
</html>