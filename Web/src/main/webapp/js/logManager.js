$(document).ready(function() {
    var table = $('#my_table').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: "/logManagerServlet",
            type: "post",
            dataSrc: "data"
        },
        columns: [
            {"data": "id"},
            {"data": "ip"},
            {"data": "levelLog"},
            {"data": "res"},
            {"data": "preValue"},
            {"data": "curValue"},
            {"data": "createAt"},
            {"data": "updateAt"}
        ]
    });

});