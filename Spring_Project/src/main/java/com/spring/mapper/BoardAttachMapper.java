package com.spring.mapper;

import java.util.List;

import com.spring.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public List<BoardAttachVO> findByBno(Long bno);
	public void delete(String uuid);
	public void deleteAll(Long bno);
}
