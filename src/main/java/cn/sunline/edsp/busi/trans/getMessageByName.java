
package cn.sunline.edsp.busi.trans;


import cn.sunline.adp.core.util.SpringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class getMessageByName {

    public static void getPortOfCurrentRoutingNode(final cn.sunline.edsp.busi.online.demo.trans.intf.GetMessageByName.Input input, final cn.sunline.edsp.busi.online.demo.trans.intf.GetMessageByName.Property property, final cn.sunline.edsp.busi.online.demo.trans.intf.GetMessageByName.Output output) {
        List<Map> routeProcess = output.getRouteProcess() == null ? new ArrayList<>() : (List<Map>) output.getRouteProcess();
        Map map = new HashMap<String, String>();

        map.put("port-1", SpringUtils.getEnv().getProperty("server.port"));
        routeProcess.add(map);
        output.setRouteProcess(routeProcess);
    }
}
