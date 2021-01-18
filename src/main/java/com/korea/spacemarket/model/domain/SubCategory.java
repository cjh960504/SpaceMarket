package com.korea.spacemarket.model.domain;

import lombok.Data;

@Data
public class SubCategory {
	private int subcategory_id;
	private TopCategory topCategory;
	private String name;
}
