package com.ddd.tmall.controller;

import com.ddd.tmall.pojo.Product;
import com.ddd.tmall.pojo.ProductImage;
import com.ddd.tmall.service.ProductImageService;
import com.ddd.tmall.service.ProductService;
import com.ddd.tmall.util.ImageUtil;
import com.ddd.tmall.util.UploadedImageFile;
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
public class ProductImageController {

    @Autowired
    ProductImageService productImageService;

    @Autowired
    ProductService productService;

    @RequestMapping("admin_productImage_list")
    public String list(int pid, Model model) {
        Product p = productService.getProduct(pid);
        List<ProductImage> pisSingle = productImageService.list(pid,productImageService.type_single);
        List<ProductImage> pisDetail = productImageService.list(pid,productImageService.type_detail);

        model.addAttribute("p",p);
        model.addAttribute("pisSingle",pisSingle);
        model.addAttribute("pisDetail",pisDetail);

        return "admin/listProductImage";
    }

    @RequestMapping("admin_productImage_add")
    public String add(UploadedImageFile uploadedImageFile,HttpSession session,ProductImage productImage)
        throws IOException{

        productImageService.add(productImage);

        String imageFloder;

        String imageFloader_small = null;
        String imageFloader_middle = null;
        if(productImage.getType().equals(ProductImageService.type_single)){
            //单张图片的时候，存三个地方
            imageFloder = session.getServletContext().getRealPath("img/productSingle");

            imageFloader_middle = session.getServletContext().getRealPath("img/productSingle_middle");
            imageFloader_small = session.getServletContext().getRealPath("img/productSingle_small");

        }else{
            //详情图的时候，就存一个地方
            imageFloder = session.getServletContext().getRealPath("img/productDetail");
        }

        File file = new File(imageFloder,productImage.getId()+".jpg");

        if(!file.getParentFile().exists())
            file.getParentFile().mkdirs();

        uploadedImageFile.getImage().transferTo(file);

        //对jpg进行处理
        BufferedImage img = ImageUtil.change2jpg(file);

        ImageIO.write(img,"jpg",file);

        //如果是单张图片，另外两张小图也要处理
        if(productImage.getType().equals(ProductImageService.type_single)){
            File small = new File(imageFloader_small,productImage.getId()+".jpg");
            File middle = new File(imageFloader_middle,productImage.getId()+".jpg");

            ImageUtil.resizeImage(file,56,56,small);
            ImageUtil.resizeImage(file,217,190,middle);
        }

        return "redirect:admin_productImage_list?pid="+productImage.getPid();
    }

    @RequestMapping("admin_productImage_delete")
    public String delete(int id,HttpSession session){
        ProductImage productImage = productImageService.get(id);

        String imgageFloder;

        String imageFloader_small = null;
        String imageFloader_middle = null;
        if(productImage.getType().equals(ProductImageService.type_single)) {
            imgageFloder = session.getServletContext().getRealPath("img/productSingle");

            imageFloader_middle = session.getServletContext().getRealPath("img/productSingle_middle");
            imageFloader_small = session.getServletContext().getRealPath("img/productSingle_small");
        }else{
            imgageFloder = session.getServletContext().getRealPath("img/productDetail");
        }

        File file = new File(imgageFloder,productImage.getId()+".jpg");

        file.delete();

        //如果是单张图片，另外两张小图也要处理
        if(productImage.getType().equals(ProductImageService.type_single)){
            File small = new File(imageFloader_small,productImage.getId()+".jpg");
            File middle = new File(imageFloader_middle,productImage.getId()+".jpg");

            small.delete();
            middle.delete();
        }
        productImageService.delete(id);

        return "redirect:admin_productImage_list?pid="+productImage.getPid();
    }


}
