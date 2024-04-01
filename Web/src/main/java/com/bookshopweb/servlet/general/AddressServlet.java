package com.bookshopweb.servlet.general;

import com.bookshopweb.api.ViettelPostApi;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet(urlPatterns = {"/address"})
public class AddressServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ViettelPostApi vietelPostApi = new ViettelPostApi();

        String province = req.getParameter("provinceID");
        String district = req.getParameter("districtID");
        String ward = req.getParameter("wardID");
        List<String> provinces = new ArrayList<>();
        List<String> districts = new ArrayList<>();
        List<String> wards = new ArrayList<>();
        for(ViettelPostApi.Province oProvince: vietelPostApi.getProvinces(province)){
            provinces.add(oProvince.getPROVINCE_NAME());
        };
        for(ViettelPostApi.District oDistrict: vietelPostApi.getDistricts(province)){
            districts.add(oDistrict.getDISTRICT_NAME());
        };
        for(ViettelPostApi.Ward oWard: vietelPostApi.getWards(district)){
            wards.add(oWard.getWARDS_NAME());
        };
        Gson gson = new Gson();
        String jsonProvinces = gson.toJson(provinces);
        String jsonDistricts = gson.toJson(districts);
        String jsonWards = gson.toJson(wards);
        resp.setContentType("application/json");
        resp.getWriter().write("{\"provinces\":"+jsonProvinces+",\"districts\":"+jsonDistricts+",\"wards\":"+jsonWards+"}");
        resp.getWriter().flush();
        resp.setStatus(200);


    }
}
