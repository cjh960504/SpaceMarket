package com.korea.spacemarket.model.domain;

import lombok.Data;

@Data
public class Favorite {
	private int favorite_id;
	private int member_id;
	private Product product;
}
