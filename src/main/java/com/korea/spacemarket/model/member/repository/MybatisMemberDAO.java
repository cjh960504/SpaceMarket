package com.korea.spacemarket.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.spacemarket.exception.MemberDMLException;
import com.korea.spacemarket.exception.MemberIdPasswordNotFound;
import com.korea.spacemarket.exception.MemberNotFoundException;
import com.korea.spacemarket.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Member.selectAll");
	}

	@Override
	public Member select(int member_id) {
		return sqlSessionTemplate.selectOne("Member.select", member_id);
	}

	@Override
	public void insert(Member member) throws MemberDMLException{
		int result = sqlSessionTemplate.insert("Member.insert", member);
		if(result==0) {
			throw new MemberDMLException("회원 등록 실패");
		}
	}

	@Override
	public void update(Member member) throws MemberDMLException{	
		int result = sqlSessionTemplate.update("Member.update", member);
		if(result==0) {
			throw new MemberDMLException("회원 수정 실패");
		}
	}

	@Override
	public void delete(int member_id) throws MemberDMLException{
		int result = sqlSessionTemplate.delete("Member.delete", member_id);
		if(result==0) {
			throw new MemberDMLException("회원 삭제 실패");
		}
	}

	@Override
	public Member login(Member member) throws MemberNotFoundException{
		Member obj = sqlSessionTemplate.selectOne("Member.login", member);
		if(obj==null) {
			throw new MemberNotFoundException("로그인 정보가 올바르지 않습니다");
		}
		return obj;
	}

	@Override
	public Member findid(Member member) throws MemberIdPasswordNotFound{
		Member findMember = sqlSessionTemplate.selectOne("Member.findid", member);
		if(findMember==null) {
			throw new MemberIdPasswordNotFound("찾으시는 ID가 없습니다.");
		}
		return findMember;
	}

	@Override
	public Member findpassword(Member member) throws MemberIdPasswordNotFound{
		Member findMember = sqlSessionTemplate.selectOne("Member.findpassword", member);
		if(findMember==null) {
			throw new MemberIdPasswordNotFound("해당 정보의 회원을 찾을 수 없습니다");
		}
		return findMember;
	}
	@Override
	public Member selectWithProduct(int member_id) {
		return sqlSessionTemplate.selectOne("Member.selectWithProduct", member_id);
	}
	@Override
	public Member selectWithFavorite(int member_id) {
		return sqlSessionTemplate.selectOne("Member.selectWithProduct", member_id);
	}
}
