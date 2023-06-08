package com.spring.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.domain.ImageVO;
import com.spring.service.ImageService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j2
public class HomeController {
	@Setter(onMethod_=@Autowired)
	private ImageService imageService;

	@RequestMapping(value = "/", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		List<ImageVO> list = imageService.getList();
		model.addAttribute("list",list);
		
		return "home";
	}
	
	
}
