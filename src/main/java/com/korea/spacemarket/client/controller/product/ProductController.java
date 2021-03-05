package com.korea.spacemarket.client.controller.product;

import java.net.http.HttpRequest;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.model.common.MessageData;
import com.korea.spacemarket.model.common.Pager;
import com.korea.spacemarket.model.domain.ForSearch;
import com.korea.spacemarket.model.domain.Product;
import com.korea.spacemarket.model.product.repository.ProductDAO;
import com.korea.spacemarket.model.product.service.ProductService;

@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	@Autowired
	private ProductService productService;
	
	@PostMapping("/search")
	public ModelAndView searchProduct(HttpServletRequest request, ForSearch forSearch) {
		logger.debug("topcategory_id="+forSearch.getSubcategory_id());
		logger.debug("product_name="+forSearch.getProduct_name());
		logger.debug("product_addr="+forSearch.getProduct_addr());
		logger.debug("currentPage="+forSearch.getCurrentPage());
		List<Product> productList = productService.selectForSearch(forSearch);
		ModelAndView mav = new ModelAndView("market/product/searchList");
		mav.addObject("subcategory_id", forSearch.getSubcategory_id());
		mav.addObject("productList", productList);
		mav.addObject("forSearch", forSearch);
		mav.addObject("currentPage", forSearch.getCurrentPage());
		return mav;
	}
	/*
	 * @PostMapping("/search") public ModelAndView
	 * searchSubCategory(HttpServletRequest request, ForSearch forSearch) {
	 * List<Product> productList = productService.selectForSearch(forSearch);
	 * ModelAndView mav = new ModelAndView("market/product/searchList");
	 * mav.addObject("topcategory_id", forSearch.getTopcategory_id());
	 * mav.addObject("productList", productList); mav.addObject("forSearch",
	 * forSearch); mav.addObject("currentPage", forSearch.getCurrentPage()); return
	 * mav; }
	 */
	
	@GetMapping("/product/detail")
	public ModelAndView detailProduct(HttpServletRequest request, int product_id) {
		ModelAndView mav = new ModelAndView("market/product/detail");
		logger.debug("product_id : "+product_id);
		Product product = productService.selectById(product_id);
		mav.addObject("product", product);
		return mav;
	}
	
	@GetMapping("/product/updateState")
	@ResponseBody
	public MessageData updateState(HttpServletRequest request, int product_id) {
		productService.updateState(product_id);
		MessageData messageData = new MessageData();
		messageData.setMsg("상품 상태를 변경하였습니다.");
		messageData.setResultCode(1);
		return messageData;
	}
	
}
