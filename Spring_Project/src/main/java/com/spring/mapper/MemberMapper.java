package com.spring.mapper;

import com.spring.domain.MemberVO;

public interface MemberMapper {
	public void insertMember(MemberVO vo);
	public MemberVO selectMemberByUserid(String user_id);
}
