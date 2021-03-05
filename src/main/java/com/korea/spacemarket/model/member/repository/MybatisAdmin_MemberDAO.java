package com.korea.spacemarket.model.member.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.spacemarket.exception.MemberNotFoundException;
import com.korea.spacemarket.model.domain.Admin_Member;

@Repository
public class MybatisAdmin_MemberDAO implements Admin_MemberDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public Admin_Member select(Admin_Member admin_Member) throws MemberNotFoundException{
		Admin_Member admMember = sqlSessionTemplate.selectOne("Admin_Member.select", admin_Member);
		if(admMember ==null) {
			throw new MemberNotFoundException("정보가 일치하지 않습니다.");
		}
		return admMember;
	}
}
