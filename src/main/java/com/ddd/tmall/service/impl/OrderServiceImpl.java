package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.OrderItemMapper;
import com.ddd.tmall.mapper.OrderMapper;
import com.ddd.tmall.pojo.*;
import com.ddd.tmall.service.OrderService;
import com.ddd.tmall.service.ProductService;
import com.ddd.tmall.service.UserService;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderItemMapper orderItemMapper;

    @Autowired
    OrderMapper orderMapper;

    @Autowired
    ProductService productService;

    @Autowired
    UserService userService;

    @Override
    public void fill(List<Order> orders) {
        for (Order order:orders) {
            fill(order);
        }
    }

    @Override
    public List<Order> list() {
        OrderExample example = new OrderExample();
        example.setOrderByClause("id desc");
        List<Order> result = orderMapper.selectByExample(example);

        //多对一赋值
        fill(result);

        return  result;
    }


    @Override
    public List<Order> list(int uid, String excludedStatus) {
        OrderExample example = new OrderExample();

        //移除那些标记为删除的订单
        example.createCriteria().andUidEqualTo(uid).andOrderStatusNotEqualTo(excludedStatus);
        example.setOrderByClause("id desc");

        List<Order> orders = orderMapper.selectByExample(example);
        fill(orders);

        return orders;
    }

    @Override
    public Order get(int id) {
        Order order = orderMapper.selectByPrimaryKey(id);
        fill(order);
        return order;
    }

    @Override
    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(Order c) {
        orderMapper.insert(c);
    }


    //添加事物回滚的机制
    //若SQL语句出现异常，则进行回滚。
    @Override
    @Transactional(propagation = Propagation.REQUIRED,rollbackForClassName = "Exception")
    public float add(Order order, List<OrderItem> orderItems) {
        float total = 0;

        //先将order加入数据库
        add(order);

        for (OrderItem orderItem:orderItems){
            //将订单的id丢到orderItem中
            orderItem.setOid(order.getId());
            orderItemMapper.updateByPrimaryKey(orderItem);
            //累计价格
            total += orderItem.getProduct().getPromotePrice()*orderItem.getNumber();
        }

        //返回总价，提供支付
        return total;
    }

    @Override
    public void update(Order c) {
        orderMapper.updateByPrimaryKey(c);
    }


    @Override
    public void fill(Order order) {
        OrderItemExample example = new OrderItemExample();

        //通过oid来查找相关的订单项目
        example.createCriteria().andOidEqualTo(order.getId());
        example.setOrderByClause("id desc");
        List<OrderItem> orderItems = orderItemMapper.selectByExample(example);

        //为OrderItem内的Product赋值，多对一赋值
        setProduct(orderItems);

        float total = 0;
        int totalNumber = 0;

        //遍历订单项目里的全部项目，并获取个数、同时由关联的Product得到数据后计算
        //同时遍历一个item即一个订单，就可以生成一个订单项目
        for(OrderItem orderItem:orderItems){
            //计算订单的全部金额
            total += orderItem.getNumber()*orderItem.getProduct().getPromotePrice();

            //可计算购买商品的数额
            totalNumber += orderItem.getNumber();
        }

        order.setTotal(total);
        order.setTotalNumber(totalNumber);
        order.setOrderItemList(orderItems);
        setUser(order);
    }

    private void setUser(Order order){
        order.setUser(userService.get(order.getUid()));
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


}
