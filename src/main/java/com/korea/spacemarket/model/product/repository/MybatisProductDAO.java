package com.korea.spacemarket.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.spacemarket.exception.FavoriteRegistFailException;
import com.korea.spacemarket.exception.ProductDeleteFailException;
import com.korea.spacemarket.exception.ProductRegistFailException;
import com.korea.spacemarket.exception.ProductStateUpdateFailException;
import com.korea.spacemarket.model.domain.Favorite;
import com.korea.spacemarket.model.domain.ForSearch;
import com.korea.spacemarket.model.domain.Product;

@Repository
public class MybatisProductDAO implements ProductDAO{
	@Autowired 
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insert(Product product) throws ProductRegistFailException{
		int result = sqlSessionTemplate.insert("Product.insert", product);
		if(result==0) {
			throw new ProductRegistFailException("상품 등록을 실패하였습니다.");
		}
	}
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Product.selectAll");
	}
	
	@Override
	public Product selectById(int product_id) {
		return sqlSessionTemplate.selectOne("Product.selectById", product_id);
	}
	
	@Override
	public void delete(int product_id) throws ProductDeleteFailException{
		 int result = sqlSessionTemplate.delete("Product.delete", product_id);
		 if(result==0) {
			 throw new ProductDeleteFailException("상품 삭제를 실패하였습니다.");
		 }
	}
	
	@Override
	public List<Product> selectForSearch(ForSearch forSearch) {
		return sqlSessionTemplate.selectList("Product.selectForSearch", forSearch);
	}
	
	@Override
	public List<Product> selectForAll(ForSearch forSearch) {
		return sqlSessionTemplate.selectList("Product.selectForAll", forSearch);
	}
	
	@Override
	public List<Product> search(String product_name) {
		return sqlSessionTemplate.selectList("Product.selectForName", product_name);
	}
	
	@Override
	public void insertFavorite(Favorite favorite) throws FavoriteRegistFailException {
		int result = sqlSessionTemplate.insert("Favorite.insert", favorite);
		if(result==0) {
			throw new FavoriteRegistFailException("좋아요 등록을 실패하였습니다.");
		}
	}
	
	@Override
	public void updateState(int product_id) throws ProductStateUpdateFailException {
		int result = sqlSessionTemplate.update("Product.updateState",product_id);
		if(result==0) {
			throw new ProductStateUpdateFailException("상품 상태 변경 실패하였습니다.");
		}
	}
	
	
}
