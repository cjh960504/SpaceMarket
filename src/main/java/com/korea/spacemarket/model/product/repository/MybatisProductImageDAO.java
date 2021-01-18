package com.korea.spacemarket.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.spacemarket.exception.ProductImageDeleteFailException;
import com.korea.spacemarket.exception.ProductImageRegistFailException;
import com.korea.spacemarket.model.domain.Product_Image;

@Repository
public class MybatisProductImageDAO implements ProductImageDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insert(Product_Image product_Image) throws ProductImageRegistFailException{
		int result = sqlSessionTemplate.insert("Product_Image.insert", product_Image);
		if(result==0) {
			throw new ProductImageRegistFailException("상품 등록 시 이미지 업로드에 실패하였습니다.");
		}
	}
	
	@Override
	public void delete(int product_id) throws ProductImageDeleteFailException{
		int result = sqlSessionTemplate.delete("Product_Image.delete", product_id);
		if(result==0) {
			throw new ProductImageDeleteFailException("상품이미지 삭제를 실패하였습니다.");
		}
	}
	
	@Override
	public List selectByProduct(int product_id) {
		return sqlSessionTemplate.selectList("Product_Image.selectByProduct", product_id);
	}
}
