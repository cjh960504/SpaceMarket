<%@page import="com.korea.spacemarket.model.domain.Product_Image"%>
<%@page import="com.korea.spacemarket.model.domain.SubCategory"%>
<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@page import="com.korea.spacemarket.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<TopCategory> topList = (List)request.getAttribute("topList");
	Product product = (Product)request.getAttribute("product");
	int selectedTop = product.getSubCategory().getTopCategory().getTopcategory_id();
	int selectedSub = product.getSubCategory().getSubcategory_id();
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
	loadSubCategory($("select[name='topcategory_id']"));	
	uploadFiles = $(".box img");
	
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
		$(e.target).parent().remove();
	})
	
});

function loadSubCategory(obj) {
	var selected = $("#selectedSub").val();
	console.log(selected);
	$.ajax({
		url:"/admin/product/getSubCategory",
		type:"post",
		data:{
			topcategory_id:$(obj).val()
		},
		success:function(responseData){
			$("select[name='subCategory.subcategory_id']").empty();
			$("select[name='subCategory.subcategory_id']").append("<option value=\"0\">하위카테고리를 선택해주세요</option>");
			for(var i=0;i<responseData.length;i++){
				if(responseData[i].subcategory_id==selected){
					$("select[name='subCategory.subcategory_id']").append("<option value=\""+responseData[i].subcategory_id+"\" selected>"+responseData[i].name+"</option>");
				}else{
					$("select[name='subCategory.subcategory_id']").append("<option value=\""+responseData[i].subcategory_id+"\">"+responseData[i].name+"</option>");
				}
			}
		}
	})
	$("#selectedSub").val(0);
}
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

function deleteProduct() {
	$.ajax({
		url:"/admin/product/delete",
		type:"post",
		data:{
			product_id:$("input[name='product_id']").val()
		},
		success:function(responseData){
			alert(responseData.msg);
			if(responseData.resultCode==1){
				location.href="/admin/product/list";
			}
		}
	})
}

</script>
</head>
<body>
	<%@ include file="../inc/top_nav.jsp" %>
  <div class="container">
	<p><h1><center><%=product.getProduct_name() %></center></h1></p>
  <form>
	<input type="hidden" id="selectedSub" value="<%=selectedSub%>">
  	<select name="topcategory_id" onChange="loadSubCategory(this)">
  		<option value=0>상위카테고리를 선택해주세요</option>
  		<%for(TopCategory topCategory:topList){ %>
  			<option value="<%=topCategory.getTopcategory_id()%>" <%if(topCategory.getTopcategory_id()==selectedTop){%>selected<%} %>><%=topCategory.getName()%></option>
  		<%} %>
  	</select>
  	<select name="subCategory.subcategory_id">
  		<option value=0>하위카테고리를 선택해주세요</option>
  	</select>
  	<!-- 관리자 로그인한 정보가 들어와야함  -->
  	<input type="hidden" name="product_id" value="<%=product.getProduct_id()%>">
  	<input type="hidden" name="member_id" value="<%=product.getMember_id()%>">
    <input type="text" name="product_name" value="<%=product.getProduct_name()%>">
    <input type="text" name="price" value="<%=product.getPrice()%>">
    <input type="text" name="brand" value="<%=product.getBrand()%>">
    <!-- 파일 -->
    <div id="dragArea">
		<%if(product.getFilename()!=null){ %>
			<div class="box">
				<div class="close" id="0">X</div>
				<img src="/resources/data/thumb_img/<%=product.getProduct_id() %>.<%=product.getFilename() %>">
			</div>
		<%} %>
		<%for(int i=0;i<product.getProductImgArr().size();i++){ %>
    	<%Product_Image productImage = product.getProductImgArr().get(i); %>
    		<div class="box">
    			<div class="close" id="<%=i+1%>">X</div>
	    			<img src="/resources/data/product_img/<%=productImage.getProduct_image_id()%>.<%=productImage.getFilename()%>">
    			<%if(i>0) {%>
    			<%} %>
    		</div>
    	<%} %>
    </div>
    <input type="text" name="product_addr" value="<%=product.getProduct_addr()%>">
    <textarea id="detail" name="detail" value="상품을 설명해주세요" style="height:200px"><%=product.getDetail() %></textarea>
    <!-- 주소 -->
    <input type="button" value="상품수정" onClick="">
    <input type="button" value="상품삭제" onClick="deleteProduct()">
  </form>
</div>
</body>
</html>