package com.korea.spacemarket.model.domain;

import lombok.Data;

@Data
public class Product_Image {
	private int product_image_id;
	private int product_id;
	private String filename;
}
