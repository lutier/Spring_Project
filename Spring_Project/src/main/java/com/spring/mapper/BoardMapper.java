package com.spring.mapper;

import java.util.List;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;

public interface BoardMapper {
	public BoardVO read(Long bno);
	public void insertBoard(BoardVO vo);
	public List<BoardVO> getList();
	public int update(BoardVO vo);
	public int delete(Long bno);
	
	public List<BoardVO> getListWithPaging(Criteria criteria);
	public int getTotalCount(Criteria criteria);
}
