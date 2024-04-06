package com.bookshopweb.dao;

import com.bookshopweb.beans.*;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {
    private Connection conn = JDBCUtils.getConnection();
    public List<Address> selectByUser(long userId){
        List<Address> result = new ArrayList<>();
        try {
            String sql = "select * from address where userId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, userId);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
            long id = rs.getLong("id");
            String houseNumber = rs.getString("houseNumber");
            String province = rs.getString("province");
            String district = rs.getString("district");
            String ward = rs.getString("ward");
            Address ad = new Address(id, userId, province, district, ward, houseNumber);

            result.add(ad);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    public int insertAddress(Address address){
        int result =0;
        try {
            String sql = "insert into address (id, userId, houseNumber,province,district,ward) " +
                    "values(?,?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, address.getId());
            st.setLong(2, address.getUserId());
            st.setString(3, address.getHouseNumber());
            st.setString(4, address.getProvince());
            st.setString(5, address.getDistrict());
            st.setString(6, address.getWard());
            result = st.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public int updateAddress(Address address){
        int result =0;
        try {
            String sql = "update address set houseNumber=?, province=?, district=?, ward=? where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, address.getHouseNumber());
            st.setString(2, address.getProvince());
            st.setString(3, address.getDistrict());
            st.setString(4, address.getWard());
            st.setLong(5, address.getId());
            result = st.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }


}
