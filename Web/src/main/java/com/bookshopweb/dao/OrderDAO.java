package com.bookshopweb.dao;

import com.bookshopweb.beans.Order;

import java.sql.PreparedStatement;

public class OrderDAO extends AbsDAO<Order> {
    @Override
    public int insert(Order order) {
        super.insert(order);
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








        return result;

    }

    @Override
    public int update(Order order) {
        super.update(order);
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
    public int delete(Order order) {
        super.delete(order);
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
        return result;
    }
}
