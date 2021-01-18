package com.korea.spacemarket.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.spacemarket.exception.SubCategoryDMLFailException;
import com.korea.spacemarket.model.domain.SubCategory;
import com.korea.spacemarket.model.product.repository.SubCategoryDAO;

@Service
public class SubCategoryServiceImpl implements SubCategoryService{
	@Autowired
	private SubCategoryDAO subCategoryDAO;
	
	@Override
	public List selectAll() {
		return subCategoryDAO.selectAll();
	}
	@Override
	public List selectByTop(int topcategory_id) {
		return subCategoryDAO.selectByTop(topcategory_id);
	}
	@Override
	public SubCategory select(int subcategory_id) {
		return null;
	}

	@Override
	public void insert(SubCategory subCategory) throws SubCategoryDMLFailException{
		subCategoryDAO.insert(subCategory);
	}

	@Override
	public void update(SubCategory subCategory) {
		
	}

	@Override
	public void delete(int subcategory_id) throws SubCategoryDMLFailException {
		subCategoryDAO.delete(subcategory_id);
	}
	
}
