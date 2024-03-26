package com.bookshopweb.dao;

import com.bookshopweb.beans.Cart;
import com.bookshopweb.beans.User;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class CartDAO extends AbsDAO<Cart> {

    Connection conn = JDBCUtils.getConnection();
    public Cart selectByUser(User user){
        Cart result = null;
        CartItemDAO dao = new CartItemDAO();
        try {
            String sql="select * from cart where userId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, user.getId());
            ResultSet rs = st.executeQuery();
            while (rs.next()){
                long id = rs.getLong("id");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result = new Cart(id, user.getId(), createdAt, updatedAt);
                result.addCartItem(dao.selectByCart(result));
                rs.close();
                st.close();
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override

    public int insert(Cart cart) {
         super.insert(cart);
         int result = 0;

        try {
            String sql = "insert into cart (id, userId, createdAt, updatedAt) " +
                    "values (?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, cart.getId());
            st.setLong(2,cart.getUserId());
            st.setTimestamp(3, cart.getCreatedAt());
            st.setTimestamp(4, cart.getUpdatedAt());

            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;

    }

    @Override
    public int update(Cart cart) {
        super.update(cart);
        int result =0;
        try {
            String sql = "update cart set updatedAt=? where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setTimestamp(1, cart.getUpdatedAt());
            st.setLong(2, cart.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int delete(Cart cart) {
        super.delete(cart);
        int result =0;
        try {
            String sql = "delete from cart where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }
}
