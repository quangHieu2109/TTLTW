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