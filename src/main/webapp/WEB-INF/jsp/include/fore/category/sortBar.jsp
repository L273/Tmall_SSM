<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/26
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" isELIgnored="false"%>
<script>
    $(function(){
        //控制价格区间的函数
        //其中，当输入完后，就会执行该函数
        $("input.sortBarPrice").keyup(function(){

            //得到本标签内嵌套的值
            var num= $(this).val();

            //如果输入的值的长度是0，即没有输入。
            //就直接输出产品单元，即不做改动的意思
            if(num.length==0){
                $("div.productUnit").show();
                return;
            }

            //反之，输入的长度不为0的时候。
            //即输入的值正常的时候
            //就对其进行整型转换
            num = parseInt(num);
            if(isNaN(num))
                num= 1;
            if(num<=0)
                num = 1;
            //有两种情况，就是输入的值不是数字的时候,isNaN()返回true，非数字
            //还有一种情况，就是0或者负数的时候，默认将数值转换为1.

            //给本输入框赋值
            $(this).val(num);

            /*
            以上就是对Input框进行初始化的过程
             */

            //得到两个输入框的值
            var begin = $("input.beginPrice").val();
            var end = $("input.endPrice").val();
            if(!isNaN(begin) && !isNaN(end)){
                console.log(begin);
                console.log(end);

                //判断，两个输入框的值都是数字后，进入函数执行功能
                //首先隐藏全部要显示的产品标签
                $("div.productUnit").hide();

                //然后遍历全部的产品标签
                //进入标签取到价格的属性
                //取到属性后，将标签显示出来
                $("div.productUnit").each(function(){
                    var price = $(this).attr("price");
                    price = new Number(price);
                    if(price<=end && price>=begin)
                        $(this).show();
                });
            }

        });
    });
</script>
<div class="categorySortBar">
    <table class="categorySortBarTable categorySortTable">
        <tr>
            <%--通过判断sort的值，来设定每个标签后面的背景颜色--%>
            <%--其中由于服务器是使用服务端跳转，所以请求时的sort变量依旧会存在--%>
            <td <c:if test="${'all'==param.sort||empty param.sort}">class="grayColumn"</c:if> >
                <a href="?cid=${c.id}&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
            <td <c:if test="${'review'==param.sort}">class="grayColumn"</c:if> >
                <a href="?cid=${c.id}&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
            <td <c:if test="${'date'==param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${c.id}&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
            <td <c:if test="${'saleCount'==param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${c.id}&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
            <td <c:if test="${'price'==param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${c.id}&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
        </tr>
    </table>

    <%--价格区间的限制--%>
    <table class="categorySortBarTable">
        <tr>
            <%--两个输入框，一个begin一个end，控制输出的区间--%>
            <td><input class="sortBarPrice beginPrice" type="text" placeholder="请输入"></td>
            <td class="grayColumn priceMiddleColumn">-</td>
            <td><input class="sortBarPrice endPrice" type="text" placeholder="请输入"></td>
        </tr>
    </table>

</div>
