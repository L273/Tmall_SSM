package com.ddd.tmall.util.Comparator;

import com.ddd.tmall.pojo.Product;

import java.util.Comparator;

public class ProductPriceComparator implements Comparator<Product> {
    @Override
    //价格肯定是从最便宜的开始选
    public int compare(Product o1, Product o2) {
        return (int)(o1.getPromotePrice()-o2.getPromotePrice());
    }
}
