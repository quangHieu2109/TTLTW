package com.bookshopweb.dao;

import com.bookshopweb.beans.Log;
import com.bookshopweb.beans.User;
import com.bookshopweb.jdbiIterface.LogJDBI;
import com.bookshopweb.utils.JDBIUltis;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
//    public static void main(String[] args) throws SQLException {
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
//        String emailRegex = "^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z0-9]+$";
//        String passwordRegex ="^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).*$";
//        Pattern pattern = Pattern.compile(emailRegex);
//        System.out.println(pattern.matcher("1111@gm.com").matches());
//        pattern = Pattern.compile(passwordRegex);
//        System.out.println(pattern.matcher("a12A").matches());

//    }
public static void main(String[] args) {
    String emailRegex = "^[a-zA-z0-9.]+@[a-zA-Z0-9].[.a-zA-Z0-9]*[a-zA-Z0-9]+$";
    String passwordRegex ="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*$";
    Pattern emailPattern = Pattern.compile(emailRegex);
    Pattern passPattern = Pattern.compile(passwordRegex);
//    System.out.println(emailPattern.matcher("1231.@12.ax.fv").matches());
    System.out.println(passPattern.matcher("12312aa").matches());
}
}

