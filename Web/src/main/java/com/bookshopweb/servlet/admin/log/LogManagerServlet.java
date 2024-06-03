package com.bookshopweb.servlet.admin.log;

import com.bookshopweb.beans.Log;
<<<<<<< HEAD
import com.bookshopweb.dao.LogDAO;
import com.bookshopweb.utils.JDBIUltis;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.json.JSONArray;
import org.json.JSONObject;
=======
import com.bookshopweb.jdbiInterface.LogJDBI;
import com.bookshopweb.utils.JDBIUltis;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987

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
<<<<<<< HEAD
        req.getRequestDispatcher("/WEB-INF/views/LogManagerView.jsp").forward(req, resp);
=======
        req.getRequestDispatcher("/WEB-INF/views/logManagerView.jsp").forward(req, resp);
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
<<<<<<< HEAD
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
=======
        int draw = Integer.parseInt(req.getParameter("draw"));
        int start = Integer.parseInt(req.getParameter("start"));
        int length = Integer.parseInt(req.getParameter("length"));
        JsonArray jsonArray = new JsonArray();
        List<Log> logs = JDBIUltis.getJDBI().onDemand(LogJDBI.class).selectByPage(start, length);
        for(Log log:logs){
            System.out.println(log);
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", log.getId());
            jsonObject.addProperty("ip", log.getIp());
            jsonObject.addProperty("levelLog", log.getLevelLog());
            jsonObject.addProperty("res", log.getResource());
            jsonObject.addProperty("preValue", log.getPreValue());
            jsonObject.addProperty("curValue", log.getCurValue());
            jsonObject.addProperty("createAt", log.getCreateAt().toString());
            jsonObject.addProperty("updateAt", log.getUpdateAt().toString());
            jsonArray.add(jsonObject);

        }
        JsonObject jsonRespone = new JsonObject();
        jsonRespone.add("data", jsonArray);
        jsonRespone.addProperty("recordsTotal", logs.size());
        jsonRespone.addProperty("recordsFiltered", JDBIUltis.getJDBI().onDemand(LogJDBI.class).getQuantity());
        resp.setStatus(200);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        System.out.println(jsonRespone.toString());
        resp.getWriter().write(jsonRespone.toString());
>>>>>>> aa358538bf6737833eed795ea55bd298af8b8987
    }
}
