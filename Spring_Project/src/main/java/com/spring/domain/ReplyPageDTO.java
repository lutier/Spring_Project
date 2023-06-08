package com.spring.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor		// 상세 선언 안해도 된다.
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyVO> list;
	
//	public ReplyPageDTO(int replyCnt, List<ReplyVO> list) {
//		this.replyCnt = replyCnt;
//		this.list = list;
//	}

}
