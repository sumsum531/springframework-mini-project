package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/take")
public class TakeController {
   @RequestMapping("/list")
   public String list() {
      return "take/list";
   }
}