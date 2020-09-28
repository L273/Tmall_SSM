package com.ddd.tmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class PageController {
    @RequestMapping("registerPage")
    public String register(){
        return "fore/register";
    }

    @RequestMapping("registerSuccessPage")
    public String registerSuccess(){
        return "fore/registerSuccess";
    }


    @RequestMapping("loginPage")
    public String login(){
        return "fore/login";
    }

    @RequestMapping("/")
    public String home(){
        //首页
        return "redirect:forehome";
    }

    @RequestMapping("forealipay")
    public String alipay(){
        return "fore/alipay";
    }
}
