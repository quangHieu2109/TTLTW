package com.bookshopweb.dao;

import com.bookshopweb.utils.JDBCUtils;

import java.sql.Connection;

public abstract class AbsDAO<T> implements IDAO<T> {
    protected Connection conn = JDBCUtils.getConnection();
    @Override
    public int insert(T t) {
        return 0;
    }

    @Override
    public int update(T t) {
        return 0;
    }

    @Override
    public int delete(T t) {
        return 0;
    }
}
