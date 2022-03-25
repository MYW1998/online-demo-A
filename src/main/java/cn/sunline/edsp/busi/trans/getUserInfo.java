
package cn.sunline.edsp.busi.trans;

import cn.sunline.adp.core.util.SpringUtils;

public class getUserInfo {

    public static void getMyselfPort(final cn.sunline.edsp.busi.online.demo.trans.intf.GetUserInfo.Input input, final cn.sunline.edsp.busi.online.demo.trans.intf.GetUserInfo.Property property, final cn.sunline.edsp.busi.online.demo.trans.intf.GetUserInfo.Output output) {
        String port = SpringUtils.getEnv().getProperty("server.port");
        output.setPortone(port);
    }
}
