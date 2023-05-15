package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.MemberVO;
import com.spring.service.MemberService;

import lombok.Setter;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@GetMapping("/signup")
	public String signupForm() {
		return "/member/signupForm";
	}
	
	@PostMapping("/signup")
	public String signupSubmit(MemberVO vo) {
		memberService.signUp(vo);
		return "redirect:/";
	}

}
