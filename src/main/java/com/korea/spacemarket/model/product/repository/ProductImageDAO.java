package com.korea.spacemarket.model.product.repository;

import java.util.List;

import com.korea.spacemarket.model.domain.Product_Image;

public interface ProductImageDAO {
	public void insert(Product_Image product_Image);
	public void delete(int product_id);
	public List selectByProduct(int product_id);
}
