
package cn.sunline.edsp.busi.serviceimpl;

import cn.sunline.adp.cedar.busi.sdk.biz.global.SysUtil;
import cn.sunline.adp.core.annotation.Generated;
import cn.sunline.adp.metadata.model.annotation.ConfigType;
import cn.sunline.edsp.busi.errors.AtErrorDef.AtError;
import cn.sunline.edsp.busi.tables.AtTable.Kapp_custDao;
import cn.sunline.edsp.busi.tables.AtTable.kapp_cust;

/**
 * Customer type service implementation
 */
@Generated
@ConfigType(value = "CustInfoImpl", longname = "Customer type service implementation", type = ConfigType.Type.SERVICE)
public class CustInfoImpl implements cn.sunline.edsp.busi.servicetype.CustInfo {
	/**
	 * Create customer information
	 */
	public void createCust(final cn.sunline.edsp.busi.servicetype.CustInfo.createCust.Input input,
			final cn.sunline.edsp.busi.servicetype.CustInfo.createCust.Output output) {
		try {
			kapp_cust custInfo = SysUtil.getInstance(kapp_cust.class);
			String custNo = "Customer Nunber:" + System.currentTimeMillis() / 1000;
			custInfo.setCustno(custNo);
			custInfo.setCustna(input.getCustna());
			custInfo.setTeleno(input.getTeleno());
			Kapp_custDao.insert(custInfo);

			output.setCustno(custNo);
		} catch (Exception e) {
			throw AtError.E001();
		}
	}
}
