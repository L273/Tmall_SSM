package com.ddd.tmall.service;

import com.ddd.tmall.pojo.Order;
import com.ddd.tmall.pojo.OrderItem;
import org.aspectj.weaver.ast.Or;

import java.util.List;

public interface OrderService {

    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";

    void add(Order c);
    void delete(int id);
    void update(Order c);

    Order get(int id);
    List<Order> list();
    List<Order> list(int uid,String excludedStatus);

    void fill(List<Order> orders);
    void fill(Order order);

    float add(Order order, List<OrderItem> orderItems);

}
