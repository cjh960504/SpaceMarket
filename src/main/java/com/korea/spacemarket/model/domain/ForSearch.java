package com.korea.spacemarket.model.domain;

import lombok.Data;

@Data
public class ForSearch {
	private int topcategory_id;
	private int subcategory_id;
	private String product_name;
	private String product_addr;
	private int currentPage;
}
