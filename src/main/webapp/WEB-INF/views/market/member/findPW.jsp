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
<script>
 function findPW(){
	var user_id=$("input[name='user_id']").val();
	var email_id=$("input[name='email_id']").val();
	var email_server=$("select").val();
	console.log(user_id, email_id, email_server);
	if(user_id.length<2||email_id.length<5||email_server=="x"){
		alert("모두 작성해주세요!");
	}else{
		$.ajax({
			url:"/market/member/findPW",
			type:"get",
			data:{
				"user_id":user_id,
				"email_id":email_id,
				"email_server":email_server
			},
			success:function(data){
				alert(data.msg);
				if(data.resultCode==1){
					location.href="/market/member/loginForm";			
				}
			}
		});
	}
} 
</script>
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp" %>

<section class="login py-5 border-top-1">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-8 align-item-center">
                <div class="border">
                    <h3 class="bg-gray p-4">Find Password</h3>
                    <form>
                        <fieldset class="p-4">
                            <input type="text" name="user_id" placeholder="Username" class="border p-3 w-100 my-2">
                            <input type="text" name="email_id" placeholder="등록하신 이메일을 작성해주세요" class="border p-3 w-100 my-2">
                            <select name="email_server" class="border w-100 my-2">
                             		<option value="x">이메일주소 선택</option>
                             		<option value="gmail.com">gmail.com</option>
									<option value="daum.net">daum.net</option>
									<option value="naver.com">naver.com</option>
                             	</select>
                            <button type="button" onClick="findPW()" class="d-block py-3 px-5 bg-primary text-white border-0 rounded font-weight-bold mt-3">Find</button>
                            <a class="mt-3 d-block  text-primary" href="/market/member/findIdForm">Forget ID?</a>
                            <a class="mt-3 d-block  text-primary" href="/market/member/loginForm">Log in</a>
                            <a class="mt-3 d-inline-block text-primary" href="/market/member/registForm">Register Now</a>
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