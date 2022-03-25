package cn.sunline.edsp.busi.trans;

import cn.sunline.adp.cedar.base.logging.BizLog;
import cn.sunline.adp.cedar.base.logging.BizLogUtil;

public class ap001 {
	private static final BizLog logger = BizLogUtil.getBizLog(ap001.class);

	public static void welcome(final cn.sunline.edsp.busi.trans.intf.Ap001.Input input,
			final cn.sunline.edsp.busi.trans.intf.Ap001.Property property,
			final cn.sunline.edsp.busi.trans.intf.Ap001.Output output) {
		logger.info("Welcome to [%s] using adp platform", input.getCustna());
		logger.error("Print error log");
		logger.debug("Print error log...");
		logger.method("Print error log...");
		logger.info("Print info log");
		logger.parm("Print parm log");
	}
}
