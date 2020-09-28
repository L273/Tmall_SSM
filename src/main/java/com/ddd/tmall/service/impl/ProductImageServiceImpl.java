package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.ProductImageMapper;
import com.ddd.tmall.pojo.ProductImage;
import com.ddd.tmall.pojo.ProductImageExample;
import com.ddd.tmall.service.ProductImageService;
import com.ddd.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductImageServiceImpl implements ProductImageService{

    @Autowired
    ProductImageMapper productImageMapper;

    @Override
    public List<ProductImage> list(int pid,String type) {
        ProductImageExample example = new ProductImageExample();
        example.createCriteria().andPidEqualTo(pid).andTypeEqualTo(type);
        example.setOrderByClause("id desc");
        return productImageMapper.selectByExample(example);
    }

    @Override
    public ProductImage get(int id) {
        return productImageMapper.selectByPrimaryKey(id);
    }

    @Override
    public void add(ProductImage productImage) {
        productImageMapper.insertSelective(productImage);
    }

    @Override
    public void delete(int id) {
        productImageMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(ProductImage productImage) {
        productImageMapper.updateByPrimaryKeySelective(productImage);
    }

}