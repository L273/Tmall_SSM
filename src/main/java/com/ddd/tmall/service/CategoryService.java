package com.ddd.tmall.service;

import com.ddd.tmall.pojo.Category;
import com.ddd.tmall.util.Page;

import java.util.List;

public interface CategoryService {
    public List<Category> listCategroy();
//    public List<Category> listCategroy(Page page);
//    public int totalCategory();
    public void addCategory(Category category);
    public void deleteCategory(int id);
    public Category getCategory(int id);
    public void updateCategory(Category category);
}
