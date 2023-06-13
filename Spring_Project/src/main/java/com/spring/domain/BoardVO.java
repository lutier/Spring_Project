package com.spring.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long rn;
	private Long bno;
	private String title, content, writer;
	private Timestamp regdate, updatedate;
	
	private List<BoardAttachVO> attachList;
	
	public BoardVO(){
		
	}

}
