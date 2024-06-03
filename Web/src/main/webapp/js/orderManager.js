$(document).ready(function () {
<<<<<<< HEAD
    loadTable(0)
})
=======
    loadTable(1)

})

>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
function loadTable(status) {
    if ($.fn.DataTable.isDataTable('#my_table')) {
        $('#my_table').DataTable().destroy()
    }
<<<<<<< HEAD
    $('#my_table').DataTable({
        processing: true, serverSide: true,
        ajax: {
            url: '/orderManagerServlet2?status=' + status,
            dataSrc: 'data',
            type: 'GET'
        },
        columns: [
            {'data': 'id'}, {'data': 'userid'}, {'data': 'diliveryMethod'},
            {'data': 'diliveryPrice'}, {'data': 'productsPrice'},
            {'data': 'totalPrice'}, {'data': 'createdAt'},
            {'data': 'updatedAt'}, {'data': 'status'},
            {'data': 'operation'}
        ]
    })
}

function changeStatus(id) {
    let idBtn = 'btn' + id;
    if ($('#' + idBtn).css('background-color') != 'rgb(237, 146, 14)') {
        $('#' + idBtn).on('click', function () {
            updateStatus(id)
        })
        $('#' + idBtn).css('background-color', 'rgb(237, 146, 14)')
        $('#' + idBtn).css('border-color', 'rgb(237, 146, 14)')
    }
}
function updateStatus(id) {
    let status = $('#sl'+id).val();
    $.ajax({
        url: "/orderManagerServlet2",
        type: "POST",
        data:{
            'id':id,
            'status':status
        },success: function (response) {
            alert(response.msg)
            $('#my_table').DataTable().ajax.reload()
        }, error: function (response) {
            alert(response.responseJSON.msg)
        }
    })
=======
    $('#my_table__content').css('display', 'block');
    $('#detail_table__content').css('display', 'none')
    $('#my_table').DataTable({

        processing: true,
        serverSide: true,
        ajax: {
            url: "/orderManagerServlet2?type=order&status=" + status,
            dataSrc: "data",
            type: "get"
        },
        columns: [
            {"data": "id"},
            {"data": "idUser"},
            {"data": "deliveryMethod"},
            {"data": "deliveryPrice"},
            {"data": "productsPrice"},
            {"data": "totalPrice"},
            {"data": "createAt"},
            {"data": "updateAt"},
            {"data": "updateStatus"},
            {"data": "operation"}
        ]
    })
    // function

}

function updateStatus(id) {
    let value = $('#sl' + id).val();
    console.log(value)
    $.ajax({
        url: "/orderManagerServlet2",
        type: "post",
        data: {
            "id": id,
            "value": value
        },
        success: function (response) {
            let status = $('input[name="category"]:checked').val();
            // loadTable(status)
            $('#my_table').DataTable().ajax.reload()
            alert("Cập nhật trạng thái đơn hàng " + id + " thành công")
        },
        error: function (response) {
            console.log(response)
            alert(response.responseJSON.error_notifica)
        }
    })
}

function changeStatus(id, value) {
    id2 = "p" + id;


    if ($('#' + id2).css('background-color') != 'rgb(198, 123, 43)') {
        $('#' + id2).on('click', function () {
            updateStatus(id)
        })
        $('#' + id2).css('background-color', '#c67b2b');
    }

}

function detail(id) {
    $('#detail').prop('checked', true);
    $('#my_table__content').css('display', 'none');
    $('#detail_table__content').css('display', 'block')
    if ($.fn.DataTable.isDataTable('#detail_table')) {
        $('#detail_table').DataTable().destroy()
    }

    $('#detail_table').DataTable({

        processing: true,
        serverSide: true,
        ajax: {
            url: "/orderManagerServlet2?type=detail&orderId=" + id,
            dataSrc: "data",
            type: "get"
        },
        columns: [
            {"data": "id"},
            {"data": "image"},
            {"data": "info"},
            {"data": "quantity"},
            {"data": "price"},
            {"data": "totalPrice"}
        ]
    })

>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
}