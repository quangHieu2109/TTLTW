<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">

<head>
  <fmt:setLocale value="vi_VN" />
  <c:if test="${sessionScope.lang!=null&&sessionScope.lang=='en'}">
    <fmt:setLocale value="en_US" />
  </c:if>
  <fmt:setBundle basename="lang" />

  <jsp:include page="_meta.jsp"/>


  <!-- Custom Scripts -->
  <script src="${pageContext.request.contextPath}/js/toast.js" type="module"></script>
  <script src="${pageContext.request.contextPath}/js/cart.js" type="module"></script>
  <script src="${pageContext.request.contextPath}/js/address.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/feeship.js" type="text/javascript"></script>

</head>

<body>
<jsp:include page="_header.jsp"/>
<fmt:message key="gio_hang"/>
<section class="section-pagetop bg-light">
  <div class="container">
    <h2 class="title-page"></h2>
  </div> <!-- container.// -->
</section> <!-- section-pagetop.// -->

<section class="section-content padding-y">
  <div class="container">
    <div class="row">

      <c:choose>
        <c:when test="${empty sessionScope.currentUser}">
          <p>
            <fmt:message key="vui_long"/> <a href="${pageContext.request.contextPath}/signin"><fmt:message key="dang_nhap"/></a> <fmt:message key="de_su_dung_chuc_nang_gio_hang"/>.
          </p>
        </c:when>
        <c:otherwise>
          <main class="col-lg-9 mb-lg-0 mb-3">
            <div class="card">

              <div id="cart-table"></div>

              <div class="card-body border-top">
                <button type="button" class="btn btn-primary float-end" id="checkoutBtn" disabled><fmt:message key="dat_hang"/></button>
                <a href="${pageContext.request.contextPath}/" class="btn btn-light"><fmt:message key="tiep_tuc_mua_sam"/></a>
              </div> <!-- card-body.// -->

            </div> <!-- card.// -->
          </main> <!-- col.// -->

          <aside class="col-lg-3">
            <div class="card mb-3">
              <div class="card-body">
                <b class="card-title">Địa chỉ nhận hàng</b>
                <select class="form-select " onscroll="4" id="selectProvince">
                  <option selected value="${requestScope.province}">${requestScope.province}</option>

                </select>
                <select class="form-select mt-2 mb-2" onscroll="4" id="selectDistrict">
                  <option selected value="${requestScope.district}">${requestScope.district}</option>

                </select>
                <select class="form-select " onscroll="4" id="selectWard">
                  <option selected value="${requestScope.ward}">${requestScope.ward}</option>

                </select>
              </div>

            </div>
            <div class="card mb-3">
              <div class="card-body">
                <b class="card-title"><fmt:message key="don_vi_van_chuyen"/></b>
                <select class="form-select" id="unit-ship">
                  <option value="none" selected>---</option>
                  <option value="ViettelPost">ViettelPost</option>
                  <option value="GHN">GHN</option>
                </select>
                <form>
                  <div class="form-check mb-2 disabled p-0 mt-3" id="infoShip">
                  </div>
                </form>

<%--                <form>--%>
<%--                  <div class="form-check mb-2">--%>
<%--                    <input class="form-check-input" type="radio" name="delivery-method"--%>
<%--                           id="delivery-method-1" value="1" disabled>--%>
<%--                    <label class="form-check-label" for="delivery-method-1"><fmt:message key="giao_tieu_chuan"/></label>--%>
<%--                  </div>--%>
<%--                  <div class="form-check mb-2">--%>
<%--                    <input class="form-check-input" type="radio" name="delivery-method"--%>
<%--                           id="delivery-method-2" value="2" disabled>--%>
<%--                    <label class="form-check-label" for="delivery-method-2"><fmt:message key="giao_nhanh"/></label>--%>
<%--                  </div>--%>
<%--                </form>--%>
              </div> <!-- card-body.// -->
            </div> <!-- card.// -->

            <div class="card">
              <div class="card-body">
                <dl class="row mb-0">
                  <dt class="col-xxl-6 col-lg-12 col-6"><fmt:message key="tam_tinh" />:</dt>
                  <dd class="col-xxl-6 col-lg-12 col-6 text-end mb-3"><span id="temp-price">0</span>₫</dd>
                  <dt class="col-xxl-6 col-lg-12 col-6"><fmt:message key="phi_van_chuyen"/>:</dt>
                  <dd class="col-xxl-6 col-lg-12 col-6 text-end mb-3"><span id="delivery-price">---</span></dd>
                  <dt class="col-xxl-6 col-lg-12 col-6"><fmt:message key="tong_cong"/>:</dt>
                  <dd class="col-xxl-6 col-lg-12 col-6 text-end mb-3"><strong><span id="total-price">0</span>₫</strong></dd>
                </dl>
              </div> <!-- card-body.// -->
            </div> <!-- card.// -->

          </aside> <!-- col.// -->
        </c:otherwise>
      </c:choose>

    </div> <!-- row.// -->
  </div> <!-- container -->
</section> <!-- section-content.// -->

<jsp:include page="_footer.jsp"/>

<div class="toast-container position-fixed bottom-0 start-0 p-3"></div> <!-- toast-container.// -->

</body>

</html>
