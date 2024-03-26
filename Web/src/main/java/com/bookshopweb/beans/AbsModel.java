package com.bookshopweb.beans;

import com.google.gson.Gson;

public class AbsModel<T> {
    public String toJson(T t) {
        Gson gson = new Gson();
        return gson.toJson(t);
    }


}
