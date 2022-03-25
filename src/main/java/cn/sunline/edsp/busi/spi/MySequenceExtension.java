//package cn.sunline.edsp.busi.spi;
//
//import cn.sunline.adp.cedar.base.util.CoreUtil;
//import cn.sunline.adp.cedar.service.engine.spi.ServiceSequenceExtension;
//import cn.sunline.adp.cedar.service.executor.ServiceExecutorContext;
//import cn.sunline.edsp.microcore.spi.SPIMeta;
//
//@SPIMeta(id=MySequenceExtension.SPI_ID, order=10)
//public class MySequenceExtension implements ServiceSequenceExtension {
//	public static final String SPI_ID = "default";
//
//	public static final String SERVICE_SEQUENCE_NAME = "service_call_seq";
//
//	@Override
//	public String getServiceCallSequence(ServiceExecutorContext context) {
//		return CoreUtil.getSubSystemId() + System.currentTimeMillis(); // TODO 还需要拼接DCN编号，由于DCN逻辑未落入底层，后续补充
//	}
//}
