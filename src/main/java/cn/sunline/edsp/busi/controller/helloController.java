//package cn.sunline.edsp.busi.controller;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
///**
// * @Description:
// * @Author meng
// * @Date 2021/8/23 11:33
// */
//@RestController
//@RequestMapping("/hello")
//public class helloController {
//    //    RestController和Controller注解的区别是：RestController是返回的内容就是返回的内容，相当于加个@ResponseBody,而controller一般是返回的页面
//
//    @Autowired
//    private final RestTemplate restTemplate;
//
//    @Autowired
//    public helloController(RestTemplate restTemplate) {
//        this.restTemplate = restTemplate;
//    }
//
//    /**
//     * 调用远程服务 --调用非adp应用
//     *
//     * @return
//     */
//    @PostMapping("/flow")
//    public String hello() {
//        String url = "http://127.0.0.1:8080/hello";
//        ResponseEntity<String> result = restTemplate.getForEntity(url, String.class);
//        System.out.println(result.getBody());
//        return result.getBody();
//    }
//
//}
