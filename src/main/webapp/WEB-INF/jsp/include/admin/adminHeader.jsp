<%--
  Created by IntelliJ IDEA.
  User: 25729
  Date: 2020/9/21
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" isELIgnored="false" %>

<%--导入JSTL--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
    <head>
        <%--引入js与css的配置文件，Jquery以及Bootstrap的配置文件--%>
        <script src="js/jquery/2.0.0/jquery.min.js"></script>
        <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
        <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" >
        <link href="css/back/style.css" rel="stylesheet">

        <%--一些功能函数--%>
        <script>
            function checkEmpty(id,name) {
                var value =$("#"+id).val();
                if(value.length == 0){
                    alert(name+"不能为空");
                    $("#"+id)[0].focus();
                    return false;
                }
                return true;
            }

            //对删除链接删除前的确认弹框
            $(function () {
                $("a").click(function () {
                    if($(this).attr("deleteLink")=="true"){
                        if(confirm("确认删除"))
                            return true;
                        return false;
                    }
                });
            });

            //判断是否是数字
            function checkNumer(id,name) {
                var test = $("#"+id).val();
                if(test.length==0){
                    alert(name+"的值不能为空");
                    //获取焦点以便下次输入
                    $("#"+id).focus();
                    return false;
                }
                if(isNaN(test)){
                    alert(name+"的值必须为数字");
                    //获取焦点以便下次输入
                    $("#"+id).focus();
                    return false;
                }
                return true;
            }

            //判断是否为整数
            function checkInt(id,name) {
                var test = $("#"+id).val();
                if(test.length==0){
                    alert(name+"的值不能为空");
                    //获取焦点以便下次输入
                    $("#"+id)[0].focus();
                    return false;
                }
                if(parseInt(test)!=test){
                    alert(name+"的值必须为整数");
                    //获取焦点以便下次输入
                    $("#"+id)[0].focus();
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>



