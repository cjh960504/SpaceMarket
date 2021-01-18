package com.korea.spacemarket.model.product.repository;

import java.util.List;

import com.korea.spacemarket.model.domain.SubCategory;

public interface SubCategoryDAO {
	public List selectAll();
	public SubCategory select(int subcategory_id);
	public List selectByTop(int topcategory_id);
	public void insert(SubCategory subCategory);
	public void update(SubCategory subCategory);
	public void delete(int subcategory_id);
}
