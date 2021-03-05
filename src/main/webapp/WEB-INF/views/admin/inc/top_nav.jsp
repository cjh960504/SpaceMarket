<%@ page contentType="text/html;charset=UTF-8"%>
<div class="navbar">
  <div class="dropdown">
    <button class="dropbtn">상품관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="/admin/product/list">상품목록 관리</a>
      <a href="/admin/category/list">카테고리 관리</a>
      <a href="#">Link 3</a>
    </div>
  </div> 
  <a href="/admin/member/list">회원관리</a>
  <div class="dropdown">
    <button class="dropbtn">페이지관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#">배너관리</a>
      <a href="#">Link 2</a>
      <a href="#">Link 3</a>
    </div>
  </div> 
  <a href="/admin/cs/notice">공지사항관리</a>
  <%if(session.getAttribute("admin")!=null){ %>
	<a href="/admin/logout">로그아웃</a>
  <%} %>
</div>

