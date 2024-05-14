package com.mvp.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	//메인 페이지 이동
	@GetMapping("/main")
	public void mainPageGET() {
		logger.info("mainPageGET()");
	}
	
	
	
}
