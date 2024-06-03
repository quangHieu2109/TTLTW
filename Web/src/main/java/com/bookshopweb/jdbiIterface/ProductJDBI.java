package com.bookshopweb.jdbiIterface;

import com.bookshopweb.beans.Product;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterBeanMapper(Product.class)
public interface ProductJDBI {
    @SqlQuery("select * from product")
    List<Product> getAll();

    @SqlUpdate("update product set name=:name, price=:price,  discount=:discount, quantity=:quantity, " +
            "totalBuy=:totalBuy, author=:author, pages=:pages, publisher=:publisher, yearPublishing =:yearPublishing, " +
            "description=:description, imageName=:imageName, shop=:shop, createdAt=:createdAt, updatedAt=:updatedAt where id =:id" )
    int updateProduct(@BindBean Product product);
//    @SqlUpdate("insert into product (id, name, price, discount, quantity, totalBuy, author, pages, publisher,yearPublishing, description, imageName, shop, createdAt, updatedAt)")
}
