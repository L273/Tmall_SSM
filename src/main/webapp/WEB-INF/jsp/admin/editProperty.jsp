<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/23
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<title>编辑</title>

<div class="workingArea">
    <ul class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a href="admin_property_list?cid=${p.cid}">${p.category.name}</a></li>
        <li class="active">编辑属性</li>
    </ul>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">修改</div>
        <div class="panel-body" >
            <form method="post" action="admin_property_update">
                <table class="addTable">
                    <tr>
                        <td>属性</td>
                        <td><input id="name" name="name" class="form-control" type="text"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="id" value="${p.id}">
                            <input type="hidden" name="cid" value="${p.cid}">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>


<%@include file="../include/admin/adminFooter.jsp"%>
