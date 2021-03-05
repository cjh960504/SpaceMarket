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
function findId(){
	var name=$("input[name='name']").val();
	var phone=$("input[name='phone']").val();
	if(name.length<2||phone.length<11){
		alert("이름과 핸드폰번호를 정확히 입력해주세요.");
	}else{
		$.ajax({
			url:"/market/member/findId",
			type:"get",
			data:{
				"name":name,
				"phone":phone
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
                    <h3 class="bg-gray p-4">Find Id</h3>
                    <form>
                        <fieldset class="p-4">
                            <input type="text" name="name" placeholder="Username" class="border p-3 w-100 my-2">
                            <input type="text" name="phone" placeholder="Phone (- 빼고 입력 해주세요)" class="border p-3 w-100 my-2">
<!--                             <div class="loggedin-forgot">
                                    <input type="checkbox" id="keep-me-logged-in">
                                    <label for="keep-me-logged-in" class="pt-3 pb-2">Keep me logged in</label>
                            </div> -->
                            <button type="button" onClick="findId()" class="d-block py-3 px-5 bg-primary text-white border-0 rounded font-weight-bold mt-3">Find</button>
                            <a class="mt-3 d-block  text-primary" href="/market/member/findPWForm">Forget Password?</a>
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