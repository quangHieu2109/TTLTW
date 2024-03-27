package com.bookshopweb.dao;

import com.bookshopweb.beans.WishlistItem;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class WishlistItemDAO extends AbsDAO<WishlistItem>{

    @Override
    public int delete(WishlistItem wishlistItem, String ip) {

        int result = 0;
        try{
            String sql = "delete from wishlist_item where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1,wishlistItem.getId());
            result = ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
           e.printStackTrace();
        }
        super.delete(wishlistItem, ip);
        return result;
    }

    @Override
    public int update(WishlistItem wishlistItem, String ip) {
        super.update(wishlistItem, ip);        int result = 0;
        try{
            String sql = "update wishlist_item set id=?, userId=?, productId=?,createdAt=?" +
                    " where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1,wishlistItem.getId());
            ps.setLong(2, wishlistItem.getUserId());
            ps.setLong(3, wishlistItem.getProductId());
            ps.setTimestamp(4,wishlistItem.getCreatedAt());
            ps.setLong(5,wishlistItem.getId());
            result = ps.executeUpdate();
            ps.close();

        }   catch (Exception e) {

        }

        return result;
    }

    @Override
    public WishlistItem selectPrevalue(Long id) {
        WishlistItem result = null;
        try {
            String sql = "select * from wishlist_item where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()){
                long userId = rs.getLong("userId");
                long productId= rs.getLong("productId");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                result = new WishlistItem(id, userId, productId, createdAt);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int insert(WishlistItem wishlistItem, String ip) {

      int result = 0;
      try{
          String sql = "insert into product_review (id, userId, productId, createdAt)" +
                  " values(?,?,?,?)";
          PreparedStatement st = conn.prepareStatement(sql);
          st.setLong(1,wishlistItem.getId());
          st.setLong(2, wishlistItem.getUserId());
          st.setLong(3, wishlistItem.getProductId());
          st.setTimestamp(4,wishlistItem.getCreatedAt());
          result = st.executeUpdate();
          st.close();

      }catch (Exception e) {
          e.printStackTrace();

      }
        super.insert(wishlistItem, ip);
      return result;
    }
}
