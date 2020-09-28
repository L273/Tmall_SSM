<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/24
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="header.jsp"%>
<nav class="top">
    <a href="forehome">
        <span style="color: #C40000;margin: 0px" class="glyphicon glyphicon-home"></span>
        天猫首页
    </a>

    <span>喵，欢迎来到天猫</span>

    <%--后面这些用于有无用户的判断--%>

    <%--如果有用户，就显示里面的内容--%>
    <c:if test="${!empty user}">
        <a href="loginPage">${user.name}</a>
        <a href="forelogout">退出</a>
    </c:if>


    <%--反之，如果用户为空，则显示登录注册的超链接--%>
    <c:if test="${empty user}">
        <a href="loginPage">请登录</a>
        <a href="registerPage">免费注册</a>
    </c:if>


    <span class="pull-right">
            <a href="forebought">我的订单</a>
            <a href="forecart">
            <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
                <%--输出拦截器中存储在session中的值--%>
            购物车<strong>${cartTotalItemNumber}</strong>件</a>
        </span>
</nav>