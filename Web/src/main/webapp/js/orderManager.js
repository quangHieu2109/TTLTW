$(document).ready(function () {
    loadTable(1)

})

function loadTable(status) {
    if ($.fn.DataTable.isDataTable('#my_table')) {
        $('#my_table').DataTable().destroy()
    }
    $('#my_table__content').css('display','block');
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
            loadTable(status)
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

function detail(id){
    $('#detail').prop('checked', true);
    $('#my_table__content').css('display','none');
    $('#detail_table__content').css('display', 'block')
    $('#detail_table').DataTable({

        processing: true,
        serverSide: true,
        ajax: {
            url: "/orderManagerServlet2?type=detail&orderId=" + id,
            dataSrc: "data",
            type: "get"
        },
        columns:[
            {"data": "id"},
            {"data": "image"},
            {"data": "info"},
            {"data": "quantity"},
            {"data": "price"},
            {"data": "totalPrice"}
        ]
    })
}