package com.spring.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {com.spring.config.RootConfig.class, com.spring.config.ServletConfig.class, com.spring.config.SecurityConfig.class})
@Log4j2
public class MemberControllerTests {

	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext context;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
//	@Test
	public void testSurvey2ndRegisterSurvey() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/member/signup"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void tsetSignUp() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/member/signup")
				.param("user_id", "abcd@gmail.com").param("user_name","모지리3")
				.param("user_pw","1212").param("location", "대구")
				.param("gender", "남성"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		log.info(resultPage);
	}
}
