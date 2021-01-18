<%@page import="com.korea.spacemarket.model.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<section>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light navigation">
					<a class="navbar-brand" href="/market/main">
						<img src="/resources/images/logo.png" alt="">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav ">
							<li class="nav-item active">
								<a class="nav-link" href="/market/main">Home</a>
							</li>
							<li class="nav-item dropdown dropdown-slide">
								<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="">Dashboard<span><i class="fa fa-angle-down"></i></span>
								</a>

								<%Member member = (Member)session.getAttribute("member"); %>
								<!-- Dropdown list -->
								<%if(member!=null){ %>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="/market/member/products?member_id=<%=member.getMember_id()%>">내 등록 상품보기</a>
										<a class="dropdown-item" href="/market/member/favoriteProducts?member_id=<%=member.getMember_id()%>">내 관심상품보기</a>
									</div>
								<%} %>
							</li>
						</ul>
						<ul class="navbar-nav ml-auto mt-10">
							<li class="nav-item">
								<%if(member==null){ %>
								<a class="nav-link login-button" href="/market/member/loginForm">Login</a>
								<%}else{ %>
								<a class="nav-link login-button" href="/market/member/logout">Logout</a>
								<%} %>
							</li>
							<li class="nav-item">
								<a class="nav-link text-white add-button" href="/market/product/registToMember"><i class="fa fa-plus-circle"></i>상품 올리기</a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
</section>