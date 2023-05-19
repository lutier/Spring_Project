package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.domain.AuthVO;
import com.spring.domain.MemberVO;
import com.spring.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MemberService {
	
//	public interface PasswordEncoder{
//		String encode(CharSequence rawPassword);
//		
//		boolean matches(CharSequence rawPassword, String encodedPassword);
//	}

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwEncoder;
	
	public void signUp(MemberVO vo) {
		vo.setUser_pw(pwEncoder.encode(vo.getUser_pw()));
		mapper.insertMember(vo);
	}
	
	public AuthVO authenticate(MemberVO vo) throws Exception{
		MemberVO selectVO = mapper.selectMemberByUserid(vo.getUser_id());
		if(selectVO == null) {
			throw new Exception("nonuser");
		}
		if (!pwEncoder.matches(vo.getUser_pw(), selectVO.getUser_pw())) {
			throw new Exception("nomatch");
		}
		AuthVO authVO = new AuthVO();
		authVO.setUser_id(selectVO.getUser_id());
		authVO.setUser_name(selectVO.getUser_name());
		return authVO;
	}
}
