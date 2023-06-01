package com.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	private Long rn;
	private Long bno;
	private String title, content, writer;
	private Timestamp regdate, updatedate;
	
	public BoardVO(){
		
	}

}
