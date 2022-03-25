
package cn.sunline.edsp.busi.trans;


import cn.sunline.adp.cedar.base.logging.BizLog;
import cn.sunline.adp.cedar.base.logging.BizLogUtil;
import cn.sunline.edsp.busi.namedsql.AtNsqlDao;
import cn.sunline.edsp.busi.type.AtComplex.custAcctComplex;


public class ap002 {

public static final BizLog logger = BizLogUtil.getBizLog(ap002.class);	
	
public static void queryInfoByCustno( final cn.sunline.edsp.busi.trans.intf.Ap002.Input input,  final cn.sunline.edsp.busi.trans.intf.Ap002.Property property,  final cn.sunline.edsp.busi.trans.intf.Ap002.Output output){
   	custAcctComplex bean = AtNsqlDao.queryInfoByCustno(input.getAcctno(), false);
   	logger.info("customer's name: " + bean.getCustna());
   	logger.info("Customer phone: " + bean.getTeleno());
   	logger.info("account balance: " + bean.getAcctam());
   	logger.info("Account Status: " + bean.getAcctst().getLongName());
   	
   	output.setCustna(bean.getCustna());
   	output.setTeleno(bean.getTeleno());
   	output.setAcctam(bean.getAcctam());
   	output.setAcctst(bean.getAcctst());
}

}
