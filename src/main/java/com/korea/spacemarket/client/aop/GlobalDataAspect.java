package com.korea.spacemarket.client.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.model.product.service.TopCategoryService;

public class GlobalDataAspect {
	private static final Logger logger = LoggerFactory.getLogger(GlobalDataAspect.class);
	@Autowired
	private TopCategoryService topCategoryService;
	
	public Object getGlobalData(ProceedingJoinPoint joinPoint) throws Throwable {
		Object result = null;
		HttpServletRequest request = null;
		
		for(Object arg:joinPoint.getArgs()) {
			if(arg instanceof HttpServletRequest) {
				request = (HttpServletRequest)arg;
			}
		}
		
		String uri = request.getRequestURI();
		logger.debug("들어온 URI : "+ uri);
		if(uri.equals("/market/product/detail")||uri.equals("/market/member/signin")) {
			logger.debug("들어온 URI 2: "+ uri);
			result = joinPoint.proceed();
		}else {
			List topList = topCategoryService.selectAll();
			ModelAndView mav = null;
			Object returnObj = joinPoint.proceed();
			if(returnObj instanceof ModelAndView) {
				mav = (ModelAndView)returnObj;
				mav.addObject("topList", topList);
				result=mav;
			}
		}
		return result;
	}
}
