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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var jibunAddr = data.jibunAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("addr").value = jibunAddr;
                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
               /*  if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                } */

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                /* if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                } */
            }
        }).open();
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
                             	<input type="text" name="addr" id="addr" placeholder="Address" class="border p-3 w-100 my-2"><input type="button" value="주소찾기" onClick="sample4_execDaumPostcode()">
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