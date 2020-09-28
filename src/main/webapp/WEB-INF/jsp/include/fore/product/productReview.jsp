<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/26
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<div class="productReviewDiv" >

    <%--栏目中两个作为跳转的href--%>
    <div class="productReviewTopPart">
        <a  href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>

        <%--评价的标签，以及相关的数量--%>
        <%--selected 属性规定在页面加载时预先选定该选项。--%>
        <%--被预选的选项会显示在下拉列表最前面的位置。--%>
        <a  href="#nowhere" class="selected">累计评价 <span class="produc tReviewTopReviewLinkNumber">${p.reviewCount}</span> </a>
    </div>

    <div class="productReviewContentPart">

        <%--遍历该产品下的全部评价，并一一显示出来--%>
        <c:forEach items="${reviews}" var="r">
            <div class="productReviewItem">
                <%--倒叙显示内容的框--%>
                <div class="productReviewItemDesc">

                    <%--评价的内容--%>
                    <div class="productReviewItemContent">
                            ${r.content }
                    </div>

                    <%--评价的日期--%>
                    <div class="productReviewItemDate"><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd"/></div>
                </div>

                    <%--显示匿名，即处理过的名字，而不显示真实的名字--%>
                <div class="productReviewItemUserInfo">
                        ${r.user.anonymousName}<span class="userInfoGrayPart">（匿名）</span>
                </div>

                    <%--取消浮动显示，上下排列div--%>
                <div style="clear:both"></div>
            </div>
        </c:forEach>
    </div>

</div>
</html>
