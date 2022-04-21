package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/interior")
public class InteriorController {
	@RequestMapping("/example")
	public String example() {
		log.info("실행");
		return "/interior/example";
	}
	
	@RequestMapping("/simulator")
	public String simulator() {
		log.info("실행");
		return "/interior/simulator";
	}
}
