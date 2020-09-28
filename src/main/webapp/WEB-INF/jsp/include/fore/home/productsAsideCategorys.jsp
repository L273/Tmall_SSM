<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/25
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false"%>

<script>
    //遍历全部显示的产品，然后，选择性的部分进行高亮处理
    $(function(){
        $("div.productsAsideCategorys div.row a").each(function(){
            var v = Math.round(Math.random() *6);
            if(v == 1)
                $(this).css("color","#87CEFA");
        });
    });

</script>


<c:forEach items="${cs}" var="c">
    <div cid="${c.id}" class="productsAsideCategorys">

        <%--按照行来读取product，一行8个，在fillByRow内定义了内行的数据量的大小--%>
        <c:forEach items="${c.productsByRow}" var="ps">
            <div class="row show1">

                <%--得到的每行的8个数据，进行二次遍历--%>
                <c:forEach items="${ps}" var="p">

                    <%--显示数据内的小标题，如果数据库内存有相关数据的话--%>
                    <c:if test="${!empty p.subTitle}">
                        <a href="foreproduct?pid=${p.id}">
                            <c:forEach items="${fn:split(p.subTitle, ' ')}" var="title" varStatus="st">
                                <c:if test="${st.index==0}">
                                    ${title}
                                </c:if>
                            </c:forEach>
                        </a>
                    </c:if>

                </c:forEach>
                <div class="seperator"></div>
            </div>
        </c:forEach>
    </div>
</c:forEach>
