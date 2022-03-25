//package cn.sunline.edsp.busi.server;
//
//import java.io.File;
//import java.util.HashMap;
//
//import org.apache.commons.io.FileUtils;
//
//import cn.sunline.edsp.midware.rpc.api.RPCStart;
//import cn.sunline.edsp.midware.rpc.api.builder.ConfigBuilder;
//import cn.sunline.edsp.midware.rpc.core.AccessId;
//import cn.sunline.edsp.midware.rpc.core.constants.RPCConstant;
//import cn.sunline.edsp.midware.rpc.core.model.InstanceConfig;
//import cn.sunline.edsp.midware.rpc.core.model.RPCResult;
//import cn.sunline.edsp.midware.rpc.packet.sdk.RPCConsumer;
//import cn.sunline.edsp.midware.rpc.registry.RegistryConfig;
//
//public class RPCClient {
//	private String host = "127.0.0.1";
//	private int port = 2181;
//
//	public static void main(String[] args) throws Exception {
//		RPCClient rp = new RPCClient("127.0.0.1:2181");
//		HashMap<String, String> headers = new HashMap<String, String>();
//		headers.put("busiseqno", String.valueOf(System.currentTimeMillis()));// callSeqNo
//		headers.put("callseqno", String.valueOf(System.currentTimeMillis()));
//		headers.put(RPCConstant.SERVICE_KEY, "ap001"); // RPCConstant.GROUP_KEY
//		String[] access = new String[4];
//		access[0] = "demo";
//		access[1] = "ap001";
//		access[2] = "onl01";
//		access[3] = "0.1";
//		try {
//			rp.send(null, access, getSendContent("ap001.json"), headers);
//		}catch (Exception e) {
//			e.printStackTrace();
//		}finally {
//			System.exit(0);
//		}
//	}
//
//	public RPCClient(String registryURL) {
//		String[] split = registryURL.split(":");
//		this.host = split[0];
//		this.port = Integer.valueOf(split[1]);
//	}
//
//	static String confPath = "src/main/resources/json/";
//
//	public static String getSendContent(String sendPkgFile) {
//		String ret = "";
//		try {
//			File pkgFile = new File(confPath + sendPkgFile);
//			ret = FileUtils.readFileToString(pkgFile);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ret;
//	}
//
//	/**
//	 *
//	 * @param params
//	 *            rpc客户端引用配置参数
//	 * @param access
//	 *            访问三要素
//	 * @param data
//	 *            请求报文
//	 * @param dcnNo
//	 *            dcn编号
//	 * @param bizHeaderParams
//	 *            业务头参数
//	 * @return
//	 * @throws Exception
//	 */
//	public Object send(HashMap<String, String> params, String[] access, String data,
//			HashMap<String, String> bizHeaderParams) throws Exception {
//		String application = access[0];
//		String serviceId = access[1]; // 服务id
//		String group = access[2]; // 服务分组
//		String version = access[3]; // 服务版本
//		/** 构建客户端引用配置referenceConfig */
//		InstanceConfig instanceConfig = new InstanceConfig().setApplication("IDE-RPC-TEST");
//		/** 构建注册中心 */
//		RegistryConfig registry = new RegistryConfig().setGroup("edsp").setHost(host).setPort(port).setRetryPeriod(1)
//				.setSession(3000);
//
//		new ConfigBuilder().setInstanceConfig(instanceConfig)//
//				.setRegistryConfig(registry)//
//				.build();
//		/**
//		 * 服务引用初始化 1.初始化后才可以对服务进行远程调用 2.相同服务可以重复初始化，第二次初始化不生效
//		 */
//		RPCStart.init();
//
//		RPCResult request = new RPCResult();// 构建请求对象
//		request.setData(data);// 设置请求报文
//		request.setHeaders(bizHeaderParams);
//		/** 服务调用 */
//		AccessId accessId = new AccessId(application, serviceId, group, version);// 构建服务唯一标识
//		RPCResult result = RPCConsumer.invoke(accessId, request);
//		// Map<String ,String> header = response.getBizHeader(); //获取请求头
//		Object ret = result.getData(); // 获取请求体
//		RPCStart.destroy();
//		return ret;
//	}
//}