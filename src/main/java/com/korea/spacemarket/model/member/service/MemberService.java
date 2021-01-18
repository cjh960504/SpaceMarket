package com.korea.spacemarket.model.member.service;

import java.util.List;

import com.korea.spacemarket.model.common.FileManager;
import com.korea.spacemarket.model.domain.Member;

public interface MemberService {
	public List selectAll();
	public Member select(int member_id);
	public void regist(FileManager fileManager, Member member);
	public void update(Member member);
	public void delete(int member_id);
	public Member login(Member member);
	public void findid(Member member);
	public void findpassword(Member member);
	public Member selectWithProduct(int member_id);
	public Member selectWithFavorite(int member_id);
}
