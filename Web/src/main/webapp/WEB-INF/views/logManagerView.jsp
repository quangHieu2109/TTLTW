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
  <jsp:include page="_meta.jsp"/>

  <link href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css" rel="stylesheet">

  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
  <link href="${pageContext.request.contextPath}/css/bootstrap-icons.css" type="text/css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">

  <style>
     .limitLine-3{
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
         word-wrap: break-word;
         overflow: hidden;
         text-overflow: ellipsis;
         width: 200px;
    }
     tr:hover td p {
         display: block;
     }
    /*td{*/
    /*  max-width: 100px;*/
    /*  max-height: 100px;*/
    /*  word-wrap: break-word;*/
    /*}*/
    .level1{
      background-color: #fff !important;
      max-height: 50px !important;
      overflow-y: auto;
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
    .w-10{
      width: 10%;

    }
    .w-20{
      width: 20%;
    }
    input[type="radio"]:checked + .page-link {
      background-color: #0d6efd;
      color: #fff;
    }
  </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"></jsp:include>
<div class="container mt-4">
  <main class="table-responsive-xl mb-5">
  <table id="my_table" class="table table-bordered table-striped table-hover align-middle">
    <thead>
    <tr>
      <th scope="col" class="w-10">ID</th>
      <th scope="col" class="w-10">IP</th>
      <th scope="col" class="w-10">Level log</th>
      <th scope="col" class="w-10">Resource</th>
      <th scope="col" class="w-20">Previous value</th>
      <th scope="col" class="w-20">Current value</th>
      <th scope="col" class="w-10">Created At</th>
      <th scope="col" class="w-10">Updated At</th>

    </tr>
    </thead>
    <tbody id="table_body">

    </tbody>
  </table>
  </main>
  <div id="paging" class="d-flex justify-content-center">

  </div>
</div>
<script src="${pageContext.request.contextPath}/js/logManager.js"></script>
</body>
</html>
