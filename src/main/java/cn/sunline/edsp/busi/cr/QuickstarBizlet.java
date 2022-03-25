package cn.sunline.edsp.busi.cr;

import java.util.HashMap;
import java.util.Map;

import cn.sunline.adp.vine.base.annotation.Bizlet;
import cn.sunline.adp.vine.base.annotation.FlowComp;

@FlowComp(category = "custom", name = "快速入门")
public class QuickstarBizlet {

//    @Bizlet(value = "调用组件示例")
    public Map<String, Object> log(Map<String, Object> param) {
        String name = (String) param.get("name");
        System.out.println("======= Welcome to cedar world, ["+name+"] =======");
        Map<String, Object> result = new HashMap<>();
        result.put("name", name);
        result.put("age", "10");
        result.put("gender", "B");
        return result;
    }
    @Bizlet(value = "调用组件示例")
    public Map<String, Object> testA(Map<String, Object> param) {
        String cust = (String) param.get("cust");
        System.out.println("======= Welcome to cedar world, ["+cust+"] =======");
        Map<String, Object> result = new HashMap<>();
        result.put("cust", cust);
        result.put("age", "18");
        return result;
    }
    @Bizlet(value = "调用组件示例")
    public Map<String, Object> testB(Map<String, Object> param) {
        String cust = (String) param.get("cust");
        System.out.println("======= Welcome to cedar world, ["+cust+"] =======");
        Map<String, Object> result = new HashMap<>();
        result.put("cust", cust);
        return result;
    }
}