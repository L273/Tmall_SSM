package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.Category;
import com.ddd.tmall.pojo.Product;
import com.ddd.tmall.service.CategoryService;
import com.ddd.tmall.service.ProductService;
import com.ddd.tmall.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductController {

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductService productService;

    @RequestMapping("admin_product_list")
    public String list(Page page, Model model,int cid){
        Category category = categoryService.getCategory(cid);
        //分页
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Product> ps = productService.listProduct(cid);

        page.setTotal((int)new PageInfo<>(ps).getTotal());

        model.addAttribute("ps",ps);
        model.addAttribute("category",category);
        model.addAttribute("page",page);

        return "admin/listProduct";
    }

    @RequestMapping("admin_product_add")
    public String add(Product product){
        product.setCreateDate(new Date());
        productService.addProduct(product);
        return "redirect:admin_product_list?cid="+product.getCid();
    }

    @RequestMapping("admin_product_delete")
    public String delete(int id){
        int cid = productService.getProduct(id).getCid();
        productService.deleteProduct(id);
        return "redirect:admin_product_list?cid="+cid;
    }

    @RequestMapping("admin_product_edit")
    public String edit(int id,Model model){
        Product product = productService.getProduct(id);
        model.addAttribute("p",product);
        return "admin/editProduct";
    }

    @RequestMapping("admin_product_update")
    public String update(Product product){
        product.setCreateDate(new Date());
        productService.update(product);
        return "redirect:admin_product_list?cid="+product.getCid();
    }
}
