package com.bookshopweb.servlet.admin.voucher;

import com.bookshopweb.beans.CategorysOfVoucher;
import com.bookshopweb.beans.Voucher;
import com.bookshopweb.dao.CategorysOfVoucherDAO;
import com.bookshopweb.dao.VoucherDAO;
import com.bookshopweb.utils.ImageUtils;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Arrays;
import java.util.Random;

@WebServlet("/createVoucherSevlet")
@MultipartConfig
public class CreateVoucherServlet extends HttpServlet {
    private VoucherDAO voucherDAO = new VoucherDAO();
    private CategorysOfVoucherDAO categorysOfVoucherDAO = new CategorysOfVoucherDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        if (type == null) {
            req.getRequestDispatcher("/WEB-INF/views/createVoucherView.jsp").forward(req, resp);

        } else {
            randomVoucherCode(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("voucherName"+" "+req.getParameter("voucherName"));
        System.out.println("voucherCode"+" "+req.getParameter("voucherCode"));
        System.out.println("typeVoucher"+" "+req.getParameter("typeVoucher"));
        System.out.println("description"+" "+req.getParameter("description"));
        System.out.println("percentDecrease"+" "+req.getParameter("percentDecrease"));
        System.out.println("maxDecrease"+" "+req.getParameter("maxDecrease"));
        System.out.println("minPrice"+" "+req.getParameter("minPrice"));
        System.out.println("voucherStartsAt"+" "+req.getParameter("voucherStartsAt"));
        System.out.println("voucherEndAt"+" "+req.getParameter("voucherEndAt"));
        String voucherName = req.getParameter("voucherName");
        String voucherCode = req.getParameter("voucherCode");
        int type = Integer.parseInt(req.getParameter("typeVoucher"));
        String description = req.getParameter("description");
        int percentDecrease = Integer.parseInt(req.getParameter("percentDecrease"));
        double maxDecrease = Double.parseDouble(req.getParameter("maxDecrease"));
        double minPrice = Double.parseDouble(req.getParameter("minPrice"));
        Timestamp voucherStartsAt = Timestamp.from(LocalDateTime.parse(req.getParameter("voucherStartsAt"))
                .atZone(ZoneId.systemDefault()).toInstant());

        Timestamp voucherEndAt = Timestamp.from(LocalDateTime.parse(req.getParameter("voucherEndAt"))
                .atZone(ZoneId.systemDefault()).toInstant());
        String[] categorysString = req.getParameterValues("categorys");
        System.out.println("categorys"+" "+ Arrays.toString(categorysString));

        Voucher voucher = voucherDAO.getByVoucherCode(voucherCode);
        JsonObject jsonResponse = new JsonObject();
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        for (String category : categorysString) {
            System.out.println(category);
        }
        if (voucher != null) {
            resp.setStatus(400);
            jsonResponse.addProperty("msg", "Mã voucher đã tồn tại, vui lòng chọn mã khác!");
            resp.getWriter().write(jsonResponse.toString());
        } else {
            voucher = new Voucher(0L, voucherCode, voucherName, description, percentDecrease, maxDecrease, minPrice, type, voucherStartsAt, voucherEndAt, "");
            ImageUtils.setServletContext(getServletContext());
            ImageUtils.upload(req).ifPresent(voucher::setImage);
            int rs = voucherDAO.insert(voucher, "");
            if(rs>0){
                voucher = voucherDAO.getByVoucherCode(voucherCode);
                String category = Arrays.toString(categorysString);
                String categoryNew="";
                for(int i=1; i<category.length()-1; i++){
                    categoryNew+= category.charAt(i);
                }
                System.out.println(Arrays.toString(categoryNew.split(",")));
                for (String c : categoryNew.split(",")) {
                    CategorysOfVoucher categorysOfVoucher = new CategorysOfVoucher(0L, voucher.getId(), Long.parseLong(c));
                    categorysOfVoucherDAO.addCategoryOfVoucher(categorysOfVoucher);
                }
                resp.setStatus(200);
                jsonResponse.addProperty("msg", "Thêm voucher thành công!");
                resp.getWriter().write(jsonResponse.toString());

            }else{
                resp.setStatus(500);
                jsonResponse.addProperty("msg", "Thêm voucher thất bại, vui lòng thử lại sau!");
                resp.getWriter().write(jsonResponse.toString());
            }
        }



    }

    protected void randomVoucherCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String voucherCode = createVoucherCode();
        while (voucherDAO.getByVoucherCode(voucherCode) != null) {
            voucherCode = createVoucherCode();
        }
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("voucherCode", voucherCode);
        resp.setStatus(200);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(jsonResponse.toString());

    }

    protected String createVoucherCode() {
        String result = "";
        Random rd = new Random();
        while (result.length() < 6) {
            if (rd.nextInt(9) % 2 == 0) {
                int c = rd.nextInt(25) + 65;
                if (rd.nextInt(10) % 2 == 0) {
                    c += 32;
                }
                result += (char) c;
            } else {
                result += rd.nextInt(9);
            }
        }
        return result;
    }


}
