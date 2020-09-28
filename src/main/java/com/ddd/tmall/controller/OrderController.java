package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.Order;
import com.ddd.tmall.service.OrderItemService;
import com.ddd.tmall.service.OrderService;
import com.ddd.tmall.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;

    @Autowired
    OrderItemService orderItemService;

    @RequestMapping("admin_order_list")
    public String list(Page page, Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Order> orderList = orderService.list();

        page.setTotal((int)new PageInfo<>(orderList).getTotal());

        model.addAttribute("os",orderList);
        model.addAttribute("page",page);

        return "admin/listOrder";
    }

    @RequestMapping("admin_order_delivery")
    public String delivery(int id)
        throws IOException{
        System.out.println(id);
        Order order = orderService.get(id);
        order.setDeliverDate(new Date());
        order.setOrderStatus(OrderService.waitConfirm);
        orderService.update(order);
        return "redirect:admin_order_list";
    }


}
