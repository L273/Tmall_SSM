package com.ddd.tmall.service;

import com.ddd.tmall.pojo.Property;

import java.util.List;

public interface PropertyService{
    public void addProperty(Property property);
    public void deleteProperty(int id);
    public void updateProperty(Property property);

    public Property getProperty(int id);

    //可能会查某个分类的list，所以有需要cid查询的情况
    public List listProperty(int cid);
}