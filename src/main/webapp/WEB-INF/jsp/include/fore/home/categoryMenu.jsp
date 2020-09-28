<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/25
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false" %>

<div class="categoryMenu">
    <%--一个超链接、一个category的数据，在foreach进行显示--%>
    <c:forEach items="${cs}" var="c">
        <div cid="${c.id}" class="eachCategory">
            <span class="glyphicon glyphicon-link"></span>
            <a href="forecategory?cid=${c.id}">
                    ${c.name}
            </a>
        </div>
    </c:forEach>
</div>