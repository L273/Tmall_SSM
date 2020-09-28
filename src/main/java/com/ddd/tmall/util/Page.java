package com.ddd.tmall.util;

public class Page {
    private int start;
    private int count;
    private int total;
    private String param;

    //默认的起始页面，以及默认的第一页的位置
    private static int defaultStart = 0;
    private static int defaultCount = 5;

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public static int getDefaultStart() {
        return defaultStart;
    }

    public static int getDefaultCount() {
        return defaultCount;
    }

    public Page(){
        this.start = defaultStart;
        this.count = defaultCount;
    }

    public Page(int start,int count){
        this.start = start;
        this.count = count;
    }

    //判断是否还有前页
    public boolean isHasPreviouse(){
        if(this.start==0){
            return false;
        }else{
            return true;
        }
    }

    //判断是否还有后一页
    public boolean isHasNext(){
        if(this.start==this.getLast())
            return false;
        else
            return true;
    }

    //得到总的页数
    public int getTotalPage(){
        int totalPage;

        //刚好可以分页完成，还有分页最后一页有多的情况
        if(this.total%count==0)
            totalPage = total/count;
        else
            totalPage = total/count + 1;

        //如果没有，默认返回一页
        return totalPage == 0 ? 1 : totalPage;
    }

    //得到最后一页的start
    public int getLast(){
        int last;

        if(total%count==0) {
            last = total - count;
        }else{
            last = total - total % count;
        }
        //如果只有一页的话，可能total-count 得到负数。 就是一页的count=5，但是只有3条数据
        return last < 0 ? 0 : last;
    }

    @Override
    public String toString() {
        return "Page [start=" + this.start + ", count=" + this.count + ", total=" + this.total + ", getStart()=" + this.getStart()
                + ", getCount()=" + this.getCount() + ", isHasPreviouse()=" + this.isHasPreviouse() + ", isHasNext()="
                + this.isHasNext() + ", getTotalPage()=" + this.getTotalPage() + ", getLast()=" + this.getLast() + "]";
    }
}
