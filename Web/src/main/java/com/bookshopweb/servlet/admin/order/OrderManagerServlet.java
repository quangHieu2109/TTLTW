package com.bookshopweb.servlet.admin.order;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.OrderItem;

import com.bookshopweb.dao.OrderDAO;
import com.bookshopweb.dao.OrderItemDAO;
import com.bookshopweb.dao.UserDAO;
import com.bookshopweb.utils.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "OrderManagerServlet", value = "/admin/orderManager")
public class OrderManagerServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final UserDAO userDAO = new UserDAO();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();

    private static final int ORDERS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalOrders = Protector.of(orderDAO::count).get(0);
        int totalPages = totalOrders / ORDERS_PER_PAGE + (totalOrders % ORDERS_PER_PAGE != 0 ? 1 : 0);

        String pageParam = Optional.ofNullable(request.getParameter("page")).orElse("1");
        int page = Protector.of(() -> Integer.parseInt(pageParam)).get(1);
        if (page < 1 || page > totalPages) {
            page = 1;
        }

        int offset = (page - 1) * ORDERS_PER_PAGE;

        List<Order> orders = Protector.of(() -> orderDAO.getOrderedPart(
                ORDERS_PER_PAGE, offset, "id", "DESC"
        )).get(ArrayList::new);

        for (Order order : orders) {
            Protector.of(() -> userDAO.selectPrevalue(order.getUserId())).get().ifPresent(order::setUser);
            List<OrderItem> orderItems = Protector.of(() -> orderItemDAO.getByOrderId(order.getId())).get(ArrayList::new);
            order.setOrderItems(orderItems);
            order.setTotalPrice(calculateTotalPrice(orderItems, order.getDeliveryPrice()));
        }

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("page", page);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/views/orderManagerView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

    public static double calculateTotalPrice(List<OrderItem> orderItems, double deliveryPrice) {
        double totalPrice = deliveryPrice;

        for (OrderItem orderItem : orderItems) {
            if (orderItem.getDiscount() == 0) {
                totalPrice += orderItem.getPrice() * orderItem.getQuantity();
            } else {
                totalPrice += (orderItem.getPrice() * (100 - orderItem.getDiscount()) / 100) * orderItem.getQuantity();
            }
        }

        return totalPrice;
    }
}
