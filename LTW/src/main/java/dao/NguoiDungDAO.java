package dao;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.protocol.Resultset;

import database.JDBCUtil;
import model.BaiBao;
import model.NguoiDung;
import model.TheLoai;

public class NguoiDungDAO {
	public static List<NguoiDung> selectAll() {
		List<NguoiDung> result = new ArrayList<NguoiDung>();
		//
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from nguoidung";
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String tenNguoiDung = rs.getString("tenDangNhap");
				String matKhau = rs.getString("matKhau");
				String hoVaTen = rs.getString("hoVaTen");
				String email = rs.getString("email");
				Date ngaySinh = rs.getDate("ngaySinh");
				String avt = rs.getString("avt");
				String theLoai = rs.getString("loaiTaiKhoan");
						
				result.add(new NguoiDung(tenNguoiDung, matKhau, hoVaTen, email, ngaySinh, avt, theLoai));
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	public static NguoiDung selectByTenDangNhap(String tenDN) {
		NguoiDung result = null;
		//
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from nguoidung where tenDangNhap=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, tenDN);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String tenNguoiDung = rs.getString("tenDangNhap");
				String matKhau = rs.getString("matKhau");
				String hoVaTen = rs.getString("hoVaTen");
				String email = rs.getString("email");
				Date ngaySinh = rs.getDate("ngaySinh");
				String avt = rs.getString("avt");
				String theLoai = rs.getString("loaiTaiKhoan");
						
				result=(new NguoiDung(tenNguoiDung, matKhau, hoVaTen, email, ngaySinh, avt, theLoai));
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	public static int insertNguoiDung(NguoiDung nguoiDung) {
		int result = 0;
		try {

			Connection conn = JDBCUtil.getConnection();
			String sql = "insert into nguoidung (tenDangNhap, matKhau, hoVaTen, email, ngaySinh)"
					+ " values (?,?,?,?,?)";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, nguoiDung.getTenDangNhap());
			st.setString(2, nguoiDung.getMatKhau());
			st.setString(3, nguoiDung.getHoVaTen());
			st.setString(4, nguoiDung.getEmail());
			st.setDate(5, nguoiDung.getNgaySinh());
			result = st.executeUpdate();

//			sql="insert into nguoidung (tenDangNhap, matKhau, hoVaTen, email, ngaySinh) "
//					+ "values ('"+nguoiDung.getTenDangNhap()+"','"+nguoiDung.getMatKhau()+"','"+nguoiDung.getHoVaTen()+"','"+nguoiDung.getEmail()+"','"+nguoiDung.getNgaySinh()+"')";

			st.close();
//			conn.close();

		} catch (Exception e) {
			// TODO: handle exception
		}
		return result; // so dong thay doi
	}

	public static int removeNguoiDung(NguoiDung nguoiDung) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "delete from nguoidung where tenDangNhap=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, nguoiDung.getTenDangNhap());
			result = st.executeUpdate();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result; // so dong thay doi
	}
	public static int updateLoaiTK(NguoiDung nguoiDung) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "update nguoidung set loaiTaiKhoan=? where tenDangNhap=?";
			PreparedStatement st = conn.prepareStatement(sql);

			
			st.setString(1, nguoiDung.getTheLoaiND());
			st.setString(2, nguoiDung.getTenDangNhap());
			result = st.executeUpdate();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result; // so dong thay doi
	}
	public static int updateNguoiDung(NguoiDung nguoiDung) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "update nguoidung set matKhau =?, hoVaten=?, email=?, ngaySinh=?, avt=?, loaiTaiKhoan=? where tenDangNhap=?";
			PreparedStatement st = conn.prepareStatement(sql);

			st.setString(1, nguoiDung.getMatKhau());
			st.setString(2, nguoiDung.getHoVaTen());
			st.setString(3, nguoiDung.getEmail());
			st.setDate(4, nguoiDung.getNgaySinh());
			st.setString(5, nguoiDung.getAvt());
			st.setString(6, nguoiDung.getTheLoaiND());
			st.setString(7, nguoiDung.getTenDangNhap());
			result = st.executeUpdate();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result; // so dong thay doi
	}

	public static NguoiDung checkNguoiDung(String tenDangNhap, String matKhau) {
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "SELECT * FROM nguoidung WHERE tenDangNhap = ? AND matKhau = ?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, tenDangNhap);
			st.setString(2, matKhau);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				
				return new NguoiDung(rs.getString("tenDangNhap"), rs.getString("matKhau"), rs.getString("hoVaTen"),
						rs.getString("email"), rs.getDate("ngaySinh"), rs.getString("avt"), rs.getString("loaiTaiKhoan"));
//				conn.close();
			} else {
//				conn.close();
				return null;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}

	public static void main(String[] args) {
		JDBCUtil.connection();
		NguoiDungDAO dao = new NguoiDungDAO();
		System.out.println(dao.insertNguoiDung(new NguoiDung("123123", null, null, null, null)));
		;
//		for(NguoiDung ng : dao.getDSNguoiDung()) {
//			System.out.println(ng);
//		}
//		System.out.println(dao.updateNguoiDung(new NguoiDung("hiu3", "123123456", "Quang Hiu", "asb@gmail.com", null)));;
//		System.out.println(dao.selectByTenDangNhap("hiu3"));
	}
}
