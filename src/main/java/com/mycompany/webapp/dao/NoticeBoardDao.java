package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.webapp.dto.NoticeBoardDto;
import com.mycompany.webapp.dto.PagerDto;

@Mapper
public interface NoticeBoardDao {
	
	public int count();
	
	public List<NoticeBoardDto> selectByPage(PagerDto pager);
}