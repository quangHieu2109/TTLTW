package com.bookshopweb.servlet.general;

import com.bookshopweb.api.ViettelPostApi;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = {"/address"})
public class AddressServlet extends HttpServlet {
    private static List<ViettelPostApi.Province> provinces = null;
    private static List<ViettelPostApi.District> districts = null;
    private static List<ViettelPostApi.Ward> wards = null;
    private static final ViettelPostApi vietelPostApi = new ViettelPostApi();
    static {

        provinces = vietelPostApi.getProvinces(null);
        districts = vietelPostApi.getDistricts(null);
        wards = vietelPostApi.getWards(null);

    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String provinceID = req.getParameter("provinceID");
        String districtID = req.getParameter("districtID");
        String wardID = req.getParameter("wardID");
        List<ViettelPostApi.Province> provincesName = new ArrayList<>();
        List<ViettelPostApi.District> districtsName = new ArrayList<>();
       List<ViettelPostApi.Ward> wardsName = new ArrayList<>();
        if(provinceID!=null) {
            for (ViettelPostApi.District district : districts) {
                if (district.getPROVINCE_ID().equals(provinceID)) {
                    districtsName.add(district);
                }
            }

        }
       else if(districtID!=null) {
            for (ViettelPostApi.Ward ward : wards) {
                if (ward.getDISTRICT_ID().equals(districtID)) {
                    wardsName.add(ward);
                }
            }

        }
        else if(provinceID == null&&districtID==null&&wardID==null) {
           for (ViettelPostApi.Province province : provinces) {
               provincesName.add(province);
           }
        }

        Gson gson = new Gson();
        String jsonProvinces = gson.toJson(provincesName);
        String jsonDistricts = gson.toJson(districtsName);
        String jsonWards = gson.toJson(wardsName);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write("{\"provinces\":"+jsonProvinces+",\"districts\":"+jsonDistricts+",\"wards\":"+jsonWards+"}");
        resp.getWriter().flush();
        resp.getWriter().close();
        resp.setStatus(200);


    }

    public static List<ViettelPostApi.Province> getProvinces() {
        return provinces;
    }

    public static List<ViettelPostApi.District> getDistricts() {
        return districts;
    }

    public static List<ViettelPostApi.Ward> getWards() {
        return wards;
    }
}
