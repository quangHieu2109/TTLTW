package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import database.JDBCUtil;
import model.DangKyDangBai;
import model.NguoiDung;

public class DangKyDangBaiDao {
	public static ArrayList<DangKyDangBai> selectAll() {
		ArrayList<DangKyDangBai> result = new ArrayList<DangKyDangBai>();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from danhsachdangky order by ngayDK asc";
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maDK = rs.getString("maDK");
				NguoiDung nguoiDung = NguoiDungDAO.selectByTenDangNhap(rs.getString("tenDangNhap"));
				Timestamp ngayDK = rs.getTimestamp("ngayDK");
				result.add(new DangKyDangBai(maDK, nguoiDung, ngayDK));
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}
	public static DangKyDangBai selectByMaDK(String maDK) {
		DangKyDangBai result = null;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from danhsachdangky where maDK=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, maDK);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				
				NguoiDung nguoiDung = NguoiDungDAO.selectByTenDangNhap(rs.getString("tenDangNhap"));
				Timestamp ngayDK = rs.getTimestamp("ngayDK");
				result=(new DangKyDangBai(maDK, nguoiDung, ngayDK));
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	public static int insertDK(DangKyDangBai dangBai) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "insert into danhsachdangky (maDK, tenDangNhap, ngayDK)"
					+ " values(?,?,?)";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, dangBai.getMaDK());
			st.setString(2, dangBai.getNguoiDung().getTenDangNhap());
			st.setTimestamp(3, dangBai.getNgayDK());
			result = st.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}
	public static int remove(String maDK) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "delete from danhsachdangky where maDK=?";
					
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, maDK);
			result = st.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}
}
