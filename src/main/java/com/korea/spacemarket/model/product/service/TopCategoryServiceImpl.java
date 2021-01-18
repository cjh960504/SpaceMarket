package com.korea.spacemarket.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.spacemarket.exception.TopCategoryDMLFailException;
import com.korea.spacemarket.model.domain.TopCategory;
import com.korea.spacemarket.model.product.repository.TopCategoryDAO;

@Service
public class TopCategoryServiceImpl implements TopCategoryService{
	@Autowired
	private TopCategoryDAO topCategoryDAO;
	
	@Override
	public List selectAll() {
		return topCategoryDAO.selectAll();
	}
	
	@Override
	public void insert(TopCategory topCategory) throws TopCategoryDMLFailException{
		topCategoryDAO.insert(topCategory);
	}
	
	@Override
	public void update(TopCategory topCategory) throws TopCategoryDMLFailException{
		topCategoryDAO.update(topCategory);
	}
	
	@Override
	public void delete(int topcategory_id) throws TopCategoryDMLFailException{
		topCategoryDAO.delete(topcategory_id);
	}
}
