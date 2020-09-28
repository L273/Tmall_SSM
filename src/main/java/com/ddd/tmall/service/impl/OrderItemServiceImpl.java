package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.OrderItemMapper;
import com.ddd.tmall.pojo.Order;
import com.ddd.tmall.pojo.OrderItem;
import com.ddd.tmall.pojo.OrderItemExample;
import com.ddd.tmall.pojo.Product;
import com.ddd.tmall.service.OrderItemService;
import com.ddd.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemServiceImpl implements OrderItemService {

    @Autowired
    OrderItemMapper orderItemMapper;

    @Autowired
    ProductService productService;

    @Override
    public List<OrderItem> list() {
        return null;
    }

    @Override
    public OrderItem get(int id) {
        OrderItem orderItem = orderItemMapper.selectByPrimaryKey(id);
        setProduct(orderItem);
        return orderItem;
    }

    @Override
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(OrderItem orderItem) {
        orderItemMapper.insertSelective(orderItem);
    }

    private void setProduct(List<OrderItem> os){
        for (OrderItem orderItem:os ) {
            setProduct(orderItem);
        }
    }

    private void setProduct(OrderItem orderItem){
        Product p = productService.getProduct(orderItem.getPid());
        orderItem.setProduct(p);
    }


    @Override
    public void update(OrderItem orderItem) {
        orderItemMapper.updateByPrimaryKey(orderItem);
    }


    //得到订单相关联的产品的数量
    @Override
    public int getSaleCount(int pid) {
        OrderItemExample example = new OrderItemExample();
        example.createCriteria().andPidEqualTo(pid);

        int result = 0;

        for (OrderItem oi:
             orderItemMapper.selectByExample(example)) {
            //累计每张订单内的交易数额
            result += oi.getNumber();
        }

        return result;
    }

    @Override
    public List<OrderItem> listByUser(int uid) {
        OrderItemExample example = new OrderItemExample();
        example.createCriteria().andUidEqualTo(uid);
        example.setOrderByClause("id desc");

        List<OrderItem> ps = orderItemMapper.selectByExample(example);

        setProduct(ps);

        return ps;
    }
}
