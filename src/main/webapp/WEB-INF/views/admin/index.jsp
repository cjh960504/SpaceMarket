<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우주마켓 | 관리자</title>
<style>
#wrapper{
	text-align: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function () {
		$("button").on("click", function () {
			var formData = $("form").serialize();
			console.log(formData);
			$.ajax({
				url:"/admin/login",
				type:"post",
				data:formData,
				success:function(result){
					if(result.resultCode==1){
						location.href="/admin/product/list";						
					}else{
						console.log(result.msg);
						alert(result.msg);
					}
				},
				error:function(xhr,status,error){
					alert("로그인 정보가 일치하지 않습니다!");
				}
			});
		})
	});
	
</script>
</head>
<body>
	<div id="wrapper">
	<h2>우주마켓 | 관리자 페이지</h2>
		<form>
			<table>
				<tr>
					<td>
						<input type="text" name="user_id" placeholder="ID">
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" name="password" placeholder="Password">
					</td>
				</tr>
				<tr>
					<td>
						<button type="button">Login</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>