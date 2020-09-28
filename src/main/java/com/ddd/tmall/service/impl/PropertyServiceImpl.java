package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.PropertyMapper;
import com.ddd.tmall.pojo.Property;
import com.ddd.tmall.pojo.PropertyExample;
import com.ddd.tmall.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyServiceImpl implements PropertyService{

    @Autowired
    PropertyMapper propertyMapper;

    @Override
    public List listProperty(int cid) {
        PropertyExample propertyExample = new PropertyExample();
        propertyExample.createCriteria().andCidEqualTo(cid);
        propertyExample.setOrderByClause("id desc");
        return propertyMapper.selectByExample(propertyExample);
    }

    @Override
    public Property getProperty(int id) {
        return propertyMapper.selectByPrimaryKey(id);
    }

    @Override
    public void addProperty(Property property) {
        propertyMapper.insertSelective(property);
    }

    @Override
    public void updateProperty(Property property) {
        propertyMapper.updateByPrimaryKeySelective(property);
    }

    @Override
    public void deleteProperty(int id) {
        propertyMapper.deleteByPrimaryKey(id);
    }
}
