<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/23
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<title>修改属性</title>
<script>
    $(function () {
        $("#addForm").submit(function () {
            if(!checkEmpty("name","属性名称"))
                return false;
            return true;
        });
    });
</script>
<div class="workingArea">
    <ul class="breadcrumb">
        <li>属性</li>
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_property_list${page.param}"}>${category.name}</a></li>
    </ul>
    <table class="table table-bordered table-hover table-hover table-condensed" style="text-align: center">
        <thead>
            <tr class="success">
                <th>ID</th>
                <th>属性值</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${ps}" var="p">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.name}</td>
                    <td><a href="admin_property_edit?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a href="admin_property_delete?id=${p.id}" deleteLink="true"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="pageDiv">
    <%@include file="../include/admin/adminPage.jsp"%>
</div>

<div class="panel panel-warning addDiv">
    <div class="panel-heading">增加属性</div>
    <div class="panel-body">
        <form method="post" action="admin_property_add" id="addForm">
            <table class="addTable">
                <tr>
                    <td>属性名称</td>
                    <td><input type="text" id="name" name="name" class="form-control"></td>
                </tr>
                <tr class="submitTR">
                    <td colspan="2" align="center">
                        <input type="hidden" name="cid" value="${category.id}">
                        <button type="submit" class="btn btn-success">提交</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>
