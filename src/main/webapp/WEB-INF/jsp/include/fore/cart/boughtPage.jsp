<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/28
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>
<script>
    var deleteOrder = false;
    var deleteOrderid = 0;

    $(function(){
        $("a[orderStatus]").click(function(){
            var orderStatus = $(this).attr("orderStatus");
            if('all'==orderStatus){
                $("table[orderStatus]").show();
            }
            else{
                $("table[orderStatus]").hide();
                $("table[orderStatus="+orderStatus+"]").show();
            }

            $("div.orderType div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
        });

        /*
        =====================================================
         */
        //与删除订单项类似，只是这里的后台操作，变成了控制Order表单数据的删除

        $("a.deleteOrderLink").click(function(){
            deleteOrderid = $(this).attr("oid");
            deleteOrder = false;
            $("#deleteConfirmModal").modal("show");
        });

        $("button.deleteConfirmButton").click(function(){
            deleteOrder = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrder){
                var page="foredeleteOrder";
                $.post(
                    page,
                    {"oid":deleteOrderid},
                    function(result){
                        //删除成功后，就hide本框，一个产品单元格
                        if("success"==result){
                            $("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
                        }
                        else{
                            //反之，进入登录界面
                            location.href="login.jsp";
                        }
                    }
                );

            }
        })

        $(".ask2delivery").click(function(){
            var link = $(this).attr("link");
            $(this).hide();
            page = link;
            $.ajax({
                url: page,
                success: function(result){
                    alert("卖家已秒发，刷新当前页面，即可进行确认收货")
                }
            });

        });
    });
</script>

<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
        <div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
        <div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
        <div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
        <div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder"></a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
        </table>

    </div>

    <div class="orderListItem">

        <%--遍历传入的os，即订单表单--%>
        <c:forEach items="${os}" var="o">

            <table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                        <b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                        <span>订单号: ${o.orderCode}
                    </span>
                    </td>
                    <td  colspan="2"><img width="13px" src="img/site/orderItemTmall.png">天猫商场</td>
                    <td colspan="1">
                        <a class="wangwanglink" href="#nowhere">
                            <div class="orderItemWangWangGif"></div>
                        </a>

                    </td>
                    <td class="orderItemDeleteTD">
                        <a class="deleteOrderLink" oid="${o.id}" href="#nowhere">
                            <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>

                    </td>
                </tr>


                <%--遍历各个订单项，显示产品--%>
                <c:forEach items="${o.orderItemList}" var="oi" varStatus="st">
                    <tr class="orderItemProductInfoPartTR" >
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="img/productSingle_middle/${oi.product.productImage.id}.jpg"></td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                    <img src="img/site/creditcard.png" title="支持信用卡支付">
                                    <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                    <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                </div>
                            </div>
                        </td>
                        <td  class="orderItemProductInfoPartTD" width="100px">

                            <div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></div>
                            <div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></div>

                        </td>
                        <td valign="top" rowspan="${fn:length(o.orderItemList)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                            <span class="orderListItemNumber">${o.totalNumber}</span>
                        </td>
                        <td valign="top" rowspan="${fn:length(o.orderItemList)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                            <div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/></div>
                            <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                        </td>

                        <td valign="top" rowspan="${fn:length(o.orderItemList)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
                                <%--根据状态来显示状态栏的东西--%>

                            <%--如果是带确认，就显示确认收货--%>
                            <c:if test="${o.orderStatus=='waitConfirm' }">
                                <a href="foreconfirmPay?oid=${o.id}">

                                    <%--点击确认收货，进入相应的UR，并传入订单的id号--%>
                                    <button class="orderListItemConfirm">确认收货</button>
                                </a>
                            </c:if>

                                    <%--如果是待付款，就显示付款--%>
                            <c:if test="${o.orderStatus=='waitPay' }">
                                <a href="forealipay?oid=${o.id}&total=${o.total}">

                                    <%--进入之前写好的付款链接--%>
                                    <button class="orderListItemConfirm">付款</button>
                                </a>
                            </c:if>

                                    <%--如果是待发货，就显示代发货的字样--%>
                            <c:if test="${o.orderStatus=='waitDelivery' }">
                                <span>待发货</span>
                            </c:if>

                            <c:if test="${o.orderStatus=='waitReview' }">
                                <a href="forereview?oid=${o.id}">
                                    <button  class="orderListItemReview">评价</button>
                                </a>
                            </c:if>

                        <c:if test="${o.orderStatus=='finish' }">
                            <span>完成订单</span>
                        </c:if>

                        </td>
                    </tr>
                </c:forEach>

            </table>
        </c:forEach>

    </div>

</div>