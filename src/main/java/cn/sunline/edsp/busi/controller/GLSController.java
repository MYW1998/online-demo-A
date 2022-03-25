package cn.sunline.edsp.busi.controller;

import cn.sunline.adp.service.router.gls.entity.AllocRouteBody;
import cn.sunline.adp.service.router.gls.entity.QueryRouteBody;
import cn.sunline.adp.service.router.gls.entity.RegistRouteBody;
import cn.sunline.adp.service.router.gls.util.CustomGLSUtil;
import cn.sunline.edsp.gcm.core.entity.UnitInfo;
import cn.sunline.edsp.gcm.core.entity.UnitType;
import cn.sunline.edsp.gls.api.entity.GLSAllocMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author xuhaojie
 * @Date 2021/12/31 10:36
 */
@RestController
@RequestMapping("/gls")
public class GLSController {
    @Autowired
    private DiscoveryClient discoveryClient;
    @Autowired
    private CustomGLSUtil customGLSUtil;

    @PostMapping("/alloc")
    public GLSAllocMapping alloc(@RequestBody AllocRouteBody routeBody) {
        List<ServiceInstance> serviceInstances = this.discoveryClient.getInstances("service-adp1");
        routeBody.setUnitType(UnitType.RUnit);
        GLSAllocMapping mapping = customGLSUtil.alloc(routeBody);
        return mapping;
    }

    @PostMapping("/regist")
    public UnitInfo regist(@RequestBody RegistRouteBody routeBody) {
        routeBody.setUnitType(UnitType.RUnit);
        UnitInfo info = CustomGLSUtil.regist(routeBody);
        return info;
    }

    @PostMapping("/query")
    public UnitInfo query(@RequestBody QueryRouteBody routeBody) {
        UnitInfo info = CustomGLSUtil.query(routeBody);
        return info;
    }

    @PostMapping("/queryConsumer")
    public UnitInfo queryConsumer(@RequestBody QueryRouteBody routeBody) {
        UnitInfo info = CustomGLSUtil.queryByCustomer(routeBody);
        System.out.println(info.toString());
        return info;
    }

    @PostMapping("/queryAdmin")
    public UnitInfo queryAdmin(@RequestBody Map<String, String> param) {
        String namespace = param.get("namespace");
        String systemCode = param.get("systemCode");
        UnitInfo info = CustomGLSUtil.queryAdminUnit(namespace, systemCode);
        return info;
    }


}
