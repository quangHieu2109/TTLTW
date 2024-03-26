package com.bookshopweb.servlet.client;

import com.bookshopweb.beans.Constants;
import com.bookshopweb.beans.User;
import com.bookshopweb.dto.UserGoogleDTO;
import com.bookshopweb.service.UserService;
import com.google.gson.Gson;
import org.apache.hc.client5.http.fluent.Form;
import org.apache.hc.client5.http.fluent.Request;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/googlehandle")
public class SignInGoogleServlet extends HttpServlet {
    UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);

        String accessToken =  getToken(req.getParameter("code"));

        UserGoogleDTO userGoogleDTO = getUserInfo(accessToken);
//        System.out.print(userGoogleDTO.getId());
//        long id = Long.valueOf(userGoogleDTO.getId().replaceAll("\"\"",""));
//        if(userService.getById(id) == null) {
            User user = new User();
//            user.setId(id);
            user.setUsername(userGoogleDTO.getFamily_name());
            user.setFullname(userGoogleDTO.getName());
            user.setEmail(userGoogleDTO.getEmail());
            user.setRole("user");
//            userService.insert(user);
            
//        }
//        System.out.println(userGoogleDTO);
    }
    public String getToken(String code) throws IOException {// lấy access token từ code do google trả về
        String response = Request.post(Constants.GOOGLE_LINK_GET_TOKEN).bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build()).execute().returnContent().asString();
        JSONObject jsonObject = new JSONObject(response);
        String accessToken = jsonObject.getString("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }
    public UserGoogleDTO getUserInfo(String accessToken) throws IOException {// lấy thông tin user từ access token
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.get(link).execute().returnContent().asString();
        System.out.println(response);
        UserGoogleDTO googlePojo = new Gson().fromJson(response, UserGoogleDTO.class);
        return googlePojo;
    }
}
