package com.bookshopweb.jdbiIterface;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.OrderItem;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

import java.util.List;

@RegisterBeanMapper(OrderItem.class)
public interface OrderItemJDBI {
    @SqlQuery("select * from order_item where orderId=:orderId limit :start, :length")
    List<Order> getByOrderIdLimit(@Bind("orderId") long orderId, @Bind("start") int start, @Bind("length") int length);
    @SqlQuery("select count(*) from order_item where orderId=:orderId")
    int getTotalRowByOrderId(@Bind("orderId") long orderId);
}
