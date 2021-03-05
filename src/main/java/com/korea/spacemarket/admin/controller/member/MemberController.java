package com.korea.spacemarket.admin.controller.member;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.exception.MemberDMLException;
import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.common.MessageData;
import com.korea.spacemarket.model.domain.Member;
import com.korea.spacemarket.model.member.service.MemberService;

@Controller
public class MemberController implements ServletContextAware{
	private static final Logger logger=LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FileManager fileManager;
	private ServletContext servletContext;
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		fileManager.setSaveBasicDir(servletContext.getRealPath(fileManager.getSaveBasicDir()));
		//fileManager.setSaveAddonDir(servletContext.getRealPath(fileManager.getSaveAddonDir()));
		logger.debug(fileManager.getSaveBasicDir());
	}
	
	//회원목록
	@GetMapping("/member/list")
	public ModelAndView getMemberList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/member/member_list");
		List memberList = memberService.selectAll();
		mav.addObject("memberList", memberList);
		return mav;
	}
	
	//회원등록폼요청
	@GetMapping("/member/registform")
	public String registForm(HttpServletRequest request) {
		return "admin/member/regist_form";
	}
	
	//회원등록
	@PostMapping(value="/member/regist", produces="text/html;charset=utf8")
	@ResponseBody
	public String registMember(Member member, HttpServletRequest request) {
		memberService.regist(fileManager, member);
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"result\":1,");
		sb.append("\"msg\":\"회원등록성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	//상세보기
	@GetMapping("/member/detail")
	public ModelAndView memberDetail(int member_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/member/member_detail");
		Member member = memberService.select(member_id);
		mav.addObject("member", member);
		return mav;
	}
	
	//회원수정
	@PostMapping("/member/edit")
	@ResponseBody
	public MessageData update(Member member, HttpServletRequest request) {
		//memberService.update(fileManager, member);
		//MemberMapper에서 새로운 sql 쿼리 필요
		memberService.update(member);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("수정을 성공했습니다.");
		return messageData;
	}
	
	//회원삭제
	@PostMapping("/member/delete")
	public String delete(int member_id, HttpServletRequest request) {
		memberService.delete(member_id);
		return "redirect:/admin/member/list";
	}
	
	//예외처리
	@ExceptionHandler(MemberDMLException.class)
	@ResponseBody
	public String handleException(MemberDMLException e) {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"result\":0");
		sb.append("\"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		return sb.toString();
	}
}
