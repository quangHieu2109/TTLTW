$(document).ready(function () {
    loadTable()
})

function loadTable() {
    if ($.fn.DataTable.isDataTable('#my_table')) {
        $('#my_table').DataTable().destroy();
    }
    $('#my_table').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: "/userManagerServlet2",
            type: "GET",
            dataSrc: "data"
        },
        columns: [
            {'data': 'id'},
            {'data': 'username'},
            {'data': 'fullname'},
            {'data': 'email'},
            {'data': 'phonenumber'},
            {'data': 'gender'},
            {'data': 'role'},
            {'data': 'operation'}
        ]
    })
}

$('#add').on('click', function () {
    $('#my_table__container').css('display', 'none')
    $('#add_user__container').css('display', 'block')
})
$('#cancel').on('click', function () {
    $('#my_table__container').css('display', 'block')
    $('#add_user__container').css('display', 'none')
})
$('#submit').on('click', validInfo)

function validInfo() {
    $('#username-error').text('')
    $('#password-error').text('')
    $('#fullname-error').text('')
    $('#email-error').text('')
    let username = $('#username').val()
    let password = $('#password').val()
    let fullname = $('#fullname').val()
    let email = $('#email').val()
    let role = $('#role').val()

    let emailRegex = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z0-9]+$/;
    let passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[\d]).*$/;
    if (username.length == 0) {
        $('#username-error').text("Vui lòng điền tên đăng nhập")
    }

    if (password.length == 0) {
        $('#password-error').text("Vui lòng điền mật khẩu")

    } else if (!passRegex.test(password)) {
        $('#password-error').text("Mật khẩu không hợp lệ, yêu cầu từ 8 kí tự trở lên bao gồm chữ thường, in hoa và số")

    }

    if (fullname.length == 0) {
        $('#fullname-error').text("Vui lòng nhập họ và tên")
    }

    if (email.length == 0) {
        $('#email-error').text('Vui lòng nhập email')
    } else if (!emailRegex.test(email)) {
        $('#email-error').text("Email không hợp lệ")
    }
    if ($('#username-error').text().length == 0 && $('#password-error').text().length == 0 &&
        $('#fullname-error').text().length == 0 && $('#email-error').text().length == 0) {
        addUser(username, password, fullname, email, role)
    }
}

function addUser(username, password, fullname, email, role) {
    console.log(123123)
    $.ajax({
        url: "/userManagerServlet2",
        type: "POST",
        data: {
            'username': username,
            'password': password,
            'fullname': fullname,
            'email': email,
            'role': role
        },
        success: function (response) {
            alert(response.msg)
            $('#my_table__container').css('display', 'block')
            $('#add_user__container').css('display', 'none')
            $('#username').val('')
            $('#password').val('')
            $('#fullname').val('')
            $('#email').val('')
            loadTable()
        },
        error: function (response) {
            alert('Thêm người dùng thất bại')
            $('#username-error').text(response.responseJSON.username_error)
            $('#password-error').text(response.responseJSON.password_error)
            $('#fullname-error').text(response.responseJSON.fullname_error)
            $('#email-error').text(response.responseJSON.email_error)
        }
    })
}