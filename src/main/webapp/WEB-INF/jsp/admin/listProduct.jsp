<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/23
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<title>产品管理</title>

<script>
    $(function () {
        $("#addForm").submit(function () {
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
        <li><a href="admin_product_list?cid=${category.id}">${category.name}</a></li>
        <li class="active">产品管理</li>
    </ul>
    <div class="listDataTableDiv">
        <table class="table table-bordered table-striped table-hover table-condensed" style="text-align: center">
            <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>图片</th>
                    <th>产品名称</th>
                    <th>小标题</th>
                    <th>原价格</th>
                    <th>优惠价</th>
                    <th>库存数量</th>
                    <th>图片管理</th>
                    <th>属性设置</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${ps}" var="p">
                    <tr>
                        <td>${p.id}</td>
                        <td>
                            <c:if test="${!empty p.productImage}">
                                <%--非空才现实图片--%>
                                <a href="img/productSingle/${p.productImage.id}.jpg">
                                    <img src="img/productSingle/${p.productImage.id}.jpg" title="点击查看图片" height="50px"></a>
                            </c:if>
                        </td>
                        <td>${p.name}</td>
                        <td>${p.subTitle}</td>
                        <td>${p.originalPrice}</td>
                        <td>${p.promotePrice}</td>
                        <td>${p.stock}</td>
                        <td><a href="admin_productImage_list?pid=${p.id}"><span class="glyphicon glyphicon-picture"></span></a></td>
                        <td><a href="admin_propertyValue_edit?pid=${p.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                        <td><a href="admin_product_edit?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a> </td>
                        <td><a href="admin_product_delete?id=${p.id}" deleteLink="true"><span class="glyphicon glyphicon-trash"></span></a> </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>
    
    <div class="addDiv">
        <div class="panel panel-warning">
            <div class="panel-heading">增加产品</div>
            <div class="panel-body">
                <form action="admin_product_add" method="post" id="addForm">
                    <table class="addTable">
                        <tr>
                            <td>产品名称</td>
                            <td><input id="name" name="name" type="text" class="form-control" placeholder="请输入产品名称"></td>
                        </tr>
                        <tr>
                            <td>小标题</td>
                            <td><input id="subTitle" name="subTitle" type="text" class="form-control" placeholder="请输入小标题"></td>
                        </tr>
                        <tr>
                            <td>原价格</td>
                            <td><input id="originalPrice" name="originalPrice" type="text" class="form-control" placeholder="请输入价格"></td>
                        </tr>
                        <tr>
                            <td>优惠价</td>
                            <td><input id="promotePrice" name="promotePrice" type="text" class="form-control" placeholder="请输入折后价"></td>
                        </tr>
                        <tr>
                            <td>库存</td>
                            <td><input id="stock" name="stock" type="number" class="form-control" placeholder="请输入库存"></td>
                        </tr>
                        <tr class="submitTR" align="center">
                            <td><input type="hidden" name="cid" value="${category.id}"></td>
                            <td><button type="submit" class="btn btn-success">提交</button></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>


<%@include file="../include/admin/adminFooter.jsp"%>