package com.bookshopweb.dao;

import com.bookshopweb.beans.ProductReview;

import java.sql.PreparedStatement;

public class ProductReviewDAO extends AbsDAO<ProductReview> {
    @Override
    public int insert(ProductReview productReview) {
         super.insert(productReview);
         int result = 0;
         try {
             String sql = "insert into product_review (id, userId, productId, ratingScore, content, isShow, createdAt, updatedAt)" +
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
        return result;
    }

    @Override
    public int update(ProductReview productReview) {
         super.update(productReview);
        int result = 0;
        try {

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int delete(ProductReview productReview) {
         super.delete(productReview);
        int result = 0;

        return result;
    }
}
