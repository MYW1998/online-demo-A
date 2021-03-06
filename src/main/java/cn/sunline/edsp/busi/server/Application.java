package cn.sunline.edsp.busi.server;

import cn.sunline.adp.boot.cedar.CedarMain;
import cn.sunline.adp.core.util.SpringUtils;
import cn.sunline.adp.service.router.gls.client.GLSClientManager;
import cn.sunline.adp.service.router.gls.entity.AllocRouteBody;
import cn.sunline.adp.service.router.gls.entity.RegistRouteBody;
import cn.sunline.adp.service.router.gls.util.CustomGLSUtil;
import cn.sunline.edsp.gcm.core.entity.UnitInfo;
import cn.sunline.edsp.gcm.core.entity.UnitType;
import cn.sunline.edsp.gls.api.entity.GLSAllocMapping;
import org.springframework.core.env.Environment;

import java.util.List;

/**
 * Online management segment startup class
 *
 * @author liangjiaming
 */
public class Application {
    public static void main(String[] args) {
        // Default configuration specification
        System.setProperty("ltts.vmid", "onlserver");
        System.setProperty("ltts.home", System.getProperty("user.dir"));
        System.setProperty("ltts.log.home", "logs");
        System.setProperty("log4j.configurationFile", "log4j2.xml");
        // i18n
        System.setProperty("i18n.enable", "true");
        System.setProperty("i18n.conf", "en");
        //指定启动工程的配置文件。部署时可以用运行命令修改。Java -jar spring.profiles.active = XXX
        System.setProperty("spring.profiles.active", "dev");
//        System.setProperty("env", "DEV");
        System.setProperty("apollo.configService", "http://10.22.4.79:8080");
        //start up
        CedarMain.main(args);
//        String flag = SpringUtils.getEnv().getProperty("edsp.gcm.multiSystem.enabled");
//        List<UnitInfo> unitInfoList = new ArrayList<UnitInfo>();
//        UnitInfo unitInfo = new UnitInfo();
//        unitInfo.setUnitId("dcn1");
//        unitInfo.setType("R");
//        unitInfoList.add(unitInfo);
//        GLSClientManager.get().getGCMQueryApi().refreshMetadata(unitInfoList);
//        List<UnitInfo> unitInfos = GLSClientManager.get().getGCMQueryApi().queryAllRUnitInfo();
        // 预分配
//        AllocRouteBody allocRouteBody = new AllocRouteBody();
//        allocRouteBody.setUnitType(UnitType.RUnit);
//        allocRouteBody.setRouteKey("libai");
//        allocRouteBody.setRouteType("idcard");
//        allocRouteBody.setNamespace("dev");
//        allocRouteBody.setCorpNo("9999");
//        allocRouteBody.setSystemCode("core");
//        GLSAllocMapping mapping = CustomGLSUtil.alloc(allocRouteBody);
//        // 注册
//        RegistRouteBody registRouteBody = new RegistRouteBody();
//        registRouteBody.setUnitType(UnitType.RUnit);
//        registRouteBody.setShardingId(mapping.getShardId());
//        registRouteBody.setRouteKey("libai");
//        registRouteBody.setRouteType("idcard");
//        registRouteBody.setNamespace("dev");
//        registRouteBody.setCorpNo("9999");
//        registRouteBody.setSystemCode("core");

//        registRouteBody.setMainCustInrId("adp-customer1");
//        CustomGLSUtil.regist(registRouteBody);


    }

}
