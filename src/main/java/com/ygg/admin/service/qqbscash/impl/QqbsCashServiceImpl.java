
 /**************************************************************************
 * Copyright (c) 2014-2016 浙江格家网络技术有限公司.
 * All rights reserved.
 * 
 * 项目名称：心动慈露APP
 * 版权说明：本软件属浙江格家网络技术有限公司所有，在未获得浙江格家网络技术有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。                            
 ***************************************************************************/
package com.ygg.admin.service.qqbscash.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.ygg.admin.config.YggAdminProperties;
import com.ygg.admin.dao.qqbscash.QqbsCashDao;
import com.ygg.admin.entity.qqbs.QqbsRewardEntity;
import com.ygg.admin.sdk.wenxin.RequestHandler;
import com.ygg.admin.service.qqbscash.QqbsCashService;
import com.ygg.admin.util.CommonHttpClient;
import com.ygg.admin.util.MD5Util;

/**
  * 心动慈露
提现服务
  * @author <a href="mailto:zhangld@yangege.com">zhangld</a>
  * @version $Id: QqbsCashServiceImpl.java 10836 2016-04-26 08:10:35Z zhanglide $   
  * @since 2.0
  */
@Service("qqbsCashService")
public class QqbsCashServiceImpl implements QqbsCashService {
    /**    */
    @Autowired(required = false)
    @Qualifier("qqbsCashDao")
    private QqbsCashDao qqbsCashDao;
    
    private static Logger logger = Logger.getLogger(QqbsCashServiceImpl.class);
    
    @Override
    public Map<String, Object> findListInfo(Map<String, Object> param)
        throws Exception
    {
        Map<String, Object> result = new HashMap<String, Object>();
        List<Map<String, Object>> infoList = qqbsCashDao.findListInfo(param);
        result.put("rows", infoList);
        result.put("total", qqbsCashDao.getCountByParam(param));
        return result;
    }
    
    
    /**
     * @param accountId
     * @param id
     * @param type 1打款 2拒绝
     * @throws Exception 
     * @see com.ygg.admin.service.qqbscash.QqbsCashService#updateLog(int, int, int)
     */
	public String updateLog(int id , int type) throws Exception{
		Map<String, Object> info = qqbsCashDao.getInfoByLogId(id);
		int accountId = Integer.valueOf(info.get("accountId")+"");
		float withdrawals = Float.valueOf(info.get("withdrawals")+"");
		String openId = info.get("openId")+"";
		int status = Integer.valueOf(info.get("status")+"");
		if(status == 1){
		    Map<String, Object> param = new HashMap<String, Object>();
	        param.put("id", id);
	        if(type == 1){
	            //打款
	            //2.打款
	            RequestHandler reqHandler = new RequestHandler(null, null);
	            String nonce_str = MD5Util.getNonceStr();
	            
	            reqHandler.setParameter("mch_appid","wxa022d433d4a30207"); // 公众账号ID
	            reqHandler.setParameter("mchid","1348518501"); // 商户号
	            //设备号
//	            reqHandler.setParameter("device_info", "1");
	            //随机字符串
	            reqHandler.setParameter("nonce_str", nonce_str); 
	            // 商家订单号
	            reqHandler.setParameter("partner_trade_no", MD5Util.getNonceStr());
	            //用户openid
	            reqHandler.setParameter("openid", openId);
	            //校验用户姓名选项
	            reqHandler.setParameter("check_name", "NO_CHECK");
	            //收款用户姓名
//	            reqHandler.setParameter("re_user_name", "马花花");
	            //金额
	            reqHandler.setParameter("amount", (int)(withdrawals * 100) + "");
	            //企业付款描述信息
	            reqHandler.setParameter("desc", "行动派提现");
	            //Ip地址
	            reqHandler.setParameter("spbill_create_ip", "192.168.0.1");
	            
	             //key
	            reqHandler.setKey("0806a6b68fa695e33895c5dd924338ed");
	            
	            // 生成签名
	            String sign = reqHandler.createSign(reqHandler.getParameters());
	            reqHandler.setParameter("sign", sign);
	            String requestUrl = reqHandler.getRequestURL();
	            String cashUrl = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";//YggAdminProperties.getInstance().getPropertie("qqbs_weixin_cash_url");
	            String mchid = "1348518501";//YggAdminProperties.getInstance().getPropertie("qqbs_weixin_mchid");
	            String certPath = "C:\\Users\\apiclient_cert.p12";//YggAdminProperties.getInstance().getPropertie("qqbs_weixin_cash_cert");
	            JSONObject responseParams = CommonHttpClient.sendXmlRefundHTTP(cashUrl, mchid, certPath, requestUrl);
	            
	            if ("SUCCESS".equals(responseParams.getString("return_code")) && "SUCCESS".equals(responseParams.getString("result_code")))
	            {
	                //1.提现成功
	                param.put("status", 2);
	                QqbsRewardEntity hre = qqbsCashDao.getByAccountId(accountId);
	                if(hre != null){
	                    float newCash = hre.getAlreadyCash()+withdrawals;
	                    hre.setAlreadyCash(newCash);
	                    qqbsCashDao.updateHqbsReward(hre);
	                }
	            }
	            else if ("SUCCESS".equals(responseParams.getString("return_code")) && "FAIL".equals(responseParams.getString("result_code")))
	            {
	              logger.info(responseParams);
	              return responseParams.getString("err_code_des") + "";
	            }
	            logger.info(responseParams);
	        }else if(type == 2){
	            //拒绝
	            //提现失败
	            param.put("status", 3);
	            //修改奖励表
	            //用户奖励信息
	            QqbsRewardEntity hre = qqbsCashDao.getByAccountId(accountId);
	            if(hre != null){
	                float newCash = hre.getWithdrawCash()+withdrawals;
	                hre.setWithdrawCash(newCash);
	                qqbsCashDao.updateHqbsReward(hre);
	            }
	        }
	        qqbsCashDao.updateLog(param);
		}else{
		    return "该记录已经打过款或已拒绝过,不再处理";
		}
    	return null;
    }
}
