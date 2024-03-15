package controller;

import model.Constants;
import model.NguoiDung;
import org.apache.hc.client5.http.fluent.Request;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/fbhandle")
public class FBHandle extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        String code = req.getParameter("code");
        String accessToken = getToken(code);
        NguoiDung nguoiDung = getUserInfo(accessToken);
        req.getSession().setAttribute("nguoiDung",nguoiDung);
        req.getRequestDispatcher("trangchu.jsp").forward(req,resp);


    }
    public String getToken(String code) throws IOException {
        String response = Request.get("https://graph.facebook.com/v19.0/oauth/access_token?"+
                "client_id="+Constants.FACEBOOK_APP_ID+"&"+
                "redirect_uri="+ Constants.FACEBOOK_REDIRECT_URL +"&"+
                "client_secret="+Constants.FACEBOOK_APP_SECRET+"&code="+code+"&scope=email,user_birthday").execute().returnContent().asString();
        JSONObject jsonObject = new JSONObject(response);

        String accessToken =  jsonObject.getString("access_token");
        return accessToken;
    }
    public NguoiDung getUserInfo(String accessToken) throws IOException{
       String response = Request.get("https://graph.facebook.com/v19.0/me?fields=id,name,email,birthday&access_token="+accessToken).execute().returnContent().asString();
         JSONObject jsonObject = new JSONObject(response);
         String name = jsonObject.getString("name");

            String id = jsonObject.getString("id");

        NguoiDung nguoiDung = new NguoiDung(id,"",name,"",null);
        return nguoiDung;
    }
}
