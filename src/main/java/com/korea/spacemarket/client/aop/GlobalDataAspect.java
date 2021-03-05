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
		//if문을 반대로 하자 즉, topList가 필요한 uri들 먼저 처리
		if(uri.equals("/market/product/detail")||uri.equals("/market/member/signin")||uri.equals("/market/member/findId")||uri.equals("/market/product/updateState")) {
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
			}else {
				result = returnObj;
			}
		}
		return result;
	}
}
