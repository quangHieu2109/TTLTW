package com.bookshopweb.dao;

import com.bookshopweb.beans.Product;
import com.bookshopweb.beans.ProductReview;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;

public class ProductReviewDAO extends AbsDAO<ProductReview> {
    public ProductReview selectPrevalue(Long id){
        ProductReview result = null;
        try {
            String sql = "select * from product_review where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long userId = rs.getLong("userId");
                long productId = rs.getLong("productId");
                int ratingScore = rs.getInt("ratingScore");
                String content = rs.getString("content");
                int isShow = rs.getInt("isShow");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result = new ProductReview(id, userId, productId, ratingScore, content, isShow, createdAt, updatedAt);
                rs.close();
                st.close();
            }
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public ProductReview selectByProduct(Product product){
        ProductReview result = null;
        try {
            String sql = "select * from product_review where productId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, product.getId());
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long id = rs.getLong("id");
                long userId = rs.getLong("userId");
                long productId = rs.getLong("productId");
                int ratingScore = rs.getInt("ratingScore");
                String content = rs.getString("content");
                int isShow = rs.getInt("isShow");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                result = new ProductReview(id, userId, productId, ratingScore, content, isShow, createdAt, updatedAt);
                rs.close();
                st.close();
            }
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override
    public int insert(ProductReview productReview, String ip) {

         int result = 0;
         try {
             String sql = "insert into wishlist_item (id, userId, productId, ratingScore, content, isShow, createdAt, updatedAt)" +
                     " values(?,?,?,?,?,?,?,?)";
             PreparedStatement st = conn.prepareStatement(sql);
             st.setLong(1,productReview.getId());
             st.setLong(2, productReview.getUserId());
             st.setLong(3, productReview.getProductId());
             st.setInt(4, productReview.getRatingScore());
             st.setString(5, productReview.getContent());
             st.setInt(6, productReview.getIsShow());
             st.setTimestamp(7, productReview.getCreatedAt());
             st.setTimestamp(8, productReview.getUpdatedAt());
             result = st.executeUpdate();
             st.close();

         } catch (Exception e) {
             throw new RuntimeException(e);
         }
        super.insert(productReview, ip);
        return result;
    }

    @Override
    public int update(ProductReview productReview, String ip) {
        super.update(productReview, ip);
        int result = 0;
        try {
            String sql = "update product_review set id=?, userId=?, productId=?, ratingScore=?, content=?, isShow=?, createdAt=?, updatedAt=?" +
                    " where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1,productReview.getId());
            st.setLong(2, productReview.getUserId());
            st.setLong(3, productReview.getProductId());
            st.setInt(4, productReview.getRatingScore());
            st.setString(5, productReview.getContent());
            st.setInt(6, productReview.getIsShow());
            st.setTimestamp(7, productReview.getCreatedAt());
            st.setTimestamp(8, productReview.getUpdatedAt());
            st.setLong(9, productReview.getProductId());
            result = st.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    @Override
    public int delete(ProductReview productReview, String ip) {

        int result = 0;
        try {
            String sql = "delete from product_review where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, productReview.getId());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        super.delete(productReview, ip);
        return result;
    }
}
