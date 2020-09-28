package com.ddd.tmall.service;

import com.ddd.tmall.pojo.Product;
import com.ddd.tmall.pojo.PropertyValue;

import java.util.List;

public interface PropertyValueService {
    public void init(Product product);
    public void update(PropertyValue propertyValue);

    public PropertyValue get(int ptid,int pid);
    public List<PropertyValue> list(int pid);
}
