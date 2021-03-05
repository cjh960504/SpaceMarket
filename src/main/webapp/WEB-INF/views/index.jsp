<%@page import="com.korea.spacemarket.model.domain.SubCategory"%>
<%@page import="com.korea.spacemarket.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	//AOP를 이용하여 항상 category를 가져올 수 있게
	List<TopCategory> topList = (List)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html lang="en">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Classimax</title>
<%@ include file="./market/inc/header.jsp" %>
<script>
	function searchProduct() {
		$("#searchForm").attr({
			action:"/market/search",
			method:"post"
		});
		$("#searchForm").submit();
	}
</script>
</head>

<body class="body-wrapper">

<%@ include file="./market/inc/top.jsp" %>

<!--===============================
=            Hero Area            =
================================-->

<section class="hero-area bg-1 text-center overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					<h1>Buy & Sell Near You </h1>
					<p>Join the millions who buy and sell from each other <br> everyday in local communities around the world</p>
					<div class="short-popular-category-list text-center">
						<h2>Popular Category</h2>
						<ul class="list-inline">
							<li class="list-inline-item">
								<a href="category.html"><i class="fa fa-bed"></i> Hotel</a></li>
							<li class="list-inline-item">
								<a href="category.html"><i class="fa fa-grav"></i> Fitness</a>
							</li>
							<li class="list-inline-item">
								<a href="category.html"><i class="fa fa-car"></i> Cars</a>
							</li>
							<li class="list-inline-item">
								<a href="category.html"><i class="fa fa-cutlery"></i> Restaurants</a>
							</li>
							<li class="list-inline-item">
								<a href="category.html"><i class="fa fa-coffee"></i> Cafe</a>
							</li>
						</ul>
					</div>
					
				</div>
				<!-- Advance Search -->
				<div class="advance-search">
						<div class="container">
							<div class="row justify-content-center">
								<div class="col-lg-12 col-md-12 align-content-center">
										<form id="searchForm">
											<input type="hidden" name="currentPage" value="1">
											<div class="form-row">
											<%if(session.getAttribute("member")!=null){ %>
											<%Member loginMember = (Member)session.getAttribute("member"); %>
											<%String[] array = loginMember.getAddr().split(" "); %>
												<div class="form-group col-md-4">
													<input type="text" class="form-control my-2 my-lg-1" id="inputtext4" name="product_addr" value="<%=array[array.length-2]%>">
												</div>
											<%} %>
												<div class="form-group col-md-4">
													<input type="text" class="form-control my-2 my-lg-1" id="inputtext4" name="product_name" placeholder="What are you looking for">
												</div>
												<div class="form-group col-md-3">
													<select class="w-100 form-control mt-lg-1 mt-md-2" name="subcategory_id">
														<option value=0>All</option>
														<%for(TopCategory topCategory:topList){ %>
																<option disabled="disabled"><%=topCategory.getName() %></option>
															<%for(SubCategory subcategory : topCategory.getSubcategoryList()) {%>
																<option value="<%=subcategory.getSubcategory_id()%>"><%=subcategory.getName()%></option>
															<%} %>
														<%} %>
													</select>
												</div>
												<!-- <div class="form-group col-md-3">
													<input type="text" class="form-control my-2 my-lg-1" id="inputLocation4" name="product_addr" placeholder="Location">
												</div> -->
												<div class="form-group col-md-2 align-self-center">
													<button type="button" class="btn btn-primary" onClick="searchProduct()">Search Now</button>
												</div>
											</div>
										</form>
									</div>
								</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>

<!--===================================
=            Client Slider            =
====================================-->


<!--===========================================
=            Popular deals section            =
============================================-->
<!-- 
<section class="popular-deals section bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="section-title">
					<h2>Trending Adds</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, magnam.</p>
				</div>
			</div>
		</div>
		<div class="row">
			offer 01
			<div class="col-lg-12">
				<div class="trending-ads-slide">
					<div class="col-sm-12 col-lg-4">
						product card
<div class="product-item bg-light">
	<div class="card">
		<div class="thumb-content">
			<div class="price">$200</div>
			<a href="single.html">
				<img class="card-img-top img-fluid" src="/resources/images/products/products-1.jpg" alt="Card image cap">
			</a>
		</div>
		<div class="card-body">
		    <h4 class="card-title"><a href="single.html">11inch Macbook Air</a></h4>
		    <ul class="list-inline product-meta">
		    	<li class="list-inline-item">
		    		<a href="single.html"><i class="fa fa-folder-open-o"></i>Electronics</a>
		    	</li>
		    	<li class="list-inline-item">
		    		<a href="#"><i class="fa fa-calendar"></i>26th December</a>
		    	</li>
		    </ul>
		    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, aliquam!</p>
		    <div class="product-ratings">
		    	<ul class="list-inline">
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item"><i class="fa fa-star"></i></li>
		    	</ul>
		    </div>
		</div>
	</div>
</div>



					</div>
					<div class="col-sm-12 col-lg-4">
						product card
<div class="product-item bg-light">
	<div class="card">
		<div class="thumb-content">
			<div class="price">$200</div>
			<a href="single.html">
				<img class="card-img-top img-fluid" src="/resources/images/products/products-2.jpg" alt="Card image cap">
			</a>
		</div>
		<div class="card-body">
		    <h4 class="card-title"><a href="single.html">Full Study Table Combo</a></h4>
		    <ul class="list-inline product-meta">
		    	<li class="list-inline-item">
		    		<a href="single.html"><i class="fa fa-folder-open-o"></i>Furnitures</a>
		    	</li>
		    	<li class="list-inline-item">
		    		<a href="#"><i class="fa fa-calendar"></i>26th December</a>
		    	</li>
		    </ul>
		    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, aliquam!</p>
		    <div class="product-ratings">
		    	<ul class="list-inline">
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item"><i class="fa fa-star"></i></li>
		    	</ul>
		    </div>
		</div>
	</div>
</div>



					</div>
					<div class="col-sm-12 col-lg-4">
						product card
<div class="product-item bg-light">
	<div class="card">
		<div class="thumb-content">
			<div class="price">$200</div>
			<a href="single.html">
				<img class="card-img-top img-fluid" src="/resources/images/products/products-3.jpg" alt="Card image cap">
			</a>
		</div>
		<div class="card-body">
		    <h4 class="card-title"><a href="single.html">11inch Macbook Air</a></h4>
		    <ul class="list-inline product-meta">
		    	<li class="list-inline-item">
		    		<a href="single.html"><i class="fa fa-folder-open-o"></i>Electronics</a>
		    	</li>
		    	<li class="list-inline-item">
		    		<a href="#"><i class="fa fa-calendar"></i>26th December</a>
		    	</li>
		    </ul>
		    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, aliquam!</p>
		    <div class="product-ratings">
		    	<ul class="list-inline">
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item"><i class="fa fa-star"></i></li>
		    	</ul>
		    </div>
		</div>
	</div>
</div>



					</div>
					<div class="col-sm-12 col-lg-4">
						product card
<div class="product-item bg-light">
	<div class="card">
		<div class="thumb-content">
			<div class="price">$200</div>
			<a href="single.html">
				<img class="card-img-top img-fluid" src="/resources/images/products/products-2.jpg" alt="Card image cap">
			</a>
		</div>
		<div class="card-body">
		    <h4 class="card-title"><a href="single.html">Full Study Table Combo</a></h4>
		    <ul class="list-inline product-meta">
		    	<li class="list-inline-item">
		    		<a href="single.html"><i class="fa fa-folder-open-o"></i>Furnitures</a>
		    	</li>
		    	<li class="list-inline-item">
		    		<a href="#"><i class="fa fa-calendar"></i>26th December</a>
		    	</li>
		    </ul>
		    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, aliquam!</p>
		    <div class="product-ratings">
		    	<ul class="list-inline">
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item"><i class="fa fa-star"></i></li>
		    	</ul>
		    </div>
		</div>
	</div>
</div>



					</div>
				</div>
			</div>
			
			
		</div>
	</div>
</section>

 -->

<!--==========================================
=            All Category Section            =
===========================================-->

<section class=" section">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Section title -->
				<div class="section-title">
					<h2>All Categories</h2>
				</div>
				<div class="row">
					<!-- Category list -->
					<%for(TopCategory topCategory:topList){ %>
						<div class="col-lg-3 offset-lg-0 col-md-5 offset-md-1 col-sm-6 col-6">
							<div class="category-block">
								<div class="header">
									<h4><%=topCategory.getName()%></h4>
								</div>
								<ul class="category-list" >
								<%for(SubCategory subCategory:topCategory.getSubcategoryList()){ %>
									<li><a href="/market/search?topcategory_id=<%=topCategory.getTopcategory_id()%>"><%=subCategory.getName() %></a></li>
								<%} %>
								</ul>
							</div>
						</div>
					<%} %>
					 <!-- /Category List -->
				</div>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>


<%@ include file="./market/inc/footer.jsp" %>
</body>

</html>



