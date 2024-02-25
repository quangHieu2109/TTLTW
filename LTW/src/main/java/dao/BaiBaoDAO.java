package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Random;

import com.mysql.cj.x.protobuf.MysqlxCrud.Collection;

import database.DatabaseManager;
import database.JDBCUtil;
import model.BaiBao;
import model.BinhLuan;
import model.DSTheLoai;
import model.NguoiDung;

public class BaiBaoDAO {

	public static ArrayList<BaiBao> selectAll() {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from baibao";
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, nguoiDung, luotXem);
				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(dsBinhLuan);
				baiBao.setTheLoai(dsTheLoai);
				result.add(baiBao);
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		//
		return result;
	}

	public static BaiBao selectByMaBaiBao(String mabb) {
		BaiBao result = null;
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "select * from baibao where maBaiBao =?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, mabb);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, nguoiDung, luotXem);
				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(dsBinhLuan);
				baiBao.setTheLoai(dsTheLoai);
				result = baiBao;
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		//
		return result;
	}

	public ArrayList<BaiBao> select() {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();

		int i = selectAll().size() - 6;
		if (i >= 0) {
			i = (selectAll().size() - 3) / 3;
			for (int j = 3; j < i * 3 + 3; j++) {
				result.add(selectAll().get(j));
			}
		}

		return result;
	}

	public int countAll() {
		int result = 0;
//		JDBCUtil.connection();
		Connection conn = JDBCUtil.getConnection();
		try {
			String sql = "select count(*) from baibao";
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			rs.next();
			result = rs.getInt(1);
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
//		JDBCUtil.closeConnection();
		return result;
	}

	public ArrayList<BaiBao> selectOrderByTime() {
		int size = ((countAll() - 4) / 3) * 3 + 4;
		ArrayList<BaiBao> temp = new ArrayList<BaiBao>();
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
//			JDBCUtil.connection();
			Connection conn = JDBCUtil.getConnection();
			String sql = "SELECT * FROM baibao ORDER BY ngayDang DESC LIMIT " + size;
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

//				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
//				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
//				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(new ArrayList<BinhLuan>());
				baiBao.setTheLoai(null);
				result.add(baiBao);

			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return result;
		}
//		JDBCUtil.closeConnection();
		return result;
	}
	public static int selectAmount() {
		int result =0;
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement st = conn.prepareStatement("select count(*) from baibao");
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}
	public ArrayList<BaiBao> selectOrderByTime(int page) {
		ArrayList<BaiBao> temp = new ArrayList<BaiBao>();
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
//			JDBCUtil.connection();
			Connection conn = JDBCUtil.getConnection();
			String sql = "SELECT * FROM baibao ORDER BY ngayDang DESC LIMIT " + (page-1)*16+", "+16;
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

//				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
//				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
//				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(new ArrayList<BinhLuan>());
				baiBao.setTheLoai(null);
				result.add(baiBao);

			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return result;
		}
//		JDBCUtil.closeConnection();
		return result;
	}

	public static ArrayList<BaiBao> selectByTen(String tenBB) {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "Select * from baibao where tenBaiBao like ?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, "%" + tenBB.replace(' ', '%') + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

//				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
//				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
//				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(new ArrayList<BinhLuan>());
				baiBao.setTheLoai(null);
				result.add(baiBao);

			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	public static ArrayList<BaiBao> selectByTenDangNhap(String tdn) {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "Select * from baibao where tenDangNhap=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, tdn);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

//				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
//				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
//				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(new ArrayList<BinhLuan>());
				baiBao.setTheLoai(null);
				result.add(baiBao);

			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	public static ArrayList<BaiBao> selectByTheLoai(DSTheLoai theLoai) {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
		NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
		TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
		try {
			Connection conn = JDBCUtil.getConnection();
			String sql = "";
			PreparedStatement st = null;
			if (theLoai.getDsTheLoaiPhu().size() > 0) {
				sql = "SELECT baibao.maBaiBao, baibao.tenBaiBao, baibao.moTa, baibao.filePath, baibao.noiDung, baibao.ngayDang, baibao.tenDangNhap, baibao.luotXem "
						+ "FROM (baibao INNER JOIN theloaichinh ON baibao.maBaiBao = theloaichinh.maBaiBao) INNER JOIN danhsachtheloaiphu ON baibao.maBaiBao = danhsachtheloaiphu.maBaiBao "
						+ " WHERE theloaichinh.maTheLoai=? AND danhsachtheloaiphu.maTheLoai=?";
				st = conn.prepareStatement(sql);
				st.setString(1, theLoai.getTheLoaiChinh().getMaTheLoai());
				st.setString(2, theLoai.getDsTheLoaiPhu().get(0).getMaTheLoai());
			} else {
				sql = "SELECT baibao.maBaiBao, baibao.tenBaiBao, baibao.moTa, baibao.filePath, baibao.noiDung, baibao.ngayDang, baibao.tenDangNhap, baibao.luotXem "
						+ "FROM (baibao INNER JOIN theloaichinh ON baibao.maBaiBao = theloaichinh.maBaiBao) INNER JOIN danhsachtheloaiphu ON baibao.maBaiBao = danhsachtheloaiphu.maBaiBao "
						+ " WHERE theloaichinh.maTheLoai=? ";
				st = conn.prepareStatement(sql);
				st.setString(1, theLoai.getTheLoaiChinh().getMaTheLoai());
			}

			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

//				NguoiDung nguoiDung = nguoiDungDAO.selectByTenDangNhap(tenDangNhap);
				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
//				ArrayList<BinhLuan> dsBinhLuan = binhLuanDAO.selectByBaiBao(baiBao);
//				DSTheLoai dsTheLoai = theLoaiDAO.selectByBaiBao(baiBao);
				baiBao.addAllBinhLuan(new ArrayList<BinhLuan>());
				baiBao.setTheLoai(null);
				result.add(baiBao);
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	public static ArrayList<BaiBao> createXuHuong() {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		int amount = 0;
		ArrayList<BaiBao> list = selectAll();
		Random rd = new Random();
		if (list.size() <= 10) {
			result = list;
		} else {
			while (result.size() < 10) {
				Collections.shuffle(list);
				for (BaiBao bb : list) {
					if (rd.nextInt() % 2 == 0 && !result.contains(bb) && result.size() < 10) {
						result.add(bb);
					}
				}
			}
		}
		return result;
	}

	public static ArrayList<BaiBao> selectXuHuong() {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		Connection conn = JDBCUtil.getConnection();

		Date today = new Date(System.currentTimeMillis());
		try {
			String sql = "SELECT baibao.maBaiBao, baibao.tenBaiBao, baibao.moTa, baibao.tenDangNhap, baibao.filePath, baibao.noiDung, baibao.ngayDang, baibao.tenBaiBao, baibao.luotXem "
					+ "FROM baibao INNER JOIN xuhuong ON baibao.maBaiBao = xuhuong.maBaiBao WHERE xuhuong.ngayXuHuong =?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setDate(1, today);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
				result.add(baiBao);
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

		if (result.size() == 0) {
			System.out.println("create xu hướng");
			result = createXuHuong();
			insertXuHuong(result);
		}
		return result;
	}

	public static ArrayList<BaiBao> selectTopView() {
		ArrayList<BaiBao> result = new ArrayList<BaiBao>();
		Connection conn = JDBCUtil.getConnection();
		try {
			String sql = "SELECT * FROM baibao " + "ORDER BY baibao.luotXem desc " + "LIMIT 10;";
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				String maBaiBao = rs.getString("maBaiBao");
				String tenBaiBao = rs.getString("tenBaiBao");
				String moTa = rs.getString("moTa");
				String filePath = rs.getString("filePath");
				String noiDung = rs.getString("noiDung");
				Timestamp ngayDang = rs.getTimestamp("ngayDang");
				String tenDangNhap = rs.getString("tenDangNhap");
				int luotXem = rs.getInt("luotXem");

				BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
				result.add(baiBao);
			}
			rs.close();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	public static void insertXuHuong(ArrayList<BaiBao> list) {
		Connection conn = JDBCUtil.getConnection();
		Timestamp today = new Timestamp(Calendar.getInstance().getTimeInMillis());
		try {
			String sql = "insert into xuhuong (maBaiBao, ngayXuHuong) values(?,?);";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setTimestamp(2, today);
			for (BaiBao bb : list) {
				st.setString(1, bb.getMaBaiBao());
				st.executeUpdate();
			}
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public static boolean addBaiBao(BaiBao baiBao) {
//		JDBCUtil.connection();
		Connection conn = JDBCUtil.getConnection();
		try {
			String sql = "insert into baibao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, tenDangNhap, luotXem)"
					+ " values(?,?,?,?,?,?,?,?);";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, baiBao.getMaBaiBao());
			st.setString(2, baiBao.getTieuDe());
			st.setString(3, baiBao.getMoTa());
			st.setString(4, baiBao.getFilePath());
			st.setString(5, baiBao.getNoiDung());
			st.setTimestamp(6, baiBao.getNgayDang());
			st.setString(7, baiBao.getNguoiDang().getTenDangNhap());
			st.setInt(8, baiBao.getLuotXem());
			int res = st.executeUpdate();

			sql = "insert into baibao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, tenDangNhap, luotXem)"
					+ " values('" + baiBao.getMaBaiBao() + "', '" + baiBao.getTieuDe() + "', '" + baiBao.getMoTa()
					+ "', '" + baiBao.getFilePath() + "', '" + baiBao.getNoiDung() + "', '" + baiBao.getNgayDang()
					+ "', '" + baiBao.getNguoiDang().getTenDangNhap() + "'," + baiBao.getLuotXem() + ");";
			TheLoaiDAO.insertTheLoaiByBaiBao(baiBao);

//			JDBCUtil.closeConnection();
			st.close();
//			conn.close();
			return res == 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}

	public static ArrayList<BaiBao> getBaiBaoByTheLoai(String theLoaiChinh, String theLoaiPhu) {
		ArrayList<BaiBao> res = new ArrayList<BaiBao>();
		String sql = "";
		PreparedStatement ps = null;
		try {
			Connection conn = JDBCUtil.getConnection();
			if (theLoaiPhu != null) {
				sql = "Select * From (baibao inner join danhsachtheloaiphu on baibao.maBaiBao = danhsachtheloaiphu.maBaiBao) Where danhsachtheloaiphu.maTheLoai = '"
						+ theLoaiPhu + "';";
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					BaiBao baiBao = new BaiBao(rs.getString("maBaiBao"), rs.getString("tenBaiBao"),
							rs.getString("moTa"), rs.getString("filePath"), rs.getString("noiDung"),
							rs.getTimestamp("ngayDang"), new NguoiDung(), rs.getInt("luotXem"), new DSTheLoai(),
							new ArrayList<BinhLuan>());
					res.add(baiBao);

				}
				rs.close();
			} else {
				sql = "Select * From (baibao inner join theloaiChinh on baibao.maBaiBao = theloaiChinh.maBaiBao) Where theloaiChinh.maTheLoai = '"
						+ theLoaiChinh + "'";
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					BaiBao baiBao = new BaiBao(rs.getString("maBaiBao"), rs.getString("tenBaiBao"),
							rs.getString("moTa"), rs.getString("filePath"), rs.getString("noiDung"),
							rs.getTimestamp("ngayDang"), new NguoiDung(), rs.getInt("luotXem"), new DSTheLoai(),
							new ArrayList<BinhLuan>());
					res.add(baiBao);

				}
				rs.close();
			}
			ps.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	public static void updateBaiBao(BaiBao baiBao) {
		Connection conn = JDBCUtil.getConnection();

		try {
			String sql = "update baibao set "
					+ "tenBaiBao =?, moTa=?, filePath=?, noiDung=?,luotXem=? where maBaiBao =?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, baiBao.getTieuDe());
			st.setString(2, baiBao.getMoTa());
			st.setString(3, baiBao.getFilePath());
			st.setString(4, baiBao.getNoiDung());
			st.setInt(5, baiBao.getLuotXem());
			st.setString(6, baiBao.getMaBaiBao());

			int i = st.executeUpdate();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	public static void removeBaiBaoByMaBaiBao(BaiBao baiBao) {
		Connection conn = JDBCUtil.getConnection();
		try {
			String sql = "delete from baibao where maBaiBao = ?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, baiBao.getMaBaiBao());
			st.executeUpdate();
			st.close();
//			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public static void main(String[] args) {
		JDBCUtil.connection();
		BaiBaoDAO dao = new BaiBaoDAO();
//		DSTheLoai dsTheLoai = new DSTheLoai(new TheLoai("tl1", null));
//
		for (BaiBao bb : dao.selectXuHuong()) {
			System.out.println(bb);
		}
//		System.out.println("\n");
//		dsTheLoai.addTheLoai(new TheLoai("tl3", null));
//		for (BaiBao bb : dao.selectXuHuong()) {
//			System.out.println(bb);
//		}
//		System.out.println(dao.selectAmount());
//		dao.insertXuHuong(dao.createXuHuong());
		JDBCUtil.closeConnection();

	}
}
