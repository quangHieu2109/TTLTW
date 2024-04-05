//package com.bookshopweb.dao;
//
//import com.bookshopweb.beans.Product;
//import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
//import org.jdbi.v3.sqlobject.customizer.Bind;
//import org.jdbi.v3.sqlobject.customizer.BindBean;
//import org.jdbi.v3.sqlobject.customizer.Define;
//import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
//import org.jdbi.v3.sqlobject.statement.SqlQuery;
//import org.jdbi.v3.sqlobject.statement.SqlUpdate;
//
//import java.util.List;
//import java.util.Optional;
//
//@RegisterBeanMapper(Product.class)
//public interface ProductIDAO extends IDAO<Product> {
//    @Override
//    @SqlUpdate("INSERT INTO product VALUES (default, :name, :price, :discount, :quantity, " +
//               ":totalBuy, :author, :pages, :publisher, :yearPublishing, :description, " +
//               ":imageName, :shop, :createdAt, :updatedAt, :startsAt, :endsAt)")
//    @GetGeneratedKeys("id")
//    long insert(@BindBean Product product);
//
//    @Override
//    @SqlUpdate("UPDATE product SET name = :name, price = :price, discount = :discount, quantity = :quantity, " +
//               "totalBuy = :totalBuy, author = :author, pages = :pages, publisher = :publisher, " +
//               "yearPublishing = :yearPublishing, description = :description, imageName = :imageName, " +
//               "shop = :shop, updatedAt = :updatedAt, startsAt = :startsAt, endsAt = :endsAt WHERE id = :id")
//    void update(@BindBean Product product);
//
//    @Override
//    @SqlUpdate("DELETE FROM product WHERE id = :id")
//    void delete(@Bind("id") long id);
//
//    @Override
//    @SqlQuery("SELECT * FROM product WHERE id = :id")
//    Optional<Product> getById(@Bind("id") long id);
//
//    @Override
//    @SqlQuery("SELECT * FROM product")
//    List<Product> getAll();
//
//    @Override
//    @SqlQuery("SELECT * FROM product LIMIT :limit OFFSET :offset")
//    List<Product> getPart(@Bind("limit") int limit, @Bind("offset") int offset);
//
//    @Override
//    @SqlQuery("SELECT * FROM product ORDER BY <orderBy> <orderDir> LIMIT :limit OFFSET :offset")
//    List<Product> getOrderedPart(@Bind("limit") int limit, @Bind("offset") int offset,
//                                 @Define("orderBy") String orderBy, @Define("orderDir") String orderDir);
//
//    @SqlQuery("SELECT p.* " +
//              "FROM product_category pc " +
//              "JOIN product p ON pc.productId = p.id " +
//              "WHERE pc.categoryId = :categoryId " +
//              "ORDER BY p.<orderBy> <orderDir> " +
//              "LIMIT :limit OFFSET :offset")
//    List<Product> getOrderedPartByCategoryId(@Bind("limit") int limit, @Bind("offset") int offset,
//                                             @Define("orderBy") String orderBy, @Define("orderDir") String orderDir,
//                                             @Bind("categoryId") long categoryId);
//
//    @SqlQuery("SELECT COUNT(productId) FROM product_category WHERE categoryId = :categoryId")
//    int countByCategoryId(@Bind("categoryId") long categoryId);
//
//    @SqlQuery("SELECT p.* FROM product_category pc " +
//              "JOIN product p ON pc.productId = p.id " +
//              "WHERE pc.categoryId = :categoryId " +
//              "ORDER BY RAND() " +
//              "LIMIT :limit OFFSET :offset")
//    List<Product> getRandomPartByCategoryId(@Bind("limit") int limit, @Bind("offset") int offset,
//                                            @Bind("categoryId") long categoryId);
//
//    @SqlQuery("SELECT DISTINCT p.publisher " +
//              "FROM product_category pc " +
//              "JOIN product p ON pc.productId = p.id " +
//              "WHERE pc.categoryId = :categoryId " +
//              "ORDER BY p.publisher")
//    List<String> getPublishersByCategoryId(@Bind("categoryId") long categoryId);
//
//    @SqlQuery("SELECT COUNT(p.id) " +
//              "FROM product_category pc " +
//              "JOIN product p ON pc.productId = p.id " +
//              "WHERE pc.categoryId = :categoryId " +
//              "AND <filters>")
//    int countByCategoryIdAndFilters(@Bind("categoryId") long categoryId, @Define("filters") String filters);
//
//    @SqlQuery("SELECT p.* " +
//              "FROM product_category pc " +
//              "JOIN product p ON pc.productId = p.id " +
//              "WHERE pc.categoryId = :categoryId " +
//              "AND <filters> " +
//              "ORDER BY p.<orderBy> <orderDir> " +
//              "LIMIT :limit OFFSET :offset")
//    List<Product> getOrderedPartByCategoryIdAndFilters(@Bind("limit") int limit, @Bind("offset") int offset,
//                                                       @Define("orderBy") String orderBy, @Define("orderDir") String orderDir,
//                                                       @Bind("categoryId") long categoryId, @Define("filters") String filters);
//
//    @SqlQuery("SELECT COUNT(id) FROM product")
//    int count();
//
//    @SqlUpdate("INSERT product_category VALUES (:productId, :categoryId)")
//    void insertProductCategory(@Bind("productId") long productId, @Bind("categoryId") long categoryId);
//
//    @SqlUpdate("UPDATE product_category SET categoryId = :categoryId WHERE productId = :productId")
//    void updateProductCategory(@Bind("productId") long productId, @Bind("categoryId") long categoryId);
//
//    @SqlUpdate("DELETE FROM product_category WHERE productId = :productId AND categoryId = :categoryId")
//    void deleteProductCategory(@Bind("productId") long productId, @Bind("categoryId") long categoryId);
//
//    @SqlQuery("SELECT * FROM product WHERE name LIKE CONCAT('%', :query, '%') LIMIT :limit OFFSET :offset")
//    List<Product> getByQuery(@Bind("query") String query, @Bind("limit") int limit, @Bind("offset") int offset);
//
//    @SqlQuery("SELECT COUNT(id) FROM product WHERE name LIKE CONCAT('%', :query, '%')")
//    int countByQuery(@Bind("query") String query);
//}
package com.bookshopweb.dao;

import com.bookshopweb.beans.Product;
import com.bookshopweb.utils.JDBCUtils;
import com.bookshopweb.utils.Protector;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class ProductDAO extends AbsDAO<Product>{
    Connection conn = JDBCUtils.getConnection();
    public Product selectPrevalue(Long id){
        Product result = null;
        try {
            String sql = "select * from product where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){

                String name = rs.getString("name");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                int quantity = rs.getInt("quantity");
                int totalBuy = rs.getInt("totalBuy");
                String author = rs.getString("author");
                int pages = rs.getInt("pages");
                String publisher = rs.getString("publisher");
                int yearPublishing = rs.getInt("yearPublishing");
                String description = rs.getString("description");
                String imageName = rs.getString("imageName");
                int shop = rs.getInt("shop");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                Timestamp startsAt = rs.getTimestamp("startsAt");
                Timestamp endsAt = rs.getTimestamp("endsAt");

                result = new Product(id, name, price, discount, quantity, totalBuy, author, pages, publisher,
                        yearPublishing, description, imageName, shop, createdAt, updatedAt, startsAt, endsAt);

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public Product selectById(Long id){
        Product result = null;
        try {
            String sql = "select * from product where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){

                String name = rs.getString("name");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                int quantity = rs.getInt("quantity");
                int totalBuy = rs.getInt("totalBuy");
                String author = rs.getString("author");
                int pages = rs.getInt("pages");
                String publisher = rs.getString("publisher");
                int yearPublishing = rs.getInt("yearPublishing");
                String description = rs.getString("description");
                String imageName = rs.getString("imageName");
                int shop = rs.getInt("shop");
                Timestamp createdAt = rs.getTimestamp("createdAt");
                Timestamp updatedAt = rs.getTimestamp("updatedAt");
                Timestamp startsAt = rs.getTimestamp("startsAt");
                Timestamp endsAt = rs.getTimestamp("endsAt");

                result = new Product(id, name, price, discount, quantity, totalBuy, author, pages, publisher,
                        yearPublishing, description, imageName, shop, createdAt, updatedAt, startsAt, endsAt);

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    @Override
    public int insert(Product product, String ip) {


        int result = 0;
        try {
            String sql = "insert into product (id, name, price, discount, quantity, totalBuy, author, pages" +
                    ", publisher, yearPublishing, description, imageName, shop, createdAt, updatedAt, startsAt, endsAt) " +
                    "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, product.getId());
            st.setString(2, product.getName());
            st.setDouble(3, product.getPrice());
            st.setDouble(4, product.getDiscount());
            st.setInt(5, product.getQuantity());
            st.setInt(6, product.getTotalBuy());
            st.setString(7, product.getAuthor());
            st.setInt(8, product.getPages());
            st.setString(9, product.getPublisher());
            st.setInt(10, product.getYearPublishing());
            st.setString(11, product.getDescription());
            st.setString(12, product.getImageName());
            st.setInt(13, product.getShop());
            st.setTimestamp(14, product.getCreatedAt());
            st.setTimestamp(15, product.getUpdatedAt());
            st.setTimestamp(16, product.getStartsAt());
            st.setTimestamp(17, product.getEndsAt());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        super.insert(product, ip);
        return result;
    }

    @Override
    public int update(Product product, String ip) {
        super.update(product, ip);
        int result = 0;
        try {
            String sql="update product set " +
                    "id=?, name=?, price=?, discount=?, quantity=?, totalBuy=?, author=?, pages=?,publisher=?," +
                    "yearPublishing=?, description=?, imageName=?, shop=?, createdAt=?, updatedAt=?, startsAt=?, endsAt=? " +
                    "where id=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, product.getId());
            st.setString(2, product.getName());
            st.setDouble(3, product.getPrice());
            st.setDouble(4, product.getDiscount());
            st.setInt(5, product.getQuantity());
            st.setInt(6, product.getTotalBuy());
            st.setString(7, product.getAuthor());
            st.setInt(8, product.getPages());
            st.setString(9, product.getPublisher());
            st.setInt(10, product.getYearPublishing());
            st.setString(11, product.getDescription());
            st.setString(12, product.getImageName());
            st.setInt(13, product.getShop());
            st.setTimestamp(14, product.getCreatedAt());
            st.setTimestamp(15, product.getUpdatedAt());
            st.setTimestamp(16, product.getStartsAt());
            st.setTimestamp(17, product.getEndsAt());
            st.setLong(18, product.getId());
            result = st.executeUpdate();
            st.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;

    }

    @Override
    public int delete(Product product, String ip) {

        int result = 0;
        try {
            String sql = "delete from product where id =?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setLong(1, product.getId());
            result = st.executeUpdate();
            st.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        super.delete(product, ip);
        return result;
    }
    public List<Product> getAll() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM product";
        try (PreparedStatement statement = conn.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Product product = mapResultSetToProduct(resultSet);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }

    public List<Product> getPart(int limit, int offset) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM product LIMIT ? OFFSET ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, limit);
            statement.setInt(2, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = mapResultSetToProduct(resultSet);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }

    public List<Product> getOrderedPart(int limit, int offset, String orderBy, String orderDir) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM product ORDER BY " + orderBy + " " + orderDir + " LIMIT ? OFFSET ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, limit);
            statement.setInt(2, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = mapResultSetToProduct(resultSet);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }

    public List<Product> getOrderedPartByCategoryId(int limit, int offset, String orderBy, String orderDir, long categoryId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.* " +
                "FROM product_category pc " +
                "JOIN product p ON pc.productId = p.id " +
                "WHERE pc.categoryId = ? " +
                "ORDER BY p." + orderBy + " " + orderDir + " " +
                "LIMIT ? OFFSET ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            statement.setInt(2, limit);
            statement.setInt(3, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = mapResultSetToProduct(resultSet);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }

    public int countByCategoryId(long categoryId) {
        int count = 0;
        String query = "SELECT COUNT(productId) FROM product_category WHERE categoryId = ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return count;
    }

    public List<Product> getRandomPartByCategoryId(int limit, int offset, long categoryId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.* FROM product_category pc " +
                "JOIN product p ON pc.productId = p.id " +
                "WHERE pc.categoryId = ? " +
                "ORDER BY RAND() " +
                "LIMIT ? OFFSET ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            statement.setInt(2, limit);
            statement.setInt(3, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = mapResultSetToProduct(resultSet);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }

    public List<String> getPublishersByCategoryId(long categoryId) {
        List<String> publishers = new ArrayList<>();
        String query = "SELECT DISTINCT p.publisher " +
                "FROM product_category pc " +
                "JOIN product p ON pc.productId = p.id " +
                "WHERE pc.categoryId = ? " +
                "ORDER BY p.publisher";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    String publisher = resultSet.getString("publisher");
                    publishers.add(publisher);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return publishers;
    }
    public int countByCategoryIdAndFilters(long categoryId, String filters) {
        int count = 0;
        String query = "SELECT COUNT(p.id) " +
                "FROM product_category pc " +
                "JOIN product p ON pc.productId = p.id " +
                "WHERE pc.categoryId = ? " +
                "AND " + filters;
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return count;
    }

    public List<Product> getOrderedPartByCategoryIdAndFilters(int limit, int offset, String orderBy, String orderDir, long categoryId, String filters) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.* " +
                "FROM product_category pc " +
                "JOIN product p ON pc.productId = p.id " +
                "WHERE pc.categoryId = ? " +
                "AND " + filters + " " +
                "ORDER BY p." + orderBy + " " + orderDir + " " +
                "LIMIT ? OFFSET ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            statement.setInt(2, limit);
            statement.setInt(3, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = mapResultSetToProduct(resultSet);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }
    public Optional<Product> getById(long id) {
        Optional<Product> product = Optional.empty();
        String query = "SELECT * FROM product WHERE id = ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    product = Optional.of(mapResultSetToProduct(resultSet));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ
        }
        return product;
    }

    public int count() {
        int count = 0;
        String query = "SELECT COUNT(id) FROM product";
        try (PreparedStatement statement = conn.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return count;
    }

    public void insertProductCategory(long productId, long categoryId) {
        String query = "INSERT product_category VALUES (?, ?)";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, productId);
            statement.setLong(2, categoryId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
    }

    public void updateProductCategory(long productId, long categoryId) {
        String query = "UPDATE product_category SET categoryId = ? WHERE productId = ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, categoryId);
            statement.setLong(2, productId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
    }

    public void deleteProductCategory(long productId, long categoryId) {
        String query = "DELETE FROM product_category WHERE productId = ? AND categoryId = ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, productId);
            statement.setLong(2, categoryId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
    }

    public List<Product> getByQuery(String query, int limit, int offset) {
        List<Product> products = new ArrayList<>();
        String sqlQuery = "SELECT * FROM product WHERE name LIKE CONCAT('%', ?, '%') LIMIT ? OFFSET ?";
        try (PreparedStatement statement = conn.prepareStatement(sqlQuery)) {
            statement.setString(1, query);
            statement.setInt(2, limit);
            statement.setInt(3, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = mapResultSetToProduct(resultSet);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return products;
    }

    public int countByQuery(String query) {
        int count = 0;
        String sqlQuery = "SELECT COUNT(id) FROM product WHERE name LIKE CONCAT('%', ?, '%')";
        try (PreparedStatement statement = conn.prepareStatement(sqlQuery)) {
            statement.setString(1, query);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return count;
    }

    private Product mapResultSetToProduct(ResultSet resultSet) throws SQLException {
        Product product = new Product();
        product.setId(resultSet.getLong("id"));
        product.setName(resultSet.getString("name"));
        product.setPrice(resultSet.getDouble("price"));
        product.setDiscount(resultSet.getDouble("discount"));
        product.setQuantity(resultSet.getInt("quantity"));
        product.setTotalBuy(resultSet.getInt("totalBuy"));
        product.setAuthor(resultSet.getString("author"));
        product.setPages(resultSet.getInt("pages"));
        product.setPublisher(resultSet.getString("publisher"));
        product.setYearPublishing(resultSet.getInt("yearPublishing"));
        product.setDescription(resultSet.getString("description"));
        product.setImageName(resultSet.getString("imageName"));
        product.setShop(resultSet.getInt("shop"));
        product.setCreatedAt(resultSet.getTimestamp("createdAt"));
        product.setUpdatedAt(resultSet.getTimestamp("updatedAt"));
        product.setStartsAt(resultSet.getTimestamp("startsAt"));
        product.setEndsAt(resultSet.getTimestamp("endsAt"));

        return product;
    }
    public String getFirst(String twopartString) {
        return twopartString.contains("-") ? twopartString.split("-")[0] : "";
    }

    public String getLast(String twopartString) {
        return twopartString.contains("-") ? twopartString.split("-")[1] : "";
    }

    private int getMinPrice(String priceRange) {
        return Protector.of(() -> Integer.parseInt(getFirst(priceRange))).get(0);
    }

    private int getMaxPrice(String priceRange) {
        return Protector.of(() -> {
            String maxPriceString = getLast(priceRange);
            if (maxPriceString.equals("infinity")) {
                return Integer.MAX_VALUE;
            }
            return Integer.parseInt(maxPriceString);
        }).get(0);
    }

    public String filterByPublishers(List<String> publishers) {
        String publishersString = publishers.stream().map(p -> "'" + p + "'").collect(Collectors.joining(", "));
        return "p.publisher IN (" + publishersString + ")";
    }

    public String filterByPriceRanges(List<String> priceRanges) {
        String priceRangeConditions = priceRanges.stream().map(
                priceRange -> "p.price BETWEEN " + getMinPrice(priceRange) + " AND " + getMaxPrice(priceRange)
        ).collect(Collectors.joining(" OR "));
        return "(" + priceRangeConditions + ")";
    }

    public String createFiltersQuery(List<String> filters) {
        return String.join(" AND ", filters);
    }
}

