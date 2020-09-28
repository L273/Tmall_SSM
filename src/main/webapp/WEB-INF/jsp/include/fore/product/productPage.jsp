<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/25
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<%--用产品的名字作为标题--%>
<title>${p.name}</title>

<%--放详情页的展示图--%>
<div class="categoryPictureInProductPageDiv">
    <img class="categoryPictureInProductPage" src="img/category/${p.category.id}.jpg">
</div>


<div class="productPageDiv">
    <%@include file="imgAndInfo.jsp" %>

    <%@include file="productReview.jsp" %>

    <%@include file="productDetail.jsp" %>
</div>
