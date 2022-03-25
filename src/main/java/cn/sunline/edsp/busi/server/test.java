//package cn.sunline.edsp.busi.server;
//
//import java.util.HashMap;
//import java.util.Map;
//
//
//import cn.sunline.adp.cedar.protocol.rest.constant.RestConstant;
//import cn.sunline.adp.cedar.protocol.rest.data.RestRequestData;
//import cn.sunline.adp.cedar.protocol.rest.util.CommonDataUtil;
//import cn.sunline.adp.cedar.service.router.drs.util.RouteUtil;
//import cn.sunline.adp.core.util.JsonUtil;
////
//public class test {
//	public static void main(String[] args) {
//        Map<String, Object> body = new HashMap<>();
//        Map<String, Object> comReq = new HashMap<>();
//        body.put(RestConstant.PARAM_SYS, new HashMap<>());
//        body.put(RestConstant.PARAM_COMMREQ, comReq);
//        body.put(RestConstant.PARAM_INPUT, body.get(RestConstant.PARAM_COMMREQ));
//
//        RestRequestData requestData = CommonDataUtil.mapToRequest(body);
//        body = CommonDataUtil.entityToMap(requestData);
//
//        RestRequestData request = new RestRequestData();
//        request.setSys((Map)body.get(RestConstant.PARAM_SYS));
//        request.setInput((Map)body.get(RestConstant.PARAM_INPUT));
//        request.setComm_req((Map)body.get(RestConstant.PARAM_COMMREQ));
//
//        String packet = JsonUtil.format(request);
//        System.out.println(packet);
//}
//}
