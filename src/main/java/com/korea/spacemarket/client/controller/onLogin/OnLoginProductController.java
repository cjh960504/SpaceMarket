package com.korea.spacemarket.client.controller.onLogin;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.client.controller.member.ClientMemberController;
import com.korea.spacemarket.exception.FavoriteRegistFailException;
import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.common.MessageData;
import com.korea.spacemarket.model.domain.Favorite;
import com.korea.spacemarket.model.domain.Member;
import com.korea.spacemarket.model.domain.Product;
import com.korea.spacemarket.model.member.service.MemberService;
import com.korea.spacemarket.model.product.service.ProductService;
import com.korea.spacemarket.model.product.service.SubCategoryService;

@Controller
public class OnLoginProductController {
	private static final Logger logger=LoggerFactory.getLogger(OnLoginProductController.class);
	@Autowired
	private SubCategoryService subCategoryService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProductService productService;
	@Autowired
	private FileManager fileManager;
	
//	private ServletContext servletContext;
//	
//	@Override
//	public void setServletContext(ServletContext servletContext) {
////		파일매니저 객체 이용하자
//		this.servletContext = servletContext;
//		fileManager.setSaveProductImgDir(servletContext.getRealPath(fileManager.getSaveProductImgDir()));
//		fileManager.setSaveThumbImgDir(servletContext.getRealPath(fileManager.getSaveThumbImgDir()));
//		logger.debug("파일경로"+fileManager.getSaveThumbImgDir());
//		logger.debug("파일경로"+fileManager.getSaveProductImgDir());
//	}
	
	@GetMapping("/product/registToMember")
	public ModelAndView getProductRegistForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("market/product/registToMember");
		List subList = subCategoryService.selectAll();
		mav.addObject("subList", subList);
		return mav;
	}
	
	@PostMapping("/product/regist")
	@ResponseBody
	public MessageData registProduct(HttpServletRequest request, Product product) {
		HttpSession session =  request.getSession();
		Member member = (Member)session.getAttribute("member");
		logger.debug("멤버id:"+member.getMember_id());
		logger.debug("유저id:"+member.getUser_id());
		logger.debug("이름:"+member.getName());
		product.setMember(member);
		productService.regist(fileManager, product);
		
		MessageData messageData = new MessageData();
		messageData.setMsg("상품등록에 성공하였습니다.");
		messageData.setResultCode(1);
		messageData.setData(member.getMember_id());
		return messageData;
	}
	
	
	@PostMapping("/product/registFavorite")
	@ResponseBody
	public MessageData regisProduct(HttpServletRequest request, int product_id) {
		HttpSession session =  request.getSession();
		Member member = (Member)session.getAttribute("member");
		Product product = new Product();
		product.setProduct_id(product_id);
		Favorite favorite = new Favorite();
		favorite.setMember_id(member.getMember_id());
		favorite.setProduct(product);
		productService.insertFavorite(favorite);
		MessageData messageData = new MessageData();
		messageData.setMsg("좋아요한 상품에 추가하였습니다");
		messageData.setResultCode(1);
		return messageData;
	}
	@GetMapping("/member/products")
	public ModelAndView productOfMember(HttpServletRequest request, int member_id) {
		ModelAndView mav = new ModelAndView("market/member/member_products");
		Member member = (Member) memberService.selectWithProduct(member_id);
		mav.addObject("thisMember", member);
		return mav;
	}
	
	@GetMapping("/member/favoriteProducts")
	public ModelAndView favoriteOfMember(HttpServletRequest request, int member_id) {
		ModelAndView mav = new ModelAndView("market/member/favorite_products");
		Member member = (Member) memberService.selectWithProduct(member_id);
		mav.addObject("thisMember", member);
		return mav;
	}
	
	@ExceptionHandler(FavoriteRegistFailException.class)
	@ResponseBody
	public MessageData exceptionHandle(FavoriteRegistFailException e) {
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		return messageData;
	}

}
