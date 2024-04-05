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
            Address ad = new Address(id, userId, houseNumber);
            ad.setProvince(getProvinceByAddressId(id));
            ad.setDistrict(getDistrictByAddressId(id));
            ad.setWard(getWardByAddressId(id));
            result.add(ad);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }
    public Province getProvinceByAddressId(long addressId){
        Province result = null;
        try {
            String sql = "select * from province where addressId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, addressId);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long id = rs.getLong("id");
                String name = rs.getString("provinceName");
                String code = rs.getString("provinceCode");
                result = new Province(id, addressId, name, code);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public District getDistrictByAddressId(long addressId){
        District result = null;
        try {
            String sql = "select * from district where addressId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, addressId);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long id = rs.getLong("id");
                String name = rs.getString("districtName");
                String code = rs.getString("districtCode");
                result = new District(id, addressId, name, code);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public Ward getWardByAddressId(long addressId){
        Ward result = null;
        try {
            String sql = "select * from ward where addressId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, addressId);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                long id = rs.getLong("id");
                String name = rs.getString("wardName");
                String code = rs.getString("wardCode");
                result = new Ward(id, addressId, name, code);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public int insertAddress(Address address){
        int result =0;
        try {
            String sql = "insert into address (id, userId, houseNumber) " +
                    "values(?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, address.getId());
            st.setLong(2, address.getUserId());
            st.setString(3, address.getHouseNumber());
            result = st.executeUpdate();
            result += insertProvince(address.getProvince());
            result += insertDistrict(address.getDistrict());
            result += insertWard(address.getWard());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public int insertProvince(Province province){
        int result =0;
        try {
            String sql = "insert into province (id, addressId, provinceName, provinceCode) " +
                    "values(?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, province.getId());
            st.setLong(2, province.getAddressId());
            st.setString(3, province.getName());
            st.setString(4, province.getCode());
            result = st.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public int insertDistrict(District district){
        int result =0;
        try {
            String sql = "insert into district (id, addressId, provinceName, provinceCode) " +
                    "values(?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, district.getId());
            st.setLong(2, district.getAddressId());
            st.setString(3, district.getName());
            st.setString(4, district.getCode());
            result = st.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public int insertWard(Ward ward){
        int result =0;
        try {
            String sql = "insert into ward (id, addressId, provinceName, provinceCode) " +
                    "values(?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, ward.getId());
            st.setLong(2, ward.getAddressId());
            st.setString(3, ward.getName());
            st.setString(4, ward.getCode());
            result = st.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
}
