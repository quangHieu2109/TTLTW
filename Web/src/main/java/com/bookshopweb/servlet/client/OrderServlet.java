package com.bookshopweb.servlet.client;

import com.bookshopweb.beans.CartItem;
import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.OrderItem;
import com.bookshopweb.beans.User;
import com.bookshopweb.dao.CartItemDAO;
import com.bookshopweb.dto.OrderResponse;
import com.bookshopweb.dao.OrderItemDAO;
import com.bookshopweb.dao.OrderDAO;
import com.bookshopweb.utils.Protector;
import com.bookshopweb.utils.VoucherUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();
    private final CartItemDAO cartItemDAO = new CartItemDAO();

    private static final int ORDERS_PER_PAGE = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");

        if (user != null) {
            int totalOrders = orderDAO.countByUserId(user.getId());


            // Tính tổng số trang (= tổng số order / số sản phẩm trên mỗi trang)
            int totalPages = totalOrders / ORDERS_PER_PAGE;
            if (totalOrders % ORDERS_PER_PAGE != 0) {
                totalPages++;
            }

            // Lấy trang hiện tại, gặp ngoại lệ (chuỗi không phải số, nhỏ hơn 1, lớn hơn tổng số trang) thì gán bằng 1
            String pageParam = Optional.ofNullable(request.getParameter("page")).orElse("1");
            int page = Protector.of(() -> Integer.parseInt(pageParam)).get(1);
            if (page < 1 || page > totalPages) {
                page = 1;
            }
//
//            // Tính mốc truy vấn (offset)
            int offset = (page - 1) * ORDERS_PER_PAGE;

            // Lấy danh sách order, lấy với số lượng là ORDERS_PER_PAGE và tính từ mốc offset
            List<Order> orders = Protector.of(() -> orderDAO.getOrderedPartByUserId(
                    user.getId(), ORDERS_PER_PAGE, offset
            )).get(ArrayList::new);
//
            List<OrderResponse> orderResponses = new ArrayList<>();
//
            for (Order order : orders) {
                List<OrderItem> orderItems = Protector.of(() -> orderItemDAO.getByOrderId(order.getId())).get(ArrayList::new);

                double total = 0.0;

                for (OrderItem orderItem : orderItems) {
                    if (orderItem.getDiscount() == 0) {
                        total += orderItem.getPrice() * orderItem.getQuantity();
                    } else {
                        total += (orderItem.getPrice() * (100 - orderItem.getDiscount()) / 100) * orderItem.getQuantity();
                    }
                }
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                String formattedDateTime = sdf.format(order.getCreatedAt());

//
                OrderResponse orderResponse = new OrderResponse(
                        order.getId(),
                        formattedDateTime,
                        check(orderItemDAO.getProductNamesByOrderId(order.getId())),
                        order.getStatus(),
                        total + order.getDeliveryPrice());

                orderResponses.add(orderResponse);
            }

            request.setAttribute("totalPages", totalPages);
            request.setAttribute("page", page);
            request.setAttribute("orders", orderResponses);
        }

        request.getRequestDispatcher("/WEB-INF/views/orderView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("currentUser");
        int deliveryMethod = Integer.parseInt(req.getParameter("unitshipVal"));
        long shipVoucherId ;
        long productVoucherId ;
        String[] cartItemIdsString = req.getParameterValues("cartItemIds");
        List<Long> cartItemIds = VoucherUtils.convertToListLong(cartItemIdsString);
        List<CartItem> cartItems = new ArrayList<>();
        for(long id : cartItemIds){
            cartItems.add(cartItemDAO.selectPrevalue(id));
        }

        double ship = Double.parseDouble(req.getParameter("ship"));
        double shipVoucherDecrease =0, productVoucherDecrease=0;
        try{
            shipVoucherId = Long.parseLong(req.getParameter("shipVoucherId"));
            shipVoucherDecrease = VoucherUtils.getDecrease(shipVoucherId, cartItemIdsString, ship);
        } catch (NumberFormatException e) {
            throw new RuntimeException(e);
        }
        try{
            productVoucherId = Long.parseLong(req.getParameter("productVoucherId"));
            productVoucherDecrease = VoucherUtils.getDecrease(productVoucherId, cartItemIdsString, ship);
        } catch (NumberFormatException e) {
            throw new RuntimeException(e);
        }

        Order order = new Order();
        order.setId(Calendar.getInstance().getTimeInMillis());
        order.setUserId(user.getId());
        order.setStatus(0);
        order.setDeliveryMethod(deliveryMethod);
        order.setDeliveryPrice(ship);
        order.setCreatedAt(new Timestamp(Calendar.getInstance().getTimeInMillis()));

        int rs = orderDAO.insert(order, "");
        if(rs > 0){
            for(CartItem cartItem : cartItems){
                OrderItem orderItem = new OrderItem();
            }
        }


    }

    private String check(List<String> list) {
        if (list.size() == 1) {
            return list.get(0);
        }

        return list.get(0) + " và " + (list.size() - 1) + " sản phẩm khác";
    }
}
