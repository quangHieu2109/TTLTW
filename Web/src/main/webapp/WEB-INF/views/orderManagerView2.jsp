<%--
  Created by IntelliJ IDEA.
  User: dmx
  Date: 4/29/2024
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý đơn hàng</title>
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
        input[type="radio"]:checked + label {
            background-color: #52e74c; /* Màu sắc bạn muốn áp dụng khi label được chọn */
        }
    </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"/>
<div class="row justify-content-around">
    <div class="w-auto">
        <input type="radio" name="category" value="1" id="1" checked hidden>
        <label for="1" class="btn p-3 pt-1 pb-1 mt-2" onclick="loadTable(1)">Đang giao hàng</label>
    </div>
    <div class="w-auto">
        <input type="radio" name="category" value="2" id="2" hidden>
        <label for="2" class="btn p-3 pt-1 pb-1 mt-2" onclick="loadTable(2)">Giao hàng thành công</label>
    </div>
    <div class="w-auto">
        <input type="radio" name="category" value="3" id="3" hidden>
        <label for="3" class="btn p-3 pt-1 pb-1 mt-2" onclick="loadTable(3)">Đã hủy</label>
    </div>
    <div class="w-auto">
        <input type="radio" name="category" id="detail" hidden>
        <label  class="btn p-3 pt-1 pb-1 mt-2">Chi tiết đơn hàng</label>
    </div>
</div>
<div class="container">
   <div id="my_table__content">
       <table id="my_table" class="table-bordered">
           <thead>
           <tr>
               <th>ID Order</th>
               <th>ID Customer</th>
               <th>Delivery method</th>
               <th>Delivery price</th>
               <th>Products price</th>
               <th>Total price</th>
               <th>Create at</th>
               <th>Update at</th>
               <th>Update status</th>
               <th>Operation</th>
           </tr>

           </thead>
           <tbody>

           </tbody>

       </table>
   </div>
    <div id="detail_table__content">
        <table id="detail_table " class="table-bordered">
            <thead>
            <th>ID</th>
            <th>Image</th>
            <th>Info</th>
            <th>Amount</th>
            <th>Price</th>
            <th>Total price</th>

            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/orderManager.js" type="text/javascript" async></script>
</body>
</html>
