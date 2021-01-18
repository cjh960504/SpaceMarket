<%@page import="com.korea.spacemarket.model.domain.SubCategory"%>
<%@page import="com.korea.spacemarket.exception.SubCategoryDMLFailException"%>
<%@page import="com.korea.spacemarket.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<TopCategory> topList = (List)request.getAttribute("topList");
	List<SubCategory> subList = (List)request.getAttribute("subList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 | 카테고리 관리</title>
<%@ include file="../inc/header.jsp" %>
<style>
.row-update {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100px;
}
.row-delete {
  background-color: #f44336;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100px;
}
.row-regist{
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 130px;
}

/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
  background-color: #555;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 28px;
  width: 280px;
}

/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  bottom: 0;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
}

/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
  background-color: #4CAF50;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  width: 100%;
  margin-bottom:10px;
  opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}
</style>
<script>
function openForm() {
	  document.getElementById("myForm").style.display = "block";
	} 

function closeForm() {
  document.getElementById("myForm").style.display = "none";
}
function registTopcategory(){
	var formData = $("#registTop").serialize();
	var rank = $("myForm ")
	$.ajax({
		url:"/admin/category/registTop",
		type:"post",
		data:formData,
		success:function(responseData){
			//성공 시 상위카테고리 테이블에 행추가
			alert(responseData.msg);
			if(responseData.resultCode==1){
				location.reload();
			}
		}
	})
}
function updateTopcategory(topcategory_id){
	var rank = $("#"+topcategory_id+" .rank").val();
	var name = $("#"+topcategory_id+" .name").val();
	console.log(rank);
	console.log(name);
	 $.ajax({
		url:"/admin/category/updateTop",
		type:"post",
		data:{
			topcategory_id:topcategory_id,
			rank:rank,
			name:name
		},
		success:function(responseData){
			//성공 시 상위카테고리 테이블에 행추가
			alert(responseData.msg);
			if(responseData.resultCode==1){
				location.reload();
			}
		}
	}) 
}
function deleteTopcategory(topcategory_id){
	 $.ajax({
			url:"/admin/category/deleteTop",
			type:"post",
			data:{
				topcategory_id:topcategory_id
			},
			success:function(responseData){
				//성공 시 상위카테고리 테이블에 행추가
				alert(responseData.msg);
				if(responseData.resultCode==1){
					$("#"+topcategory_id).remove();
				}
			}
		}) 
}
function registSubCategory() {
	var selectedTop = $("#registRow select").val();
	var subName = $("#registRow input[type='text']").val();
	$.ajax({
		url:"/admin/category/registSub",
		type:"post",
		data:{
			"topCategory.topcategory_id":selectedTop,
			name:subName
		},
		success:function(responseData){
			//성공 시 상위카테고리 테이블에 행추가
			alert(responseData.msg);
			if(responseData.resultCode==1){
				location.reload();
			}
		}
	})
}
function deleteSub(subcategory_id) {
	$.ajax({
		url:"/admin/category/deleteSub",
		type:"post",
		data:{
			"subcategory_id":subcategory_id,
		},
		success:function(responseData){
			//성공 시 상위카테고리 테이블에 행추가
			alert(responseData.msg);
			if(responseData.resultCode==1){
				$("#sub"+subcategory_id).remove();
			}
		}
	})
}
</script>
</head>
<body>
<%@ include file="../inc/top_nav.jsp" %>
	<h1>카테고리 관리</h1>
	
	<h3>상위목록</h3>
	<div class="row">
  <div class="column">
    <table id="topTable">
    <tr>
        <th>순서</th>
        <th>카테고리명</th>
        <th></th>
      </tr>
    <%for(TopCategory topcategory : topList){ %>
      <tr id="<%=topcategory.getTopcategory_id()%>">
        <td><input class="rank" type="text" value="<%=topcategory.getRank() %>"></td>
        <td><input class="name" type="text" value="<%=topcategory.getName() %>"></td>
        <!-- 수정을 누르면 랭크와 카테고리명을 수정 -->
        <td>
        	<button class="row-update" type="button" onClick="updateTopcategory(<%=topcategory.getTopcategory_id()%>)">수정</button>
        	<button class="row-delete" type="button" onClick="deleteTopcategory(<%=topcategory.getTopcategory_id()%>)">삭제</button>
        <td>
        
      </tr>
    <%} %>
      <tr>
      	<td colspan="3" style="text-align: left">
	      <div class="form-popup" id="myForm">
			  <form id="registTop" class="form-container">
			    <h1>Login</h1>
			
			    <label for="rank"><b>순서</b></label>
			    <input type="text" placeholder="Enter Rank" name="rank" required>
			
			    <label for="name"><b>카테고리명</b></label>
			    <input type="text" placeholder="Enter TopCategoryName" name="name" required>
			
			    <button type="button" class="btn" onClick="registTopcategory()">regist</button>
			    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
			  </form>
			</div>
      		<button type="button" class="row-regist" onClick="openForm()">상위카테고리 추가</button>	
      	</td>
      </tr>
    </table>
  </div>
  <h3>하위목록</h3>
  <div class="column">
    <table>
      <tr>
        <th>상위카테고리</th>
        <th>하위카테고리</th>
        <th></th>
      </tr>
      <%for(SubCategory subCategory:subList){ %>
	      <tr id="sub<%=subCategory.getSubcategory_id() %>">
	        <td><%=subCategory.getTopCategory().getName() %></td>
	        <td><%=subCategory.getName() %></td>
	        <td><button type="button" onClick="deleteSub(<%=subCategory.getSubcategory_id()%>)">삭제</button></td>
	      </tr>
      <%} %>
      <tr>
      	<td colspan="2" id="registRow">
      		<select name="topCategory.topcategory_id">
      		<%for(TopCategory topCategory : topList){ %>
      			<option value="<%=topCategory.getTopcategory_id()%>" ><%=topCategory.getName()%></option>
      		<%} %>
      		</select>
      		<input type="text" name="name" value=""> 
      		<button type="button" class="row-regist" onClick="registSubCategory()">하위카테고리 추가</button>	
      	</td>
      </tr>
    </table>
  </div>
</div>
</body>
</html>