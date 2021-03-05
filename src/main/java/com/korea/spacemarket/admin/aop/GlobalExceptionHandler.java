package com.korea.spacemarket.admin.aop;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.exception.LoginRequiredException;
import com.korea.spacemarket.model.common.MessageData;

@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(LoginRequiredException.class)
	public ModelAndView handleException(LoginRequiredException e) {
		ModelAndView mav = new ModelAndView();
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData", messageData);
		mav.setViewName("admin/error/message");
		
		return mav;
	}
}
