<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/23
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<title>修改产品</title>
<%@include file="../include/admin/adminNavigator.jsp"%>
<script>
    $(function () {
        $("#editForm").submit(function () {
            if(!checkEmpty("name","产品名称"))
                return false;
            if(!checkEmpty("subTitle","小标题"))
                return false;
            if(!checkNumer("originalPrice", "原价格"))
                return false;
            if(!checkNumer("promotePrice","优惠价"))
                return false;
            if(!checkInt("stock","库存"))
                return false;
            return true;
        });
    });
</script>

<div class="workingArea">
    <ul class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="/admin_product_list?cid=${p.cid}"></a></li>
        <li class="active">属性修改</li>
    </ul>
    <div class="editDiv">
        <div class="panel panel-warning">
            <div class="panel-heading">修改属性</div>
            <div class="panel-body">
                <form id="editForm" method="post" action="admin_product_update">
                    <table class="addTable">
                        <tr>
                            <td>产品名称</td>
                            <td><input id="name" name="name"  type="text" class="form-control" value="${p.name}"></td>
                        </tr>
                        <tr>
                            <td>小标题</td>
                            <td><input id="subTitle" name="subTitle" type="text" class="form-control" value="${p.subTitle}"></td>
                        </tr>
                        <tr>
                            <td>原价格</td>
                            <td><input id="originalPrice" name="originalPrice" type="text" class="form-control" value="${p.originalPrice}"></td>
                        </tr>
                        <tr>
                            <td>优惠价格</td>
                            <td><input id="promotePrice" name="promotePrice" type="text" class="form-control" value="${p.promotePrice}"></td>
                        </tr>
                        <tr>
                            <td>库存</td>
                            <td><input id="stock" name="stock" type="number" class="form-control" value="${p.stock}"></td>
                        </tr>

                        <tr>
                            <td><input type="hidden" name="id" value="${p.id}"></td>
                            <td><input type="hidden" name="cid" value="${p.cid}"></td>
                        </tr>
                        <tr class="submitTR" >

                            <td colspan="2" align="center">
                                <button type="submit" class="btn btn-success">提交</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>