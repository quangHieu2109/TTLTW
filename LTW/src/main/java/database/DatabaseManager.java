package database;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import model.BaiBao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class DatabaseManager {

    private static DataSource dataSource;

    public DatabaseManager() {
        try {
            // Look up the DataSource
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/YourDB");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
public static Connection getConnection() {
	 try {
         // Look up the DataSource
         Context initContext = new InitialContext();
         Context envContext = (Context) initContext.lookup("java:/comp/env"); 
         dataSource = (DataSource) envContext.lookup("jdbc/yourDB");
         return dataSource.getConnection();
     } catch (Exception e) {
    	 System.out.println(567567567);
         e.printStackTrace();
     }
	return null;
}
    public void performDatabaseOperation() {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        try {
            // Get a connection from the pool
            connection = dataSource.getConnection();

            // Use the connection for database operations
            String sql = "SELECT baibao.maBaiBao, baibao.tenBaiBao, baibao.moTa, baibao.tenDangNhap, baibao.filePath, baibao.noiDung, baibao.ngayDang, baibao.tenBaiBao, baibao.luotXem "
    				+ "FROM baibao INNER JOIN xuhuong ON baibao.maBaiBao = xuhuong.maBaiBao WHERE xuhuong.ngayXuHuong =?";
            preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();

            // Process the result set or perform other database operations
            while (rs.next()) {
                // Extract data from the result set
                // Example: String columnName = resultSet.getString("column_name");
            	String maBaiBao = rs.getString("maBaiBao");
    			String tenBaiBao = rs.getString("tenBaiBao");
    			String moTa = rs.getString("moTa");
    			String filePath = rs.getString("filePath");
    			String noiDung = rs.getString("noiDung");
    			Timestamp ngayDang = rs.getTimestamp("ngayDang");
    			String tenDangNhap = rs.getString("tenDangNhap");
    			int luotXem = rs.getInt("luotXem");

    			BaiBao baiBao = new BaiBao(maBaiBao, tenBaiBao, moTa, filePath, noiDung, ngayDang, null, luotXem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (rs != null) rs.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        DatabaseManager dbManager = new DatabaseManager();
        dbManager.performDatabaseOperation();
    }
}
