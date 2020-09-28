<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/23
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/admin/adminHeader.jsp"%>
<title>管理图片</title>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function () {
       $("#addSingle").submit(function () {
           if(!checkEmpty("singlePic","单个图片上传"))
               return false;
           return true;
       });

       $("#addDetail").submit(function () {
           if(!checkEmpty("detailPic","详情图片上传"))
               return false;
           return true;
       })
    });
</script>

<div class="workingArea">
    <ul class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a> </li>
        <li><a href="admin_product_list?cid=${p.cid}">${p.category.name}</a></li>
        <li class="active">${p.name}</li>
        <li class="active">图片管理</li>
    </ul>

    <table class="addPictureTable " align="center">
        <tr>
            <td class="addPictureTableTD">
                <div class="panel panel-warning addPictureDiv">
                    <div class="panel-heading">新增<b class="text-primary"> 单个 </b>图片</div>
                    <div class="panel-body">
                        <form method="post" action="admin_productImage_add" enctype="multipart/form-data" id="addSingle">
                            <table class="addTable">
                                <tr>
                                    <td>选择本地照片，400x400最佳</td>
                                </tr>
                                <tr>
                                    <td align="center"><input name="image" type="file" id="singlePic" accept="image/jpeg"></td>
                                </tr>
                                <tr class="submitTR">
                                   <td align="center">
                                       <input type="hidden" name="type" value="type_single">
                                       <input type="hidden" name="pid" value="${p.id}">
                                       <button type="submit" class="btn btn-success">提交</button>
                                   </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
                <table class="table table-bordered table-striped table-hover table-condensed">
                    <tr class="success">
                        <th>ID</th>
                        <th>图片</th>
                        <th>删除</th>
                    </tr>
                    <c:forEach items="${pisSingle}" var="s">
                        <tr>
                            <td>${s.id}</td>
                            <td><a href="img/productSingle/${s.id}.jpg"><img src="img/productSingle/${s.id}.jpg" title="点击鼠标查看原图" height="50px"></a></td>
                            <td><a href="admin_productImage_delete?id=${s.id}" deleteLink="true"><span class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </td>


            <td class="addPictureTableTD">
                <div class="addPictureDiv">
                    <div class="panel panel-warning">
                        <div class="panel-heading">添加<b class="text-primary"> 详情 </b>图片</div>
                        <div class="panel-body">
                            <form method="post" enctype="multipart/form-data" action="admin_productImage_add" id="addDetail">
                                <table class="addTable">
                                    <tr>
                                        <td>选择本体图片宽度790为佳</td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <input name="image" id="detailPic" type="file" accept="image/jpeg">
                                        </td>
                                    </tr>
                                    <tr class="submitTR">
                                        <td align="center">
                                            <input type="hidden" name="type" value="type_detail">
                                            <input type="hidden" name="pid" value="${p.id}">
                                           <button type="submit" class="btn btn-success">提交</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>

                <table class="table table-bordered table-striped table-hover table-condensed">
                    <tr class="success">
                        <th>ID</th>
                        <th>图片</th>
                        <th>删除</th>
                    </tr>
                    <c:forEach items="${pisDetail}" var="d">
                        <tr>
                            <td>${d.id}</td>
                            <td><a href="img/productDetail/${d.id}.jpg"><img src="img/productDetail/${d.id}.jpg" title="点击鼠标查看原图" height="50px"></a></td>
                            <td><a href="admin_productImage_delete?id=${d.id}" deleteLink="true"><span class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>
                    </c:forEach>
                </table>

            </td>
        </tr>
    </table>


</div>
<%@include file="../include/admin/adminFooter.jsp"%>
