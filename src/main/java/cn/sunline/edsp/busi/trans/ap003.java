
package cn.sunline.edsp.busi.trans;



import cn.sunline.adp.cedar.base.logging.BizLog;
import cn.sunline.adp.cedar.base.logging.BizLogUtil;
import cn.sunline.edsp.busi.tables.AtTable.Kapp_acctDao;
import cn.sunline.edsp.busi.tables.AtTable.Kapp_custDao;
import cn.sunline.edsp.busi.tables.AtTable.kapp_acct;
import cn.sunline.edsp.busi.tables.AtTable.kapp_cust;


public class ap003 {
	
public static final BizLog logger = BizLogUtil.getBizLog(ap003.class);	
	
public static void queryAmountByAcctno( final cn.sunline.edsp.busi.trans.intf.Ap003.Input input,  final cn.sunline.edsp.busi.trans.intf.Ap003.Property property,  final cn.sunline.edsp.busi.trans.intf.Ap003.Output output){
	//Get account
	String acctno = input.getAcctno();
	//Get account information by account number
	logger.info("Get account information by account number...》》》》》》》》》》》》》》");	
	kapp_acct bean = Kapp_acctDao.selectOne_odb2(acctno, true);		
	logger.info("Start looking up account information...》》》》》》》》》》》》》》");		
	//Populate the customer number into the property interface
	property.setCustno(bean.getCustno());
	//Set account balance to output
	output.setAcctam(bean.getAcctam());
	
	try {
		//1.Query target dcn according to account number
//		TargetInfo info=RouteUtil.locateTargetDCN(RouteUtil.BizKeyType.bankAccount,input.getAcctno());
//		System.out.print("\n Query target dcn according to account number："+info.getDcnNo());
		//2.Query target dcn by obtaining the account number in the public run variable
		//Constructing a service request object
//		ServiceRequest request = new ServiceRequest(EngineContext.getEngineRuntimeContext().getRunDataArea().getInput());
//		ServiceController serviceController = ServiceControllerManager.get().getServiceController("ap001.CustInfo.createCust", "CustInfo.createCust");
//		ServiceRouteResult routeResult = ServiceRouterUtils.getServiceRouter().route(request, serviceController);
//		System.out.print("\n Query target dcn by obtaining the account number in the public run variable："+info.getDcnNo());
		//3.Query target dcn according to custom route type
		//TargetInfo routekey1=RouteUtil.locateTargetDCN(RouteUtil.BizKeyType.routeKey1,"routekey1");
		//System.out.print("\n Query target dcn according to custom route type："+routekey1.getDcnNo()+"\n");
	}catch(Exception e) {
		
	}
}

	public static void queryTelepByCustno(final cn.sunline.edsp.busi.trans.intf.Ap003.Input input,
			final cn.sunline.edsp.busi.trans.intf.Ap003.Property property,
			final cn.sunline.edsp.busi.trans.intf.Ap003.Output output) {

		String custno = property.getCustno();
		logger.info("Start looking up customer information》》》》》》》》》》》》》》");
		kapp_cust bean = Kapp_custDao.selectOne_odb1(custno, true);
		logger.info("End query customer information》》》》》》》》》》》》》》");
		logger.info("2Start looking up customer information》》》》》》》》》》》》》》");
		bean = Kapp_custDao.selectOne_odb1(custno, true);
		logger.info("2End query customer information》》》》》》》》》》》》》》");
		output.setTeleno(bean.getTeleno());
	}
}
