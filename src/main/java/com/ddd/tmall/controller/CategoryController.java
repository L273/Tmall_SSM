package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.Category;
import com.ddd.tmall.service.CategoryService;
import com.ddd.tmall.util.ImageUtil;
import com.ddd.tmall.util.Page;
import com.ddd.tmall.util.UploadedImageFile;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_category_list")
    public String list(Model model,Page page){
        //用插件得到分页的偏移量，写第一行，不然写后面可能第一次加载页面的时候，不会有分页的效果
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Category> cs = categoryService.listCategroy();

        //用插件得到页面的总数
        page.setTotal((int)new PageInfo<>(cs).getTotal());

        model.addAttribute("cs",cs);
        model.addAttribute("page",page);

        //“admin/listCategory” 会根据后续的springMVC.xml 配置文件，跳转到 WEB-INF/jsp/admin/listCategory.jsp 文件
        return "admin/listCategory";
    }

//    @RequestMapping("admin_category_list")
//    public String list(Model model, Page page){
//        List<Category> cs = categoryService.listCategroy(page);
//
//        int total = categoryService.totalCategory();
//
//        page.setTotal(total);
//        model.addAttribute("cs",cs);
//        model.addAttribute("page",page);
//
//        //“admin/listCategory” 会根据后续的springMVC.xml 配置文件，跳转到 WEB-INF/jsp/admin/listCategory.jsp 文件
//        return "admin/listCategory";
//    }

    @RequestMapping("admin_category_add")
    public String add(Category category, HttpSession httpSession, UploadedImageFile uploadedImageFile)
        throws IOException{

        //先将category加入数据库
        categoryService.addCategory(category);

        File imageFolder = new File(httpSession.getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder,category.getId()+".jpg");
        //得到文件对象，并创造新文件
        if(!file.getParentFile().exists())
            file.getParentFile().mkdirs();

        //将得到的image数据流传入文件中
        uploadedImageFile.getImage().transferTo(file);

        //将文件流转成jpg的格式
        BufferedImage bufferedImage = ImageUtil.change2jpg(file);

        //将文件写入文件中
        ImageIO.write(bufferedImage,"jpg",file);

        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_delete")
    public String delete(int id,HttpSession session){
        categoryService.deleteCategory(id);

        File imageFolder = new File(session.getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder,id+".jpg");

        file.delete();

        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_edit")
    public String edit(int id, Model model){
        Category category = categoryService.getCategory(id);
        model.addAttribute("category",category);
        return "admin/editCategory";
    }

    @RequestMapping("admin_category_update")
    public String update(Category category,HttpSession session,UploadedImageFile uploadedImageFile)
        throws IOException{
        //修改数据库里的数据
        categoryService.updateCategory(category);

        //修改图片
        File imageFloder = new File(session.getServletContext().getRealPath("img/category"));
        File file = new File(imageFloder,category.getId()+".jpg");
        file.delete();

        //读取上传的图片多块
        uploadedImageFile.getImage().transferTo(file);

        //修复jpg，使其正常显示
        BufferedImage img = ImageUtil.change2jpg(file);

        ImageIO.write(img,"jpg",file);

        return "redirect:/admin_category_list";

    }
}
