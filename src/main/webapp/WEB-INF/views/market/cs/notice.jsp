<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

  <!-- SITE TITTLE -->
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Classimax</title>
<%@ include file="../inc/header.jsp" %>
<style>
	body {
	  font-family: Arial, Helvetica, sans-serif;
	}
	
	* {
	  box-sizing: border-box;
	}
	
	/* style the container */
	.container {
	  position: relative;
	  border-radius: 5px;
	  padding: 20px 0 30px 0;
	} 
	
	table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 16px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
</style>
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp" %>
<div class="container">
	<table>
  <tr>
    <th>No</th>
    <th>Title</th>
    <th>Writer</th>
    <th>Regdate</th>
    <th>Hit</th>
  </tr>
  <%-- <%for(int i=0;i<qnaList.size();i++){ %>
  <%Qna qna = qnaList.get(i); %>
	  <tr>
	    <td><%=qna.getQna_id() %></td>
	    <td><%=qna.getTitle() %></td>
	    <td><%=qna.getWriter() %></td>
	    <td><%=qna.getRegdate() %></td>
	    <td><%=qna.getHit() %></td>
	  </tr>
  <%} %> --%>
</table>
</div>
<%@ include file="../inc/footer.jsp" %>

</body>

</html>