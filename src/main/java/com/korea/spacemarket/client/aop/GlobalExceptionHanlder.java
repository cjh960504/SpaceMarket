package com.korea.spacemarket.client.aop;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.exception.LoginRequiredException;
import com.korea.spacemarket.exception.ProductDeleteFailException;
import com.korea.spacemarket.exception.ProductImageDeleteFailException;
import com.korea.spacemarket.model.common.MessageData;

//글로벌한 exception을 잡기 위한 @ControllerAdvice에서 잡아야하는
//예외는 공통적인 로직에서 발생하는 예외만을 취급해야한다!!!
@ControllerAdvice
public class GlobalExceptionHanlder {
//	@ExceptionHandler(ProductDeleteFailException.class)
//	@ResponseBody
//	public MessageData exceptionHandle(ProductDeleteFailException e) {
//		MessageData messageData = new MessageData();
//		messageData.setResultCode(0);
//		messageData.setMsg("상품 삭제를 실패했습니다.");
//		return messageData;
//	}
//	@ExceptionHandler(ProductImageDeleteFailException.class)
//	@ResponseBody
//	public MessageData exceptionHandle(ProductImageDeleteFailException e) {
//		MessageData messageData = new MessageData();
//		messageData.setResultCode(0);
//		messageData.setMsg("상품 이미지 삭제를 실패했습니다.");
//		return messageData;
//	}
	@ExceptionHandler(LoginRequiredException.class)
	public ModelAndView handleException(LoginRequiredException e) {
		ModelAndView mav = new ModelAndView();
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData", messageData);
		mav.setViewName("market/error/message");
		
		return mav;
	}
	
}
