<%@page import="com.korea.spacemarket.model.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Member member = (Member)request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {box-sizing: border-box;}
</style>
<%@ include file="../inc/header.jsp" %>
<script>
//회원삭제
function edit(){
	if(confirm("수정하시겠어요?")){
		var formData = new FormData($("form")[0]);
		$.ajax({
			url:"/admin/member/edit",
			data:formData,
			contentType:false,
			processData:false,
			type:"post",
			success:function(responseData){
				$("#loader").removeClass("loader");
				alert(responseData.msg);
				location.href="/admin/member/list";
			}
		});
	}
}
function del(){
	if(confirm("삭제하시겠어요?")){
		$("form").attr({
			action:"/admin/member/delete",
			method:"post"
		});
		$("form").submit();
	}
}
</script>
</head>
<body>
	<%@ include file="../inc/top_nav.jsp" %>
	<div class="container">
	  <form>
	  	<input type="hidden" name="member_id" value="<%=member.getMember_id()%>">
	    <label for="fname">아이디</label>
	    <input type="text" name="user_id" value="<%=member.getUser_id()%>" readonly="readonly">
	    <label for="lname">이름</label>
	    <input type="text" name="name" value="<%=member.getName()%>">
	    <label for="lname">연락처</label>
	    <input type="text" name="phone" value="<%=member.getPhone()%>">
	    <label for="lname">이메일아이디</label>
	    <input type="text" name="email_id" value="<%=member.getEmail_id()%>">
	    <label for="lname">이메일서버</label>
	    <select name="email_server" value="<%=member.getEmail_server()%>">
			<option value="gmail.com">gmail.com</option>
			<option value="daum.net">daum.net</option>
			<option value="naver.com">naver.com</option>
		</select>
	    <label for="lname">주소</label>
	    <input type="text" name="addr" value="<%=member.getAddr()%>">
		<input type="file" name="repImg" value="<%=member.getFilename()%>"><br>
	    <input type="button" value="회원수정" onClick="edit()">
	    <input type="button" value="회원삭제" onClick="del()">
	    <input type="button" value="목록보기" onClick="location.href='/admin/member/list'">
	  </form>
	</div>
</body>
</html>