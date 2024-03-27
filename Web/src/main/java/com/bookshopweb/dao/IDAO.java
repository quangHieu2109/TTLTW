package com.bookshopweb.dao;

import java.util.List;
import java.util.Optional;

public interface IDAO<T> {
    int insert(T t, String ip);

    int update(T t, String ip);

    int delete(T t, String ip);
    T selectPrevalue(Long id);

}
