package com.korea.spacemarket.model.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.spacemarket.exception.MemberNotFoundException;
import com.korea.spacemarket.model.domain.Admin_Member;
import com.korea.spacemarket.model.member.repository.Admin_MemberDAO;

@Service
public class Admin_MemberServiceImpl implements Admin_MemberService{
	@Autowired
	private Admin_MemberDAO admin_memberDAO;
	
	@Override
	public Admin_Member select(Admin_Member admin_Member) throws MemberNotFoundException{
		return admin_memberDAO.select(admin_Member);
	}
}
