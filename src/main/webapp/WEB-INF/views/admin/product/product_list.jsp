<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<Product> productList = (List)request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp" %>
<style>
	img{
		width:100px;
	}
</style>
</head>
<body>
<%@ include file="../inc/top_nav.jsp" %>
<h1>상품목록 관리</h1>
<table>
  <tr>
    <th>No</th>
    <th>썸네일</th>
    <th>상품명</th>
    <th>판매자</th>
    <th>등록일</th>
    <th>가격</th>
  </tr>
  <%for(Product product:productList){ %>
	  <tr>
	    <td>Jill</td>
	    <td><img src="/resources/data/thumb_img/<%=product.getProduct_id()%>.<%=product.getFilename()%>"/></td>
	    <td><a href="/admin/product/detail?product_id=<%=product.getProduct_id()%>"><%=product.getProduct_name() %></a></td>
	    <td></td> <!-- MemberMapper를 만들어서 Product와 Collection하여 정보가져오기 -->
	    <td><%=product.getRegdate() %></td>
	    <td><%=product.getPrice() %></td>
	  </tr>
  <%} %>
  <tr>
  	<td colspan="5"><button type="button" onClick="location.href='/admin/product/registForm'">상품등록</button></td>
  </tr>
</table>

</body>
</html>
