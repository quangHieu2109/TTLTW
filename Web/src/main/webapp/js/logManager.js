<<<<<<< HEAD
$(document).ready(function (){
    loadTable()
})
function loadTable(){
    $('#my_table').DataTable({
        processing: true,
        serverSide: true,
        ajax:{
            url:"/logManagerServlet",
            type:"POST",
            dataSrc:"data"
        },
        columns:[
            {'data':'id'},
            {'data':'ip'},
            {'data':'level'},
            {'data':'res'},
            {'data':'pre'},
            {'data':'cur'},
            {'data':'create'},
            {'data':'update'}
        ],
        createdRow:function(row, data, index){
            row.classList.add('level'+data.level)
        }
    })
}
=======
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
        ],
        fnCreatedRow: function(row, data, index){
            row.classList.add("logLV"+data.levelLog)
        }
    });

});
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
