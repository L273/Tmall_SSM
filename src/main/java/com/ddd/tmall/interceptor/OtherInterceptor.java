package com.ddd.tmall.interceptor;

import com.ddd.tmall.pojo.OrderItem;
import com.ddd.tmall.pojo.User;
import com.ddd.tmall.service.CategoryService;
import com.ddd.tmall.service.OrderItemService;
import com.ddd.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class OtherInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    UserService userService;

    @Autowired
    OrderItemService orderItemService;

    @Autowired
    CategoryService categoryService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //允许到下一个拦截器。
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        //jsp生成之前，也称视图渲染之前
        //需要preHandle返回true
        HttpSession session = request.getSession();
        String contextPath = session.getServletContext().getContextPath();

        session.setAttribute("contextPath",contextPath);
        session.setAttribute("cs",categoryService.listCategroy());

        //这里是购物车中一共有多少数量
        User user = (User) session.getAttribute("user");
        int cartTotalItemNumber = 0;
        if(user!=null){
            //由于是数据库中取出的user，所以是有uid值的。
            List<OrderItem> orderItemList = orderItemService.listByUser(user.getId());

            //若有值的话
            if(!orderItemList.isEmpty()){
                for(OrderItem orderItem:orderItemList){
                    //统计购物车内的数量
                    cartTotalItemNumber += orderItem.getNumber();
                }
            }
        }

        //用于存储订单项的数目，用于在购物车显示
        request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);

    }

}
