package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.Category;
import com.ddd.tmall.pojo.Property;
import com.ddd.tmall.service.CategoryService;
import com.ddd.tmall.service.PropertyService;
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
public class PropertyController {
    @Autowired
    CategoryService categoryService;

    @Autowired
    PropertyService propertyService;

    @RequestMapping("admin_property_list")
    public String list(int cid, Model model, Page page){

        //得到一个category，用于之后的edit使用
        Category category = categoryService.getCategory(cid);

        //分页
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Property> propertyList = propertyService.listProperty(cid);

        //得到总数，用于page内的last生成，还有相关第一页，最后一页的判断语句
        page.setTotal((int)new PageInfo<>(propertyList).getTotal());
        page.setParam("?cid="+cid);

        model.addAttribute("category",category);
        model.addAttribute("page",page);
        model.addAttribute("ps",propertyList);

        return "admin/listProperty";
    }

    @RequestMapping("admin_property_add")
    public String add(Property property){
        propertyService.addProperty(property);
        return "redirect:admin_property_list?cid="+property.getCid();
    }

    @RequestMapping("admin_property_delete")
    public String delete(int id){
        int cid = propertyService.getProperty(id).getCid();
        propertyService.deleteProperty(id);
        return "redirect:admin_property_list?cid="+cid;
    }

    @RequestMapping("admin_property_edit")
    public String edit(int id,Model model){
        Property property = propertyService.getProperty(id);
        property.setCategory(categoryService.getCategory(property.getCid()));

        model.addAttribute("p",property);
        return "admin/editProperty";
    }

    @RequestMapping("admin_property_update")
    public String update(Property property){
        propertyService.updateProperty(property);
        return "redirect:admin_property_list?cid="+property.getCid();
    }
}
