<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/24
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"
        pageEncoding="UTF-8" isELIgnored="false" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/fore/style.css">
    <link rel="stylesheet" href="css/bootstrap/3.3.6/bootstrap.min.css">
    <script>


        //格式化输出总数，即结算的总数的样式
        function formatMoney(num){
            num = num.toString().replace(/\$|\,/g,'');
            if(isNaN(num))
                num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num*100+0.50000000001);
            cents = num%100;
            num = Math.floor(num/100).toString();
            if(cents<10)
                cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
                num = num.substring(0,num.length-(4*i+3))+','+
                    num.substring(num.length-(4*i+3));
            return (((sign)?'':'-') + num + '.' + cents);
        }


        function checkEmpty(id, name){
            var value = $("#"+id).val();
            if(value.length==0){

                $("#"+id)[0].focus();
                return false;
            }
            return true;
        }




        $(function(){

//            评价和产品详情页之间的跳转
//            即显示和隐藏
            $("a.productDetailTopReviewLink").click(function(){
                $("div.productReviewDiv").show();
                $("div.productDetailDiv").hide();
            });
            $("a.productReviewTopPartSelectedLink").click(function(){
                $("div.productReviewDiv").hide();
                $("div.productDetailDiv").show();
            });

            $("span.leaveMessageTextareaSpan").hide();
            $("img.leaveMessageImg").click(function(){

                $(this).hide();
                $("span.leaveMessageTextareaSpan").show();
                $("div.orderItemSumDiv").css("height","100px");
            });


            //一些无效链接的跳转
            $("div#footer a[href$=#nowhere]").click(function(){
                alert("模仿天猫的连接，并没有跳转到实际的页面");
            });

            $("a.wangwanglink").click(function(){
                alert("模仿旺旺的图标，并不会打开旺旺");
            });
            $("a.notImplementLink").click(function(){
                alert("这个功能没做，蛤蛤~");
            });

        });
    </script>
</head>
<body>


