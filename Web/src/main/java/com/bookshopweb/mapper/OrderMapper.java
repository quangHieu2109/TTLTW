package com.bookshopweb.mapper;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.Product;
import com.bookshopweb.utils.JDBIUltis;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderMapper implements RowMapper<Order> {

    @Override
    public Order map(ResultSet rs, StatementContext ctx) throws SQLException {
        Order order = new Order();
        order.setId(rs.getLong("id"));

        return order;

    }

    public static void main(String[] args) {
        Jdbi jdbi = Jdbi.create("jdbc:mysql://localhost:3306/bookshopdb","root","");
        jdbi.installPlugin(new SqlObjectPlugin());

        Order order= jdbi.withHandle(handle->
                handle.createQuery("select * from orders where id = 3")
                        .map(new OrderMapper()).one());
        System.out.println(order);
    }
}
