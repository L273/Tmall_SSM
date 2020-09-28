package com.ddd.tmall.util.Comparator;

import com.ddd.tmall.pojo.Product;

import java.util.Comparator;

public class ProductDateComparator implements Comparator<Product>{
    //时间戳是从1970到现在的毫秒数
    //时间戳越大，数字越大

    @Override
    public int compare(Product o1, Product o2) {
        //相当于o2-o1
        return o2.getCreateDate().compareTo(o1.getCreateDate());
    }
}
