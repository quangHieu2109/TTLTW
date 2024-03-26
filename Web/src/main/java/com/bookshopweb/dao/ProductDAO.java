package com.bookshopweb.dao;

import com.bookshopweb.beans.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class ProductDAO extends AbsDAO<Product>{

    public Product selectById(Long id){
        Product result = null;
        try {
            String sql = "select * from product where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){

                String name = rs.getString("name");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                int quantity = rs.getInt("quantity");
                int totalBuy = rs.getInt("totalBuy");
                String author = rs.getString("author");
                int pages = rs.getInt("pages");
                String publisher = rs.getString("publisher");
                int yearPublishing = rs.getInt("yearPublishing");
                String description = rs.getString("description");
                String imageName = rs.getString("imageName");
                int shop = rs.getInt("shop");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                Timestamp startsAt = rs.getTimestamp("startsAt");
                Timestamp endsAt = rs.getTimestamp("endsAt");

                result = new Product(id, name, price, discount, quantity, totalBuy, author, pages, publisher,
                        yearPublishing, description, imageName, shop, createdAt, updatedAt, startsAt, endsAt);
                rs.close();
                st.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override
    public int insert(Product product) {

         super.insert(product);
         int result = 0;
        try {
            String sql = "insert into product (id, name, price, discount, quantity, totalBuy, author, pages" +
                    ", publisher, yearPublishing, description, imageName, shop, createdAt, updatedAt, startsAt, endsAt) " +
                    "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, product.getId());
            st.setString(2, product.getName());
            st.setDouble(3, product.getPrice());
            st.setDouble(4, product.getDiscount());
            st.setInt(5, product.getQuantity());
            st.setInt(6, product.getTotalBuy());
            st.setString(7, product.getAuthor());
            st.setInt(8, product.getPages());
            st.setString(9, product.getPublisher());
            st.setInt(10, product.getYearPublishing());
            st.setString(11, product.getDescription());
            st.setString(12, product.getImageName());
            st.setInt(13, product.getShop());
            st.setTimestamp(14, product.getCreatedAt());
            st.setTimestamp(15, product.getUpdatedAt());
            st.setTimestamp(16, product.getStartsAt());
            st.setTimestamp(17, product.getEndsAt());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int update(Product product) {
         super.update(product);
        int result = 0;
        try {
            String sql="update product set " +
                    "id=?, name=?, price=?, discount=?, quantity=?, totalBuy=?, author=?, pages=?,publisher=?," +
                    "yearPublishing=?, description=?, imageName=?, shop=?, createdAt=?, updatedAt=?, startsAt=?, endsAt=? " +
                    "where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, product.getId());
            st.setString(2, product.getName());
            st.setDouble(3, product.getPrice());
            st.setDouble(4, product.getDiscount());
            st.setInt(5, product.getQuantity());
            st.setInt(6, product.getTotalBuy());
            st.setString(7, product.getAuthor());
            st.setInt(8, product.getPages());
            st.setString(9, product.getPublisher());
            st.setInt(10, product.getYearPublishing());
            st.setString(11, product.getDescription());
            st.setString(12, product.getImageName());
            st.setInt(13, product.getShop());
            st.setTimestamp(14, product.getCreatedAt());
            st.setTimestamp(15, product.getUpdatedAt());
            st.setTimestamp(16, product.getStartsAt());
            st.setTimestamp(17, product.getEndsAt());
            st.setLong(18, product.getId());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;

    }

    @Override
    public int delete(Product product) {
         super.delete(product);
        int result = 0;
        try {
           String sql = "delete from product where id =?";
           PreparedStatement st = conn.prepareStatement(sql);
           st.setLong(1, product.getId());
           result = st.executeUpdate();
           st.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
}
