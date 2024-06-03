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
    <title>Quản lý người dùng</title>
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
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.css" type="text/css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
    <style>
<<<<<<< HEAD
        #add_user__container{
            display: none;
            width: 500px;
            margin: auto;
            border-radius: 10px;
            border: 1px solid #b0b2b2;
            padding: 20px;
=======
        .add-user__btn{
            width: max-content;
            margin-right: 0;

        }
        .add-user__btn button{
            padding-left: 20px;
            padding-right: 20px;
        }
        .add-user__content{

            display: none;
            background-color: #fff;
            border: 1px solid #ddd;

>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
        }
       .btn_add__container{

       }
    </style>
</head>
<body>
<jsp:include page="_headerAdmin.jsp"/>
<<<<<<< HEAD

=======
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
<div class="container">
    <div class="btn_add__container d-flex justify-content-end">
        <button class="btn btn-success" id="add">Thêm người dùng</button>
    </div>
    <div id="my_table__container">
        <table id="my_table" class="table-bordered">
            <thead>
            <tr>
                <th>ID</th>
                <th>UesrName</th>
                <th>FullName</th>
                <th>Email</th>
                <th>PhoneNumber</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Operation</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <div id="add_user__container">
        <div class="mb-3">
            <lable class="form-label">Tên đăng nhập</lable>
            <label class="form-label text-danger" id="username-error"></label>
            <input type="text" class="form-control" id="username">
        </div>
        <div class="mb-3">
            <lable class="form-label">Mật khẩu</lable>
            <label class="form-label text-danger" id="password-error"></label>
            <input type="password" class="form-control" id="password">
        </div>
        <div class="mb-3">
            <lable class="form-label">Họ và tên</lable>
            <label class="form-label text-danger" id="fullname-error"></label>
            <input type="text" class="form-control" id="fullname">
        </div>
        <div class="mb-3">
            <lable class="form-label">Email</lable>
            <label class="form-label text-danger" id="email-error"></label>
            <input type="email" class="form-control" id="email">
        </div>
        <div class="mb-3">
            <lable class="form-label">Role</lable>

            <select name="" id="role" class="form-select">
                <option value="CUSTOMER">CUSTOMER</option>
                <option value="EMPLOYEE">EMPLOYEE</option>
                <option value="ADMIN">ADMIN</option>
            </select>
        </div>
        <div class="mb-3 d-flex justify-content-around">
            <button class="btn btn-secondary" id="cancel">Hủy</button>
            <button class="btn btn-primary" id="submit">Thêm</button>

        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/userManager.js" type="text/javascript"></script>

</body>
</html>
