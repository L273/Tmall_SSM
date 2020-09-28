<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/28
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<div class="reviewDiv">
    <div class="reviewProductInfoDiv">
        <div class="reviewProductInfoImg"><img width="400px" height="400px" src="img/productSingle/${p.productImage.id}.jpg"></div>
        <div class="reviewProductInfoRightDiv">
            <div class="reviewProductInfoRightText">
                ${p.name}
            </div>
            <table class="reviewProductInfoTable">
                <tr>
                    <td width="75px">价格:</td>
                    <td><span class="reviewProductInfoTablePrice">￥<fmt:formatNumber type="number" value="${p.originalPrice}" minFractionDigits="2"/></span> 元 </td>
                </tr>
                <tr>
                    <td>配送</td>
                    <td>快递:  0.00</td>
                </tr>
                <tr>
                    <td>月销量:</td>
                    <td><span class="reviewProductInfoTableSellNumber">${p.saleCount}</span> 件</td>
                </tr>
            </table>

            <div class="reviewProductInfoRightBelowDiv">
                <span class="reviewProductInfoRightBelowImg"><img1 src="img/site/reviewLight.png"></span>
                <span class="reviewProductInfoRightBelowText" >现在查看的是 您所购买商品的信息
于<fmt:formatDate value="${o.createDate}" pattern="yyyy年MM月dd"/>下单购买了此商品 </span>

            </div>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="reviewStasticsDiv">
        <div class="reviewStasticsLeft">
            <div class="reviewStasticsLeftTop"></div>
            <div class="reviewStasticsLeftContent">累计评价 <span class="reviewStasticsNumber"> ${p.reviewCount}</span></div>
            <div class="reviewStasticsLeftFoot"></div>
        </div>
        <div class="reviewStasticsRight">
            <div class="reviewStasticsRightEmpty"></div>
            <div class="reviewStasticsFoot"></div>
        </div>
    </div>

    <%--反之，评价过后，这个值就会设置为true--%>
    <%--用户就可以在这里看到评价的信息--%>
    <c:if test="${param.showonly==true}">
        <div class="reviewDivlistReviews">
            <c:forEach items="${reviews}" var="r">
                <div class="reviewDivlistReviewsEach">
                    <div class="reviewDate"><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd"/></div>
                    <div class="reviewContent">${r.content}</div>
                    <div class="reviewUserInfo pull-right">${r.user.anonymousName}<span class="reviewUserInfoAnonymous">(匿名)</span></div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <%--评价页面显示的功能不完善，因为用户可以二次评价--%>


    <%--当用户没有评价的时候，就没有进入评价确认的控制器--%>
    <%--此时的shownly为false因为没有设置--%>
    <c:if test="${param.showonly!=true}">
        <div class="makeReviewDiv">
            <form method="post" action="foredoreview">
                <div class="makeReviewText">其他买家，需要你的建议哦！</div>
                <table class="makeReviewTable">
                    <tr>
                        <td class="makeReviewTableFirstTD">评价商品</td>
                        <td><textarea name="content"></textarea></td>
                    </tr>
                </table>
                <div class="makeReviewButtonDiv">
                    <input type="hidden" name="oid" value="${o.id}">
                    <input type="hidden" name="pid" value="${p.id}">
                    <button type="submit">提交评价</button>
                </div>
            </form>
        </div>
    </c:if>

</div>
