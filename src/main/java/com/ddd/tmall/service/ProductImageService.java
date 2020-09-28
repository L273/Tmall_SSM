package com.ddd.tmall.service;

import com.ddd.tmall.pojo.ProductImage;
import jdk.nashorn.internal.runtime.regexp.joni.constants.StringType;

import java.util.List;

public interface ProductImageService  {

    String type_single = "type_single";
    String type_detail = "type_detail";

    public void add(ProductImage productImage);
    public void delete(int id);
    public void update(ProductImage productImage);

    public ProductImage get(int id);
    public List<ProductImage> list(int pid,String type);

}
