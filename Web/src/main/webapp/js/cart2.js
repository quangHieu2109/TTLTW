import createToast, {toastComponent} from "./toast.js";

var contextPath = $("meta[name='contextPath']").attr('content');

const FAILED_OPERATION_MESSAGE = "Đã có lỗi truy vấn!";
const SUCCESS_DELETE_CART_ITEM_MESSAGE = (productName) => `Đã xóa sản phẩm ${productName} khỏi giỏ hàng thành công!`;
const SUCCESS_UPDATE_CART_ITEM_MESSAGE = (productName) => `Đã cập nhật số lượng của sản phẩm ${productName} thành công!`;
const SUCCESS_ADD_ORDER_MESSAGE = "Đặt hàng thành công!";
var cartItems;

loadCartItem()
function loadCartItem(){
    $.ajax({
        url:'/cartItem',
        type: 'GET',
        success: function (response) {
            cartItems = response.cartItems;
            if(cartItems.length ==0){
                $('#cart_body').append('Giỏ hàng không có sản phẩm nào :(')
            }else{
                for(let i=0; i<cartItems.length; i++){
                    $('#cart_body').append(convertCartItemToHTML(cartItems[i]))
                    updateCartItem(cartItems[i].id, cartItems[i].productName)
                    deleteCartItem(cartItems[i].id, cartItems[i].productName)
                }
                updateTotalProductPrice()
            }
        },
        error: function (response) {
            
            
        }
    })
}
function updateTotalQuantity(){
    $.ajax({
        url:'/cartItem?type=getTotalQuantity',
        type:'GET',
        success: function (response){
            $('#total-cart-items-quantity').text(response.totalQuantity)
        }
    })
}
function deleteCartItem(id, productName){


    $('#delete-cart-item-'+id).on('click', function(){
        if(confirm("Bạn có muốn xóa?")){
            let formData = new FormData()
            formData.append('cartItemId', id);

            $.ajax({
                url:"/cartItem",
                type: "DELETE",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    createToast(toastComponent(SUCCESS_DELETE_CART_ITEM_MESSAGE(productName), "success"));
                    updateTotalQuantity()
                    $('#tr'+id).remove()
                },
                error: function (response) {
                    console.log(response)
                    createToast(toastComponent(FAILED_OPERATION_MESSAGE, "danger"));
                }
            })
        }

    })
}
function updateCartItem(id, productName){


    $('#update-cart-item-'+id).on('click', function(){

        let formData = new FormData()
        formData.append('cartItemId', id);
        formData.append('quantity', $('#quantity-cart-item-'+id).val());
        $.ajax({
            url:"/cartItem",
            type: "PUT",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                createToast(toastComponent(SUCCESS_UPDATE_CART_ITEM_MESSAGE(productName), "success"));
                updateTotalQuantity()
            },
            error: function (response) {
                console.log(response)
                createToast(toastComponent(FAILED_OPERATION_MESSAGE, "danger"));
            }
        })
    })
}
function updateTotalProductPrice(){
    $("input[name='cartItem']").each(function(){
        $(this).on('change', function(){
            let cartItemIds = []
            $("input[name='cartItem']:checked").each(function() {
                cartItemIds.push($(this).val())
            })
            
            if(cartItemIds.length ==0){
                $('#temp-price').text('0')
                $("#checkoutBtn").prop("disabled", true);
            }else{
                $("#checkoutBtn").prop("disabled", false);
                let formData = new FormData()
                formData.append('cartItemIds', cartItemIds)
                
                $.ajax({
                    url:'/cartItemPriceServlet',
                    type: 'Post',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (repsonse) {
                        $('#temp-price').text(_formatPrice(repsonse.totalPrice))
                    },
                    error: function (response) {
                        
                    }
                })
            }
        })
    })
}
function cartItemPriceComponent(productPrice, productDiscount) {
    if (productDiscount === 0) {
        return `<span class="price">${_formatPrice(productPrice)}₫</span>`;
    }

    return `
    <div>
      <span class="price">${_formatPrice(productPrice * (100 - productDiscount) / 100)}₫</span>
      <span class="ms-2 badge bg-info">-${productDiscount}%</span>
    </div>
    <small class="text-muted text-decoration-line-through">${_formatPrice(productPrice)}₫</small>
  `;
}
export function _formatPrice(value){
    return parseFloat(value).toLocaleString('vi-VN')
}
function convertCartItemToHTML(cartItem){
    return  `
    <tr id="tr${cartItem.id}">
    <td>
    <input type="checkbox" value="${cartItem.id}" name="cartItem" class="form-check" style="width: 30px" >
    </td>
      <td>
        <figure class="itemside">
          <div class="float-start me-3">
            <img
              src="${contextPath + (cartItem.productImageName ? ('/image/' + cartItem.productImageName) : '/img/80px.png')}"
              alt="${cartItem.productName}"
              width="80"
              height="80"
            >
          </div>
          <figcaption class="info">
            <a href="${contextPath + '/product?id=' + cartItem.productId}" class="title">${cartItem.productName}</a>
          </figcaption>
        </figure>
      </td>
      <td>
        <div class="price-wrap">
          ${cartItemPriceComponent(cartItem.productPrice, cartItem.productDiscount)}
        </div>
      </td>
      <td>
        <input type="number" value="${cartItem.quantity}" min="1" max="${cartItem.productQuantity}" class="form-control" id="quantity-cart-item-${cartItem.id}">
      </td>
      <td class="text-center text-nowrap">
        <button type="button" class="btn btn-success" id="update-cart-item-${cartItem.id}">Cập nhật</button>
        <button type="button" class="btn btn-danger ms-1" id="delete-cart-item-${cartItem.id}">Xóa</button>
      </td>
    </tr>
  `;
}

$('#add_address-btn').on('click', function(){
    $('#add_address_content').css('display', 'block');
    $('#main_content').css('display', 'none');

})
$('#back').on('click', function(){
    $('#add_address_content').css('display', "none");
    $('#main_content').css('display', 'block');

})
