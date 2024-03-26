package com.bookshopweb.dao;

import com.bookshopweb.beans.Category;

import java.sql.PreparedStatement;

public class CategoryDAO extends AbsDAO<Category>{
    @Override
    public int delete(Category category) {
         super.delete(category);
         int result = 0;
         try{
             String sql = "delete from category where id=?";
             PreparedStatement ps = conn.prepareStatement(sql);
             ps.setLong(1,category.getId());
             result = ps.executeUpdate();

         }catch (Exception e) {
             e.printStackTrace();
         }
         return result;

    }
    @Override
    public int update(Category category) {
        super.update(category);
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
    public int insert(Category category) {
        super.insert(category);
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
    return result;

    }}
