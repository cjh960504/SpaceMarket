<%@page import="com.korea.spacemarket.model.common.Formatter"%>
<%@page import="com.fasterxml.jackson.core.format.DataFormatMatcher"%>
<%@page import="com.korea.spacemarket.model.domain.Product_Image"%>
<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Product product = (Product)request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="en">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Classimax</title>
  
  <%@ include file="../inc/header.jsp" %>
  <style>
  	.before{
  	    color: #59d659;
  }
  .after{
  	    color: #d91c1c;
  }
  	   
  </style>
</head>

<body class="body-wrapper">
<%@ include file="../inc/top.jsp" %>
	상품 등록
<%@ include file="../inc/footer.jsp" %>
</body>

</html>