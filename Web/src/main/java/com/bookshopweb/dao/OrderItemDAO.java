package com.bookshopweb.dao;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.OrderItem;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO extends AbsDAO<OrderItem> {
    public OrderItem selectPrevalue(Long id){
        OrderItem result = null;
        try {
            String sql = "select * from order_item where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long orderId = rs.getLong("orderId");
                long productId = rs.getLong("productId");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                int quantity = rs.getInt("quantity");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result=(new OrderItem(id, orderId, productId, price, discount, quantity, createdAt, updatedAt));
            }
            rs.close();
            st.close();


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  result;
    }
    public List<OrderItem> selectByOrder(Order order){
        List<OrderItem> result = new ArrayList<>();
        try {
            String sql = "select * from order_item where orderId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, order.getId());
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long id = rs.getLong("id");
                long orderId = rs.getLong("orderId");
                long productId = rs.getLong("productId");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                int quantity = rs.getInt("quantity");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result.add(new OrderItem(id, orderId, productId, price, discount, quantity, createdAt, updatedAt));
            }
            rs.close();
            st.close();


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  result;
    }

    @Override
    public int insert(OrderItem orderItem, String ip) {

         int result =0;
         try {
             String sql="insert into order_item (id, orderId, productId, price, discount, quantity, createdAt, updatedAt) " +
                     "values(?,?,?,?,?,?,?,?)";
             PreparedStatement st = conn.prepareStatement(sql);
             st.setLong(1, orderItem.getId());
             st.setLong(2, orderItem.getOrderId());
             st.setLong(3, orderItem.getProductId());
             st.setDouble(4, orderItem.getPrice());
             st.setDouble(5, orderItem.getDiscount());
             st.setInt(6, orderItem.getQuantity());
             st.setTimestamp(7, orderItem.getCreatedAt());
             st.setTimestamp(8, orderItem.getUpdatedAt());
             result = st.executeUpdate();
             st.close();
         } catch (Exception e) {
             throw new RuntimeException(e);
         }
        super.insert(orderItem, ip);
        return result;
    }

    @Override
    public int update(OrderItem orderItem, String ip) {
        super.update(orderItem, ip);
        int result =0;
        try {
            String sql = "update order_item set id=?, orderId=?, productId=?, price=?, discount=?, quantity=?, createdAt=?, updatedAt=?" +
                    " where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, orderItem.getId());
            st.setLong(2, orderItem.getOrderId());
            st.setLong(3, orderItem.getProductId());
            st.setDouble(4, orderItem.getPrice());
            st.setDouble(5, orderItem.getDiscount());
            st.setInt(6, orderItem.getQuantity());
            st.setTimestamp(7, orderItem.getCreatedAt());
            st.setTimestamp(8, orderItem.getUpdatedAt());
            st.setLong(9, orderItem.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    @Override
    public int delete(OrderItem orderItem, String ip) {

        int result =0;
        try {
            String sql = "delete from order_item where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, orderItem.getId());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        super.delete(orderItem, ip);
        return result;
    }
}
