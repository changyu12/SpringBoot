package com.example.boot3mybatis;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

public class MainController {
	@GetMapping("/")
	public String index() {
	
		return "index";
	}
}
