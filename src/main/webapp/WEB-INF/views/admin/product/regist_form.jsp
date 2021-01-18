<%@page import="com.korea.spacemarket.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<TopCategory> topList = (List)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {box-sizing: border-box;}
/*드래그 관련*/
#dragArea {
	width: 100%;
	height: 300px;
	overflow: scroll;
	border:1px solid #ccc;
	float:left;
}
.dragBorder {
	background: #ffffff;
}
.box > img{
	width:100%;
}
.box{
	width:100px;
	float:left;
	padding:5px;
}
.close{
	color:#ccc;
	cursor:pointer;
}
</style>
<%@ include file="../inc/header.jsp" %>
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
	function chageTopcategory(obj) {
		console.log($(obj).val());
		$.ajax({
			url:"/admin/product/getSubCategory",
			type:"post",
			data:{
				topcategory_id:$(obj).val()
			},
			success:function(responseData){
				$("select[name='subCategory.subcategory_id']").empty();
				$("select[name='subCategory.subcategory_id']").append("<option value=\"0\">하위카테고리를 선택해주세요</option>");
				console.log(responseData.length);
				for(var i=0;i<responseData.length;i++){
					$("select[name='subCategory.subcategory_id']").append("<option value=\""+responseData[i].subcategory_id+"\">"+responseData[i].name+"</option>");
				}
				
			}
		})
	}
	function registProduct() {
		var formData = new FormData($("form")[0]);//이미지와 같은 데이터들을 파라미터에 담기위함
		
		$.each(uploadFiles, function(i, file){
			formData.append("productImg", file, file.name);
			console.log(i, file.name);
		});
		
		formData.append("detail" , (CKEDITOR.instances["detail"].getData()));
		
		$.ajax({
			url:"/admin/product/regist",
			data:formData,
			contentType:false,/*false일 경우 multipart/form-data로 지정한 효과!*/
			processData:false,/*false일 경우 query-string으로 전송하지 않음, 문자열만 보내는게 아니라 이미지도 껴있기 떄문에 stream방식*/
			type:"post",
			success:function(responseData){
				//성공실패 여부를 판단할 수 있는 데이터
				if(responseData.resultCode==1){
					location.href="/admin/product/list";
				}else{
					alert(responseData.msg);
				}
			}
		})
	}
</script>
</head>
<body>
	<%@ include file="../inc/top_nav.jsp" %>
  <div class="container">
	<p><h1><center>상품등록</center></h1></p>
  <form >
  	<select name="topcategory_id" onChange="chageTopcategory(this)">
  		<option value=0>상위카테고리를 선택해주세요</option>
  		<%for(TopCategory topCategory:topList){ %>
  			<option value="<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></option>
  		<%} %>
  	</select>
  	<select name="subCategory.subcategory_id">
  		<option value=0>하위카테고리를 선택해주세요</option>
  	</select>
  	<!-- 관리자 로그인한 정보가 들어와야함  -->
  	<input type="hidden" name="member_id" value="1">
    <input type="text" name="product_name" placeholder="상품명을 입력해주세요">
    <input type="text" name="price" placeholder="가격을 입력해주세요">
    <input type="text" name="brand" placeholder="브랜드명을 입력해주세요">
    <!-- 파일 -->
    <div id="dragArea"></div>
    <input type="text" name="product_addr" placeholder="주소를 입력해주세요">
    <textarea id="detail" name="detail" placeholder="상품을 설명해주세요" style="height:200px"></textarea>
    <!-- 주소 -->
    <input type="button" value="상품등록" onClick="registProduct()">
  </form>
</div>
</body>
</html>