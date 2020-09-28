package com.ddd.tmall.util.Comparator;

import com.ddd.tmall.pojo.Product;

import java.util.Comparator;

public class ProductReviewComparator implements Comparator<Product> {
    //倒叙的Review
    @Override
    public int compare(Product o1, Product o2) {
        return o2.getReviewCount()-o1.getReviewCount();
    }
}
