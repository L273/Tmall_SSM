package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.PropertyValueMapper;
import com.ddd.tmall.pojo.Product;
import com.ddd.tmall.pojo.Property;
import com.ddd.tmall.pojo.PropertyValue;
import com.ddd.tmall.pojo.PropertyValueExample;
import com.ddd.tmall.service.PropertyService;
import com.ddd.tmall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyValueServiceImpl implements PropertyValueService{

    @Autowired
    PropertyValueMapper propertyValueMapper;

    @Autowired
    PropertyService propertyService;

    @Override
    public List<PropertyValue> list(int pid) {
        PropertyValueExample example = new PropertyValueExample();
        example.createCriteria().andPidEqualTo(pid);
        List<PropertyValue> pvs = propertyValueMapper.selectByExample(example);
        for (PropertyValue pv: pvs) {
            //为pojo内的Projoerty非数据库段的数据进行赋值
            pv.setProperty(propertyService.getProperty(pv.getPtid()));
        }
        return pvs;
    }

    @Override
    public PropertyValue get(int ptid, int pid) {
        PropertyValueExample example = new PropertyValueExample();
        example.createCriteria().andPidEqualTo(pid).andPtidEqualTo(ptid);
        return propertyValueMapper.selectByExample(example).size()!=0 ?
                propertyValueMapper.selectByExample(example).get(0) : null;
    }

    @Override
    public void init(Product product) {
        //查询同一分类下的属性
        List<Property> ps = propertyService.listProperty(product.getCid());

        for (Property pt:ps) {
            PropertyValue pv = get(pt.getId(),product.getId());
            if(pv==null){
                pv = new PropertyValue();
                pv.setPid(product.getId());
                pv.setPtid(pt.getId());
                propertyValueMapper.insert(pv);
            }
        }
    }

    @Override
    public void update(PropertyValue propertyValue) {
        propertyValueMapper.updateByPrimaryKey(propertyValue);
    }

}
