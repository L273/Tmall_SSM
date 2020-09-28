package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.CategoryMapper;
import com.ddd.tmall.mapper.ProductMapper;
import com.ddd.tmall.mapper.ReviewMapper;
import com.ddd.tmall.pojo.*;
import com.ddd.tmall.service.OrderItemService;
import com.ddd.tmall.service.ProductImageService;
import com.ddd.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    CategoryMapper categoryMapper;

    @Autowired
    ProductMapper productMapper;

    @Autowired
    ProductImageService productImageService;

    @Autowired
    OrderItemService orderItemService;

    @Autowired
    ReviewMapper reviewMapper;

    @Override
    public List<Product> listProduct(int cid) {
        ProductExample example = new ProductExample();
        example.createCriteria().andCidEqualTo(cid);

        //为列表内的Product赋值
        return setCategory(productMapper.selectByExample(example));
    }

    private List<Product> setCategory(List<Product> ps){
        for (Product p: ps) {
            p.setCategory(categoryMapper.selectByPrimaryKey(p.getCid()));
        }

        //为产品添加图片
        setProductImage(ps);

        return ps;
    }

    private void setProductImage(List<Product> ps){
        for (Product p: ps) {
            //默认取第一张图
            p.setProductImage(
                    productImageService.list(p.getId(),ProductImageService.type_single).size()!=0
                            ? productImageService.list(p.getId(),ProductImageService.type_single).get(0) : null);
        }
    }

    @Override
    public Product getProduct(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        product.setCategory(categoryMapper.selectByPrimaryKey(product.getCid()));

        //默认存放第一张图
        product.setProductImage(productImageService.list(id,productImageService.type_single).get(0));


        return product;
    }

    @Override
    public void addProduct(Product product) {
        productMapper.insertSelective(product);
    }

    @Override
    public void deleteProduct(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKeySelective(product);
    }


    @Override
    public void fill(List<Category> cs) {
        for (Category c:cs) {
            this.fill(c);
        }
    }

    @Override
    public void fill(Category c) {
        c.setProducts(listProduct(c.getId()));
    }

    @Override
    public void fillByRow(List<Category> cs) {
        int productNumberEachRow = 8;
        for(Category c:cs){
            List<Product> products = c.getProducts();
            List<List<Product>> productsByRow = new ArrayList<>();

            //对整体的products进行切片。
            for (int i = 0; i < products.size(); i += productNumberEachRow) {
                    int size = i + productNumberEachRow;

                    //如果按照一行8个的截取，到了最后一行，不及8个，就用原大小
                    //size是最后一个元素的浮标位置
                    size = size > products.size() ? products.size() : size;
                    productsByRow.add(products.subList(i,size));
                }
                c.setProductsByRow(productsByRow);
            }
        }

    @Override
    public void setSaleAndReviewNumber(Product product) {
        product.setSaleCount(orderItemService.getSaleCount(product.getId()));
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.setOrderByClause("id desc");
        product.setReviewCount(reviewMapper.selectByExample(reviewExample).size());
    }

    @Override
    public void setSaleAndReviewNumber(List<Product> products) {
        for (Product product:products) {
            setSaleAndReviewNumber(product);
        }
    }

    @Override
    public List<Product> search(String keyword) {
        ProductExample example = new ProductExample();
        //配置模糊查询的表达式
        example.createCriteria().andNameLike("%"+keyword+"%");
        example.setOrderByClause("id desc");
        List<Product> result = productMapper.selectByExample(example);
        setProductImage(result);
        return result;
    }
}
