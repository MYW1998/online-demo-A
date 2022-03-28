
package cn.sunline.edsp.busi.serviceimpl.edsp_sentinal;

/**
 * 资源1的实现类
 */
@cn.sunline.adp.core.annotation.Generated
@cn.sunline.adp.metadata.model.annotation.ConfigType(value = "resource1Impl", longname = "资源1的实现类", type = cn.sunline.adp.metadata.model.annotation.ConfigType.Type.SERVICE)
public class resource1Impl implements cn.sunline.edsp.busi.online.demo.servicetype.edsp_sentinal.resource1 {
    /**
     * 非外调接口，调用成功，返回1
     */
    public Integer selfInvokeGetOne(final cn.sunline.edsp.busi.online.demo.servicetype.edsp_sentinal.resource1.selfInvokeGetOne.Input input) {
        return Integer.valueOf(1);
    }
}

