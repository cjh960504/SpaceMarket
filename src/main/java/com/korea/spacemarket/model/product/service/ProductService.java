package com.korea.spacemarket.model.product.service;

import java.util.List;

import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.domain.Favorite;
import com.korea.spacemarket.model.domain.ForSearch;
import com.korea.spacemarket.model.domain.Product;

public interface ProductService {
	public void regist(FileManager fileManager, Product product);
	public List selectAll();
	public Product selectById(int product_id);
	public void deleteProduct(FileManager fileManager, int product_id);
	public List<Product> selectForSearch(ForSearch forSearch);
	public void insertFavorite(Favorite favorite);
	public void deleteProduct(int product_id);
	public void updateState(int product);
	public List<Product> search(String product_name);
}
