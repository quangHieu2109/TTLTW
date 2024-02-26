package security;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

import model.NewsService;
import model.NguoiDung;

/**
 * Servlet Filter implementation class SecurityFilter
 */
@WebFilter(urlPatterns = { "/pageJournalist/*" })
public class PageJournalistFilter extends HttpFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		NguoiDung nguoiDung = (NguoiDung) req.getSession().getAttribute("nguoiDung");
		
		NewsService newsService = (NewsService) req.getSession().getAttribute("newsService");
		if (!nguoiDung.isLogin()) {

			// Người dùng chưa đăng nhập thì chuyển đến trang đăng nhập
			res.sendRedirect(newsService.rewriteURL(req.getContextPath() + "/UserServlet?type=dangNhap"));
		} else {
			if (nguoiDung.isAdmin() || nguoiDung.isNhaBao()) {
				chain.doFilter(req, res);
			} else {
				res.sendRedirect(newsService.rewriteURL(req.getContextPath() + "/thongBao.jsp"));
			}
		}

	}

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public PageJournalistFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
