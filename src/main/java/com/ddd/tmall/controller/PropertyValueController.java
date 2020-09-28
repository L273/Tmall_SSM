package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.Product;
import com.ddd.tmall.pojo.PropertyValue;
import com.ddd.tmall.service.ProductService;
import com.ddd.tmall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("")
public class PropertyValueController {

    @Autowired
    PropertyValueService propertyValueService;

    @Autowired
    ProductService productService;

    @RequestMapping("admin_propertyValue_edit")
    public String edit(Model model,int pid){
        Product product = productService.getProduct(pid);
        propertyValueService.init(product);

        List<PropertyValue> pvs = propertyValueService.list(pid);

        model.addAttribute("product",product);
        model.addAttribute("pvs",pvs);

        return "admin/editPropertyValue";
    }

    @RequestMapping("admin_propertyValue_upadte")
    @ResponseBody
    public String update(PropertyValue propertyValue){
        propertyValueService.update(propertyValue);
        return "success";
    }
}
