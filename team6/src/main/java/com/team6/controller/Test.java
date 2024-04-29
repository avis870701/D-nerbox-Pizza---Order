package com.team6.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Test {

	
	@GetMapping("/test.do")
	@ResponseBody
	public String test() {
		return "goodjob!";
	}
	
}
