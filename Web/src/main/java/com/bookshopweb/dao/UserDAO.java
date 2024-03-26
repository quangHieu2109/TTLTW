package com.bookshopweb.dao;

import com.bookshopweb.beans.User;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO extends AbsDAO<User> {
    public User selectByUserName(String userName){
        User result = null;
        Connection conn = JDBCUtils.getConnection();
        try {
            String sql = "select * from user where username =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, userName);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Long id = rs.getLong("id");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                int gender = rs.getInt("gender");
                String address = rs.getString("address");
                String role = rs.getString("role");
               result = new User(id, userName, password, fullname, email, phoneNumber, gender, address, role);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override
    public int delete(User user) {
        super.delete(user);
        int result =0;
        Connection conn = JDBCUtils.getConnection();

        try {
            String sql = "delete from user where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, user.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @Override
    public int update(User user) {
        super.update(user);
        int result  = 0;
        Connection conn = JDBCUtils.getConnection();
        try {
            String sql = "update user " +
                    "set password=?, fullname=?, email=?, phoneNumber=?,gender=?, address=?, role=?" +
                    "where id=?";

            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, user.getPassword());
            st.setString(2, user.getFullname());
            st.setString(3, user.getEmail());
            st.setString(4, user.getPhoneNumber());
            st.setInt(5, user.getGender());
            st.setString(6, user.getAddress());
            st.setString(7, user.getRole());
            st.setLong(8, user.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    @Override
    public int insert(User user) {
         super.insert(user);
         int result = 0;
         Connection conn = JDBCUtils.getConnection();
         try {
             String sql = "insert into user(id, username, password, fullname, email, phoneNumber, gender, address, role ) " +
                     "values(?,?,?,?,?,?,?,?,?)";
             PreparedStatement st = conn.prepareStatement(sql);
             st.setLong(1, user.getId());
             st.setString(2, user.getUsername());
             st.setString(3, user.getPassword());
             st.setString(4, user.getFullname());
             st.setString(5, user.getEmail());
             st.setString(6, user.getPhoneNumber());
             st.setInt(7, user.getGender());
             st.setString(8, user.getAddress());
             st.setString(9, user.getRole());
             result = st.executeUpdate();
             st.close();


         } catch (Exception e) {
             throw new RuntimeException(e);
         }
        return result;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        User user = new User(10, "hiu", "456456456", "Quang Hieu", "","123123123", 1,"","");
        System.out.println(dao.selectByUserName("hiu"));
    }
}
