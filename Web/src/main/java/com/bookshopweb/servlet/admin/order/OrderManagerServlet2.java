package com.bookshopweb.servlet.admin.order;

import com.bookshopweb.beans.Order;
import com.bookshopweb.jdbiIterface.OrderItemJDBI;
import com.bookshopweb.jdbiIterface.OrderJDBI;
import com.bookshopweb.jdbiIterface.ProductJDBI;
import com.bookshopweb.utils.JDBIUltis;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/orderManagerServlet2")
public class OrderManagerServlet2 extends HttpServlet {
    OrderJDBI orderJDBI = JDBIUltis.getJDBI().onDemand(OrderJDBI.class);
    OrderItemJDBI orderItemJDBI = JDBIUltis.getJDBI().onDemand(OrderItemJDBI.class);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("status"));
        Order order = orderJDBI.getById(id);
        JsonObject jsonResponse = new JsonObject();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        if(order.getStatus() == status){
            jsonResponse.addProperty("msg","Cập nhật thất bại. Trạng thái đơn hàng bị trùng với trạng thái ban đầu!");
            resp.setStatus(400);
            resp.getWriter().write(jsonResponse.toString());
        }else{
            int rs = orderJDBI.updateStatus(status, id);
            if(rs>0){
                jsonResponse.addProperty("msg","Cập nhật trạng thái đơn hàng "+id+" thành công!");
                resp.setStatus(200);
                resp.getWriter().write(jsonResponse.toString());
            }else{
                jsonResponse.addProperty("msg","Cập nhật thất bại. Có lỗi từ máy chủ");
                resp.setStatus(400);
                resp.getWriter().write(jsonResponse.toString());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int start = Integer.parseInt(req.getParameter("start"));
        int length = Integer.parseInt(req.getParameter("length"));
        int status = Integer.parseInt(req.getParameter("status"));

        List<Order> orders = orderJDBI.getByStatusLimit(status, start, length);
        JsonArray jsonArray = new JsonArray();
        for (Order order : orders) {
            String dileveryMethod = (order.getDeliveryMethod() == 1) ? "Giao hàng tiết kiện" : "Giao hàng nhanh";
            String updateAt = (order.getUpdatedAt() == null) ? "" : order.getUpdatedAt().toString();
            String updateStatus = "";
            switch (status) {
                case 0:
                    updateStatus ="<select id=\"sl"+order.getId()+"\"  onchange=\"changeStatus("+order.getId()+")\">" +
                            "<option value=\"0\" selected>Đặt hàng thành công</option>" + "<option value=\"1\">Đang giao hàng</option>"+
                            "<option value=\"3\">Đã hủy</option>"+ "</select>";
                    break;
                case 1:
                    updateStatus ="<select id=\"sl"+order.getId()+"\"  onchange=\"changeStatus("+order.getId()+")\">" +
                            "<option value=\"1\" selected>Đang giao hàng</option>"+ "<option value=\"2\">Giao hàng thành công</option>"+
                            "<option value=\"3\">Đã hủy</option>"+ "</select>";
                    break;
                case 2:
                    updateStatus ="<select id=\"sl"+order.getId()+"\"  onchange=\"changeStatus("+order.getId()+")\">" +
                            "<option value=\"2\" selected>Giao hàng thành công</option>"+
                            "<option value=\"4\">Trả hàng</option>"+
                            "</select>";
                    break;
                case 3:
                    updateStatus ="<select id=\"sl"+order.getId()+"\"  onchange=\"changeStatus("+order.getId()+")\">" +
                            "<option value=\"3\" selected>Đã hủy</option>"+ "</select>";
                    break;
                case 4:
                    updateStatus ="<select id=\"sl"+order.getId()+"\"  onchange=\"changeStatus("+order.getId()+")\">" +
                            "<option value=\"4\" selected>Trả hàng</option>"+ "</select>";
                    break;
            }
            String saveBtn="<button class=\"btn btn-secondary\" id=\"btn"+order.getId()+"\">Save</button> ";
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", order.getId());
            jsonObject.addProperty("userid", order.getUserId());
            jsonObject.addProperty("diliveryMethod", dileveryMethod);
            jsonObject.addProperty("diliveryPrice", order.getDeliveryPrice());
            jsonObject.addProperty("productsPrice", orderJDBI.getTotalPrice(order.getId()));
            jsonObject.addProperty("totalPrice", orderJDBI.getTotalPrice(order.getId()) + order.getDeliveryPrice());
            jsonObject.addProperty("createdAt", order.getCreatedAt().toString());
            jsonObject.addProperty("updatedAt", updateAt);
            jsonObject.addProperty("status", updateStatus);
            jsonObject.addProperty("operation", saveBtn);
            jsonArray.add(jsonObject);
        }
        JsonObject jsonResponse = new JsonObject(); jsonResponse.add("data", jsonArray);
        jsonResponse.addProperty("recordsTotal", orders.size());
        jsonResponse.addProperty("recordsFiltered", orderJDBI.getTotalRowStatus(status));
        resp.setContentType("application/json"); resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonResponse.toString());
    }
}
