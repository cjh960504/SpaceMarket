package com.korea.spacemarket.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_id;
	private SubCategory subCategory;
	private Member member;
	private String product_name;
	private int price;
	private String brand;
	private String product_addr;
	private String detail;
	private String regdate;
	private String filename;
	private Product_State productState;
	
	private MultipartFile[] productImg;//추가 이미지는 선택사항이며, 동시에 배열
	
	private List<Product_Image>productImgArr;
}
