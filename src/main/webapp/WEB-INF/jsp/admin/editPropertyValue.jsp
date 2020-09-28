<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/24
  Time: 3:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<title>编辑产品属性</title>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    //通过ajax修改每个属性的值
    $(function () {
        $("input.pvValue").keyup(function () {
            var value = $(this).val();

            var pvid = $(this).attr("pvid");
            var pid = $(this).attr("pid");
            var ptid = $(this).attr("ptid");

            var parentSpan = $(this).parent("span");

            parentSpan.css("border","1px solid yellow");

            $.post(
                "admin_propertyValue_upadte",
                    {"value":value,"id":pvid,"pid":pid,"ptid":ptid},
                    function (result) {
                        if("success"==result){
                            //正确就显示绿色的实线
                            parentSpan.css("border","1px solid green");
                        }else{
                            //错误就显示红色的实线
                            parentSpan.css("border","1px solid red");
                        }
                    }
            );
        });
    });



</script>
<div class="workingArea">
    <ul class="breadcrumb">
        <li><a href="admin_category_list">全部分类</a> </li>
        <li><a href="admin_product_list?cid=${product.cid}">${product.category.name}</a> </li>
        <li class="active">${product.name}</li>
        <li class="active">属性编辑</li>
    </ul>

    <div class="editDiv">
        <c:forEach items="${pvs}" var="pv">
            <div class="eachPV">
                <span class="pvName">${pv.property.name}</span>
                <span class="pvValue"><input class="pvValue" pvid="${pv.id}"
                                             ptid="${pv.ptid}" pid="${pv.pid}"
                                             type="text" value="${pv.value}"></span>
            </div>
        </c:forEach>
    </div>
    <div style="clear: both"></div>
</div>



<%@include file="../include/admin/adminFooter.jsp"%>