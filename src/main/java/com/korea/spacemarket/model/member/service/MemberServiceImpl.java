package com.korea.spacemarket.model.member.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.spacemarket.admin.controller.member.MemberController;
import com.korea.spacemarket.exception.MemberDMLException;
import com.korea.spacemarket.exception.MemberIdPasswordNotFound;
import com.korea.spacemarket.exception.MemberNotFoundException;
import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.common.MailSender;
import com.korea.spacemarket.model.common.SecureManager;
import com.korea.spacemarket.model.domain.Member;
import com.korea.spacemarket.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Autowired
	private MemberDAO memberDAO;

	@Autowired
	private SecureManager secureManager;

	@Autowired
	private MailSender mailSender;

	@Override
	public List selectAll() {
		return memberDAO.selectAll();
	}

	@Override
	public Member select(int member_id) {
		return memberDAO.select(member_id);
	}

	@Override
	public void regist(FileManager fileManager, Member member) throws MemberDMLException {
		String ext = fileManager.getExtend(member.getRepImg().getOriginalFilename());
		member.setFilename(ext);

		String secureData = secureManager.getSecureData(member.getPassword());
		member.setPassword(secureData);

		memberDAO.insert(member);

		String basicImg = member.getMember_id() + "." + ext;
		fileManager.saveFile(fileManager.getSaveBasicDir() + File.separator + basicImg, member.getRepImg());
	}

	@Override
	public void update(Member member) throws MemberDMLException {
		// fileManager.deleteFile(member.getRepImg().getOriginalFilename());
		// String ext = fileManager.getExtend(member.getRepImg().getOriginalFilename());
		// member.setFilename(ext);

		if (member.getPassword() != null) {
			String secureData = secureManager.getSecureData(member.getPassword());
			member.setPassword(secureData);
		}

		memberDAO.update(member);

		// String basicImg = member.getMember_id()+"."+ext;
		// fileManager.saveFile(fileManager.getSaveBasicDir()+File.separator+basicImg,
		// member.getRepImg());
	}

	@Override
	public void delete(int member_id) throws MemberDMLException {
		memberDAO.delete(member_id);
	}

	@Override
	public Member login(Member member) throws MemberNotFoundException {
		String hash = secureManager.getSecureData(member.getPassword());
		member.setPassword(hash);
		Member obj = memberDAO.login(member);
		return obj;
	}

	@Override
	public Member findid(Member member) throws MemberIdPasswordNotFound {
		Member findMember = memberDAO.findid(member);
		String name = member.getName();
		String id = member.getUser_id();
		String email = member.getEmail_id() + "@" + member.getEmail_server();
		// mailSender.send(email, name+"님 반갑습니다. 우주마켓 아이디 찾기 요청 하셨네요?", "찾으시고자 하는 아이디는
		// <"+ id +">입니다");
		return findMember;
	}

	@Override
	public void findpassword(Member member) throws MemberIdPasswordNotFound, MemberDMLException {
		Member findMember = memberDAO.findpassword(member);
		// 임시 비밀번호 생성
		String pw = "";
		for (int i = 0; i < 12; i++) {
			pw += (char) ((Math.random() * 26) + 97);
		}
		String secureData = secureManager.getSecureData(pw);
		findMember.setPassword(secureData);

		memberDAO.update(findMember);
		String email = member.getEmail_id() + "@" + member.getEmail_server();

		mailSender.send(email, "[우리 주변의 마켓, 우주마켓] 임시 비밀번호 발송",
				"회원님의 " + member.getUser_id() + "의 계정의 임시 비밀번호는 " + pw+ "입니다.");
	}

	@Override
	public Member selectWithProduct(int member_id) {
		return memberDAO.selectWithProduct(member_id);
	}

	@Override
	public Member selectWithFavorite(int member_id) {
		return memberDAO.selectWithProduct(member_id);
	}

}
