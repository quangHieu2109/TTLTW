package com.bookshopweb.jdbiInterface;

import com.bookshopweb.beans.User;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.locator.UseClasspathSqlLocator;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;
//@UseClasspathSqlLocator
@RegisterBeanMapper(User.class)
public interface UserJDBI {
    @SqlQuery("select * from user")
    List<User> selectAll();
    @SqlQuery("select * from user where id= :id")
    User getById(@Bind("id") long id);
    @SqlUpdate("insert into user(id, username, password, fullname, email, phoneNumber, gender, role, createAt) " +
            "values(:id, :username, :password, :fullname, :email, :phoneNumber, :gender, :role, :createAt)")
    void addUsser(@BindBean User user);
}
