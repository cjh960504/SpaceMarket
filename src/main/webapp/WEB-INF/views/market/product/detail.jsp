<%@page import="com.korea.spacemarket.model.common.Formatter"%>
<%@page import="com.fasterxml.jackson.core.format.DataFormatMatcher"%>
<%@page import="com.korea.spacemarket.model.domain.Product_Image"%>
<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Product product = (Product)request.getAttribute("product");
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
  	.before{
  	    color: #59d659;
  }
  .after{
  	    color: #d91c1c;
  }
  	   
  </style>
  
  <script>
  	$(function(){
  		addrToLocation();
  		 initialize();
	});
  	
  	function addrToLocation() {
  		var address = encodeURIComponent();
  		console.log(address);
  		$.ajax({
			url:"https://maps.googleapis.com/maps/api/geocode/json",
			type:"get",
			data:{
				"address":"<%=product.getProduct_addr()%>",
				"key":""
			},
			success:function(responseData){
				console.log(responseData.results[0].geometry.location);
				/* $("#map_canvas")[0].dataset.latitude=responseData.results[0].geometry.location.lat;
				$("#map_canvas")[0].dataset.longitude=responseData.results[0].geometry.location.lng; */
				$("#map_canvas").attr({
					"data-latitude":responseData.results[0].geometry.location.lat,
					"data-longitude":responseData.results[0].geometry.location.lng
				});
				
				console.log($("#map_canvas"));
			}
		}) 
	}
  	
  	function registFavorite() {
  		$.ajax({
  			url:"/market/product/registFavorite",
  			type:"post",
  			data:{
  				product_id:<%=product.getProduct_id()%>
  			},
  			success:function(responseData){
  				alert(responseData.msg);
  				console.log(responseData);
  			}
  		})
	}
  </script>
  
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp" %>
<section class="page-search">
	<div class="container">
	
		<div class="row">
			<div class="col-md-12">
				<!-- Advance Search -->
				<div class="advance-search">
					<form>
						<div class="form-row">
							<div class="form-group col-md-4">
								<input type="text" class="form-control my-2 my-lg-0" id="inputtext4" placeholder="What are you looking for">
							</div>
							<div class="form-group col-md-3">
								<input type="text" class="form-control my-2 my-lg-0" id="inputCategory4" placeholder="Category">
							</div>
							<div class="form-group col-md-3">
								<input type="text" class="form-control my-2 my-lg-0" id="inputLocation4" placeholder="Location">
							</div>
							<div class="form-group col-md-2">

								<button type="submit" class="btn btn-primary">Search Now</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<!--===================================
=            Store Section            =
====================================-->
<section class="section bg-gray">

	<!-- Container Start -->
	<div class="container">
	<a href="javascript:history.back();" class="btn btn-contact d-inline-block  btn-primary px-lg-5 my-1 px-md-3">목록으로</a>
		<div class="row">
			<!-- Left sidebar -->
			<div class="col-md-8">
				<div class="product-details">
					<h1 class="product-title"><%=product.getProduct_name() %></h1>
					<div class="product-meta">
						<ul class="list-inline">
						<%int state = product.getProductState().getProduct_state_id(); %>
							<li class="list-inline-item"><i class="fa fa-user-o"></i> By <a href=""><%=product.getMember().getName() %></a></li>
							<li class="list-inline-item"><i class="fa fa-folder-open-o"></i> Category<a href=""><%=product.getSubCategory().getName() %></a></li>
							<li class="list-inline-item"><i class="fa fa-location-arrow"></i> Location<a href=""><%=product.getProduct_addr() %></a></li>
							<li class="list-inline-item"></i><%if(state==1) {%><i class="fa fa-check-circle"></i><%}else{ %><i class="fa fa-minus-circle"></i><%} %> State<a href=""><strong <%if(state==1){ %>class="before"<%}else{ %>class="after"<%} %>><%=product.getProductState().getState() %></strong></a></li>
						</ul>
					</div>

					<!-- product slider -->
					<div class="product-slider">
						<%if(product.getFilename()!=null){ %>
							<div class="product-slider-item my-4" data-image="/resources/data/thumb_img/<%=product.getProduct_id()%>.<%=product.getFilename()%>">
								<img class="img-fluid w-100" src="/resources/data/thumb_img/<%=product.getProduct_id()%>.<%=product.getFilename()%>" alt="thumb_img">
							</div>
						<%} %>
						<%if(product.getProductImgArr().size()!=0){ %>
							<%for(Product_Image image : product.getProductImgArr()) {%>
								<div class="product-slider-item my-4" data-image="/resources/data/product_img/<%=image.getProduct_image_id()%>.<%=image.getFilename()%>">
									<img class="d-block img-fluid w-100" src="/resources/data/product_img/<%=image.getProduct_image_id()%>.<%=image.getFilename()%>" alt="product_img">
								</div>
							<%} %>
						<%} %>
					</div>
					<!-- product slider -->

					<div class="content mt-5 pt-5">
						<ul class="nav nav-pills  justify-content-center" id="pills-tab" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home"
								 aria-selected="true">Product Details</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile"
								 aria-selected="false">Specifications</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact"
								 aria-selected="false">Reviews</a>
							</li>
						</ul>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
								<h3 class="tab-title">Product Description</h3>
								<p><%=product.getDetail() %></p>
							</div>
							<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
								<h3 class="tab-title">Product Specifications</h3>
								<table class="table table-bordered product-table">
									<tbody>
										<tr>
											<td>Seller Price</td>
											<td><%=Formatter.getCurrency(product.getPrice())%></td>
										</tr>
										<tr>
											<td>Added</td>
											<td><%=product.getRegdate().substring(0, 10) %></td>
										</tr>
										<tr>
											<td>State</td>
											<td><%=product.getProductState().getState() %></td>
										</tr>
										<tr>
											<td>Brand</td>
											<td><%=product.getBrand() %></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
								<h3 class="tab-title">Product Review</h3>
								<div class="product-review">
									<div class="media">
										<!-- Avater -->
										<img src="images/user/user-thumb.jpg" alt="avater">
										<div class="media-body">
											<!-- Ratings -->
											<div class="ratings">
												<ul class="list-inline">
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
												</ul>
											</div>
											<div class="name">
												<h5><%=product.getMember().getName()%></h5>
											</div>
											<div class="date">
												<p>Joined <%=product.getMember().getRegdate()%></p>
											</div>
											<div class="review-comment">
												<p>
													Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremqe laudant tota rem ape
													riamipsa eaque.
												</p>
											</div>
										</div>
									</div>
									<div class="review-submission">
										<h3 class="tab-title">Submit your review</h3>
										<!-- Rate -->
										<div class="rate">
											<div class="starrr"></div>
										</div>
										<div class="review-submit">
											<form action="#" class="row">
												<div class="col-lg-6">
													<input type="text" name="name" id="name" class="form-control" placeholder="Name">
												</div>
												<div class="col-lg-6">
													<input type="email" name="email" id="email" class="form-control" placeholder="Email">
												</div>
												<div class="col-12">
													<textarea name="review" id="review" rows="10" class="form-control" placeholder="Message"></textarea>
												</div>
												<div class="col-12">
													<button type="submit" class="btn btn-main">Sumbit</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="sidebar">
					<div class="widget price text-center">
						<h4>Price</h4>
						<p><%=Formatter.getCurrency(product.getPrice()) %></p>
					</div>
					<!-- User Profile widget -->
					<div class="widget user text-center">
						<img class="rounded-circle img-fluid mb-5 px-5" src="/resources/data/basic/<%=product.getMember().getMember_id() %>.<%=product.getMember().getFilename()%>" alt="">
						<h4><a href=""><%=product.getMember().getName() %></a></h4>
						<p class="member-time">Joined <%=product.getMember().getRegdate().substring(0, 10) %></p>
						<ul class="list-inline mt-20">
							<li class="list-inline-item"><a href="javascript:registFavorite()" class="btn btn-contact d-inline-block  btn-primary px-lg-5 my-1 px-md-3">좋아요</a></li>
							<li class="list-inline-item"><a href="/market/member/products?member_id=<%=product.getMember().getMember_id()%>" class="btn btn-contact d-inline-block  btn-primary px-lg-5 my-1 px-md-3">다른 상품보기</a></li>
						</ul>
					</div>
					<!-- Map Widget -->
					<div class="widget map">
						<div class="map">
							<div id="map_canvas" data-latitude="" data-longitude=""></div>
						</div>
					</div>
					<!-- Rate Widget -->
					<div class="widget rate">
						<!-- Heading -->
						<h5 class="widget-header text-center">What would you rate
							<br>
							this product</h5>
						<!-- Rate -->
						<div class="starrr"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>
<%@ include file="../inc/footer.jsp" %>
</body>

</html>