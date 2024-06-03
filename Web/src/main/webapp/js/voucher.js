function randomVoucherCode(){
    $.ajax({
        url: "/createVoucherSevlet?type=randomVoucherCode",
        type: "GET",
        success: function (response) {
            $("#voucher-code").val(response.voucherCode)

        }
    })
}
$('#my_form').on('submit', submitForm)
function submitForm(event){
    event.preventDefault()
    $('#voucher-imageName_error').text("")
    if($('#voucher-imageName').val() == ""){
        $('#voucher-imageName_error').text("Vui lòng chọn ảnh voucher")

    }
    $('#voucher-startsAt_error').text("")
    if($('#voucher-startsAt').val()==""){
        $('#voucher-startsAt_error').text("Vui lòng chọn ngày bắt đầu")
    }
    $('#voucher-endAt_error').text("")
    if($('#voucher-endAt').val()==""){
        $('#voucher-endAt_error').text("Vui lòng chọn ngày kết thúc")
    }

    var categorys = [];
    $('input[name="categorys"]:checked').each(function() {
        categorys.push($(this).val());
    });

    var formData = new FormData();
    formData.append('image', $('#voucher-imageName')[0].files[0]);
    formData.append('voucherName', $('#voucher-name').val());
    formData.append('voucherCode', $('#voucher-code').val());
    formData.append('typeVoucher', $("input[name='typeVoucher']:checked").val());
    formData.append('description', $('#voucher-description').val());
    formData.append('percentDecrease', $('#percent-decrease').val());
    formData.append('maxDecrease', $('#max-decrease').val());
    formData.append('minPrice', $('#min-price').val());
    formData.append('voucherStartsAt', $('#voucher-startsAt').val());
    formData.append('voucherEndAt', $('#voucher-endAt').val());
    formData.append('categorys', categorys.join(','));

    $.ajax({
        url: "/createVoucherSevlet",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
            alert(response.msg);
        },
        error: function (response) {
            if(response.status == 400){
                $('#voucher-code_error').text(response.responseJSON.msg)
            }
            alert(response.responseJSON.msg)
        }
    });

}