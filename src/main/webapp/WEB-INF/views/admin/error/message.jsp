<%@page import="com.korea.spacemarket.model.common.MessageData"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	MessageData messageData= (MessageData)request.getAttribute("messageData");

%>
<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
alert("<%=messageData.getMsg()%>");
<%if(messageData.getResultCode()==0){%>
	location.href="/admin/";
<%}%>
</script>
</head>
<body>
</body>
</html>