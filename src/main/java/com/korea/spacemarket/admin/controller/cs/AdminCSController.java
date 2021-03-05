package com.korea.spacemarket.admin.controller.cs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminCSController {
	
	
	
	@GetMapping("/cs/notice")
	public String getNoticeList() {
		
		return null;
	}
}
