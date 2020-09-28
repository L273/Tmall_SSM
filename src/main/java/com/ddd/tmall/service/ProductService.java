package com.ddd.tmall.service;

import com.ddd.tmall.pojo.Category;
import com.ddd.tmall.pojo.Product;

import java.util.List;

public interface ProductService {
    public void addProduct(Product product);
    public void deleteProduct(int id);
    public void update(Product product);

    public Product getProduct(int id);
    public List<Product> listProduct(int cid);

    void fill(List<Category> cs);
    void fill(Category c);
    void fillByRow(List<Category> cs);

    void setSaleAndReviewNumber(Product product);
    void setSaleAndReviewNumber(List<Product> products);

    List<Product> search(String keyword);
}
