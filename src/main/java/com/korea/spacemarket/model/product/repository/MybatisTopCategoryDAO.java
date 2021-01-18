package com.korea.spacemarket.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.spacemarket.exception.TopCategoryDMLFailException;
import com.korea.spacemarket.model.domain.TopCategory;

@Repository
public class MybatisTopCategoryDAO implements TopCategoryDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("TopCategory.selectAll");
	}
	
	@Override
	public void insert(TopCategory topcategory) throws TopCategoryDMLFailException{
		int result = sqlSessionTemplate.insert("TopCategory.insert", topcategory);
		if(result==0) {
			throw new TopCategoryDMLFailException("상위 카테고리 등록에 실패했습니다.");
		}
	}

	@Override
	public void update(TopCategory topCategory) throws TopCategoryDMLFailException{
		int result = sqlSessionTemplate.update("TopCategory.update", topCategory);
		if(result==0) {
			throw new TopCategoryDMLFailException("상위 카테고리 수정에 실패했습니다.");
		}
	}
	@Override
	public void delete(int topcategory_id) throws TopCategoryDMLFailException{
		int result = sqlSessionTemplate.update("TopCategory.delete", topcategory_id);
		if(result==0) {
			throw new TopCategoryDMLFailException("상위 카테고리 수정에 실패했습니다.");
		}
	}
}
