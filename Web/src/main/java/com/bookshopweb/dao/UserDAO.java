package com.bookshopweb.dao;

import com.bookshopweb.beans.User;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class UserDAO extends AbsDAO<User> {
    public User selectPrevalue(Long id){
        User result = null;
        Connection conn = JDBCUtils.getConnection();
        try {
            String sql = "select * from user where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                int gender = rs.getInt("gender");
                String address = rs.getString("address");
                String role = rs.getString("role");
                Timestamp createAt = rs.getTimestamp("createAt");
                result = new User(id, username, password, fullname, email, phoneNumber, gender, address, role, createAt);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
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
                Timestamp createAt = rs.getTimestamp("createAt");
               result = new User(id, userName, password, fullname, email, phoneNumber, gender, address, role, createAt);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override
    public int delete(User user, String ip) {

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
        super.delete(user, ip);
        return result;
    }

    @Override
    public int update(User user, String ip) {
        super.update(user,ip);
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
    public int insert(User user, String ip) {

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
        super.insert(user, ip);
        return result;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        User user = new User(10, "hiu", "111", "Quang Hieu", "","123123123", 1,"","",null);
        System.out.println(dao.update(user, "123123"));
    }
}
