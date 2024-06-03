package com.bookshopweb.utils;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

public class JDBIUltis {
    private static Jdbi jdbi;
    public static Jdbi getJDBI(){
        jdbi = Jdbi.create("jdbc:mysql://localhost:3306/bookshopdb", "root", "");
        jdbi.installPlugin(new SqlObjectPlugin());
        return jdbi;
    }
}
