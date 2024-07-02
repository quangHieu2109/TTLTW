<%--
  Created by IntelliJ IDEA.
  User: dmx
  Date: 5/1/2024
  Time: 1:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý log</title>
  <link href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" rel="stylesheet">

  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
  <link href="${pageContext.request.contextPath}/css/bootstrap-icons.css" type="text/css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
  <style>
    td{
      max-width: 100px;
      word-wrap: break-word;
    }
    .level1{
      background-color: #fff !important;
    }
    .level2{
      background-color: #a4a1a1 !important;
    }
    .level3{
      background-color: #e59e5e !important;
    }
    .level4{
      background-color: #f32929 !important;
      color: #fff;
    }
  </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"></jsp:include>
<div class="container">
  <table id="my_table" class="table-bordered">
    <thead>
    <tr>
      <th>ID</th>
      <th>IP</th>
      <th>Level log</th>
      <th>Resource</th>
      <th>Previous value</th>
      <th>Current value</th>
      <th>Created At</th>
      <th>Updated At</th>

    </tr>
    </thead>
    <tbody></tbody>
  </table>
</div>
<script src="${pageContext.request.contextPath}/js/logManager.js"></script>
</body>
</html>
