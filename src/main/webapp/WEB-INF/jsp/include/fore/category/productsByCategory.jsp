<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/26
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<div class="categoryProducts">
    <c:forEach items="${c.products}" var="p" varStatus="stc">
        <%--限制到200个--%>
        <c:if test="${stc.count<=200}">
            <%--设置price属性，供Jquery里使用--%>
            <div class="productUnit" price="${p.promotePrice}">

                <%--所有的超链接均是跳转到产品的详情页面--%>
                <div class="productUnitFrame">
                    <a href="foreproduct?pid=${p.id}">
                        <img class="productImage" src="img/productSingle_middle/${p.productImage.id}.jpg">
                    </a>
                    <span class="productPrice">
                        ¥<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/></span>
                    <a class="productLink" href="foreproduct?pid=${p.id}">
                            ${fn:substring(p.name, 0, 50)}
                    </a>

                    <a  class="tmallLink" href="foreproduct?pid=${p.id}">本产品的店铺</a>

                    <div class="show1 productInfo">
                        <span class="monthDeal ">月成交 <span class="productDealNumber">${p.saleCount}笔</span></span>
                        <span class="productReview">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
                        <span class="wangwang">
                            <%--旺旺的链接，暂时未设置--%>
                            <a class="wangwanglink" href="#nowhere">
                                <img src="img/site/wangwang.png">
                            </a>
                        </span>
                    </div>
                </div>

            </div>
        </c:if>
    </c:forEach>
    <div style="clear:both"></div>
</div>
