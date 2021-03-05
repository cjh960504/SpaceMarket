package com.korea.spacemarket.rest.controller.product;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.korea.spacemarket.model.domain.Product;
import com.korea.spacemarket.model.product.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class RestProductController {
	@Autowired
	private ProductService productService;
	
	@GetMapping("/product")
	public ArrayList<Product> getProductList(){
		ArrayList<Product> productList = (ArrayList<Product>) productService.selectAll();
		log.debug("프로덕트 사이즈:" + productList.size());

		return productList;
	}
}
