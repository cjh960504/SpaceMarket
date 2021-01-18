<%@page import="com.korea.spacemarket.model.domain.ForSearch"%>
<%@page import="com.korea.spacemarket.model.common.Pager"%>
<%@page import="com.korea.spacemarket.model.domain.Product"%>
<%@page import="com.korea.spacemarket.model.domain.SubCategory"%>
<%@page import="com.korea.spacemarket.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	//AOP를 이용하여 항상 category를 가져올 수 있게
	List<TopCategory> topList = (List)request.getAttribute("topList");
	List<Product> productList = (List)request.getAttribute("productList");
	ForSearch forSearch = (ForSearch)request.getAttribute("forSearch");
	Pager pager = new Pager();
	pager.init(request, productList);
	
	TopCategory selectedTop=null;
	for(TopCategory topCategory:topList){
		if(topCategory.getTopcategory_id()==(Integer)request.getAttribute("topcategory_id")){
			selectedTop=topCategory;
		}
	}
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
	function searchProduct() {
		$("#searchForm").attr({
			action:"/market/search",
			method:"post"
		});
		$("#searchForm").submit();
	}
	function changePage(nextPage) {
		$("#searchedData input[name='currentPage']").val(nextPage);
		
		$("#searchedData").attr({
			action:"/market/search",
			method:"post"
		});
		$("#searchedData").submit();
	}
</script>
</head>

<body class="body-wrapper">

<%@ include file="../inc/top.jsp" %>
<section class="page-search">
	<!-- Advance Search -->
				<div class="advance-search">
						<div class="container">
							<div class="row justify-content-center">
								<div class="col-lg-12 col-md-12 align-content-center">
										<form id="searchForm">
											<div class="form-row">
												<div class="form-group col-md-4">
													<input type="text" class="form-control my-2 my-lg-1" id="inputtext4" name="product_name" placeholder="What are you looking for">
												</div>
												<div class="form-group col-md-3">
													<select class="w-100 form-control mt-lg-1 mt-md-2" name="subCategory.topCategory.topcategory_id">
														<option>Category</option>
														<%for(TopCategory topCategory:topList){ %>
															<option value="<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></option>
														<%} %>
													</select>
												</div>
												<div class="form-group col-md-3">
													<input type="text" class="form-control my-2 my-lg-1" id="inputLocation4" name="product_addr" placeholder="Location">
												</div>
												<div class="form-group col-md-2 align-self-center">
													<button type="button" class="btn btn-primary" onClick="searchProduct()">Search Now</button>
												</div>
											</div>
										</form>
									</div>
								</div>
					</div>
				</div>
</section>
<section class="section-sm">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="search-result bg-gray">
					<h2>검색하신 결과의 상품입니다</h2>
					<p>123 Results on 12 December, 2017</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="category-sidebar">
					<div class="widget category-list">
	<h4 class="widget-header"><%=selectedTop.getName() %></h4>
	<ul class="category-list">
		<%for(SubCategory subCategory : selectedTop.getSubcategoryList()){ %>
			<li><a href="#"><%=subCategory.getName()%></a></li>
		<%} %>
	</ul>
</div>


<div class="widget filter">
	<h4 class="widget-header">Show Produts</h4>
	<select>
		<option>Popularity</option>
		<option value="1">Top rated</option>
		<option value="2">Lowest Price</option>
		<option value="4">Highest Price</option>
	</select>
</div>

<div class="widget price-range w-100">
	<h4 class="widget-header">Price Range</h4>
	<div class="block">
						<input class="range-track w-100" type="text" data-slider-min="0" data-slider-max="5000" data-slider-step="5"
						data-slider-value="[0,5000]">
				<div class="d-flex justify-content-between mt-2">
						<span class="value">$10 - $5000</span>
				</div>
	</div>
</div>

<div class="widget product-shorting">
	<h4 class="widget-header">By Condition</h4>
	<div class="form-check">
	  <label class="form-check-label">
	    <input class="form-check-input" type="checkbox" value="">
	    Brand New
	  </label>
	</div>
	<div class="form-check">
	  <label class="form-check-label">
	    <input class="form-check-input" type="checkbox" value="">
	    Almost New
	  </label>
	</div>
	<div class="form-check">
	  <label class="form-check-label">
	    <input class="form-check-input" type="checkbox" value="">
	    Gently New
	  </label>
	</div>
	<div class="form-check">
	  <label class="form-check-label">
	    <input class="form-check-input" type="checkbox" value="">
	    Havely New
	  </label>
	</div>
</div>

				</div>
			</div>
			<div class="col-md-9">
				<div class="category-search-filter">
					<div class="row">
						<div class="col-md-6">
							<strong>Short</strong>
							<select>
								<option>Most Recent</option>
								<option value="1">Most Popular</option>
								<option value="2">Lowest Price</option>
								<option value="4">Highest Price</option>
							</select>
						</div>
						<div class="col-md-6">
							<div class="view">
								<strong>Views</strong>
								<ul class="list-inline view-switcher">
									<li class="list-inline-item">
										<a href="#" onclick="event.preventDefault();" class="text-info"><i class="fa fa-th-large"></i></a>
									</li>
									<li class="list-inline-item">
										<a href="ad-list-view.html"><i class="fa fa-reorder"></i></a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="product-grid-list">
					<div class="row mt-30">
						<%
							// ++ 혹은 -- 할 대상은 변수로 받아놓고 처리해야 편하다
							int curPos=pager.getCurPos();
							int num = pager.getNum();
						%>
						<%for(int i=0;i<pager.getPageSize();i++){ %>
						<%if(num<1)break; %>
						<%Product product = productList.get(curPos++); %>
						<%num-- ;%>
							<div class="col-sm-12 col-lg-4 col-md-6">
							<!-- product card -->
							<div class="product-item bg-light">
								<div class="card">
									<div class="thumb-content">
										<!-- <div class="price">$200</div> -->
										<a href="/market/product/detail?product_id=<%=product.getProduct_id()%>">
										<img class="card-img-top img-fluid" src="/resources/data/thumb_img/<%=product.getProduct_id()%>.<%=product.getFilename() %>" alt="Card image cap">
										</a>
									</div>
									<div class="card-body">
										<h4 class="card-title"><a href="/market/product/detail?product_id=<%=product.getProduct_id()%>"><%=product.getProduct_name() %></a></h4>
										<ul class="list-inline product-meta">
											<li class="list-inline-item">
											<a href="#"><i class="fa fa-folder-open-o"></i><%=product.getSubCategory().getName()%></a>
											</li>
											<li class="list-inline-item">
											<a href="#"><i class="fa fa-calendar"></i><%=product.getRegdate().substring(0,10) %></a>
											</li>
										</ul>
										<p class="card-text">
											<%=product.getProduct_addr() %>
										</p>
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
					<%} %>
					</div>
				</div>
				<div class="pagination justify-content-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination">
						<%if(pager.getFirstPage()-1>0){%>
							<li class="page-item">
								<a class="page-link" href="javascript:changePage(<%=pager.getFirstPage()-1%>)" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
									<span class="sr-only">Previous</span>
								</a>
							</li>
						<%} %>
							<%for(int i=pager.getFirstPage();i<=pager.getLastPage();i++){%>
							<%if(i>pager.getTotalPage()) break;%>
								<li class="page-item"><a class="page-link" href="javascript:changePage(<%=i%>)"><%=i %></a></li>
							<%} %>
							<%if(pager.getLastPage()<pager.getTotalPage()){ %>
							<li class="page-item">
								<a class="page-link" href="javascript:changePage(<%=pager.getLastPage()+1%>)" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
									<span class="sr-only">Next</span>
								</a>
							</li>
							<%} %>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</section>
<form id="searchedData">
	<input type="hidden" name="topcategory_id" value="<%=forSearch.getTopcategory_id()%>">
	<input type="hidden" name="product_name" value="<%=forSearch.getProduct_name()%>">
	<input type="hidden" name="product_addr" value="<%=forSearch.getProduct_addr()%>">
	<input type="hidden" name="currentPage" value="<%=forSearch.getCurrentPage()%>">
</form>
<%@ include file="../inc/footer.jsp" %>

</body>

</html>