<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/28
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<script>

    var deleteOrderItem = false;
    var deleteOrderItemid = 0;
    $(function(){

        $("a.deleteOrderItem").click(function(){
            //当触发删除按钮的时候，就会连着一同触发确认删除的按钮

            //在第二次点击的时候，这个属性值就有效了
            deleteOrderItem = false;

            //同时，将ooid的属性值取出。
            var oiid = $(this).attr("oiid")


            //得到ooid，即数据表单的值，以供之后使用
            deleteOrderItemid = oiid;

            //将原本隐藏的删除确认按钮显示为Show
            $("#deleteConfirmModal").modal('show');
        });


        $("button.deleteConfirmButton").click(function(){
            //提交的时候，将判断值设置为真
            deleteOrderItem = true;

            //同时隐藏确认删除的div
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function () {
            //当确认删除的框加载的时候
            //如果确认的boolean为真，则利用ajax提交数据
            if(deleteOrderItem){
                //利用ajax提交到另一个页面
                var page="foredeleteOrderItem";

                $.post(
                    page,
                    {"oiid":deleteOrderItemid},
                    function(result){
                        if("success"==result){
                            $("tr.cartProductItemTR[oiid="+deleteOrderItemid+"]").hide();
                        }
                        else{
                            //检查，如果检查失败
                            //就说明没有登录，要进入登录界面
                            location.href="loginPage";
                        }
                    }
                );
            }
        });

        $("img.cartProductItemIfSelected").click(function(){
            var selectit = $(this).attr("selectit")
            if("selectit"==selectit){
                $(this).attr("src","img/site/cartNotSelected.png");

               //二次点击修改为false
                $(this).attr("selectit","false");

                //修改成未选择时的背景
                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
            }
            else{
                $(this).attr("src","img/site/cartSelected.png");

                //切换，修改为selectit
                $(this).attr("selectit","selectit")

                //修改成选择时的背景
                $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
            }

            //修改图标
            syncSelect();

            //结算按钮的设置
            syncCreateOrderButton();

            //显示总数
            calcCartSumPriceAndNumber();
        });


        //全选操作，一次性全部处理
        $("img.selectAllItem").click(function(){
            var selectit = $(this).attr("selectit")
            if("selectit"==selectit){
                $("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
                $("img.selectAllItem").attr("selectit","false")
                $(".cartProductItemIfSelected").each(function(){
                    $(this).attr("src","img/site/cartNotSelected.png");
                    $(this).attr("selectit","false");
                    $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
                });
            }
            else{
                $("img.selectAllItem").attr("src","img/site/cartSelected.png");
                $("img.selectAllItem").attr("selectit","selectit")
                $(".cartProductItemIfSelected").each(function(){
                    $(this).attr("src","img/site/cartSelected.png");
                    $(this).attr("selectit","selectit");
                    $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
                });
            }
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();

        });

        $(".orderItemNumberSetting").keyup(function(){
            var pid=$(this).attr("pid");
            var stock= $("span.orderItemStock[pid="+pid+"]").text();
            var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();

            var num= $(".orderItemNumberSetting[pid="+pid+"]").val();

            //进入输入值的检查
            num = parseInt(num);
            if(isNaN(num))
                num= 1;
            if(num<=0)
                num = 1;
            if(num>stock)
                num = stock;

            //检查num，即输入的text是合格的数字，就传入syncPrice进行数据库的更新
            syncPrice(pid,num,price);
        });

        $(".numberPlus").click(function(){

            var pid=$(this).attr("pid");
            var stock= $("span.orderItemStock[pid="+pid+"]").text();
            var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
            var num= $(".orderItemNumberSetting[pid="+pid+"]").val();

            //与减少一样的思路，只是num这里变成了++
            num++;
            if(num>stock)
                num = stock;
            syncPrice(pid,num,price);
        });

        $(".numberMinus").click(function(){
            var pid=$(this).attr("pid");
            var stock= $("span.orderItemStock[pid="+pid+"]").text();
            var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();

            var num= $(".orderItemNumberSetting[pid="+pid+"]").val();

            //传入syncPrice后，可讲-1的值输出
            --num;

            //限制最小值是1
            if(num<=0)
                num=1;
            syncPrice(pid,num,price);
        });


        //点击结算按钮，会用each取循环所有的选择单元。
        //对于选择的项目，即设置selectit为selectit的项目
        //取其ooid的值，放到URL里，传递到forebuy中，即订单生成页面
        $("button.createOrderButton").click(function(){
            var params = "";
            $(".cartProductItemIfSelected").each(function(){
                if("selectit"==$(this).attr("selectit")){
                    var oiid = $(this).attr("oiid");
                    params += "&oiid="+oiid;
                }
            });

            //把第一个&符号去掉
            params = params.substring(1);

//            用URL传递参数，到订单生成页面
            location.href="forebuy?"+params;
        });

    })

    function syncCreateOrderButton(){
        var selectAny = false;

        //遍历，只要存在一个项目
        $(".cartProductItemIfSelected").each(function(){
            if("selectit"==$(this).attr("selectit")){
                selectAny = true;
            }
        });


        //修改结算按钮的背景，同时，将disabled移除，因为可以使用
        if(selectAny){
            $("button.createOrderButton").css("background-color","#C40000");
            $("button.createOrderButton").removeAttr("disabled");
        }
        else{
            //反之，修改按钮背景，并使之不可使用
            $("button.createOrderButton").css("background-color","#AAAAAA");
            $("button.createOrderButton").attr("disabled","disabled");
        }

    }
    function syncSelect(){
        var selectAll = true;
        $(".cartProductItemIfSelected").each(function(){
            if("false"==$(this).attr("selectit")){
                selectAll = false;
            }
        });

        //修改图标
        if(selectAll)
            $("img.selectAllItem").attr("src","img/site/cartSelected.png");
        else
            $("img.selectAllItem").attr("src","img/site/cartNotSelected.png");

    }
    function calcCartSumPriceAndNumber(){
        var sum = 0;
        var totalNumber = 0;
        $("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
            var oiid = $(this).attr("oiid");
            var price =$(".cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
            price = price.replace(/,/g, "");
            price = price.replace(/￥/g, "");
            sum += new Number(price);

            var num =$(".orderItemNumberSetting[oiid="+oiid+"]").val();
            totalNumber += new Number(num);

        });

        $("span.cartSumPrice").html("￥"+formatMoney(sum));
        $("span.cartTitlePrice").html("￥"+formatMoney(sum));
        $("span.cartSumNumber").html(totalNumber);
    }


    //异步更新数据
    //用于购物车栏目的增加和删除
    function syncPrice(pid,num,price){
        //为显示的框重新设置值
        $(".orderItemNumberSetting[pid="+pid+"]").val(num);
        var cartProductItemSmallSumPrice = formatMoney(num*price);
        $(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+cartProductItemSmallSumPrice);
        calcCartSumPriceAndNumber();

        //将结果映射到该URL上
        var page = "forechangeOrderItem";
        $.post(
            page,
            {"pid":pid,"number":num},
            function(result){
                if("success"!=result){
                    //若验证失败，则说明还没有登录，需要重新登录用户
                    location.href="login.jsp";
                }
            }
        );

    }
</script>

<title>购物车</title>
<div class="cartDiv">
    <div class="cartTitle pull-right">
        <span>已选商品  (不含运费)</span>
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" disabled="disabled">结 算</button>
    </div>

    <div class="cartProductList">
        <table class="cartProductTable">
            <thead>
            <tr>
                <th class="selectAndImage">
                    <img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png">
                    全选

                </th>
                <th>商品信息</th>
                <th>单价</th>
                <th>数量</th>
                <th width="120px">金额</th>
                <th class="operation">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${ois }" var="oi">
                <tr oiid="${oi.id}" class="cartProductItemTR">
                    <td>
                        <%--class=cartProductItemIfSelected--%>
                        <%--默认是没有选择项的--%>
                        <img selectit="false" oiid="${oi.id}" class="cartProductItemIfSelected" src="img/site/cartNotSelected.png">
                        <a style="display:none" href="#nowhere"><img src="img/site/cartSelected.png"></a>
                        <img class="cartProductImg"  src="img/productSingle_middle/${oi.product.productImage.id}.jpg">
                    </td>
                    <td>
                        <div class="cartProductLinkOutDiv">
                            <a href="foreproduct?pid=${oi.product.id}" class="cartProductLink">${oi.product.name}</a>
                            <div class="cartProductLinkInnerDiv">
                                <img src="img/site/creditcard.png" title="支持信用卡支付">
                                <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                            </div>
                        </div>

                    </td>
                    <td>
                        <span class="cartProductItemOringalPrice">￥${oi.product.originalPrice}</span>
                        <span  class="cartProductItemPromotionPrice">￥${oi.product.promotePrice}</span>

                    </td>
                    <td>

                        <div class="cartProductChangeNumberDiv">
                            <span class="hidden orderItemStock " pid="${oi.product.id}">${oi.product.stock}</span>
                            <span class="hidden orderItemPromotePrice " pid="${oi.product.id}">${oi.product.promotePrice}</span>

                            <%--减少产品的数量--%>
                            <a  pid="${oi.product.id}" class="numberMinus" href="#nowhere">-</a>


                            <input pid="${oi.product.id}" oiid="${oi.id}" class="orderItemNumberSetting" autocomplete="off" value="${oi.number}">


                            <%--增加产品的数量--%>
                            <a  stock="${oi.product.stock}" pid="${oi.product.id}" class="numberPlus" href="#nowhere">+</a>
                        </div>

                    </td>
                    <td >
                            <span class="cartProductItemSmallSumPrice" oiid="${oi.id}" pid="${oi.product.id}" >
                            ￥<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number}" minFractionDigits="2"/>
                            </span>

                    </td>
                    <td>
                        <a class="deleteOrderItem" oiid="${oi.id}"  href="#nowhere">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>

    <div class="cartFoot">
        <img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png">
        <span>全选</span>
        <div class="pull-right">
            <span>已选商品 <span class="cartSumNumber" >0</span> 件</span>

            <span>合计 (不含运费): </span>
            <span class="cartSumPrice" >￥0.00</span>
            <button class="createOrderButton" disabled="disabled" >结  算</button>
        </div>

    </div>

</div>