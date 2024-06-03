package com.bookshopweb.servlet.admin.user;

import com.bookshopweb.beans.User;
import com.bookshopweb.dao.UserDAO;
import com.bookshopweb.jdbiIterface.UserJDBI;
import com.bookshopweb.utils.JDBIUltis;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(value = "/userManagerServlet2")
public class UserManagerSerlet2 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserJDBI userJDBI = JDBIUltis.getJDBI().onDemand(UserJDBI.class);
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String role = req.getParameter("role");
        String emailRegex ="^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z0-9]$";
        String passRegex="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*$";

        String username_error="", password_error="", fullname_error="", email_error="";
        if(username.length() ==0){
            username_error="Vui lòng điền tên đăng nhập";
        }else{
            User user = userJDBI.getByUsername(username);
            if(user != null){
                username_error="Tên đăng nhập đã được đăng ký, vui lòng chọn tên đăng nhập khác";
            }

        }
        if(password.length() ==0){
            password_error="Vui lòng điền mật khẩu";
        }else if(!Pattern.compile(passRegex).matcher(password).matches()){
            password_error="Mật khẩu không hợp lệ, yêu cầu từ 8 kí tự trở lên bao gồm cả chữ thường, in hoa và số";
        }

        if(fullname.length() ==0){
            fullname_error = "Vui lòng điền họ và tên";
        }

        if(email.length() ==0){
            email_error="Vui lòng điền emai;";
        }else if(!Pattern.compile(emailRegex).matcher(email).matches()){
            email_error="Email không hợp lệ";
        }else{
            if(userJDBI.getByEmail(email) != null){
                email_error="Email đã được đăng ký, vui lòng chọn email khác";
            }
        }

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("username_error", username_error);
        jsonResponse.put("password_error", password_error);
        jsonResponse.put("fullname_error", fullname_error);
        jsonResponse.put("email_error", email_error);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        if(username_error.length() ==0 && password_error.length() ==0 &&
        fullname_error.length() ==0 && email_error.length() ==0){
            User user = new User();
            user.setId(0L);
            user.setUsername(username);
            user.setFullname(fullname);
            user.setPassword(password);
            user.setEmail(email);
            user.setRole(role);
            int rs = userJDBI.addUsser(user);
            if(rs>0){
                jsonResponse.put("msg","Thêm người dùng thành công");
                resp.setStatus(200);
                resp.getWriter().write(jsonResponse.toString());
            }else{
                resp.setStatus(400);
                resp.getWriter().write(jsonResponse.toString());
            }
        }else{

            resp.setStatus(400);
            resp.getWriter().write(jsonResponse.toString());
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserJDBI userJDBI = JDBIUltis.getJDBI().onDemand(UserJDBI.class);
        int start = Integer.parseInt(req.getParameter("start"));
        int length = Integer.parseInt(req.getParameter("length"));
        List<User> users = userJDBI.getLimit(start, length);
        JSONArray jsonArray = new JSONArray();
        for(User user:users){
            JSONObject jsonObject = new JSONObject();
            jsonObject.append("id", user.getId());
            jsonObject.append("username", user.getUsername());
            jsonObject.append("fullname", user.getFullname());
            jsonObject.append("email", user.getEmail());
            jsonObject.append("phonenumber", user.getPhoneNumber());
            String gender = (user.getGender()==0)?"Nam":"Nu";
            jsonObject.append("gender", gender);
            jsonObject.append("role", user.getRole());
            String deleteBtn = "<button class=\"btn btn-danger\" onclick=\"deleteUser("+user.getId()+")\">Delete</button>";
            jsonObject.append("operation",deleteBtn);
            jsonArray.put(jsonObject);
        }
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("data", jsonArray);
        jsonResponse.put("recordsTotal", users.size());
        jsonResponse.put("recordsFiltered", userJDBI.getQuantity());
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonResponse.toString());
        System.out.println(jsonResponse.toString());
    }
}
