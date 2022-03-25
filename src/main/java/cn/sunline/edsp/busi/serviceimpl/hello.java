
package cn.sunline.edsp.busi.serviceimpl;

import cn.sunline.adp.metadata.base.util.EdspCoreBeanUtil;
import cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Input;
import cn.sunline.edsp.busi.servicetype.hello.getUserInfo.Output;

/**
 * 快速入门
 */
@cn.sunline.adp.core.annotation.Generated
@cn.sunline.adp.metadata.model.annotation.ConfigType(value = "hell", longname = "快速入门", type = cn.sunline.adp.metadata.model.annotation.ConfigType.Type.SERVICE)
public class hello implements cn.sunline.edsp.busi.servicetype.hello {
    /**
     * 获取用户信息
     */
    public Output getUserInfo(final cn.sunline.edsp.busi.servicetype.hello.getUserInfo.Input input) {
        String name = input.getName();
        System.out.println("======== Hello.getUserInfo, [" + name + "]=====");
        Output output = EdspCoreBeanUtil.getModelObjectCreator().create(Output.class);
        output.setPortone("28");
        output.setName(name);
        return output;

    }

    /**
     * 根据名字获取用户信息
     */
    @Override
    public cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Output getMeassageByName(Input input) {
        String name = input.getName();
        System.out.println("======== hello.getMeassageByName, [" + name + "]=====");
        cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Output output =
                EdspCoreBeanUtil.getModelObjectCreator().create(cn.sunline.edsp.busi.servicetype.hello.getMeassageByName.Output.class);
        return output;
    }

}

