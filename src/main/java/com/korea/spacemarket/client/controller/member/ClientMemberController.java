package com.korea.spacemarket.client.controller.member;

import javax.mail.Session;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.korea.spacemarket.exception.MemberDMLException;
import com.korea.spacemarket.exception.MemberIdPasswordNotFound;
import com.korea.spacemarket.exception.MemberNotFoundException;
import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.common.MessageData;
import com.korea.spacemarket.model.domain.Member;
import com.korea.spacemarket.model.member.service.MemberService;

@Controller
public class ClientMemberController  implements ServletContextAware{
	private static final Logger logger=LoggerFactory.getLogger(ClientMemberController.class);
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FileManager fileManager;
	private ServletContext servletContext;
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		//fileManager.setSaveBasicDir(servletContext.getRealPath(fileManager.getSaveBasicDir()));
		//fileManager.setSaveAddonDir(servletContext.getRealPath(fileManager.getSaveAddonDir()));
		fileManager.setSaveBasicDir(fileManager.getSaveBasicDir());
		logger.debug(fileManager.getSaveBasicDir());
	}
	
	@GetMapping("/member/loginForm")
	public ModelAndView getLoginForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("market/member/login");
		return mav;
	}
	
	@PostMapping("/member/signin")
	public ModelAndView login(Member member, HttpServletRequest request) {
		Member obj = memberService.login(member);
		logger.debug("member_id : "+ obj.getMember_id());
		HttpSession session = request.getSession();
		session.setAttribute("member", obj);
		ModelAndView mav = new ModelAndView("redirect:/market/main");
		return mav;
	}
	
	@GetMapping("/member/logout")
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().invalidate();
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("로그아웃 되었습니다");
		messageData.setUrl("/market/main");
		ModelAndView mav = new ModelAndView("redirect:/market/main");
		return mav;
	}
	
	@GetMapping("/member/registForm")
	public ModelAndView getRegistForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("market/member/register");
		return mav;
	}
	
	@PostMapping(value="/member/regist", produces="text/html;charset=utf8")
	@ResponseBody
	public MessageData registMember(Member member, HttpServletRequest request) {
		memberService.regist(fileManager, member);
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("회원 등록을 성공했습니다.");
		return messageData;
	}
	
	@GetMapping("/member/findIdForm")
	public String getFindIdForm(HttpServletRequest request) {
		return "market/member/findid";
	}
	
	@GetMapping("/member/findPWForm")
	public String getFindPWForm(HttpServletRequest request) {
		return "market/member/findPW";
	}
	
	@RequestMapping(value="/member/findId", method=RequestMethod.GET)
	@ResponseBody
	public MessageData memberFindId(Member member, HttpServletRequest request) {
		Member findMember = memberService.findid(member);
		logger.debug("name" + member.getName());
		logger.debug("phone : "+member.getPhone());
		logger.debug("finded : "+findMember.getUser_id());
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("찾으시는 아이디는 "+findMember.getUser_id());
		logger.debug(""+messageData.getResultCode());
		logger.debug(""+messageData.getMsg());
		return messageData;
	}
	
	@GetMapping("/member/findPW")
	@ResponseBody
	public MessageData memberFindPW(Member member, HttpServletRequest request) {
		HttpSession session = request.getSession();
		memberService.findpassword(member);
		logger.debug("user_id : " +member.getUser_id() );
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("작성하신 이메일로 임시비밀번호로 발급해드렸습니다.\n임시비밀번호로 로그인 후 비밀번호를 꼭 변경해주세요!");
		return messageData;
	}
	
	
	
	
	//예외처리
	@ExceptionHandler(MemberDMLException.class)
	@ResponseBody
	public MessageData handleException(MemberDMLException e) {
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		return messageData;
	}
	
	@ExceptionHandler(MemberIdPasswordNotFound.class)
	@ResponseBody
	public MessageData handleException(HttpServletRequest request, MemberIdPasswordNotFound e) {
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		logger.debug(""+messageData.getResultCode());
		logger.debug(""+messageData.getMsg());
		return messageData;
	}
	
	@ExceptionHandler(MemberNotFoundException.class)
	public ModelAndView handleException(MemberNotFoundException e, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("market/error/message");
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData", messageData);
		return mav;
	}
	
}
