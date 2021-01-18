package com.korea.spacemarket.model.product.service;

import java.util.List;

import com.korea.spacemarket.model.domain.TopCategory;

public interface TopCategoryService {
	public List selectAll();
	public void insert(TopCategory topCategory);
	public void update(TopCategory topCategory);
	public void delete(int topcategory_id);
}
