package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.CategoryMapper;
import com.ddd.tmall.pojo.Category;
import com.ddd.tmall.pojo.CategoryExample;
import com.ddd.tmall.service.CategoryService;
import com.ddd.tmall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    CategoryMapper categoryMapper;

    @Override
    public List<Category> listCategroy() {
        CategoryExample example = new CategoryExample();
        example.setOrderByClause("id desc");
        return categoryMapper.selectByExample(example);
    }

    //    @Override
//    public List<Category> listCategroy(Page page) {
//        return categoryMapper.listCategory(page);
//    }

//    @Override
//    public int totalCategory() {
//        return categoryMapper.totalCategory();
//    }

    @Override
    public void addCategory(Category category) {
        categoryMapper.insert(category);
    }

    @Override
    public void deleteCategory(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Category getCategory(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateCategory(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }
}
