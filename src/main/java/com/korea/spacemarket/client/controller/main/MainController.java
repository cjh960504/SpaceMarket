package com.korea.spacemarket.client.controller.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.model.domain.TopCategory;
import com.korea.spacemarket.model.product.service.TopCategoryService;

@Controller
public class MainController {
	@Autowired
	private TopCategoryService topcategoryService;
	
	@GetMapping("/main")
	public ModelAndView getMain(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("index");
		List<TopCategory> topList = topcategoryService.selectAll(); 
		mav.addObject("topList", topList);
		return mav;
	}
}
