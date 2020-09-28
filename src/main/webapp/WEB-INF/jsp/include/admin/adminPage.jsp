<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/21
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" isELIgnored="false"%>
<script>
    //当前后页不存在的时候，点击相关href的时候，return false使链接失效
    $(function () {
        $("ul.pagination li.disabled a").click(function () {
            return false;
        });
    });
</script>

<nav>
    <ul class="pagination">

        <%--最前一页--%>
        <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
            <a href="?start=0${page.param}" aria-label="Previous">
                <span aria-hidden="true">«</span>
            </a>
        </li>

        <%--前一页--%>
        <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
            <a href="?start=${page.start-page.count}${page.param}" aria-label="Previous">
                <span aria-hidden="true">‹</span>
            </a>
        </li>

        <%--中间的按照数字跳转的页面--%>
        <c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">
            <li>
                <a href="?start=${status.index*page.count}${page.param}"<c:if test="${status.index*page.count==page.start}">class="current"</c:if>>
                    <span aria-hidden="true">${status.count}</span>
                </a>
            </li>
        </c:forEach>

        <%--下一页--%>
            <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
            <a href="?start=${page.start+page.count}${page.param}" aria-label="Next">
                <span aria-hidden="true">›</span>
            </a>
        </li>

        <%--最后一页--%>
        <li <c:if test="${!page.hasNext}">class="disabled" </c:if>>
            <a href="?start=${page.last}${page.param}" aria-label="Next">
                <span aria-hidden="true">»</span>
            </a>
        </li>
    </ul>
</nav>