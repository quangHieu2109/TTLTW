<%--
  Created by IntelliJ IDEA.
  User: dmx
  Date: 4/26/2024
  Time: 2:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<jsp:include page="_meta.jsp"></jsp:include>--%>
<html>
<head>
    <title>Quản lý log</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon" type="image/x-icon">

    <!-- Bootstrap v5.0.1 -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.js" type="text/javascript"></script>

    <!-- Bootstrap Icons v1.5.0 -->
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.css" type="text/css" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="${pageContext.request.contextPath}/css/styles.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
    <style>
        .add-user__btn{
            width: max-content;
            margin-right: 0;

        }
        .add-user__btn button{
            padding-left: 20px;
            padding-right: 20px;
        }
        .add-user__content{
            position: absolute;
            left: 25%;
            top:10%;
            display: none;
            background-color: #fff;
            border: 1px solid #ddd;
            z-index: 2;
        }
        #table-contaier{
            width: 100%; overflow: auto;
        }
        td{
            word-wrap: break-word;
            max-width: 100px !important;
        }
        .logLV1{
            background-color: #ffffff !important;
        }
        .logLV2{
            background-color: rgba(131, 134, 129, 0.44) !important;
        }
        .logLV3{
            background-color: rgba(250, 166, 23, 0.7) !important;
        }
        .logLV4{
            background-color: rgba(243, 26, 26, 0.45) !important;
            color: #ffffff !important;
        }
    </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"/>
<div class="container">

    <div style="width: 100%; margin: auto" id="table-contaier">
        <table id="my_table" class="disabled table-bordered table-striped">
            <thead>
            <tr>
                <%--        <th>#</th>--%>
                <th>ID</th>
                <th>IP</th>

                <th>Level</th>
                <th>Resource</th>
                <th>Previous value</th>
                <th>Current value</th>
                <th>Create at</th>
                <th>Update At</th>


            </tr>

            </thead>
            <tbody>

            </tbody>

        </table>

    </div>



</div>
<jsp:include page="_footerAdmin.jsp"/>


<script src="${pageContext.request.contextPath}/js/logManager.js" type="text/javascript" ></script>

</body>
</html>
