package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.mapper.BoardAttachMapper;
import com.spring.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	public void register(BoardVO vo) {
		mapper.insertBoard(vo);
		
		List<BoardAttachVO> list = vo.getAttachList();
		if(list == null || list.isEmpty()) {
			return;
		}
		
		for(BoardAttachVO attach : list) {
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		}
	}
	
	public List<BoardVO> getList(Criteria criteria) {
		return mapper.getListWithPaging(criteria);
	}
	
	public int getTotal(Criteria criteria) {
		return mapper.getTotalCount(criteria);
	}

	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	public boolean modify(BoardVO vo) {
		return mapper.update(vo) == 1;
	}

	public boolean remove(Long bno) {
		return mapper.delete(bno)==1;
	}

}
