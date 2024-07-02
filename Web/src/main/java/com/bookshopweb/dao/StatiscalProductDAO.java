package com.bookshopweb.dao;

import com.bookshopweb.beans.StatisticalProduct;
import com.bookshopweb.utils.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StatiscalProductDAO {
    private Connection conn = JDBCUtils.getConnection();

    public List<StatisticalProduct> getAll() {
        List<StatisticalProduct> result = new ArrayList<>();
        try {
            String sql = "SELECT pd.id, pd.name,  \n" +
                    "COALESCE((SELECT SUM(product_import.quanlity) FROM product_import \n" +
                    "WHERE product_import.productId=pd.id), 0) AS import_quatity,\n" +
                    "COALESCE((SELECT SUM(order_item.quantity) \n" +
                    "FROM order_item \n" +
                    "INNER JOIN orders ON order_item.orderId = orders.id \n" +
                    "WHERE order_item.productId = pd.id AND orders.status != 3 ), 0) AS sell_quantityitem, \n" +
                    "COALESCE((SELECT SUM(order_item.price) \n" +
                    "FROM order_item \n" +
                    "INNER JOIN orders ON order_item.orderId = orders.id \n" +
                    "WHERE order_item.productId = pd.id AND orders.status != 3), 0) AS total_sell_price,\n" +
                    "COALESCE((SELECT SUM(product_import.quanlity * product_import.price) \n" +
                    "FROM product_import \n" +
                    "WHERE product_import.productId=pd.id), 0) AS total_import_price\n" +
                    "FROM product pd";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            result = getFromResultset(rs);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    // Lấy số lượng tồn kho và sô lượng bán trong 1 khoảng thời gian
    // để biết số lượng tồn kho có đủ để bán hay không => có cần nhập thêm không
    public List<StatisticalProduct> getUnsold(String start, String end) {
        List<StatisticalProduct> result = new ArrayList<>();
        try {
            String sql =
                    "SELECT pd.id, pd.name,  \n" +

                            "COALESCE((SELECT SUM(order_item.quantity)\n" +
                            "              FROM order_item \n" +
                            "              INNER JOIN orders ON order_item.orderId = orders.id\n" +
                            "              WHERE order_item.productId = pd.id AND orders.status != 3 \n" +
                            "  AND (orders.createdAt BETWEEN ? AND ?)), 0) AS sell_quantityitem,\n" +
                            "COALESCE((SELECT SUM(order_item.quantity)\n" +
                            "              FROM order_item \n" +
                            "              INNER JOIN orders ON order_item.orderId = orders.id\n" +
                            "              WHERE order_item.productId = pd.id AND orders.status != 3 \n" +
                            "  ), 0) AS total_sell_quantityitem,\n" +

                            " COALESCE((SELECT SUM(product_import.quanlity) \n" +
                            "               FROM product_import\n" +
                            "               WHERE product_import.productId=pd.id \n" +
                            "  ), 0) AS total_import_quatity" +
                            "\n" +
                            "FROM product pd\n" +
                            "HAVING sell_quantityitem=0";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, start);
            st.setString(2, end);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                int quantitySell = rs.getInt("sell_quantityitem");
                int totalQuantityImport = rs.getInt("total_import_quatity");
                int totalQuantitySell = rs.getInt("total_sell_quantityitem");
                result.add(new StatisticalProduct(id, name, totalQuantityImport-totalQuantitySell, quantitySell));

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    // Thống kê tỉ lệ nhập so với tỉ lệ bán, số lượng tồn kho
    public List<StatisticalProduct> getSaleRate(String start, String end) {
        List<StatisticalProduct> result = new ArrayList<>();
        try {
            String sql =
                    "SELECT pd.id, pd.name,  \n" +

                            "COALESCE((SELECT SUM(order_item.quantity)\n" +
                            "              FROM order_item \n" +
                            "              INNER JOIN orders ON order_item.orderId = orders.id\n" +
                            "              WHERE order_item.productId = pd.id AND orders.status != 3 \n" +
                            "  AND (orders.createdAt BETWEEN ? AND ?)), 0) AS sell_quantityitem,\n" +
                            "COALESCE((SELECT SUM(order_item.quantity)\n" +
                            "              FROM order_item \n" +
                            "              INNER JOIN orders ON order_item.orderId = orders.id\n" +
                            "              WHERE order_item.productId = pd.id AND orders.status != 3 \n" +
                            "  ), 0) AS total_sell_quantityitem,\n" +
                            "COALESCE((SELECT SUM(product_import.quanlity) \n" +
                            "FROM product_import\n" +
                            "WHERE product_import.productId=pd.id \n" +
                            "AND (product_import.importAt BETWEEN ? AND ?)), 0) AS import_quatity, "+

                            " COALESCE((SELECT SUM(product_import.quanlity) \n" +
                            "               FROM product_import\n" +
                            "               WHERE product_import.productId=pd.id \n" +
                            "  ), 0) AS total_import_quatity" +
                            "\n" +
                            "FROM product pd\n" +
                            "HAVING sell_quantityitem=0";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, start);
            st.setString(2, end);
            st.setString(3, start);
            st.setString(4, end);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                int quantitySell = rs.getInt("sell_quantityitem");
                int totalQuantityImport = rs.getInt("total_import_quatity");
                int totalQuantitySell = rs.getInt("total_sell_quantityitem");
                int quantityImport = rs.getInt("import_quatity");
                double saleRate = (quantityImport >0)?quantitySell/quantityImport:1;
                result.add(new StatisticalProduct(id, name, quantityImport, quantitySell, totalQuantityImport-totalQuantitySell, saleRate));

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    // THống kê doanh thu của từng sản phẩm trong một khoảng thời gian
    public List<StatisticalProduct> getRevenue(String start, String end) {
        List<StatisticalProduct> result = new ArrayList<>();
        try {
            String sql =
                    "SELECT pd.id, pd.name,  " +

                            "COALESCE((SELECT SUM(order_item.quantity)\n" +
                            "              FROM order_item \n" +
                            "              INNER JOIN orders ON order_item.orderId = orders.id\n" +
                            "              WHERE order_item.productId = pd.id AND orders.status != 3 \n" +
                            "  AND (orders.createdAt BETWEEN ? AND ?)), 0) AS sell_quantityitem,\n" +
                            "\n" +
                            " COALESCE((SELECT SUM(order_item.price)\n" +
                            "              FROM order_item \n" +
                            "              INNER JOIN orders ON order_item.orderId = orders.id\n" +
                            "              WHERE order_item.productId = pd.id AND orders.status != 3 \n" +
                            "  AND (orders.createdAt BETWEEN ? AND ?)), 0) AS total_sell_price\n" +
                            "\n" +
                            "FROM product pd\n" +
                            "HAVING total_sell_price>0";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, start);
            st.setString(2, end);
            st.setString(3, start);
            st.setString(4, end);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                int quantity = rs.getInt("sell_quantityitem");
                double totalPrice = rs.getDouble("total_sell_price");
                result.add(new StatisticalProduct(id, name, quantity, totalPrice));

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public List<StatisticalProduct> getFromResultset(ResultSet rs) {
        List<StatisticalProduct> result = new ArrayList<>();
        try {
            while (rs.next()) {
                long productId = rs.getLong("id");
                String name = rs.getString("name");
                int importQuantity = rs.getInt("import_quatity");
                int sellQuantity = rs.getInt("sell_quantityitem");
                double totalSellPrice = rs.getDouble("total_sell_price");
                double totalImportPrice = rs.getDouble("total_import_price");
                result.add(new StatisticalProduct(productId, name, importQuantity, sellQuantity, totalImportPrice, totalSellPrice));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }
public int getRemainingAmount(long productId){
        int result =0;

        return result;
}
    public static void main(String[] args) {
        StatiscalProductDAO dao = new StatiscalProductDAO();
        for (StatisticalProduct s : dao.getSaleRate("2020-1-1","2025-1-1")) {
            System.out.println(s);
        }
    }
}
