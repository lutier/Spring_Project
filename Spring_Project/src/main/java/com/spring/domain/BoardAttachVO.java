package com.spring.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private String uuid, uploadpath, filename;
	private boolean filetype;
	private Long bno;
}
