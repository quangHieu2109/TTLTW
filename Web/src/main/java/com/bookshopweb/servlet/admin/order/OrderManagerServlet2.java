package com.bookshopweb.servlet.admin.order;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.OrderItem;
import com.bookshopweb.beans.Product;
import com.bookshopweb.beans.User;
import com.bookshopweb.dao.OrderDAO;
import com.bookshopweb.dao.OrderItemDAO;
import com.bookshopweb.dao.ProductDAO;
import com.bookshopweb.dao.UserDAO;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;

@WebServlet(value = "/orderManagerServlet2")
public class OrderManagerServlet2 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String type=req.getParameter("type");
    if(type.equalsIgnoreCase("order")){
        getOrder(req, resp);
    }else{
        getDetail(req, resp);
    }


    }
    protected void getDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long orderId = Long.parseLong(req.getParameter("orderId"));
        NumberFormat formatter = NumberFormat.getInstance();
        OrderDAO orderDAO = new OrderDAO();
        UserDAO userDAO = new UserDAO();
        Order order = orderDAO.selectPrevalue(orderId);
        OrderItemDAO orderItemDAO = new OrderItemDAO();
        List<OrderItem> orderItems = orderItemDAO.getByOrderId(orderId);
        JsonArray jsonArray = new JsonArray();
        ProductDAO productDAO = new ProductDAO();
        for(OrderItem orderItem:orderItems){
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", orderItem.getId());
            Product product = productDAO.getByIdProduct(orderItem.getProductId());
            product.setPrice(product.getPrice() *(1-product.getDiscount()/100));
            String imgSrc = req.getContextPath()+"/img/"+product.getImageName();
            jsonObject.addProperty("image","<img width=\"80\"\n" +
                    "                                     height=\"80\" src=\""+imgSrc+"\">");
            String info="Name: "+product.getName()+"<br/>"
                    +"Author: "+product.getAuthor()+"<br>"
                    +"Pages: "+product.getPages()+"<br>"
                    +"YearPublishing: "+product.getYearPublishing();
            jsonObject.addProperty("info", info);
            jsonObject.addProperty("quantity", product.getQuantity());
            jsonObject.addProperty("price", formatter.format(product.getPrice()) );
            jsonArray.add(jsonObject);
        }
        User user = userDAO.selectPrevalue(order.getUserId());
        JsonObject jsonResopne = new JsonObject();
        String status ="";
        switch (order.getStatus()){
            case 0:
                status="Đặt hàng thành công";
                break;
            case 1:
                status="Đang giao hàng";
                break;
            case 2:
                status="Giao hàng thành công";
                break;
            case 3:
                status="Đã hủy";
                break;
            case 4:
                status="Trả hàng";
                break;

        }
        jsonResopne.add("products", jsonArray);
        jsonResopne.addProperty("orderId", order.getId());
        jsonResopne.addProperty("createdAt", order.getCreateAt().toString());
        jsonResopne.addProperty("status", status);
        jsonResopne.addProperty("fullname", user.getFullname());
        jsonResopne.addProperty("phoneNumber", user.getPhoneNumber());
        jsonResopne.addProperty("deliveryMethod", order.getDeliveryMethod());
        jsonResopne.addProperty("tempPrice", formatter.format((int)order.getTotalPrice()));
        jsonResopne.addProperty("totalPrice", formatter.format((int)order.getTotalPrice()+order.getDeliveryPrice()));
        jsonResopne.addProperty("deliveryPrice", formatter.format((int)order.getDeliveryPrice()));


        resp.setStatus(200);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(jsonResopne.toString());


    }
    protected void getOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println(1111);
        int status = Integer.parseInt(req.getParameter("status"));
        int start = Integer.parseInt(req.getParameter("start"));
        int length = Integer.parseInt(req.getParameter("length"));
        OrderDAO orderDAO = new OrderDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();
        List<Order> orders = orderDAO.getByStatusLimit(status, start, length);
        JsonArray jsonArray = new JsonArray();
        for (Order order : orders) {
            JsonObject jsonObject = new JsonObject();
            int totalPrice = orderItemDAO.getTotalPriceByOrderId(order.getId());
            String deliveryMethod = (order.getDeliveryMethod() == 1) ? "Giao hàng nhanh" : "Giao hàng tiết kiệm";
            String updateStatus = "";
            switch (status) {
                case 0:
                    updateStatus = "<select class=\"form-select\" onchange=\"changeStatus(" + order.getId() + ", this.value)\" " +
                            "id=\"sl"+order.getId()+"\">" +
                            "<option value=\"0\" selected>Đặt hành thành công</option>" +
                            "<option value=\"1\" >Đang giao</option>" +
                            "<option value=\"3\" >Đã hủy</option>" +
                            "</select>";
                    break;
                case 1:
                    updateStatus = "<select class=\"form-select\" onchange=\"changeStatus(" + order.getId() + ", this.value)\" " +
                            "id=\"sl"+order.getId()+"\">" +
                            "<option value=\"1\" selected>Đang giao</option>" +
                            "<option value=\"2\" >Giao thành công</option>" +
                            "<option value=\"3\" >Đã hủy</option>" +
                            "</select>";
                    break;
                case 2:
                    updateStatus = "<select class=\"form-select\" onchange=\"changeStatus(" + order.getId() + ", this.value)\" " +
                            "id=\"sl"+order.getId()+"\">" +

                            "<option value=\"2\" selected>Giao hàng thành công</option>" +
                            "<option value=\"4\" >Trả hàng</option>" +

                            "</select>";
                    break;
                case 3:
                    updateStatus = "<select class=\"form-select\" onchange=\"changeStatus(" + order.getId() + ", this.value)\" " +
                            "id=\"sl"+order.getId()+"\">"+

                            "<option value=\"3\" selected>Đã hủy</option>" +
                            "</select>";
                    break;
                case 4:
                    updateStatus = "<select class=\"form-select\" onchange=\"changeStatus(" + order.getId() + ", this.value)\" " +
                            "id=\"sl"+order.getId()+"\">"+

                            "<option value=\"4\" selected>Trả hàng</option>" +
                            "</select>";
                    break;
            }
            String saveBtn = "<button style=\"width: 66px\" class=\"btn btn-secondary m-auto\" id=\"p" + order.getId() + "\">Save</button>";
            String detailBtn="<button style=\"width: 66px\" class=\"btn btn-primary m-auto\" onclick=\"detail("+order.getId()+")\">Detail</button>";
            jsonObject.addProperty("id", order.getId());
            jsonObject.addProperty("idUser", order.getUserId());
            jsonObject.addProperty("deliveryMethod", deliveryMethod);
            jsonObject.addProperty("deliveryPrice", order.getDeliveryPrice());
            jsonObject.addProperty("productsPrice", totalPrice);
            jsonObject.addProperty("totalPrice", order.getDeliveryPrice() + totalPrice);
            jsonObject.addProperty("createAt", order.getCreatedAt().toString());
            jsonObject.addProperty("updateAt", (order.getUpdatedAt() == null) ? "" : order.getUpdatedAt().toString());
            jsonObject.addProperty("updateStatus", updateStatus);
            jsonObject.addProperty("operation", "<div class=\"row\">"+saveBtn+detailBtn+"</div>");
            jsonArray.add(jsonObject);
//            System.out.println(jsonObject.toString());
        }
        JsonObject jsonResopne = new JsonObject();
        jsonResopne.add("data", jsonArray);
        jsonResopne.addProperty("recordsTotal", orders.size());
        jsonResopne.addProperty("recordsFiltered", orderDAO.getQuantity(status));
        resp.setStatus(200);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
//        System.out.println(jsonResopne.toString());
        resp.getWriter().write(jsonResopne.toString());


    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println(121212);
        long id = Long.parseLong(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("value"));
        OrderDAO orderDAO = new OrderDAO();

        resp.setCharacterEncoding("UTF-8");
        Order order = orderDAO.selectPrevalue(id);
        JsonObject jsonResponse = new JsonObject();
        if (order.getStatus() == status) {
            jsonResponse.addProperty("error_notifica", "Trạng thái mới bị trùng với trạng thái cũ, cập nhật thất bại!");
            resp.setStatus(400);
            resp.setContentType("application/json");

            resp.getWriter().write(jsonResponse.toString());
        } else if (orderDAO.updateStatus(status, id) > 0) {

            resp.setStatus(200);
        } else {
            jsonResponse.addProperty("error_notifica", "Cập nhật thất bại!");
            resp.setStatus(400);
            resp.setContentType("application/json");

            resp.getWriter().write(jsonResponse.toString());
        }

    }
}
