package controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DangKyDangBai;
import model.NewsService;
import model.NguoiDung;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String type = request.getParameter("type");
		if (type.equals("dangNhap")) {
			dangNhap(request, response);
		} else if (type.equals("dangKy")) {
			dangKy(request, response);
		} else if (type.equals("login")) {
			login(request, response);
		} else if (type.equals("register")) {
			register(request, response);
		} else if (type.equals("logout")) {
			logout(request, response);
		} else if (type.equals("editIn4")) {
			editIn4(request, response);
		} else if (type.equals("dangKyDangBai")) {
			dangKyDangBai(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tenDangNhap = request.getParameter("tenDangNhap");
		String matKhau = request.getParameter("matKhau");
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		System.out.println(newsService.isEnglish());
		if (newsService == null) {
			newsService = new NewsService();

		}
		String error = "";
		NguoiDung nguoiDung = newsService.getNguoiDung(tenDangNhap);
		if (nguoiDung == null) {
			error = "dang_nhap_error_tk";
			request.setAttribute("error", error);
			request.getRequestDispatcher(newsService.rewriteURL("/dangNhap.jsp")).forward(request, response);
		} else {
			if (!nguoiDung.getMatKhau().equals(matKhau)) {
				error = "dang_nhap_error_mk";
				request.setAttribute("error", error);
				request.getRequestDispatcher(newsService.rewriteURL("/dangNhap.jsp")).forward(request, response);
			} else {
				request.getSession().setAttribute("nguoiDung", nguoiDung);
				System.out.println(nguoiDung);
				response.sendRedirect(newsService.rewriteURL(request.getContextPath()+"/MainServlet"));
			}
		}

	}

	protected void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		request.getSession().invalidate();
		request.getSession().setAttribute("newsService", newsService);
		response.sendRedirect("MainServlet");
	}

	protected void register(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tenDangNhap = request.getParameter("tenDangNhap");
		String matKhau = request.getParameter("matKhau");
		String hoTen = request.getParameter("hoTen");
		String email = request.getParameter("email");
		String ngaySinh = request.getParameter("ngaySinh");
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
//		if (newsService == null) {
//			newsService = new NewsService();
//			request.getSession().setAttribute("newsService", newsService);
//
//		}
		if (newsService.addNguoiDung(new NguoiDung(tenDangNhap, matKhau, hoTen, email, Date.valueOf(ngaySinh))) != 0) {
			request.setAttribute("error", "dang_ky_thanh_cong");
			request.getRequestDispatcher(newsService.rewriteURL("/dangNhap.jsp")).forward(request, response);
		} else {
			request.setAttribute("error", "dang_ky_error");
			NguoiDung nguoidung = new NguoiDung(tenDangNhap, matKhau, hoTen, email, Date.valueOf(ngaySinh));
			request.setAttribute("nguoidung", nguoidung);
			request.getRequestDispatcher(newsService.rewriteURL("/dangKy.jsp")).forward(request, response);
		}
	}

	protected void dangNhap(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		response.sendRedirect(newsService.rewriteURL(request.getContextPath()+"/dangNhap.jsp"));
	}

	protected void dangKy(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		response.sendRedirect(newsService.rewriteURL(request.getContextPath()+"/dangKy.jsp"));
	}

	protected void dangKyDangBai(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String typeDK = request.getParameter("typeDK");
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		if (typeDK.equals("danhSach")) {
			request.setAttribute("danhSachDK", newsService.getDangKyDangBai());
//			request.getRequestDispatcher(newsService.rewriteURL("admin/danhSachDangKy.jsp")).forward(request, response);
			response.sendRedirect(newsService.rewriteURL(request.getContextPath()+"/admin/danhSachDangKy.jsp"));
		} else if (typeDK.equals("xoa")) {
			String maDK = request.getParameter("maDK");
			DangKyDangBai dkdb = newsService.getDangKyDangBaiByMaDK(maDK);
			NguoiDung nguoiDung = dkdb.getNguoiDung();
			nguoiDung.setTheLoaiND("NguoiDung");
			newsService.updateNguoiDung(nguoiDung);
			newsService.deleteDangKy(maDK);
//			request.getSession().setAttribute("danhSachDK", newsService.getDangKyDangBai());
			response.sendRedirect(newsService.rewriteURL(request.getContextPath()
					+ "/UserServlet?type=dangKyDangBai&typeDK=danhSach"));
		} else if (typeDK.equals("chapNhan")) {
			String maDK = request.getParameter("maDK");
			DangKyDangBai dkdb = newsService.getDangKyDangBaiByMaDK(maDK);
			NguoiDung nguoiDung = dkdb.getNguoiDung();
			nguoiDung.setTheLoaiND("NhaBao");
			newsService.updateNguoiDung(nguoiDung);
			newsService.deleteDangKy(maDK);
//			request.getSession().setAttribute("danhSachDK", newsService.getDangKyDangBai());
			response.sendRedirect(newsService.rewriteURL(request.getContextPath()
					+ "/UserServlet?type=dangKyDangBai&typeDK=danhSach"));
		} else if (typeDK.equals("dangKy")) {
			NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");
			nguoiDung.setTheLoaiND("DangKy");
			newsService.updateNguoiDung(nguoiDung);
			newsService.addDangKy(new DangKyDangBai(nguoiDung));
			response.sendRedirect(newsService.rewriteURL(request.getContextPath()+"/thongBaoKetQua.jsp"));
		}
	} 

	protected void editIn4(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");
		String matKhau = request.getParameter("matKhau");
		String hoTen = request.getParameter("hoTen");
		String email = request.getParameter("email");
		String ngaySinh = request.getParameter("ngaySinh");
		nguoiDung.setHoVaTen(hoTen);
		nguoiDung.setMatKhau(matKhau); 
		nguoiDung.setEmail(email);
		nguoiDung.setNgaySinh(Date.valueOf(ngaySinh));
		NewsService service = (NewsService) request.getSession().getAttribute("newsService");
		if (service == null) {
			service = new NewsService();
			request.getSession().setAttribute("newsService", service);

		}
		service.updateNguoiDung(nguoiDung);
		request.setAttribute("thongBao", "Thay đổi thông tin thành công");
		request.getRequestDispatcher(newsService.rewriteURL("/thayDoiThongTin.jsp")).forward(request, response);
	}

}
