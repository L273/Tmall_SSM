<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/26
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<div class="productDetailDiv" >
    <div class="productDetailTopPart">

        <%--利用selected标签，来选择当前的显示界面--%>
        <a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
        <a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span class="productDetailTopReviewLinkNumber">${p.reviewCount}</span> </a>
    </div>


    <div class="productParamterPart">
        <div class="productParamter">产品参数：</div>

        <%--显示全部的产品参数--%>
        <div class="productParamterList">
            <c:forEach items="${pvs}" var="pv">
                <span>${pv.property.name}:  ${fn:substring(pv.value, 0, 10)} </span>
            </c:forEach>
        </div>

        <div style="clear:both"></div>
    </div>

    <%--竖向排列产品的详情图片--%>
    <div class="productDetailImagesPart">
        <c:forEach items="${p.productDetailImages}" var="pi">
            <%--${pi.id}--%>
            <img src="img/productDetail/${pi.id+5}.jpg">
        </c:forEach>
    </div>
</div>
