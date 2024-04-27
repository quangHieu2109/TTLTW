package com.bookshopweb.servlet.client;

import com.bookshopweb.beans.AccurancyUser;
import com.bookshopweb.beans.Address;
import com.bookshopweb.beans.User;
import com.bookshopweb.dao.AccurancyDAO;
import com.bookshopweb.dao.UserDAO;
import com.bookshopweb.utils.HashingUtils;
import com.bookshopweb.utils.Protector;
import com.bookshopweb.utils.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.*;

@WebServlet(name = "SignupServlet", value = "/signup")
public class SignupServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/signupView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lưu các parameter (tên-giá trị) vào map values
        Map<String, String> values = new HashMap<>();
        values.put("username", request.getParameter("username"));
        values.put("password", request.getParameter("password"));
        values.put("fullname", request.getParameter("fullname"));
        values.put("email", request.getParameter("email"));
        values.put("phoneNumber", request.getParameter("phoneNumber"));
        values.put("gender", request.getParameter("gender"));
        values.put("numberhouse", request.getParameter("numberhouse"));
        values.put("province", request.getParameter("province"));
        values.put("district", request.getParameter("district"));
        values.put("ward", request.getParameter("ward"));
        values.put("policy", request.getParameter("policy"));

        // Kiểm tra các parameter, lưu các vi phạm (nếu có) vào map violations
        Map<String, List<String>> violations = new HashMap<>();
        Optional<User> userFromServer = Protector.of(() -> userDAO.getByUsername(values.get("username")))
                .get(Optional::empty);
        violations.put("usernameViolations", Validator.of(values.get("username"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .isAtMostOfLength(25)
                .isNotExistent(userFromServer.isPresent(), "Tên đăng nhập")
                .toList());
        violations.put("passwordViolations", Validator.of(values.get("password"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .isAtMostOfLength(32)
                .toList());
        violations.put("fullnameViolations", Validator.of(values.get("fullname"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .toList());
        violations.put("emailViolations", Validator.of(values.get("email"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .hasPattern("^[^@]+@[^@]+\\.[^@]+$", "email")
                .toList());
        violations.put("phoneNumberViolations", Validator.of(values.get("phoneNumber"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .hasPattern("^\\d{10,11}$", "số điện thoại")
                .toList());
        violations.put("genderViolations", Validator.of(values.get("gender"))
                .isNotNull()
                .toList());
        violations.put("numberhouseViolations", Validator.of(values.get("numberhouse"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .toList());
        violations.put("provinceViolations", Validator.of(values.get("province"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .isNotConttain("none")
                .toList());
        violations.put("districtViolations", Validator.of(values.get("district"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .isNotConttain("none")
                .toList());
        violations.put("wardViolations", Validator.of(values.get("ward"))
                .isNotNullAndEmpty()
                .isNotBlankAtBothEnds()
                .isNotConttain("none")
                .toList());
        violations.put("policyViolations", Validator.of(values.get("policy"))
                .isNotNull()
                .toList());

        // Tính tổng các vi phạm sau kiểm tra (nếu có)
        int sumOfViolations = violations.values().stream().mapToInt(List::size).sum();
        String successMessage = "Đã đăng ký thành công! Vui lòng đăng nhập và xác thực tài khoản!";
        String errorMessage = "Đã có lỗi truy vấn!";

        // Khi không có vi phạm trong kiểm tra các parameter
        if (sumOfViolations == 0) {
            User user = new User(
                    0L,
                    values.get("username"),
                    HashingUtils.hash(values.get("password")),
                    values.get("fullname"),
                    values.get("email"),
                    values.get("phoneNumber"),
                    Protector.of(() -> Integer.parseInt(values.get("gender"))).get(0),
                    new Address(0L, 0L, values.get("province"), values.get("district"), values.get("ward"), values.get("numberhouse")),
                    "CUSTOMER",
                    Timestamp.from(Instant.now())
            );

            Protector.of(() -> userDAO.insert(user,""))
                    .done(r -> request.setAttribute("successMessage", successMessage))
                    .fail(e -> {
                        request.setAttribute("values", values);
                        request.setAttribute("errorMessage", errorMessage);
                    });
            AccurancyUser accurancyUser = new AccurancyUser(user.getUsername());
            accurancyUser.setEndAt(new Timestamp(Calendar.getInstance().getTimeInMillis()));
            new AccurancyDAO().insertAccurancy(accurancyUser);
//            request.getRequestDispatcher("/WEB-INF/views/accuracyView.jsp").forward(request, response);
        } else {
            // Khi có vi phạm
            request.setAttribute("values", values);
            request.setAttribute("violations", violations);

        }
        request.getRequestDispatcher("/WEB-INF/views/signupView.jsp").forward(request, response);

    }
}
