
package cn.sunline.edsp.busi.trans;

import cn.sunline.adp.cedar.base.logging.BizLog;
import cn.sunline.adp.cedar.base.logging.BizLogUtil;
import cn.sunline.adp.cedar.busi.sdk.biz.global.SysUtil;
import cn.sunline.edsp.busi.parm.TrxEnvs;


public class ap004 {
	
public static final BizLog logger = BizLogUtil.getBizLog(ap004.class);	

public static Object[] method1;
public static void getAndSetTxnRunEnvs( final cn.sunline.edsp.busi.trans.intf.Ap004.Input input,  final cn.sunline.edsp.busi.trans.intf.Ap004.Property property,  final cn.sunline.edsp.busi.trans.intf.Ap004.Output output){
	
	TrxEnvs.RunEnvs trxRunEnvs = SysUtil.getTrxRunEnvs();
	
	logger.info("Corporate code: " + trxRunEnvs.getBossno());
	
	logger.info("Trading serial number: " + trxRunEnvs.getTranno());
	
	trxRunEnvs.setTranno("Trading serial number:tranno");
	
	method1 = new Object[]{input,property,output};
		
}
public static void testInputOuputPropertySame( final cn.sunline.edsp.busi.trans.intf.Ap004.Input input,  final cn.sunline.edsp.busi.trans.intf.Ap004.Property property,  final cn.sunline.edsp.busi.trans.intf.Ap004.Output output){

	if(method1[0] == input){
		logger.info("Method input object shared in the node");
	}
	if(method1[1] == property){
		logger.info("Shared property object in method node");
	}
	if(method1[2] == output){
		logger.info("Shared output object in method node");
	}
}
}
