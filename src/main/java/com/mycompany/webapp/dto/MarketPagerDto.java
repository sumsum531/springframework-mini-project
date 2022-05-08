package com.mycompany.webapp.dto;

import lombok.Data;

@Data
public class MarketPagerDto extends PagerDto{
	private String category;
	private String align;
	
	//검색 조건
	private String searchType;
	private String searchContent;
	
	public MarketPagerDto(int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo) {
		super(rowsPerPage, pagesPerGroup, totalRows, pageNo);
		// TODO Auto-generated constructor stub
	}

}
