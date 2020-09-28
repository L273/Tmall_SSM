package com.ddd.tmall.interceptor;

import com.ddd.tmall.pojo.User;
import com.ddd.tmall.service.OrderItemService;
import com.ddd.tmall.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class LoginInterceptor extends HandlerInterceptorAdapter{
    @Autowired
    OrderItemService orderItemService;

    @Autowired
    UserService userService;


    /*
    如果返回false
        从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
    如果返回true
       执行下一个拦截器,直到所有的拦截器都执行完毕
     */

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //先通过request获得Session
        HttpSession session = request.getSession();
        String contextPath = session.getServletContext().getContextPath();
        //与订单操作无关的页面，均被省略
        String[] noNeedAuthPage = new String[]{
                "home",
                "checkLogin",
                "register",
                "loginAjax",
                "login",
                "product",
                "category",
                "search"};

        String uri = request.getRequestURI();

//        将rui中的路径去掉
        uri = StringUtils.remove(uri, contextPath);

        if (uri.startsWith("/fore")) {
            //从后开始取，取字符串/fore后的内容
            String method = StringUtils.substringAfterLast(uri, "/fore");

            //对于不在noNeedAuthPage内的字符串进行检查
            if (!Arrays.asList(noNeedAuthPage).contains(method)) {
                User user = (User) session.getAttribute("user");

                //如果没有在session中找到user，就跳转到登录目录
                //loginPage的映射位于PageController
                if (user == null) {
                    response.sendRedirect("loginPage");
                    return false;
                }
            }
        }

        return true;
    }
}
