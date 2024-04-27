package com.bookshopweb.dao;

import com.bookshopweb.beans.User;
import com.bookshopweb.utils.JDBIUltis;
import org.jdbi.v3.core.Handle;

import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
    public static void main(String[] args) throws SQLException {
//        UserJDBI userJDBI = JDBIUltis.getJDBI().onDemand(UserJDBI.class);
//        List<User> users = userJDBI.selectAll(); // lấy dữ liệu thông qua map constructor
//        List<User> users = JDBIUltis.getJDBI().withHandle( handle ->
//                handle.createQuery("select * from user").map(new UserMapper())
//                        .list()); // lấy dữ liệu thông qua mapper object
//        for(User u : users){
//            System.out.println(u);
//        }
//Handle handle = JDBIUltis.getJDBI().open();
//        User user =
//                handle.createQuery("select * from user where username='hiune12'")
//                        .map(new UserMapper())
//                        .one();
//        System.out.println(userJDBI.getById(1));
//        User user = new User(1221, "hiune12", "123321", "Quang Hiu", "hiu@12.21", "13321231", 1, "ấda", null);
//        userJDBI.addUsser(user);

//        String regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).*$";
//            Pattern pattern = Pattern.compile(regex);
//            Matcher matcher =  pattern.matcher("12aAcxN");
//            System.out.println(matcher.matches());
UserDAO userDAO = new UserDAO();
        System.out.println(userDAO.selectByUserName("user1"));

    }
}
