
package cn.sunline.edsp.busi.online.demo.serviceimpl.edsp_sentina;

import cn.sunline.adp.cedar.base.logging.BizLog;
import cn.sunline.adp.cedar.base.logging.BizLogUtil;
import cn.sunline.adp.cedar.busi.sdk.biz.global.SysUtil;

/**
  * 资源2的实现类
  *
  */
@cn.sunline.adp.core.annotation.Generated
@cn.sunline.adp.metadata.model.annotation.ConfigType(value="resource2Impl", longname="资源2的实现类", type=cn.sunline.adp.metadata.model.annotation.ConfigType.Type.SERVICE)
public class resource2Impl implements cn.sunline.edsp.busi.servicetype.edsp_sentinal.resource2{
	 private static final BizLog logger = BizLogUtil.getBizLog(resource2Impl.class);
	/**
  * 外调接口，根据奇数偶数对应得到不同结果
  *
  */
	public Integer odevityInvoke(final cn.sunline.edsp.busi.servicetype.edsp_sentinal.resource2.odevityInvoke.Input input){


		  String goodsId = input.getGoodsId();
	        Integer result = Integer.valueOf(goodsId);
	        if (goodsId == "0") {
	            logger.info("coreA 开始进入休眠");
	            //休眠500ms
	            try {
	                Thread.sleep(500);
	            } catch (InterruptedException e) {
	                e.printStackTrace();
	            }
	        } else {
	            logger.info("不休眠");
	            return result;
	        }
	        return result;
	}
}

