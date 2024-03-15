package controller;

import com.google.gson.Gson;
import dto.UserGoogleDTO;
import model.Constants;
import model.NewsService;
import model.NguoiDung;
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
public class GoogleHandle extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        NewsService newsService = (NewsService) req.getSession().getAttribute("newsService");
        String accessToken =  getToken(req.getParameter("code"));

        UserGoogleDTO userGoogleDTO = getUserInfo(accessToken);

        NguoiDung nguoiDung = new NguoiDung(userGoogleDTO.getEmail(), "", userGoogleDTO.getName(), userGoogleDTO.getEmail(), null, userGoogleDTO.getPicture(), "user");
        req.getSession().setAttribute("nguoiDung", nguoiDung);
        resp.sendRedirect(newsService.rewriteURL(req.getContextPath()+"/MainServlet"));
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
    public UserGoogleDTO getUserInfo(final String accessToken) throws IOException {// lấy thông tin user từ access token
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.get(link).execute().returnContent().asString();
        UserGoogleDTO googlePojo = new Gson().fromJson(response, UserGoogleDTO.class);
        return googlePojo;
    }
}
