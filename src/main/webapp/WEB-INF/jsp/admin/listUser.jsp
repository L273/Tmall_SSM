<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/24
  Time: 4:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<title>用户管理</title>
<%@include file="../include/admin/adminNavigator.jsp"%>

<div class="workingArea">
    <label class="label label-info">用户管理</label>
    <br>
    <br>
    <div class="listDataTableDiv">
        <table class="table table-bordered table-hover table-striped table-condensed" style="text-align: center">
            <tr class="success">
                <th>ID</th>
                <th>用户名</th>
                <th>密码</th>
            </tr>
            <c:forEach items="${us}" var="u">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.name}</td>
                    <td>${u.password}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>