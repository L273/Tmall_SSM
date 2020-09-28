package com.ddd.tmall.service;

import com.ddd.tmall.pojo.User;

import java.util.List;

public interface UserService {

    void add(User user);
    void delete(int id);
    void update(User user);

    public List<User> list();
    User get(int id);

    boolean isExitst(String name);

    User getUser(String name,String passwd);
}
