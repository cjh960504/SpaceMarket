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
	
input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=button] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp" %>
<div class="container">
  <form id="qnaForm">
    <input type="text" id="fname" name="title" placeholder="Your name..">
    <input type="text" id="lname" name="writer" placeholder="Your last name..">
    <textarea id="subject" name="content" placeholder="Write something.." style="height:200px"></textarea>
    <input type="button" value="Submit">
  </form>
</div>
<%@ include file="../inc/footer.jsp" %>

</body>

</html>