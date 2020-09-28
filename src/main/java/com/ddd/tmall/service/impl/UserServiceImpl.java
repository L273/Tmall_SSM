package com.ddd.tmall.service.impl;

import com.ddd.tmall.mapper.UserMapper;
import com.ddd.tmall.pojo.User;
import com.ddd.tmall.pojo.UserExample;
import com.ddd.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> list() {
        UserExample example = new UserExample();
        example.setOrderByClause("id desc");
        return userMapper.selectByExample(example);
    }

    @Override
    public User get(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public void delete(int id) {
        userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(User user) {
        userMapper.insertSelective(user);
    }

    @Override
    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public boolean isExitst(String name) {
        UserExample example = new UserExample();
        example.createCriteria().andNameEqualTo(name);
        if(userMapper.selectByExample(example).isEmpty())
            return false;
        return true;
    }

    @Override
    public User getUser(String name,String passwd) {
        UserExample example = new UserExample();
        example.createCriteria().andNameEqualTo(name).andPasswordEqualTo(passwd);
        return userMapper.selectByExample(example).get(0);
    }
}
