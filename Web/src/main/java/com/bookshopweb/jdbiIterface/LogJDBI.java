package com.bookshopweb.jdbiIterface;

import com.bookshopweb.beans.Log;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterBeanMapper(Log.class)
public interface LogJDBI {
    @SqlQuery("select * from log")
    List<Log> getAll();
    @SqlQuery("select * from log limit :start, :length")
    List<Log> getByLimit(@Bind("start") int start, @Bind("length") int length);
    @SqlQuery("select count(*) from log")
    int getQuantity();
    @SqlUpdate("insert into log(id, ip, levelLog, res, preValue, curValue, createAt, updateAt)" +
            " values(:id, :ip, :levelLog, :resource, :preValue, :curValue, createAt, updateAt)")
    int insertLog(@BindBean Log log);

    @SqlUpdate("update log set levelLog=:levelLog where id=:id")
    int updateLevelLog(@BindBean Log log);

}
