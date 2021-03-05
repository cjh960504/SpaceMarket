<%@page import="com.korea.spacemarket.model.domain.SubCategory"%>
<%@page import="com.korea.spacemarket.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@page import="com.korea.spacemarket.model.common.Formatter"%>
<%@page import="com.fasterxml.jackson.core.format.DataFormatMatcher"%>
<%@page import="com.korea.spacemarket.model.domain.Product_Image"%>
<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<SubCategory> subList = (List)request.getAttribute("subList");
%>
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
  /*드래그 관련*/
#dragArea {
	width: 100%;
	height: 300px;
	border:2px solid #ccc;
	overflow: scroll;
	float:left;
}
.dragBorder {
	background: #ffffff;
}
.box > img{
	width:100%;
}
.box{
	width:70px;
	float:left;
	padding:5px;
}
.close{
	color:black;
	cursor:pointer;
}

  </style>
  
  <script>
  var uploadFiles=[]; //이미지 미리보기 목록
	var psize=[];//유저가 선택한 사이즈를 담는 배열
	
	$(function () {
		CKEDITOR.replace( 'detail' );
		 
		 $("#dragArea").on("dragenter",function(e){
			 $(this).addClass("dragBorder");
		 });
		 $("#dragArea").on("dragover", function (e) {
			e.preventDefault();
		});
		$("#dragArea").on("drop", function (e) {
			e.preventDefault();
			
			var fileList = e.originalEvent.dataTransfer.files;
			
			for(var i=0;i<fileList.length;i++){
				uploadFiles.push(fileList[i]);
				preview(uploadFiles[i], i); 
			}
		});
		$("#dragArea").on("dragleave", function(e) {//드래그로 영역에서 빠져나가면..
			//$(this).append("dragleave<br>");
			$(this).removeClass();
		});
		//이미지 삭제 이벤트 처리
		$("#dragArea").on("click", ".close", function(e){
			console.log(e);
			
			//대상 요소 배열에서 삭제 
			//삭제 전에 uploadFiles라는 배열에 들어있는 file의 index를 구하자!!
			var f = uploadFiles[e.target.id];
			//console.log(f);
			var index = uploadFiles.indexOf(f);
			console.log(index);
			uploadFiles.splice(index, 1);
			
			//내가 추가한거
			$(".box").remove();
			for(var i=0;i<uploadFiles.length;i++){
				preview(uploadFiles[i], i);
			}
			//대상요소삭제
			//class인 close를 감싸고 있는 부모인 box를 지운다!(시각적 삭제)
			//$(e.target).parent().remove();
		})
	});
	
	//업로드 이미지 미리보기
	function preview(file, index){
		//js로 이미지 미리보기를 구현하려면, 파일리더를 이용하면 된다. FileReader
		var reader = new FileReader(); //아직은 읽을 대상 파일이 결정되지 않음..
		//파일을 읽어들이면, 이벤트 발생시킴
		reader.onload=function(e){
			//console.log(reader.result);
			var tag ="<div class=\"box\">";
			tag+="<div class=\"close\" id=\""+index+"\">X</div>"; 
			tag+="<img src=\""+reader.result+"\">";
			tag+="</div>";
			$("#dragArea").append(tag);
			
		};
		
		//위의 이벤트를 발동시킴!
		reader.readAsDataURL(file);//지정한 파일을 읽는다(매개변수로는 파일이 와야함)
	}
	function registProduct() {
		var formData = new FormData($("form")[0]);//이미지와 같은 데이터들을 파라미터에 담기위함
		
		$.each(uploadFiles, function(i, file){
			formData.append("productImg", file, file.name);
			console.log(i, file.name);
		});
		
		formData.append("detail" , (CKEDITOR.instances["detail"].getData()));
		
		if(uploadFiles.length<1){
			alert("상품의 이미지가 없어서 되겠어요?");
		}else{
			$.ajax({
				url:"/market/product/regist",
				data:formData,
				contentType:false,/*false일 경우 multipart/form-data로 지정한 효과!*/
				processData:false,/*false일 경우 query-string으로 전송하지 않음, 문자열만 보내는게 아니라 이미지도 껴있기 떄문에 stream방식*/
				type:"post",
				success:function(responseData){
					//성공실패 여부를 판단할 수 있는 데이터
					if(responseData.resultCode==1){
						location.href="/market/member/products?member_id="+responseData.data;
					}else{
						alert(responseData.msg);
					}
				}
			})
		}
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
<section class="ad-post bg-gray py-5">
    <div class="container">
        <form action="#">
            <!-- Post Your ad start -->
            <fieldset class="border border-gary p-4 mb-5">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3>판매상품 글쓰기</h3>
                        </div>
                        <div class="col-lg-6">
                            <h6 class="font-weight-bold pt-4 pb-1">제목:</h6>
                            <input type="text" name="product_name" class="border w-100 p-2 bg-white text-capitalize" placeholder="Ad title go There">
                            <h6 class="font-weight-bold pt-4 pb-1">판매자 위치:</h6>
                            <input type="text" id="addr" name="product_addr" class="border w-100 p-2 bg-white text-capitalize" placeholder="Ad title go There" value="<%=member.getAddr()%>"><input type="button" value="주소변경" onClick="sample4_execDaumPostcode()">
                            <h6 class="font-weight-bold pt-4 pb-1">설명:</h6>
                            <textarea name="detail" id="detail" class="border p-3 w-100" rows="7" placeholder="내용을 작성해주세요."></textarea>
                        </div>
                        <div class="col-lg-6">
                            <h6 class="font-weight-bold pt-4 pb-1">Select Ad Category:</h6>
                            <select name="subCategory.subcategory_id"  class="w-100" >
                                <option value="0">카테고리 선택</option>
                                <%for(SubCategory subCategory:subList){ %>
                                	<option value="<%=subCategory.getSubcategory_id()%>"><%=subCategory.getName()%></option>
                                <%} %>
                            </select>
                                 <div class="price">
                                <h6 class="font-weight-bold pt-4 pb-1">브랜드:</h6>
                                <div class="row px-3">
                                    <div class="col-lg-4 mr-lg-4 rounded bg-white my-2 ">
                                        <input type="text" name="brand" class="border-0 py-2 w-100 price" placeholder="brand"
                                            id="price">
                                    </div>
                                </div>
                            </div>
                            <div class="price">
                                <h6 class="font-weight-bold pt-4 pb-1">가격 (₩):</h6>
                                <div class="row px-3">
                                    <div class="col-lg-4 mr-lg-4 rounded bg-white my-2 ">
                                        <input type="text" name="price" class="border-0 py-2 w-100 price" placeholder="Price"
                                            id="price">
                                    </div>
                                </div>
                            </div>
                            <h6 class="font-weight-bold pt-4 pb-1">게시할 상품의 사진을 드래그해주세요:</h6>
                            <div class="choose-file text-center my-4 py-4 rounded" id="dragArea">
                                <label for="file-upload">
                                </label>
                            </div>
                        </div>
                    </div>
            </fieldset>
            <!-- Post Your ad end -->



            <!-- submit button -->
            <div class="checkbox d-inline-flex">
                <input type="checkbox" id="terms-&-condition" class="mt-1">
                <label for="terms-&-condition" class="ml-2">By click you must agree with our
                    <span> <a class="text-success" href="terms-condition.html">Terms & Condition and Posting Rules.</a></span>
                </label>
            </div>
            <button type="button" onClick="registProduct()" class="btn btn-primary d-block mt-2">상품등록</button>
        </form>
    </div>
</section>
<%@ include file="../inc/footer.jsp" %>
</body>

</html>