package com.korea.spacemarket.model.product.service;

import java.util.List;

import com.korea.spacemarket.model.domain.SubCategory;

public interface SubCategoryService {
	public List selectAll();
	public SubCategory select(int subcategory_id);
	public List selectByTop(int topcategory_id);
	public void insert(SubCategory subCategory);
	public void update(SubCategory subCategory);
	public void delete(int subcategory_id);
}
