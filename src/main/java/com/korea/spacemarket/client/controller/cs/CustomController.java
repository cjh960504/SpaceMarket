package com.korea.spacemarket.client.controller.cs;

import java.net.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomController {
	@GetMapping("/cs/notice")
	public String noticeList(HttpServletRequest request) {
		return "market/cs/notice";
	}

}
