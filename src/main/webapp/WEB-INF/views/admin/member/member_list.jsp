<%@page import="com.korea.spacemarket.model.domain.Member"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<Member> memberList = (List)request.getAttribute("memberList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="../inc/header.jsp" %>
<style>
.container {
	  border-radius: 5px;
	  background-color: #f2f2f2;
	  padding: 20px;
}
</style>
<script>
	$(function(){
		$("button").click(function(){
			location.href="/admin/member/registform";
		});
	});
</script>
</head>
<body>
<%@ include file="../inc/top_nav.jsp" %>
<div class="container">
			<table>
				<tr>
					<th>No</th>
					<th>회원프로필</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>주소</th>
					<th>등록일</th>
				</tr>
				<%for(int i=0;i<memberList.size();i++){ %>
				<%Member member = memberList.get(i); %>
				<tr>
					<td><%=member.getMember_id()%></td>
					<td><img src="/resources/data/basic/<%=member.getMember_id()%>.<%=member.getFilename()%>" width="50px"></td>
					<td><a href="/admin/member/detail?member_id=<%=member.getMember_id()%>"><%=member.getUser_id()%></a></td>
					<td><%=member.getName()%></td>
					<td><%=member.getPhone()%></td>
					<td><%=member.getEmail_id()%>@<%=member.getEmail_server()%></td>
					<td><%=member.getAddr()%></td>
					<td><%=member.getRegdate()%></td>
				</tr>
				<%}%>
				<tr>
					<td colspan="8">
						<button>회원등록</button>
					</td>
				</tr>
			</table>
		</div>	
</body>
</html>
