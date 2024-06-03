package com.bookshopweb.jdbiIterface;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.Product;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterBeanMapper(Order.class)
public interface OrderJDBI {
    @SqlQuery("select * from orders where status =:status limit :start,:length")
    List<Order> getByStatusLimit(@Bind("status") int status, @Bind("start") int start, @Bind("length") int length);
    @SqlQuery("select count(*) from orders where status=:status")
    int getTotalRowStatus(@Bind("status") int status);
    @SqlUpdate("update orders set status=:status where id=:id")
    int updateStatus(@Bind("status") int status, @Bind("id") long id);
    @SqlQuery ("select * from orders where id=:id")
    Order getById(@Bind("id") long id);
    @SqlQuery("select sum(price) from order_item where orderId=:orderId")
    int getTotalPrice(@Bind("orderId") long orderId);
}
