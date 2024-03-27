package com.bookshopweb.dao;

import com.bookshopweb.beans.Cart;
import com.bookshopweb.beans.CartItem;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class CartItemDAO extends AbsDAO<CartItem> {

    public List<CartItem> selectByCart(Cart cart){
        List<CartItem> result = new ArrayList<>();
        Connection conn = JDBCUtils.getConnection();
        try {
            String sql = "select * from cart_item where cartId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1,cart.getId());
            ResultSet rs = st.executeQuery();
            while (rs.next()){
                Long id = rs.getLong("id");
                Long productId = rs.getLong("productId");
                int quantity = rs.getInt("quantity");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result.add(new CartItem(id, cart.getId(), productId, quantity, createdAt, updatedAt));

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public CartItem selectPrevalue(Long id){
      CartItem result = null;
        try {
            String sql = "select * from cart_item where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1,id);
            ResultSet rs = st.executeQuery();
            while (rs.next()){
                Long productId = rs.getLong("productId");
                int quantity = rs.getInt("quantity");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                long cartId = rs.getLong("cartId");
                result=(new CartItem(id, cartId, productId, quantity, createdAt, updatedAt));

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override
    public int delete(CartItem cartItem, String ip) {

         int result =0;
        Connection conn = JDBCUtils.getConnection();

        try {
            String sql = "delete from cart_item where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, cartItem.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        super.delete(cartItem, ip);
         return result;
    }

    @Override
    public int update(CartItem cartItem, String ip) {
        super.update(cartItem, ip);
         int result =0;
         Connection conn = JDBCUtils.getConnection();
         try {
             String sql = "update cart_item set " +
                     "quantity=?, updatedAt=? where id=?";
             PreparedStatement st = conn.prepareStatement(sql);
             st.setInt(1, cartItem.getQuantity());
             st.setTimestamp(2, cartItem.getUpdatedAt());
             st.setLong(3, cartItem.getId());
             result = st.executeUpdate();
             st.close();
         } catch (Exception e) {
             throw new RuntimeException(e);
         }

        return result;
    }

    @Override
    public int insert(CartItem cartItem, String ip) {

         int result = 0;
         Connection conn = JDBCUtils.getConnection();
         try {
             String sql = "insert into cart_item (id, cartId, productId, quantity, createdAt, updatedAt) " +
                     "values(?,?,?,?,?,?)";
             PreparedStatement st = conn.prepareStatement(sql);
             st.setLong(1, cartItem.getId());
             st.setLong(2, cartItem.getCartId());
             st.setLong(3, cartItem.getProductId());
             st.setInt(4, cartItem.getQuantity());
             st.setTimestamp(5, cartItem.getCreatedAt());
             st.setTimestamp(6, cartItem.getUpdatedAt());
             result = st.executeUpdate();
             st.close();
         } catch (Exception e) {
             throw new RuntimeException(e);
         }
        super.insert(cartItem, ip);
        return result;
    }

    public static void main(String[] args) {
        CartItemDAO dao = new CartItemDAO();
        Cart cart = new Cart(1, 1, null, null);
        CartItem cartItem = new CartItem(10, 1,1,100,new Timestamp(Calendar.getInstance().getTimeInMillis()), null);
        for(CartItem c : dao.selectByCart(cart)) {
            System.out.println(c);
        }
    }
}
