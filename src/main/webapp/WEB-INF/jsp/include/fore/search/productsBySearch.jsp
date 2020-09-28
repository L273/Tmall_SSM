<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/26
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<div class="searchProducts">

    <%--对控制器传来的产品进行遍历--%>
    <c:forEach items="${ps}" var="p">

        <%--按照详情页内的productUnit一个一个展示结果--%>
    <div class="productUnit" price="${p.promotePrice}">
        <a href="foreproduct?pid=${p.id}">
            <img class="productImage" src="img/productSingle/${p.productImage.id}.jpg">
        </a>
        <span class="productPrice">
            ¥<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/></span>
        <a class="productLink" href="foreproduct?pid=${p.id}">
                ${fn:substring(p.name, 0, 50)}
        </a>

        <a class="tmallLink" href="foreproduct?pid=${p.id}">天猫专卖</a>

        <div class="productInfo">
            <span class="monthDeal ">月成交 <span class="productDealNumber">${p.saleCount}笔</span></span>
            <span class="productReview">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
            <span class="wangwang"><img src="img/site/wangwang.png"></span>
        </div>

    </div>
    </c:forEach>

        <%--如果从控制器传来的产品列表是空值，则直接输出没有产品--%>
    <c:if test="${empty ps}">
    <div class="noMatch">没有满足条件的产品</div>
        </c:if>

        <div style="clear:both"></div>
</div>