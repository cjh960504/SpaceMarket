package com.korea.spacemarket.model.product.repository;

import java.util.List;

import com.korea.spacemarket.model.domain.TopCategory;

public interface TopCategoryDAO {
	public List selectAll();
	public void insert(TopCategory topcategory);
	public void update(TopCategory topCategory);
	public void delete(int topcategory_id);
}
