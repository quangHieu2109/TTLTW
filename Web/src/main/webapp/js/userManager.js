// var table = $('#my_table').DataTable();

$(document).ready(function () {
    renderTable()
    var add_user__btn = $('#addUser');

    var cancel = $('#cancel')
    var add_user__content = $('#add-user__content');
    add_user__btn.on('click', function () {
        // alert('123123')
        add_user__content.css('display', 'block');
        $('#table-contaier').css('display', 'none')
    });
    cancel.on('click', function () {
        add_user__content.css('display', 'none');
        $('#table-contaier').css('display', 'block')
    })
})

function renderTable() {
    $('#my_table').DataTable(
        {
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "/userManagerServlet2", // URL của Servlet
                "dataSrc": "data",
                "type": "GET"
            },
            "columns": [
                {"data": "id"},
                {"data": "username"},

                {"data": "fullname"},
                {"data": "email"},
                {"data": "phoneNumber"},
                {"data": "gender"},
                {"data": "role"},
                {"data": "deleteBtn"}

            ]
        }
    )
}
var add = $('#add');
add.on('click', addUserAction)
function addUserAction() {
    let username = $('#username').val();
    let password = $('#password').val();
    let fullname = $('#fullname').val();
    let email = $('#email').val();
    let role = $('#role').val();
    let emailRegex = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$/
    let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*$/
    if (username.length == 0) {
        $('#username-error').text('Vui lòng nhập tên đăng nhập')
    }else{
        $('#username-error').text('')

    }
    if (password.length == 0) {
        $('#password-error').text('Vui lòng nhập mật khẩu')
    }else{
        if(password.length <8 || !passwordRegex.test(password)){
            $('#password-error').text('Mật khẩu không đủ mạnh, vui lòng nhập 8 kí tự trở lên bao gồm cả số và chữ viết hoa')

        }else{
            $('#password-error').text('')

        }
    }
    if (fullname.length == 0) {
        $('#fullname-error').text('Vui lòng nhập họ tên')
    }else{
        $('#fullname-error').text('')

    }
    if (email.length == 0) {
        $('#email-error').text('Vui lòng nhập email')
    }else if(!emailRegex.test(email)){
        $('#email-error').text('Email không hợp lệ')

    }else{
        $('#email-error').text('')

    }

    if($('#username-error').text().length >0 ||  $('#password-error').text().length >0 ||
        $('#fullname-error').text().length >0 || $('#email-error').text().length>0){

    }else{
        addUser(username, password, fullname, email, role );
    }

}
function addUser(username, password, fullname, email, role) {
    $.ajax({
        url: "/userManagerServlet2",
        type: 'post',
        data: {
            username: username,
            password: password,
            fullname: fullname,
            email: email,
            role: role
        },
        success: function (respone) {
            console.log(respone)
            $('#my_table').DataTable().rows.add(respone).draw();
            $('#username').val("");
            $('#password').val("");
            $('#fullname').val("");
            $('#emaill').val("");
           $('#add-user__content').css('display', 'none');
            $('#table-contaier').css('display', 'block')
            alert('Thêm thành công')
        },
        error: function (respone) {
            $('#username-error').text(respone.responseJSON.username_error)
            $('#password-error').text(respone.responseJSON.password_error)
            $('#email-error').text(respone.responseJSON.email_error)
            console.log(respone)
            alert('THêm thất bại')
        }
    })
}
function deleteUser(id) {


    $.ajax({
        url: "/userManagerServlet2?id=" + id,
        type: "DELETE",
        success: function (response) {
            alert("Xóa thành công");

            // Xác định chỉ mục của hàng dựa trên giá trị id
            var rowIndex = $('#my_table').DataTable().column(0).data().indexOf(id);

            // Xóa hàng trong DataTable
            $('#my_table').DataTable().row(rowIndex).remove().draw();
        },
        error: function (response) {
            alert("Xóa thất bại");
        }
    });


}
