package com.bookshopweb.dao;

import com.bookshopweb.beans.OrderDetail;
import com.bookshopweb.jdbiInterface.OrderDetailJDBI;
import com.bookshopweb.utils.JDBIUltis;

import java.util.List;

public class OrderDetailDAO {
    private OrderDetailJDBI orderDetailJDBI = JDBIUltis.getJDBI().onDemand(OrderDetailJDBI.class);
    public List<OrderDetail> getAll(){
        return orderDetailJDBI.getAll();
    }
    public OrderDetail getByOrderId(long orderId){
        return orderDetailJDBI.getByOrderId(orderId);
    }
    public int addOrderDetail(OrderDetail orderDetail){
        return orderDetailJDBI.addVoucherDetail(orderDetail);
    }
    public int addOrderDetailNoVoucher(OrderDetail orderDetail){
        return orderDetailJDBI.addVoucherDetailNoVoucher(orderDetail);
    }
    public int updateShipVoucherId(long shipVoucherId, long orderId){
        return orderDetailJDBI.updateShipVoucherId(shipVoucherId, orderId);
    }
    public int updateProductVoucherId(long productVoucherId, long orderId){
        return orderDetailJDBI.updateProductVoucherId(productVoucherId, orderId);
    }
}
