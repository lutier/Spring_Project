package com.spring.persistance;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.domain.MemberVO;
import com.spring.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.spring.config.RootConfig.class})
@Log4j2
public class MemberMapperTests {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
//	@Test
	public void testInsertMember() {
		MemberVO vo = new MemberVO("a","a","a","a","a");
		memberMapper.insertMember(vo);
	}
	
//	@Test
	public void testPwEncoder() {
		String rawPassword = "12345678";
		
		
	}
	


}
