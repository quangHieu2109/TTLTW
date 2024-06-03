<%--
  Created by IntelliJ IDEA.
  User: dmx
  Date: 5/1/2024
  Time: 3:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý đơn hàng</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" rel="stylesheet">

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
        }
    </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"/>
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
                <th>Delivery method</th>
                <th>Delivery price</th>
                <th>Products price</th>
                <th>Total price</th>
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
</body>
</html>
