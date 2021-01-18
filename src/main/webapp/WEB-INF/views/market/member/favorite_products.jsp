<%@page import="com.korea.spacemarket.model.domain.Favorite"%>
<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Member thisMember = (Member)request.getAttribute("thisMember");
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
<script>
</script>
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp"%>

<!--==================================
=            User Profile            =
===================================-->
<section class="dashboard section">
	<!-- Container Start -->
	<div class="container">
		<!-- Row Start -->
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
				<div class="sidebar">
					<!-- User Widget -->
					<div class="widget user-dashboard-profile">
						<!-- User Image -->
						<div class="profile-thumb">
							<img src="/resources/data/basic/<%=thisMember.getMember_id()%>.<%=thisMember.getFilename() %>" alt="" class="rounded-circle">
						</div>
						<!-- User Name -->
						<h5 class="text-center"><%=thisMember.getName() %></h5>
						<p>Joined <%=thisMember.getRegdate().substring(0, 10) %></p>
						<a href="user-profile.html" class="btn btn-main-sm">Edit Profile</a>
					</div>
					<!-- Dashboard Links -->
					<div class="widget user-dashboard-menu">
						<ul>
								<li >
									<a href="/market/member/products?member_id=<%=thisMember.getMember_id()%>"><i class="fa fa-user"></i> 내 상품</a>
								 </li>
							<li class="active">
								<a href="dashboard-favourite-ads.html"><i class="fa fa-bookmark-o"></i> 좋아요한 상품 <span></span></a>
							</li>
							<%if(member.getMember_id()==thisMember.getMember_id()){ %>
								<li>
									<a href="" data-toggle="modal" data-target="#deleteaccount"><i class="fa fa-power-off"></i>Delete Account</a>
								</li>
							<%} %>
						</ul>
					</div>

					<!-- delete-account modal -->
											  <!-- delete account popup modal start-->
                <!-- Modal -->
                <div class="modal fade" id="deleteaccount" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                  aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                      <div class="modal-header border-bottom-0">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body text-center">
                        <img src="/resources/images/account/Account1.png" class="img-fluid mb-2" alt="">
                        <h6 class="py-2">Are you sure you want to delete your account?</h6>
                        <p>Do you really want to delete these records? This process cannot be undone.</p>
                        <textarea name="message" id="" cols="40" rows="4" class="w-100 rounded"></textarea>
                      </div>
                      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-lg-between justify-content-center">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger">Delete</button>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- delete account popup modal end-->
					<!-- delete-account modal -->

				</div>
			</div>
			<div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
				<!-- Recently Favorited -->
				<div class="widget dashboard-container my-adslist">
					<h3 class="widget-header">좋아요한 상품</h3>
					<table class="table table-responsive product-dashboard-table">
						<thead>
							<tr>
								<th>Image</th>
								<th>Product Title</th>
								<th class="text-center">Category</th>
								<th class="text-center">Action</th>
							</tr>
						</thead>
						<tbody>
							<%for(Favorite favorite: thisMember.getFavoriteList()) {%>
							<%Product product = favorite.getProduct(); %>
								<tr>
									<td class="product-thumb">
										<img width="80px" height="auto" src="/resources/data/thumb_img/<%=product.getProduct_id() %>.<%=product.getFilename() %>" alt="image description"></td>
									<td class="product-details">
										<h3 class="title"><%=product.getProduct_name() %></h3>
										<span><strong>Posted on: </strong><time><%=product.getRegdate().substring(0, 10) %></time> </span>
										<span class="status active"><strong>Status</strong><%=product.getProductState().getState()%></span>
										<span class="location"><strong>Location</strong><%=product.getProduct_addr() %></span>
									</td>
									<td class="product-category"><span class="categories"><%=product.getSubCategory().getName() %></span></td>
									
									<td class="action" data-title="Action">
										<div class="">
											<ul class="list-inline justify-content-center">
												<li class="list-inline-item">
													<a data-toggle="tooltip" data-placement="top" title="View" class="view" href="/market/product/detail?product_id=<%=product.getProduct_id()%>">
														<i class="fa fa-eye"></i>
													</a>
												</li>
											</ul>
										</div>
									</td>
								</tr>
							<%} %>
						</tbody>
					</table>

				</div>

			</div>
		</div>
		<!-- Row End -->
	</div>
	<!-- Container End -->
</section>
<%@ include file="../inc/footer.jsp" %>

</body>

</html>