package com.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVO {

	private long rno, bno;
	private String reply, replyer;
	private Timestamp regdate, updatedate;
}
