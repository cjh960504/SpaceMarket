package com.korea.spacemarket.model.product.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.spacemarket.exception.FavoriteRegistFailException;
import com.korea.spacemarket.exception.ProductDeleteFailException;
import com.korea.spacemarket.exception.ProductImageDeleteFailException;
import com.korea.spacemarket.exception.ProductImageRegistFailException;
import com.korea.spacemarket.exception.ProductRegistFailException;
import com.korea.spacemarket.exception.ProductStateUpdateFailException;
import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.domain.Favorite;
import com.korea.spacemarket.model.domain.ForSearch;
import com.korea.spacemarket.model.domain.Product;
import com.korea.spacemarket.model.domain.Product_Image;
import com.korea.spacemarket.model.product.repository.ProductDAO;
import com.korea.spacemarket.model.product.repository.ProductImageDAO;

@Service
public class ProductServiceImpl implements ProductService {
	private static final Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);
	
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private ProductImageDAO productImageDAO;
	
	@Override
	public void regist(FileManager fileManager, Product product) throws ProductRegistFailException, ProductImageRegistFailException {
		//우선 파일의 이름을 변경
		if(product.getProductImg().length!=0) {
			String ext = fileManager.getExtend(product.getProductImg()[0].getOriginalFilename());
			logger.debug(ext);
			logger.debug(product.getDetail());
			logger.debug(product.getBrand());
			logger.debug("서브카테고리 "+product.getSubCategory().getSubcategory_id());
			
			product.setFilename(ext);
			productDAO.insert(product);
			logger.debug("파일경로"+fileManager.getSaveThumbImgDir());
			
			String thumb = product.getProduct_id()+"."+ext;
			fileManager.saveFile(fileManager.getSaveThumbImgDir()+File.separator+thumb
					, product.getProductImg()[0]);
		}else {
			product.setFilename("png"); //default.png
		}
		//product을 insert한 후 selectKey를 이용하여 받은 pk로 썸네일의 이미지가 될 이름을 바꾸어 물리적 저장
		//그 후 이미지 다른이미지들을 insert한 후 
//		product.getProductImg()의 첫번째 요소는 product의 filename에 넣고
		//나머지 파일들은 image의 
		for(int i=1;i<product.getProductImg().length;i++) {
			String ext = fileManager.getExtend(product.getProductImg()[i].getOriginalFilename());
			Product_Image product_Image = new Product_Image();
			product_Image.setProduct_id(product.getProduct_id());
			product_Image.setFilename(ext);
			productImageDAO.insert(product_Image);
			String productImg = product_Image.getProduct_image_id()+"."+ext;
			fileManager.saveFile(fileManager.getSaveProductImgDir()+File.separator+productImg, product.getProductImg()[i]);
		}
	}
	
	@Override
	public List selectAll() {
		return productDAO.selectAll();
	}
	@Override
	public Product selectById(int product_id) {
		return productDAO.selectById(product_id);
	}
	
	@Override
	public void deleteProduct(FileManager fileManager, int product_id){
		//이미지 삭제 후, 상품/상품이미지 테이블 레코드 삭제
		Product product=productDAO.selectById(product_id);
		List<Product_Image> imgList = product.getProductImgArr();
		
		if(product.getProductImgArr().size()!=0) {
			productImageDAO.delete(product_id); 
		}
		
		if(product.getFilename()!=null) {
			productDAO.delete(product_id);
		}
	
		
		String thumbImg = product.getProduct_id()+"."+product.getFilename();
		fileManager.deleteFile(fileManager.getSaveThumbImgDir()+File.separator+thumbImg);
		
		for(int i=0;i<imgList.size();i++) {
			String productImg =  imgList.get(i).getProduct_image_id()+"."+imgList.get(i).getFilename();
			fileManager.deleteFile(fileManager.getSaveProductImgDir()+File.separator+productImg);
		}
	}
	
	@Override
	public List<Product> selectForSearch(ForSearch forSearch) {
		if(forSearch.getProduct_addr()==null) {
			forSearch.setProduct_addr("");
		}
		if(forSearch.getSubcategory_id()==0) {
			return productDAO.selectForAll(forSearch);
		}else {
			return productDAO.selectForSearch(forSearch);
		}
	}
	
	@Override
	public List<Product> search(String product_name) {
		return productDAO.search(product_name);
	}
	
	@Override
	public void insertFavorite(Favorite favorite) throws FavoriteRegistFailException{
		productDAO.insertFavorite(favorite);
	}
	
	@Override
	public void deleteProduct(int product_id) {
		productDAO.delete(product_id);
	}
	
	@Override
	public void updateState(int product) throws ProductStateUpdateFailException {
		productDAO.updateState(product);
	}
}
