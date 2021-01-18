package com.korea.spacemarket.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private int member_id;
	private String user_id;
	private String password;
	private String name;
	private String phone;
	private String email_id;
	private String email_server;
	private String addr;
	private String regdate;
	private String filename;
	
	private MultipartFile repImg;
	private List<Product> productList;
	private List<Favorite> favoriteList;
}
