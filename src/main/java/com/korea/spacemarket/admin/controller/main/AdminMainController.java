package com.korea.spacemarket.admin.controller.main;


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
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.exception.MemberNotFoundException;
import com.korea.spacemarket.model.common.MessageData;
import com.korea.spacemarket.model.domain.Admin_Member;
import com.korea.spacemarket.model.member.service.Admin_MemberService;

@Controller
public class AdminMainController {
	@Autowired
	private Admin_MemberService admin_MemberService;
	private static final Logger logger=LoggerFactory.getLogger(AdminMainController.class);
	@GetMapping("/")
	public String getMain(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		if(session.getAttribute("admin") != null) {
			return "redirect:/admin/product/list";
		}else {
			return "admin/index";
		}
	}
	
	@PostMapping("/login")
	@ResponseBody
	public MessageData login(Admin_Member admin_Member,HttpServletRequest request) {
		logger.debug(admin_Member.getUser_id());
		Admin_Member find_admin = admin_MemberService.select(admin_Member);
		HttpSession session =  request.getSession();
		session.setAttribute("admin", find_admin);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("성공");
		return messageData;
	} 
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/admin/";
	}
	
	@ExceptionHandler(MemberNotFoundException.class)
	@ResponseBody
	public MessageData exceptionHandler(MemberNotFoundException e) {
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		return messageData;
	}
}
