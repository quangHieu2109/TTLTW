package dao;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import database.JDBCUtil;
import model.BaiBao;
import model.BinhLuan;
import model.NguoiDung;
import model.TheLoai;

public class BinhLuanDAO extends GeneralDAO {
	public  static List<BinhLuan> selectAll(String id) {
		List<BinhLuan> result = new ArrayList<BinhLuan>();
		//
		return result;
	}

	public  static ArrayList<BinhLuan> selectByBaiBao(BaiBao baiBao) {
		ArrayList<BinhLuan> result = new ArrayList<BinhLuan>();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from binhluan where maBaiBao=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, baiBao.getMaBaiBao());
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBinhLuan = rs.getString("maBinhLuan");
				String tenDangNhap = rs.getString("tenDangNhap");
				String noiDung = rs.getString("noiDung");
				Date ngayBinhLuan = rs.getDate("ngayBinhLuan");
				NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				result.add(new BinhLuan(maBinhLuan, nguoiDung, ngayBinhLuan, noiDung, baiBao));
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	public  static int insertBinhLuan(BinhLuan binhLuan) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "insert into binhluan(maBinhLuan, tenDangNhap, maBaiBao, noiDung, ngayBinhLuan)"
					+ " values (?,?,?,?,?)";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, binhLuan.getMaBinhLuan());
			st.setString(2, binhLuan.getNguoiDung().getTenDangNhap());
			st.setString(3, binhLuan.getBaiBao().getMaBaiBao());
			st.setString(4, binhLuan.getNoiDung());
			st.setDate(5, binhLuan.getNgayBinhLuan());

			result = st.executeUpdate();

			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;

	}

	public static  int removeBinhLuan(BinhLuan binhLuan) {
		int result = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "delete from binhluan where maBinhLuan=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, binhLuan.getMaBinhLuan());
			result = st.executeUpdate();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	public static void main(String[] args) {
		JDBCUtil.connection();
		BinhLuanDAO dao = new BinhLuanDAO();
		BinhLuan binhLuan = new BinhLuan("bl1234", new NguoiDung("hiu3", null, null, null, null), null, "asdasd",
				new BaiBao("bb1", null, null, null, null, null, null, 0, null, null));
//	for(BinhLuan bl:dao.selectByBaiBao(new BaiBao("bb1", null, null, null, null, null, null, 0, null, null))) {
//		System.out.println(bl);
//	}
	System.out.println(dao.insertBinhLuan(binhLuan));
//	dao.removeBinhLuan(binhLuan);
		JDBCUtil.closeConnection();
	}
}
