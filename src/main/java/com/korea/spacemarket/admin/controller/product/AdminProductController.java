package com.korea.spacemarket.admin.controller.product;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.exception.ProductImageRegistFailException;
import com.korea.spacemarket.exception.ProductRegistFailException;
import com.korea.spacemarket.exception.SubCategoryDMLFailException;
import com.korea.spacemarket.exception.TopCategoryDMLFailException;
import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.common.MessageData;
import com.korea.spacemarket.model.domain.Product;
import com.korea.spacemarket.model.domain.SubCategory;
import com.korea.spacemarket.model.domain.TopCategory;
import com.korea.spacemarket.model.product.service.ProductService;
import com.korea.spacemarket.model.product.service.SubCategoryService;
import com.korea.spacemarket.model.product.service.TopCategoryService;

@Controller
public class AdminProductController implements ServletContextAware {
	private static final Logger logger = LoggerFactory.getLogger(AdminProductController.class);
	@Autowired
	private TopCategoryService topCategoryService;
	@Autowired
	private SubCategoryService subCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired  
	private FileManager fileManager;
	
	private ServletContext servletContext;
	
	@Override
	public void setServletContext(ServletContext servletContext) {
//		파일매니저 객체 이용하자
		this.servletContext = servletContext;
		fileManager.setSaveProductImgDir(servletContext.getRealPath(fileManager.getSaveProductImgDir()));
		fileManager.setSaveThumbImgDir(servletContext.getRealPath(fileManager.getSaveThumbImgDir()));
		logger.debug(fileManager.getSaveProductImgDir());
		logger.debug(fileManager.getSaveThumbImgDir());
	}
	/*===============================================*/
												/* 상품관련 */
	/*===============================================*/
	@GetMapping("/product/list")
	public ModelAndView getProductList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		List productList = productService.selectAll();
		mav.addObject("productList", productList);
		return mav;
	}
	
	@GetMapping("/product/registForm")
	public ModelAndView getProductRegistForm(HttpServletRequest request) {
		List<TopCategory> topList = topCategoryService.selectAll();
		ModelAndView mav = new ModelAndView("admin/product/regist_form");
		mav.addObject("topList", topList);
		return mav;
	}
	
	@RequestMapping(value="/product/getSubCategory", method=RequestMethod.POST)
	@ResponseBody
	public List getSubCategory(int topcategory_id, HttpServletRequest request) {
		List subList = subCategoryService.selectByTop(topcategory_id);
		return subList;
	}
	
	@RequestMapping(value="/product/regist", method=RequestMethod.POST)
	@ResponseBody
	public MessageData registProduct(Product product, HttpServletRequest request) {
//		logger.debug("파일 사이즈"+product.getProductImg().length);
//		productService.regist(fileManager, product);//경로를 알고 파일명을 변경할 수 있는 filemanager와 함께
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("상품 등록을 성공했습니다.");
		return messageData;
	}
	
	@GetMapping("/product/detail")
	public ModelAndView detailProduct(int product_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/product/product_detail");
		Product product = productService.selectById(product_id);
		List<TopCategory> topList = topCategoryService.selectAll();
		mav.addObject("product", product);
		mav.addObject("topList", topList);
		return mav;
	}
	
	@PostMapping("/product/delete")
	@ResponseBody
	public MessageData delete(int product_id, HttpServletRequest request) {
		logger.debug(""+product_id);
		productService.deleteProduct(fileManager, product_id);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("상품 삭제를 성공했습니다.");
		return messageData;
	} 
	
	/*===============================================*/
												/* 카테고리관련 */
	/*===============================================*/
	@GetMapping("/category/list")
	public ModelAndView getCategoryList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/product/category_list");
		List topList = topCategoryService.selectAll();
		mav.addObject("topList", topList);
		List subList = subCategoryService.selectAll();
		mav.addObject("subList", subList);
		return mav;
	}
	
	@PostMapping("/category/registTop")
	@ResponseBody
	public MessageData registTopCategory(TopCategory topcategory, HttpServletRequest request) {
		topCategoryService.insert(topcategory);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("상위카테고리 등록을 성공했습니다.");
		return messageData;
	}
	
	@PostMapping("/category/updateTop")
	@ResponseBody
	public MessageData updateTopCategory(TopCategory topcategory, HttpServletRequest request) {
		topCategoryService.update(topcategory);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("상위카테고리 수정을 성공했습니다.");
		return messageData;
	}
	
	@PostMapping("/category/deleteTop")
	@ResponseBody
	public MessageData deleteTopCategory(int topcategory_id, HttpServletRequest request) {
		topCategoryService.delete(topcategory_id);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("상위카테고리 삭제를 성공했습니다.");
		return messageData;
	}
	@PostMapping("/category/registSub")
	@ResponseBody
	public MessageData registSubCategory(SubCategory subCategory, HttpServletRequest request) {
		System.out.println(subCategory.getTopCategory().getTopcategory_id());
		subCategoryService.insert(subCategory);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("하위카테고리 등록을 성공했습니다.");
		return messageData;
	}
	
	@PostMapping("/category/deleteSub")
	@ResponseBody
	public MessageData deleteSubCategory(int subcategory_id, HttpServletRequest request) {
		subCategoryService.delete(subcategory_id);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("하위카테고리 삭제를 성공했습니다.");
		return messageData;
	}
	/*===============================================*/
												/* Exception */
	/*===============================================*/
	
	@ExceptionHandler(TopCategoryDMLFailException.class)
	@ResponseBody
	public MessageData exceptionHanlder(TopCategoryDMLFailException e) {
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		return messageData;
	}
	
	@ExceptionHandler(SubCategoryDMLFailException.class)
	@ResponseBody
	public MessageData exceptionHanlder(SubCategoryDMLFailException e) {
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		return messageData;
	}
	
	
}
