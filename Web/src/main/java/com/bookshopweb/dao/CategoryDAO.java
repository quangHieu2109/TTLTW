package com.bookshopweb.dao;

import com.bookshopweb.beans.Category;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CategoryDAO extends AbsDAO<Category>{
    @Override
    public int delete(Category category, String ip) {

         int result = 0;
         try{
             String sql = "delete from category where id=?";
             PreparedStatement ps = conn.prepareStatement(sql);
             ps.setLong(1,category.getId());
             result = ps.executeUpdate();

         }catch (Exception e) {
             e.printStackTrace();
         }
        super.delete(category, ip);
         return result;

    }
    @Override
    public int update(Category category, String ip) {
        super.update(category, ip);
        int result = 0;
        try{
            String sql = "update category " +
                    "set id=?, name=?, description=?,imageName=?" +
                    "where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1,category.getId());
            ps.setString(2,category.getName());
            ps.setString(3,category.getDescription());
            ps.setString(4,category.getImageName());
            result= ps.executeUpdate();

        }catch (Exception e) {
            e.printStackTrace();
        }

        return result;

    }

    @Override
    public Category selectPrevalue(Long id) {
        Category result = null;
        try {
            String sql = "select * from category where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                String name = rs.getString("name");
                String description = rs.getString("description");
                String imageName = rs.getString("imageName");
                result = new Category(id, name, description, imageName);
             }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int insert(Category category, String ip) {

    int result = 0;
    try{
        String sql = "insert into category (id, name, description, imageName)\" +\n" +
                "                     \" values(?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1,category.getId());
        ps.setString(2, category.getName());
        ps.setString(3, category.getDescription());
        ps.setString(4, category.getImageName());
        result = ps.executeUpdate();
        ps.close();

    }catch (Exception e) {
        e.printStackTrace();
    }
        super.insert(category, ip);
    return result;

    }
}
