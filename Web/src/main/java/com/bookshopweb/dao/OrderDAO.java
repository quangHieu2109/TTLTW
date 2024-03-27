package com.bookshopweb.dao;

import com.bookshopweb.beans.Order;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class OrderDAO extends AbsDAO<Order> {
    @Override
    public Order selectPrevalue(Long id) {
        Order result = null;
        try {
            String sql = "select * from orders where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()){
                long userId = rs.getLong("userId");
                int status = rs.getInt("status");
                int deliveryMethod = rs.getInt("deliveryMethod");
                double deliveryPrice = rs.getDouble("deliveryPrice");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result = new Order(id, userId, status, deliveryMethod, deliveryPrice, createdAt, updatedAt);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int insert(Order order, String ip) {

        int result = 0;
        try {
            String sql = "insert into orders (id, userId, status, deliveryMethod, deliveryPrice, createdAt, updatedAt) " +
                    "values(?,?,?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, order.getId());
            st.setLong(2, order.getUserId());
            st.setInt(3, order.getStatus());
            st.setInt(4, order.getDeliveryMethod());
            st.setDouble(5, order.getDeliveryPrice());
            st.setTimestamp(6, order.getCreatedAt());
            st.setTimestamp(7, order.getUpdatedAt());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        super.insert(order, ip);
        return result;

    }

    @Override
    public int update(Order order, String ip) {
        super.update(order, ip);
        int result = 0;
        try {
            String sql = "update orders set id=?, userId=?, status=?, deliveryMethod=?, deliveryPrice=?, createdAt=?, updatedAt=? " +
                    "where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, order.getId());
            st.setLong(2, order.getUserId());
            st.setInt(3, order.getStatus());
            st.setInt(4, order.getDeliveryMethod());
            st.setDouble(5, order.getDeliveryPrice());
            st.setTimestamp(6, order.getCreatedAt());
            st.setTimestamp(7, order.getUpdatedAt());
            st.setLong(8, order.getId());
            result = st.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    @Override
    public int delete(Order order, String ip) {

        int result = 0;
        try {
            String sql = "delete from orders where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, order.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        super.delete(order, ip);
        return result;
    }
}
