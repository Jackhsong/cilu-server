
 /**************************************************************************
 * Copyright (c) 2014-2016 浙江格家网络技术有限公司.
 * All rights reserved.
 * 
 * 项目名称：心动慈露APP
 * 版权说明：本软件属浙江格家网络技术有限公司所有，在未获得浙江格家网络技术有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。                            
 ***************************************************************************/
package com.ygg.admin.dao.qqbscash;

import java.util.List;
import java.util.Map;

import com.ygg.admin.entity.qqbs.QqbsRewardEntity;

/**
  * TODO 请在此处添加注释
  * @author <a href="mailto:zhangld@yangege.com">zhangld</a>
  * @version $Id: QqbsCashDao.java 10835 2016-04-26 08:06:06Z zhanglide $   
  * @since 2.0
  */
public interface QqbsCashDao {
	/**
     * 查询推荐列表
     * @param param
     * @return
     * @throws Exception
     */
    List<Map<String, Object>> findListInfo(Map<String, Object> param)
        throws Exception;
    
    /**
     * 统计条数
     * @param param
     * @return
     * @throws Exception
     */
    int getCountByParam(Map<String, Object> param)
        throws Exception;
    
    public int updateLog(Map<String, Object> param);
    
    public int updateHqbsReward(QqbsRewardEntity hqbsRewardEntity);
    /**
	 * 获取用户奖励信息
	 * @param accountId
	 * @return
	 * @throws Exception
	 */
	public QqbsRewardEntity getByAccountId(int accountId);
	
	
	/**
     * 获取用户奖励信息
     * @param accountId
     * @return
     * @throws Exception
     */
    public Map<String, Object> getInfoByLogId(int logId);
}
