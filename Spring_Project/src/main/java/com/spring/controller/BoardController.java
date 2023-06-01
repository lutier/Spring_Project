package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.PageDTO;
import com.spring.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
@RequestMapping("/board/*")
public class BoardController {
	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	@GetMapping("/register")
	public String registerForm() {
		return "/board/registerForm";
	}
	
	@PostMapping("/register")
		public String register(BoardVO vo, RedirectAttributes rttr) {
			boardService.register(vo);
			rttr.addFlashAttribute("result", vo.getBno());
			return "redirect:/board/list";
		
	}
	
//	@GetMapping("/list")
//	public String getList(Model model) {
//		List<BoardVO> list = boardService.getList();
//		model.addAttribute("list", list);
//		log.info(model);
//		return "/board/list";
//		
//	}
	
	@GetMapping("/list")
	public String list(Criteria criteria, Model model) {
		List<BoardVO> list = boardService.getList(criteria);
		model.addAttribute("list", list);
		int total = boardService.getTotal(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		log.info(list + "total : " + total);
		return "/board/list";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("bno")Long bno, Criteria criteria, Model model) {
		model.addAttribute("board", boardService.get(bno));
		return "/board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam ("bno")Long bno, Criteria criteria, Model model) {
		model.addAttribute("board", boardService.get(bno));
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria criteria) {
		if (boardService.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		return "redirect:/board/list" + criteria.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno")Long bno,Criteria criteria, RedirectAttributes rttr) {
		if(boardService.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		return "redirect:/board/list" + criteria.getListLink();
	}

}
