package com.bookshopweb.beans;

import com.google.gson.Gson;

import java.sql.Timestamp;

public abstract class AbsModel<T> {
    public String toJson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }
    public abstract String getResource();
    public abstract Timestamp getCreateAt();
    public abstract long getId();

}
