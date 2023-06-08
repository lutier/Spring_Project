package com.spring.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.ImageVO;
import com.spring.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ImageService {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	public List<ImageVO> getList(){
		List<ImageVO> list = new ArrayList<ImageVO>();
		for(int i=1; i<4; i++) {
			ImageVO vo = new ImageVO("/resources/img/pic"+ i + ".jpg", "pic" + i, String.valueOf(i));
			list.add(vo);
		}
		return list;
	}
}
