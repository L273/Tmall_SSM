<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/22
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"
         import="java.util.*" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>编辑</title>
<div class="workingArea">
    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑分类</div>
        <div class="panel-body">
            <form method="post" enctype="multipart/form-data" action="admin_category_update" >
                <table class="editTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input name="name" id="name" type="text" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>分类图片</td>
                        <td><input name="image" id="categoryPic" accept="image/jpeg" type="file"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2">
                            <input type="hidden" name="id" value="${category.id}"/>
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>