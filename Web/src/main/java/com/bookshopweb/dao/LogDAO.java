package com.bookshopweb.dao;

import com.bookshopweb.beans.Log;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class LogDAO {
    Connection conn = JDBCUtils.getConnection();
    public List<Log> selectAll(){
        List<Log> result = new ArrayList<>();
        try {
            String sql = "select * from log";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()){
                long id = rs.getLong("id");
                String ip = rs.getString("ip");
                int levelLog = rs.getInt("levelLog");
                String res = rs.getString("res");
                String preValue = rs.getString("preValue");
                String curValue = rs.getString("curValue");
                Timestamp createAt = rs.getTimestamp("createAt");
                Timestamp updateAt = rs.getTimestamp("updateAt");
                result.add(new Log(id, ip, levelLog, res, preValue, curValue, createAt, updateAt));
            }
            rs.close();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public int insert(Log log) {
        int result =0;
        try {
            String sql = "insert into log(id, ip, levelLog, res, preValue, curValue, createAt, updateAt) " +
                    "values(?,?,?,?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, log.getId());
            st.setString(2, log.getIp());
            st.setInt(3, log.getLevelLog());
            st.setString(4, log.getResource());
            st.setString(5, log.getPreValue());
            st.setString(6, log.getCurValue());
            st.setTimestamp(7, log.getCreateAt());
            st.setTimestamp(8, log.getUpdateAt());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    public int update(Log log) {
        int result =0;
        try {
            String sql = "update log set levelLog=? where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, log.getLevelLog());
            st.setLong(2, log.getId());
            result = st.executeUpdate();
            st.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public int delete(Log log) {
        int result =0;
        try {
            String sql = "delete from log where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, log.getId());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public static void main(String[] args) {
        Log log = new Log(1, "4564256", 11, "rs11", "pre", "cur", null, null);
        LogDAO dao = new LogDAO();
       for(Log l : dao.selectAll()){
           System.out.println(l);
       }
    }
}
