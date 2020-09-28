<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/25
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<script>
    $(function(){
        var stock = ${p.stock};
        $(".productNumberSetting").keyup(function(){
            var num= $(".productNumberSetting").val();
            num = parseInt(num);
            if(isNaN(num))
                num= 1;
            if(num<=0)
                num = 1;
            if(num>stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });

        //点击数量上升的按钮
        $(".increaseNumber").click(function(){
            var num= $(".productNumberSetting").val();
            num++;

            //不能高于库存的数量
            if(num>stock)
                num = stock;

            //显示的div，标签内嵌入的值要上升
            $(".productNumberSetting").val(num);
        });

        //点击下降的按钮
        $(".decreaseNumber").click(function(){
            var num= $(".productNumberSetting").val();
            --num;
            if(num<=0)
                num=1;
            $(".productNumberSetting").val(num);
        });

        //点击加入购物车
        $(".addCartLink").click(function(){
            //购物车对应的控制器映射的URL
            var page = "forecheckLogin";
            $.get(
                page,
                function(result){

                    //如果访问成功，即登录状态
                    // 再嵌套一个URL，里面再写一个get的AJAX
                    //这里要二次提交数据
                    if("success"==result){
                        var pid = ${p.id};
                        var num= $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";

                        //这里再加入购物车，进行处理
                        //提交到加入购物车的Response
                        $.get(
                            addCartpage,
                            {"pid":pid,"num":num},
                            function(result){
                                //如果提交成功，则改变按钮的显示
                                if(result=="success"){
                                    $(".addCartButton").html("已加入购物车");
                                    $(".addCartButton").attr("disabled","disabled");
                                    $(".addCartButton").css("background-color","lightgray");
                                    $(".addCartButton").css("border-color","lightgray");
                                    $(".addCartButton").css("color","black");
                                }
                                else{

                                }
                            }
                        );
                    }
                    //如果没有返回success，则显示LoginModal，即就是没有登录的状态
                    else{
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });


        $(".buyLink").click(function(){
            var page = "forecheckLogin";
            $.get(
                page,
                function(result){
                    //如果检查登入成功的话，就生成一个用RUL传递参数的href，即传递提交的购物数据
                    if("success"==result){
                        var num = $(".productNumberSetting").val();

                        //控制器的num参数是在ajax登录验证通过后，重新生成URL跳转后传递过去的
                        location.href= $(".buyLink").attr("href")+"&num="+num;
                    }
                    else{
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });

        //modaj.jsp内的登录div点击的时候
        //使用ajax来提交数据
        $("button.loginSubmitButton").click(function(){
            var name = $("#name").val();
            var password = $("#password").val();

            //两个inpu框的输入校验
            if(0==name.length||0==password.length){
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }


            //检查没问题后，就进入专门处理ajax消息请求的控制器
            var page = "foreloginAjax";
            $.get(
                page,
                {"name":name,"password":password},
                function(result){
                    if("success"==result){
                        //如果返回的值是成功
                        //就重新载入本页面
                        location.reload();
                    }
                    else{
                        //如果失败
                        //就在错误显示的div内显示账号或者密码错误
                        $("span.errorMessage").html("账号密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            );

            return true;
        });


        $("img.smallImage").mouseenter(function(){
            var bigImageURL = $(this).attr("bigImageURL");
            //当鼠标移动到小图片的时候
            //刷新大图片的url，以达到换图的效果
            $("img.bigImg").attr("src",bigImageURL);
        });


        $("img.bigImg").load(
            //当大图片载入的时候

            function(){
                $("img.smallImage").each(function(){

                    //得到大图片的URL
                    var bigImageURL = $(this).attr("bigImageURL");

                    //生成一个img 标签
                    //并将src属性设置为bigImage的URL
                    img = new Image();
                    img.src = bigImageURL;

                    //当载入小图片的时候
                    //img4load的里面要加上，新生成的img标签
                    img.onload = function(){
                        console.log(bigImageURL);
                        $("div.img4load").append($(img));
                    };
                });
            }
        );
    });

</script>

<div class="imgAndInfo">

    <div class="imgInimgAndInfo">
        <%--默认显示第一张图片--%>
        <img src="img/productSingle/${p.productImage.id}.jpg" class="bigImg">
        <div class="smallImageDiv">
            <c:forEach items="${p.productSingleImages}" var="pi">
                <%--显示五张小图片--%>
                <img src="img/productSingle_small/${pi.id}.jpg" bigImageURL="img/productSingle/${pi.id}.jpg" class="smallImage">
            </c:forEach>
        </div>
        <div class="img4load hidden" >
            <%--虽然会加载，但是已经加载过的，会直接从缓存里去而不会从服务端取了。--%>
        </div>
    </div>

    <div class="infoInimgAndInfo">

        <div class="productTitle">
            <%--产品的名称，大标题--%>
            ${p.name}
        </div>
        <div class="productSubTitle">
            <%--产品的小标题--%>
            ${p.subTitle}
        </div>

        <div class="productPrice">
            <div class="juhuasuan">
                <span class="juhuasuanBig" >聚划算</span>
                <span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始，</span>
            </div>
            <div class="productPriceDiv">
                <div class="gouwujuanDiv"><img height="16px" src="img/site/gouwujuan.png">
                    <span> 全天猫实物商品通用</span>

                </div>
                <div class="originalDiv">
                    <span class="originalPriceDesc">价格</span>
                    <span class="originalPriceYuan">¥</span>
                    <span class="originalPrice">
                        <%--显示原价格的后两位小数--%>
                        <fmt:formatNumber type="number" value="${p.originalPrice}" minFractionDigits="2"/>
                    </span>
                </div>
                <div class="promotionDiv">
                    <span class="promotionPriceDesc">促销价 </span>
                    <span class="promotionPriceYuan">¥</span>
                    <span class="promotionPrice">
                        <%--显示优惠价格的后两位小数--%>
                        <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
                    </span>
                </div>
            </div>
        </div>
        <div class="productSaleAndReviewNumber">
            <div>销量 <span class="redColor boldWord"> ${p.saleCount }</span></div>
            <div>累计评价 <span class="redColor boldWord"> ${p.reviewCount}</span></div>
        </div>
        <div class="productNumber">
            <span>数量</span>
            <span>
                <span class="productNumberSettingSpan">
                    <%--用来显示并提交数量的input--%>
                <input class="productNumberSetting" type="text" value="1">
                </span>
                <span class="arrow">
                    <a href="#nowhere" class="increaseNumber">
                    <span class="updown">
                        <%--上升的标签--%>
                        <img src="img/site/increase.png">
                    </span>
                    </a>

                    <span class="updownMiddle"> </span>
                    <a href="#nowhere"  class="decreaseNumber">

                        <%--下降标签--%>
                    <span class="updown">
                            <img src="img/site/decrease.png">
                    </span>
                    </a>

                </span>

            件</span>
            <span>库存${p.stock}件</span>
        </div>
        <div class="serviceCommitment">
            <span class="serviceCommitmentDesc">服务承诺</span>
            <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
        </div>

        <div class="buyDiv">
            <%--购买的表单，已经有了产品的pid，只差购物的数量--%>
            <a class="buyLink" href="forebuyone?pid=${p.id}"><button class="buyButton">立即购买</button></a>
            <a href="#nowhere" class="addCartLink">
                <button class="addCartButton">
                    <span class="glyphicon glyphicon-shopping-cart"></span>加入购物车
                </button></a>
        </div>
    </div>

    <div style="clear:both"></div>
</div>
