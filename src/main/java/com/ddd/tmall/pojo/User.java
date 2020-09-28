package com.ddd.tmall.pojo;

public class User {
    private Integer id;

    private String name;

    private String password;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }


    /*
    =========================添加的非数据库字段================================
     */

    public String getAnonymousName(){
        //分长度为1     返回：*
        //长度为2       返回：x*
        //d大于等于2    返回：x*****y

        if(name==null)
            return null;

        if(name.length()<=1)
            return "*";

        if(name.length()==2)
            return name.charAt(0)+"*";


        char[] cs = name.toCharArray();
        for (int i = 1; i < name.length()-1; i++) {
            cs[i]='*';
        }
        return new String(cs);
    }

}