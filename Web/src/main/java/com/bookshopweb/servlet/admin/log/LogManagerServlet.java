package com.bookshopweb.servlet.admin.log;

import com.bookshopweb.beans.Log;
import com.bookshopweb.dao.LogDAO;
import com.bookshopweb.utils.JDBIUltis;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/logManagerServlet")
public class LogManagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/LogManagerView.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int start = Integer.parseInt(req.getParameter("start"));
        int length = Integer.parseInt(req.getParameter("length"));
        List<Log> logs = new LogDAO().getByLimit(start, length);
        JSONArray jsonArray = new JSONArray();
        for(Log log:logs){
            JSONObject jsonObject = new JSONObject();
            jsonObject.append("id", log.getId());
            jsonObject.append("ip", log.getIp());
            jsonObject.append("level", log.getLevelLog());
            jsonObject.append("res", log.getResource());
            jsonObject.append("pre", log.getPreValue());
            jsonObject.append("cur", log.getCurValue());
            jsonObject.append("create", log.getCreateAt().toString());
            jsonObject.append("update", (log.getUpdateAt() == null)?"":log.getUpdateAt().toString());
            jsonArray.put(jsonObject);

        }
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("data", jsonArray);
        resp.setStatus(200);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(jsonResponse.toString());
    }
}
