package com.korea.spacemarket.model.product.repository;

import java.util.List;

import com.korea.spacemarket.model.domain.Favorite;
import com.korea.spacemarket.model.domain.ForSearch;
import com.korea.spacemarket.model.domain.Product;

public interface ProductDAO {
	public void insert(Product product);
	public List selectAll();
	public Product selectById(int product_id);
	public List<Product> selectForSearch(ForSearch forSearch);
	public void delete(int product_id);
	public void insertFavorite(Favorite favorite);
	public void updateState(int product_id);
}
