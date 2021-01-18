package com.korea.spacemarket.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.spacemarket.exception.SubCategoryDMLFailException;
import com.korea.spacemarket.model.domain.SubCategory;

@Repository
public class MybatisSubCategoryDAO implements SubCategoryDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("SubCategory.selectAll");
	}
	@Override
	public List selectByTop(int topcategory_id) {
		return sqlSessionTemplate.selectList("SubCategory.selectByTop", topcategory_id);
	}
	@Override
	public SubCategory select(int subcategory_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(SubCategory subCategory) throws SubCategoryDMLFailException{
		int result = sqlSessionTemplate.insert("SubCategory.insert", subCategory);
		if(result==0) {
			throw new SubCategoryDMLFailException("서브카테고리 입력을 실패했습니다");
		}
	}

	@Override
	public void update(SubCategory subCategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int subcategory_id) throws SubCategoryDMLFailException{
		int result = sqlSessionTemplate.delete("SubCategory.delete", subcategory_id);
		if(result==0) {
			throw new SubCategoryDMLFailException("서브카테고리 삭제를 실패했습니다. 해당 카테고리의 존재하는 상품이 존재 시 삭제 불가능합니다.");
		}
	}
	
}
