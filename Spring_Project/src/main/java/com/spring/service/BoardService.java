package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
	
//	public boolean modify(BoardVO vo) {
//	return mapper.update(vo) == 1;
//}
	
	@Transactional
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		List<BoardAttachVO> list = board.getAttachList();
		if(modifyResult && list != null) {
			for(BoardAttachVO vo : list) {
				vo.setBno(board.getBno());
				attachMapper.insert(vo);
			}
		}
		return modifyResult;
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



	public boolean remove(Long bno) {
		return mapper.delete(bno)==1;
	}

	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno " + bno);
		return attachMapper.findByBno(bno);
	}

}
