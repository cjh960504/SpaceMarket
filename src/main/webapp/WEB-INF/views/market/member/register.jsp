<%@ page contentType="text/html;charset=UTF-8"%>
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
.loader {
	  border: 16px solid #ff0000;
	  border-radius: 50%;
	  border-top: 16px solid #3498db;
	  width: 100px;
	  height: 100px;
	  -webkit-animation: spin 2s linear infinite; /* Safari */
	  animation: spin 2s linear infinite;
	}
	
	/* Safari */
	@-webkit-keyframes spin {
	  0% { -webkit-transform: rotate(0deg); }
	  100% { -webkit-transform: rotate(360deg); }
	}
	
	@keyframes spin {
	  0% { transform: rotate(0deg); }
	  100% { transform: rotate(360deg); }
	}	
</style>
<script>
function regist(){
	$("#loader").addClass("loader");
	var formData = new FormData($("form")[0]);
	$.ajax({
		url:"/market/member/regist",
		data:formData,
		contentType:false,
		processData:false,
		type:"post",
		success:function(responseData){
			$("#loader").removeClass("loader");
			alert(responseData.msg);
			location.href="/market/member/loginForm";
		}
	});
}
function checkId(){
	$("#loader").addClass("loader");
	var user_id = $("#user_id").val();
	$.ajax({
		url:"/market/member/checkId",
		data:user_id,
		contentType:false,
		processData:false,
		type:"post",
		success:function(responseData){
			$("#loader").removeClass("loader");
			alert(responseData.msg);
			location.href="/market/member/regist";
		}
	});
}
</script>
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp" %>

<section class="login py-5 border-top-1">
        <div class="container">
        <div id="loader" style="margin:auto"></div>
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8 align-item-center">
                    <div class="border border">
                        <h3 class="bg-gray p-4">회원가입</h3>
                        <form>
                            <fieldset class="p-4">
                                <input type="text" name="user_id" placeholder="Id" class="border p-3 w-100 my-2">
                                <!-- <button type="button" onClick="checkId()" class="d-block py-3 px-4 bg-primary text-white border-0 rounded font-weight-bold">Id check</button> -->
                                <input type="password" name="password" placeholder="Password" class="border p-3 w-100 my-2">
                                <input type="password" name="passwordcheck" placeholder="RE Password" class="border p-3 w-100 my-2">
                             	<input type="text" name="name" placeholder="Name" class="border p-3 w-100 my-2">
                             	<input type="text" name="phone" placeholder="Phone (- 빼고 입력 해주세요)" class="border p-3 w-100 my-2">
                             	<input type="text" name="email_id" placeholder="Email Id" class="border p-3 w-100 my-2">
                             	<select name="email_server" class="border w-100 my-2">
                             		<option>이메일주소 선택</option>
                             		<option value="gmail.com">gmail.com</option>
									<option value="daum.net">daum.net</option>
									<option value="naver.com">naver.com</option>
                             	</select>
                             	<input type="text" name="addr" placeholder="Address" class="border p-3 w-100 my-2">
                             	<input type="file" name="repImg" class="border p-3 w-100 my-2">
                                <button type="button" onClick="regist()" class="d-block py-3 px-4 bg-primary text-white border-0 rounded font-weight-bold">가입</button>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
</section>
<%@ include file="../inc/footer.jsp" %>
</body>

</html>