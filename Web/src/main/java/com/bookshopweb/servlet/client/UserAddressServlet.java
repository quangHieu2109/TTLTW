package com.bookshopweb.servlet.client;

import com.bookshopweb.beans.*;
import com.bookshopweb.dao.AddressDAO;
import com.bookshopweb.dao.CartDAO;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

@WebServlet(name = "UserAddressServlet", value = "/userAddress")
public class UserAddressServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        AddressDAO addressDAO = new AddressDAO();
        List<Address> addresses = addressDAO.selectByUser(user.getId());

        Gson gson = new Gson();
        String jsonAddresses = gson.toJson(addresses);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().write("{\"addresses\":"+jsonAddresses+"}");
        response.getWriter().flush();
        response.getWriter().close();
        response.setStatus(200);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        long id = new Random().nextInt(9)*10000+ Calendar.getInstance().getTimeInMillis();
        String houseNumber = request.getParameter("houseNumber");
        Address address = new Address(id, user.getId(), houseNumber);
        long provinceId = Long.parseLong(request.getParameter("provinceId"));
        long districtId = Long.parseLong(request.getParameter("districtId"));
        long wardId = Long.parseLong(request.getParameter("wardId"));

        String provinceName = request.getParameter("provinceName");
        String districtName = request.getParameter("districtName");
        String wardName = request.getParameter("wardName");

        String provinceCode = request.getParameter("provinceCode");
        String districtCode = request.getParameter("districtCode");
        String wardCode = request.getParameter("wardCode");

        address.setProvince(new Province(provinceId, id, provinceName, provinceCode));
        address.setDistrict(new District(districtId, id, districtName, districtCode));
        address.setWard(new Ward(wardId, id, wardName, wardCode));

        int status = new AddressDAO().insertAddress(address);
        response.setStatus(200);
    }
}
