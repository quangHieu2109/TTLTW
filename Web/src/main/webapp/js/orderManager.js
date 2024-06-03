$(document).ready(function () {
    loadTable(0)
})
function loadTable(status) {
    if ($.fn.DataTable.isDataTable('#my_table')) {
        $('#my_table').DataTable().destroy()
    }
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
}