package com.spring.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.domain.BoardVO;
import com.spring.mapper.BoardMapper;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {com.spring.config.RootConfig.class, com.spring.config.SecurityConfig.class})
public class BoardMapperTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper mapper;
	
	@Test
	public void testBoardInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("Board Test");
		vo.setContent("test");
		vo.setWriter("admin");
		mapper.insertBoard(vo);
	}

}
