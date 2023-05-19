package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.AuthVO;
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
	public String signupSubmit(MemberVO vo, HttpSession session) {
		String user_pw = vo.getUser_pw();
		memberService.signUp(vo);
		try {
			vo.setUser_pw(user_pw);
			AuthVO authVO = memberService.authenticate(vo);
			session.setAttribute("auth", authVO);
		} catch (Exception e) {
			
		}
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "/member/loginForm";
	}
	
	@PostMapping("/login")
	public String loginSubmit(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		try {
			AuthVO authVO = memberService.authenticate(vo);
			session.setAttribute("auth", authVO);
			String userURI = (String) session.getAttribute("userURI");
			if (userURI != null) {
				session.removeAttribute("userURI");
				return "redirect:/"+userURI;
			}
			return "redirect:/";
		} catch (Exception e){
			rttr.addFlashAttribute("error",e.getMessage());
			rttr.addFlashAttribute("memberVO",vo);
			return "redirect:/member/login";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.removeAttribute("auth");
		rttr.addFlashAttribute("msg","logout");
		return "redirect:/";
	}

}
