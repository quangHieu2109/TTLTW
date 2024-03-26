package com.bookshopweb.dao;

import com.bookshopweb.beans.WishlistItem;

import java.sql.PreparedStatement;

public class WishlistItemDAO extends AbsDAO<WishlistItem>{

    @Override
    public int delete(WishlistItem wishlistItem) {
        super.delete(wishlistItem);
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
        return result;
    }

    @Override
    public int update(WishlistItem wishlistItem) {
        super.update(wishlistItem);
        int result = 0;
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
    public int insert(WishlistItem wishlistItem) {
        super.insert(wishlistItem);
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
      return result;
    }
}
