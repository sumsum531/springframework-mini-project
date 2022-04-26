package com.mycompany.webapp.dto;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardDto {
	private int freeNo;
	private String freeTitle;
	private String feeContent;
	private String freeWriter;
	private Date freeRegistDate;	//등록일
	private Date freeModifyDate;	//수정일
	private int freeUseYN;			//삭제 여부
	private int freeHitCount;		//조회수
}