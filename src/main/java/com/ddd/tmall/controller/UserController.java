package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.User;
import com.ddd.tmall.service.UserService;
import com.ddd.tmall.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("admin_user_list")
    public String list(Page page, Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<User> us = userService.list();

        page.setTotal((int)new PageInfo<>(us).getTotal());

        model.addAttribute("us",us);
        model.addAttribute("page",page);

        return "admin/listUser";
    }
}
