package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.http.HttpClient;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.net.ssl.SSLContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONObject;

import dao.TheLoaiDAO;
import model.APISaveImage;
import model.BaiBao;
import model.BinhLuan;
import model.DSTheLoai;
import model.NewsService;
import model.NguoiDung;
import model.TheLoai;

/**
 * Servlet implementation class NewsServlet
 */
@MultipartConfig
@WebServlet("/NewsServlet")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		String type = request.getParameter("type");
		if (type.equals("upAnh")) {
			upAnh(request, response);
		} else if (type.equals("dangBai")) {
			dangBai(request, response);
		} else if (type.equals("avt")) {
			doiAVT(request, response);
		} else if (type.equals("showList")) {
			showList(request, response);
		} else if (type.equals("read")) {
			read(request, response);
		} else if (type.equals("edit")) {
			edit(request, response);
		} else if (type.equals("search")) {
			search(request, response);
		} else if (type.equals("cmt")) {
			cmt(request, response);
		} else if (type.equals("dangBao")) {
			response.sendRedirect(newsService.rewriteURL(request.getContextPath() + "/pageJournalist/dangBai.jsp"));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	protected void cmt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");
		String maBaiBao = request.getParameter("maBaiBao");
		String noiDung = request.getParameter("noiDung");
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		BaiBao baiBao = newsService.getBaiBaoByMaBB(maBaiBao);
		BinhLuan binhLuan = new BinhLuan(nguoiDung, noiDung, baiBao);
		newsService.addBinhLuan(binhLuan);
		response.sendRedirect(
				newsService.rewriteURL(request.getContextPath() + "/NewsServlet?type=read&maBaiBao=" + maBaiBao));

	}

	protected void upAnh(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		// Lấy tệp tin được tải lên từ yêu cầu
		Part filePart = request.getPart("file");
		// Lấy tên file từ part
		String fileName = getFileName(filePart);
		// Lưu file trên server
		filePart.write(getServletContext().getRealPath("/img") + "/" + fileName);

		String filePath = getServletContext().getRealPath("/img") + "/" + fileName;

		request.getSession().setAttribute("filePath", filePath);
		// lấy đường dẫn của file trên server
		String link = request.getContextPath() + "/img/" + fileName;
		request.setAttribute("image", link);
		request.getSession().setAttribute("fileName", fileName);

		System.out.println(filePath);
		// lấy mã thể loại chính
		String theLoai = request.getParameter("theLoai");
		// lấy danh sách mã thể loại phụ
		List<String> values = null;
		if (theLoai != null) {
			if (request.getParameterValues(theLoai) != null) {
				values = Arrays.asList(request.getParameterValues(theLoai));
			}
		} else {
			theLoai = "";
			values = new ArrayList<String>();
		}
		// lấy danh sách thể loại phụ từ danh sách mã thể loại phụ
		ArrayList<TheLoai> dsTLPhu = new ArrayList<TheLoai>();
		if (values != null) {
			for (String s : values) {
				dsTLPhu.add(TheLoaiDAO.selectByMaTheLoai(s));
			}
		}
		// lấy thể loại chính từ mã thể loại chính
		TheLoai tlChinh = (TheLoaiDAO.selectByMaTheLoai(theLoai) == null) ? new TheLoai()
				: TheLoaiDAO.selectByMaTheLoai(theLoai);
		DSTheLoai dsTheLoai = new DSTheLoai(tlChinh, dsTLPhu);
		// lấy các tham số khác của bài báo
		String tieuDe = request.getParameter("tieuDe");
		String moTa = request.getParameter("moTa");
		String noiDung = request.getParameter("noiDung");
		NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");

		BaiBao baiBao = new BaiBao(tieuDe, moTa, link, noiDung, nguoiDung, dsTheLoai);
//		request.getSession().setAttribute("baiBao", baiBao);
		request.getSession().setAttribute("baoDB", baiBao);
		// Chuyển hướng trở lại trang dangBai.jsp
		response.sendRedirect(newsService.rewriteURL(request.getContextPath() + "/pageJournalist/dangBai.jsp"));
	}

	protected void dangBai(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		File file = new File(request.getSession().getAttribute("filePath") + "");
		InputStream is = null;
		if (file.exists()) {
			is = new FileInputStream(file);
		} else {
			is = request.getPart("file").getInputStream();
		}

		String fileName = request.getSession().getAttribute("fileName") + "";
		// up ảnh lên app thứ 3
		String link = APISaveImage.uploadImageAndGetLink(is, fileName);
		file.delete();
		is.close();
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		request.getSession().removeAttribute("filePath");
//					TheLoai tl = null;

		String theLoai = request.getParameter("theLoai");
		List<String> values = null;
		if (theLoai != null) {
			if (request.getParameterValues(theLoai) != null) {
				values = Arrays.asList(request.getParameterValues(theLoai));
			}
		} else {
			theLoai = "";
			values = new ArrayList<String>();
		}
		ArrayList<TheLoai> dsTLPhu = new ArrayList<TheLoai>();
		if (values != null) {
			for (String s : values) {
				dsTLPhu.add(TheLoaiDAO.selectByMaTheLoai(s));
			}
		}
		DSTheLoai dsTheLoai = new DSTheLoai(TheLoaiDAO.selectByMaTheLoai(theLoai), dsTLPhu);

		String tieuDe = request.getParameter("tieuDe");
		String moTa = request.getParameter("moTa");
		String noiDung = request.getParameter("noiDung");

		System.out.println("link : " + link);
		NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");
		BaiBao baiBao = new BaiBao(tieuDe, moTa, link, noiDung, nguoiDung, dsTheLoai);

		newsService.addBaiBao(baiBao);
		response.sendRedirect(newsService.rewriteURL(request.getContextPath() + "/MainServlet"));
	}

	protected void doiAVT(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// Lấy phần dữ liệu file từ request
		Part filePart = request.getPart("file");
		// Lấy tên file
		String fileName = getFileName(filePart);
		// Gửi file lên Imgur và lấy liên kết
		String link = APISaveImage.uploadImageAndGetLink(filePart.getInputStream(), fileName);
		// Lấy thông tin người dùng từ session
		NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");
		// Cập nhật liên kết ảnh đại diện của người dùng
		nguoiDung.setAvt(link);
		// Lấy dịch vụ quản lý tin tức từ session
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		// Cập nhật thông tin người dùng trong dịch vụ quản lý tin tức
		newsService.updateNguoiDung(nguoiDung);
		// Chuyển hướng đến trang cá nhân
		response.sendRedirect(
				newsService.rewriteURL(request.getContextPath() + "/NewsServlet?typeShow=trangCaNhan&type=showList"));
	}

	protected void showList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		String type = request.getParameter("typeShow");
		if (type.equalsIgnoreCase("danhSachBaiBao")) {
			response.sendRedirect(
					newsService.rewriteURL(request.getContextPath() + "/pageJournalist/danhSachBaiBao.jsp"));
		} else if (type.equalsIgnoreCase("trangCaNhan")) {
			response.sendRedirect(newsService.rewriteURL(request.getContextPath() + "/thongTinTaiKhoan.jsp"));
		}
//		

	}

	protected void search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String type = req.getParameter("typeSearch");
		NewsService newsService = (NewsService) req.getSession().getAttribute("newsService");
		if (type != null && type.equalsIgnoreCase("searchByTheLoai")) {
			String theLoaiChinh = req.getParameter("theLoaiChinh");
			String theLoaiPhu = req.getParameter("theLoaiPhu");
			req.setAttribute("baos", newsService.getBaiBaoByTheLoai(theLoaiChinh, theLoaiPhu));

		} else {

			String txtSearch = req.getParameter("txtSearch");
			req.setAttribute("key", txtSearch);
			req.setAttribute("baos", newsService.searchBaiBao(txtSearch));
		}
		req.getRequestDispatcher(newsService.rewriteURL("/ketQuaTimKiem.jsp")).forward(req, resp);
	}

	protected void read(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");

		BaiBao bao = newsService.getBaiBaoByMaBB(request.getParameter("maBaiBao") + "");

		request.setAttribute("bao", bao);
		request.setAttribute("cmts", newsService.getBinhLuan(bao));
		newsService.updateBaiBao(bao);
		request.getRequestDispatcher(newsService.rewriteURL("/docBao.jsp")).forward(request, response);
	}

	protected void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
		String type = request.getParameter("typeEdit");
		if (type.equals("edit")) {
			// chỉnh sửa bài báo
			String maBaiBao = request.getParameter("maBaiBao");
			BaiBao baiBao = newsService.getBaiBaoByMaBB(maBaiBao);

			request.setAttribute("baiBao", baiBao);
//			request.getRequestDispatcher(newsService.rewriteURL("pageJournalist/chinhSuaBaiBao.jsp?maBaiBao="+maBaiBao)).forward(request, response);
			response.sendRedirect(newsService
					.rewriteURL(request.getContextPath() + "/pageJournalist/chinhSuaBaiBao.jsp?maBaiBao=" + maBaiBao));
		} else if (type.equals("remove")) {
			// xóa bài báo
			String maBaiBao = request.getParameter("maBaiBao");
			BaiBao baiBao = newsService.getBaiBaoByMaBB(maBaiBao);
			newsService.removeBaiBao(baiBao);
			NguoiDung nguoiDung = (NguoiDung) request.getSession().getAttribute("nguoiDung");
			request.setAttribute("baos", newsService.getBaiBaoByTenDanhNap(nguoiDung.getTenDangNhap()));
			response.sendRedirect(newsService
					.rewriteURL(request.getContextPath() + "/NewsServlet?typeShow=danhSachBaiBao&type=showList"));
		} else if (type.equals("upAnh")) {
			// Đổi ảnh bài báo
			// Lấy tệp tin được tải lên từ yêu cầu
			Part filePart = request.getPart("file");
			String fileName = getFileName(filePart);
			// lưu ảnh trên server
			filePart.write(getServletContext().getRealPath("/img") + "//" + fileName);
			// lấy đường dẫn tuyệt đối của file ảnh
			String filePath = getServletContext().getRealPath("/img") + "//" + fileName;
			// lưu đường dẫn ảnh trên server để phục vụ việc đăng bài
			request.getSession().setAttribute("filePath", filePath);

			// lấy đường dẫn file ảnh trên server
			String link = request.getContextPath() + "/img/" + fileName;
//			request.setAttribute("image", link);
//			request.getSession().setAttribute("fileName", fileName);
			String maBaiBao = request.getParameter("maBaiBao");
			String theLoai = request.getParameter("theLoai");
			List<String> values = null;
			if (theLoai != null) {
				if (request.getParameterValues(theLoai) != null) {
					values = Arrays.asList(request.getParameterValues(theLoai));
				}
			} else {
				theLoai = "";
				values = new ArrayList<String>();
			}

			ArrayList<TheLoai> dsTLPhu = new ArrayList<TheLoai>();
			if (values != null) {
				for (String s : values) {
					dsTLPhu.add(TheLoaiDAO.selectByMaTheLoai(s));
				}
			}
			TheLoai tlChinh = (TheLoaiDAO.selectByMaTheLoai(theLoai) == null) ? new TheLoai()
					: TheLoaiDAO.selectByMaTheLoai(theLoai);
			DSTheLoai dsTheLoai = new DSTheLoai(tlChinh, dsTLPhu);

			String tieuDe = request.getParameter("tieuDe");
			String moTa = request.getParameter("moTa");
			String noiDung = request.getParameter("noiDung");

			BaiBao baiBao = newsService.getBaiBaoByMaBB(maBaiBao);
			baiBao.setTieuDe(tieuDe);
			baiBao.setNoiDung(noiDung);
			baiBao.setFilePath(link);
			baiBao.setTheLoai(dsTheLoai);
			baiBao.setMoTa(moTa);

			request.setAttribute("baiBao", baiBao);
			request.getRequestDispatcher(newsService.rewriteURL("/pageJournalist/chinhSuaBaiBao.jsp")).forward(request,
					response);
		} else {
			String maBaiBao = request.getParameter("maBaiBao");
			BaiBao baiBao = newsService.getBaiBaoByMaBB(maBaiBao);
			String link = null;
			if (request.getSession().getAttribute("filePath") != null) {
				// có thay đổi ảnh
				System.out.println("FilePath not null");
				File file = new File(request.getSession().getAttribute("filePath") + "");
				InputStream is = new FileInputStream(file);
				String fileName = request.getSession().getAttribute("fileName") + "";
				link = APISaveImage.uploadImageAndGetLink(is, fileName);
				file.delete();
				is.close();
//				NewsService newsService = (NewsService) request.getSession().getAttribute("newsService");
				request.getSession().removeAttribute("filePath");
			} else {
				// không thay đổi ảnh
				link = baiBao.getFilePath();
			}

			String theLoai = request.getParameter("theLoai");
			List<String> values = null;
			if (theLoai != null) {
				if (request.getParameterValues(theLoai) != null) {
					values = Arrays.asList(request.getParameterValues(theLoai));
				}
			} else {
				theLoai = "";
				values = new ArrayList<String>();
			}
			ArrayList<TheLoai> dsTLPhu = new ArrayList<TheLoai>();
			if (values != null) {
				for (String s : values) {
					dsTLPhu.add(TheLoaiDAO.selectByMaTheLoai(s));
				}
			}
			DSTheLoai dsTheLoai = new DSTheLoai(TheLoaiDAO.selectByMaTheLoai(theLoai), dsTLPhu);

			String tieuDe = request.getParameter("tieuDe");
			String moTa = request.getParameter("moTa");
			String noiDung = request.getParameter("noiDung");

			baiBao.setTieuDe(tieuDe);
			baiBao.setNoiDung(noiDung);
			baiBao.setFilePath(link);
			baiBao.setTheLoai(dsTheLoai);
			baiBao.setMoTa(moTa);
			newsService.updateBaiBao(baiBao);
			response.sendRedirect(newsService.rewriteURL(request.getContextPath() + "/MainServlet"));
		}

	}

	protected String getFileName(Part part) {
		String header = part.getHeader("content-disposition");
		for (String headerPart : header.split(";")) {
			if (headerPart.trim().startsWith("filename")) {
				return headerPart.substring(headerPart.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;

	}
}
