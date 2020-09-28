package com.ddd.tmall.service;

import com.ddd.tmall.pojo.Order;
import com.ddd.tmall.pojo.OrderItem;
import com.ddd.tmall.pojo.Product;

import java.util.List;

public interface OrderItemService {
    public void add(OrderItem orderItem);
    public void delete(int id);
    public void update(OrderItem orderItem);

    public OrderItem get(int id);
    public List<OrderItem> list();

    int getSaleCount(int pid);

    List<OrderItem> listByUser(int uid);
}
