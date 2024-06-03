<<<<<<<< HEAD:Web/src/main/java/com/bookshopweb/jdbiIterface/UserJDBI.java
package com.bookshopweb.jdbiIterface;
========
package com.bookshopweb.jdbiInterface;
>>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987:Web/src/main/java/com/bookshopweb/jdbiInterface/UserJDBI.java

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
    @SqlQuery("select * from user where username= :username")
    User getByUsername(@Bind("username") String username);
    @SqlQuery("select * from user where email= :email")
    User getByEmail(@Bind("email") String email);
    @SqlUpdate("insert into user(id, username, password, fullname, email, phoneNumber, gender, role, createAt) " +
            "values(:id, :username, :password, :fullname, :email, :phoneNumber, :gender, :role, :createAt)")
    int addUsser(@BindBean User user);
    @SqlQuery("select * from user limit :start, :length")
    List<User> getLimit(@Bind("start") int start, @Bind("length") int length);
    @SqlUpdate("delete from user where id=:id")
    int deleteById(@Bind("id") long id);
    @SqlQuery("select count(*) from user")
    int getQuantity();
}
