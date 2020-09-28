package com.ddd.tmall.util.Comparator;

import com.ddd.tmall.pojo.Product;

import java.util.Comparator;

public class ProductAllComparator implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {
        //销量和评论的数量一起作为评价的标准
        return o2.getSaleCount()*o2.getSaleCount()-o1.getSaleCount()*o1.getReviewCount();
    }
}
