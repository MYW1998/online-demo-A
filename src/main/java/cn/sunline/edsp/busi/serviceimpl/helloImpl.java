
package cn.sunline.edsp.busi.serviceimpl;

import cn.sunline.adp.core.util.SpringUtils;
import cn.sunline.adp.metadata.base.util.EdspCoreBeanUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 快速入门
 */
@cn.sunline.adp.core.annotation.Generated
@cn.sunline.adp.metadata.model.annotation.ConfigType(value = "helloImpl", longname = "快速入门", type = cn.sunline.adp.metadata.model.annotation.ConfigType.Type.SERVICE)
public class helloImpl implements cn.sunline.edsp.busi.servicetype.hello {
    /**
     * 获取用户信息
     */
    public getUserInfo.Output getUserInfo(final cn.sunline.edsp.busi.servicetype.hello.getUserInfo.Input input) {
        String name = input.getName();
        System.out.println("======== Hello, [" + name + "]=====");

        getUserInfo.Output output = EdspCoreBeanUtil.getModelObjectCreator().create(getUserInfo.Output.class);
        String port = SpringUtils.getEnv().getProperty("server.port");
        output.setPorttwo(port);
        output.setName(name);
        return output;

    }

    /**
     * 根据名字获取用户信息
     */
    @Override
    public cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Output getMeassageByName(getMeassageByName.Input input) {
        String name = input.getName();
        System.out.println("======== hello.getMeassageByName, [" + name + "]=====");
        cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Output output =
                EdspCoreBeanUtil.getModelObjectCreator().create(cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Output.class);

        List<Map> routeProcess = output.getRouteProcess() == null ? new ArrayList<>() : (List<Map>) output.getRouteProcess();
        Map map = new HashMap<String, String>();

        map.put("port-2", SpringUtils.getEnv().getProperty("server.port"));
        routeProcess.add(map);
        output.setRouteProcess(routeProcess);
        output.setName(name);

        return output;
    }

}

