package com.spring.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	private String filename, uploadPath, uuid;
	private boolean image;
}
