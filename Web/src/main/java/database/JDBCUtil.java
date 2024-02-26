package database;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JDBCUtil {
	private static Connection conn = null;
	private static DataSource dataSource ;

	public static void connection() {
		if(conn == null) {
			try {
				// Đăng ký MySQL Driver với DriverManager
				
				DriverManager.registerDriver(new com.mysql.jdbc.Driver());

				// Các thông số
				String url = "jdbc:mySQL://localhost:3306/web";
				String username = "root";
				String password = ""; 

				// Tạo kết nối
				conn = DriverManager.getConnection(url, username, password);
				System.out.println("Kết nối thành công");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("Kết nối thất bại");
				e.printStackTrace();
			}

		}
	}

	public static Connection getConnection() {
//		connection();
		return conn;
//		try {
//	         // Look up the DataSource
//	         Context initContext = new InitialContext();
//	         Context envContext = (Context) initContext.lookup("java:/comp/env"); 
//	         dataSource = (DataSource) envContext.lookup("jdbc/yourDB");
//	         return dataSource.getConnection();
//	     } catch (Exception e) {
//	         e.printStackTrace();
//	     }
//		return null;
	}



	public static void closeConnection() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws SQLException {
		JDBCUtil.connection();
		Connection con = JDBCUtil.getConnection();
		String sql = "insert into nguoidung values ('hiu3','123123','Ngo Quang Hieu', null, null)";
		PreparedStatement st = con.prepareStatement(sql);
		System.out.println(st.executeUpdate());
//		JDBCUtil.backup();
		JDBCUtil.closeConnection();
	}
}
