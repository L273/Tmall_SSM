<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/24
  Time: 18:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<title>用户管理</title>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function () {
        //当点击详情的按钮之后
        $("button.orderPageCheckItems").click(function () {
            var oid = $(this).attr("oid");

            //tr标签下的orderPageOrderItemTR内的id为oid的标签进行切换
            $("tr.orderPageOrderItemTR[oid="+oid+"]").toggle();
        });
    });
</script>

<div class="workingArea">
    <h1 class="label-info label">订单管理</h1>
    <br>
    <br>
    <table class="table table-bordered table-striped table-hover table-condensed">
        <thead>
            <tr class="success">
                <th>ID</th>
                <th>状态</th>
                <th>金额</th>
                <th width="100px">商品数量</th>
                <th width="100px">买家名称</th>
                <th>创建时间</th>
                <th>支付时间</th>
                <th>发货时间</th>
                <th>确认收货时间</th>
                <th width="120px">操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${os}" var="o">
                <tr>
                    <td>${o.id}</td>
                    <td>${o.status}</td>
                    <td>
                        <fmt:formatNumber  type="number" value="${o.total}" minFractionDigits="2"></fmt:formatNumber>
                    </td>
                    <td align="center">${o.totalNumber}</td>
                    <td align="center">${o.user.name}</td>
                    <td>
                        <fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>
                    <td>
                        <fmt:formatDate value="${o.payDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>
                    <td>
                        <fmt:formatDate value="${o.deliverDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>
                    <td>
                        <fmt:formatDate value="${o.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>

                    <td>
                        <button oid="${o.id}" class="orderPageCheckItems btn btn-primary btn-xs">查看详情</button>
                        <c:if test="${o.orderStatus=='waitDelivery'}">
                            <a href="admin_order_delivery?id=${o.id}">
                                <button class="btn btn-primary btn-xs">发货</button>
                            </a>
                        </c:if>
                    </td>
                </tr>

                <tr class="orderPageOrderItemTR" oid="${o.id}">
                    <td colspan="10" align="center">
                        <div class="orderPageOrderItem">
                            <table width="800px" align="center" class="orderPageOrderItemTable">
                                <c:forEach items="${o.orderItemList}" var="orderItem">
                                    <tr>
                                        <td align="left">
                                            <img src="img/productSingle/${orderItem.product.productImage.id}.jpg" height="40px">
                                            <%--${orderItem.product.productImage.id}--%>
                                        </td>
                                        <td>
                                            <a href="admin_productImage_list?pid=${orderItem.product.id}">
                                                <span>${orderItem.product.name}</span>
                                            </a>
                                        </td>
                                        <td align="right">
                                            <span class="text-muted">${orderItem.number}个</span>
                                        </td>
                                        <td align="right">
                                            <span class="text-muted">单价：￥${orderItem.product.promotePrice}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>
</div>
<%@include file="../include/admin/adminFooter.jsp"%>
