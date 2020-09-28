package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.ReviewMapper;
import com.ddd.tmall.mapper.UserMapper;
import com.ddd.tmall.pojo.Review;
import com.ddd.tmall.pojo.ReviewExample;
import com.ddd.tmall.service.ReviewService;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    ReviewMapper reviewMapper;

    @Autowired
    UserMapper userMapper;

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Review get(int id) {
        Review re = reviewMapper.selectByPrimaryKey(id);
        re.setUser(userMapper.selectByPrimaryKey(re.getPid()));
        return re;
    }

    @Override
    public List<Review> list(int pid) {
        ReviewExample example = new ReviewExample();
        example.createCriteria().andPidEqualTo(pid);
        example.setOrderByClause("id desc");
        List<Review> ls = reviewMapper.selectByExample(example);
        setUser(ls);
        return ls;
    }

    @Override
    public int getCount(int pid) {
        return list(pid).size();
    }

    @Override
    public void add(Review review) {
        reviewMapper.insertSelective(review);
    }

    @Override
    public void update(Review review) {
        reviewMapper.updateByPrimaryKey(review);
    }

    private void setUser(List<Review> reviews){
        for (Review r:reviews) {
            r.setUser(userMapper.selectByPrimaryKey(r.getPid()));
        }
    }
}