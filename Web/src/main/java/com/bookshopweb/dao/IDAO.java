package com.bookshopweb.dao;

import java.util.List;
import java.util.Optional;

public interface IDAO<T> {
    int insert(T t);

    int update(T t);

    int delete(T t);


}
