<%--
  Created by IntelliJ IDEA.
  User: dmx
<<<<<<< HEAD
  Date: 5/1/2024
  Time: 3:35 PM
=======
  Date: 4/29/2024
  Time: 1:52 PM
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý đơn hàng</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" rel="stylesheet">
<<<<<<< HEAD

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.css" type="text/css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
    <style>
        input[name='status']:checked + label {
            background-color: #20c997;
        }
        .btn{
            border: 1px solid #ececec;
=======
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
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
        }
    </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"/>
<<<<<<< HEAD
<div class="container">
    <div class="d-flex justify-content-around mt-3">
        <div class="mb-3">
            <input type="radio" id="0" name="status" checked hidden>
            <label for="0" class="btn" onclick="loadTable(0)">Đặt hàng thành công</label>
        </div>
        <div class="mb-3">
            <input type="radio" id="1" name="status" hidden>
            <label for="1" class="btn" onclick="loadTable(1)">Đang giao hàng</label>
        </div>
        <div class="mb-3">
            <input type="radio" id="2" name="status" hidden>
            <label for="2" class="btn" onclick="loadTable(2)">Giao hàng thành công</label>
        </div>
        <div class="mb-3">
            <input type="radio" id="3" name="status" hidden>
            <label for="3" class="btn" onclick="loadTable(3)">Đã hủy</label>
        </div>
        <div class="mb-3">
            <input type="radio" id="4" name="status" hidden>
            <label for="4" class="btn" onclick="loadTable(4)">Trả hàng</label>
        </div>

    </div>

    <table id="my_table" class="table-bordered">
        <thead>
            <tr>
                <th>OrderID</th>
                <th>UesrID</th>
=======
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
        <label class="btn p-3 pt-1 pb-1 mt-2">Chi tiết đơn hàng</label>
    </div>
</div>
<div class="container">
    <div id="my_table__content">
        <table id="my_table" class="table-bordered">
            <thead>
            <tr>
                <th>ID Order</th>
                <th>ID Customer</th>
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
                <th>Delivery method</th>
                <th>Delivery price</th>
                <th>Products price</th>
                <th>Total price</th>
<<<<<<< HEAD
                <th>Created at</th>
                <th>Updated at</th>
                <th>Status</th>
                <th>Operation</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<script src="${pageContext.request.contextPath}/js/orderManager.js"></script>
=======
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
        <table id="detail_table" class="table-bordered">
            <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Info</th>
                <th>Amount</th>
                <th>Price</th>
                <th>Total price</th>
            </tr>

            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/orderManager.js" type="text/javascript" async></script>
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
</body>
</html>
