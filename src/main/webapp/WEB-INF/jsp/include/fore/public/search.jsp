<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/24
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" isELIgnored="false" %>
<a href="${contextPath}">
    <%--导入一个gif图片--%>
    <img id="logo" src="img/site/logo.gif" class="logo">
</a>

<form action="foresearch" method="post" >
    <div class="searchDiv">

        <%--一个输入框，用于提交like的参数--%>
        <input name="keyword" type="text" placeholder="时尚男鞋  太阳镜 ">

        <button  type="submit" class="searchButton">搜索</button>
        <div class="searchBelow">
            <%--标题栏也是放分类，但是不多，就是第5到第8的分类--%>
            <c:forEach items="${cs}" var="c" varStatus="st">
                <c:if test="${st.count>=5 and st.count<=8}">
                        <span>
                            <a href="forecategory?cid=${c.id}">
                                    ${c.name}
                            </a>

                            <%--最后一个分类，后面不显示 | --%>
                            <c:if test="${st.count!=8}">
                                <span>|</span>
                            </c:if>
                        </span>
                </c:if>
            </c:forEach>
        </div>
    </div>
</form>