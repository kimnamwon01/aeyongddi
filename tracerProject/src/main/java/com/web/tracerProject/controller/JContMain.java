package com.web.tracerProject.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.tracerProject.mapper.JDaoMain;
import com.web.tracerProject.vo.Task;

@Controller
public class JContMain {
	@Autowired(required = false)
	private JDaoMain service;
	
	// http://localhost:5656/main

	@GetMapping("/main")
	public String main(Model d, Task task) {
		int todayDoCount = service.getTodayDo(task);
		d.addAttribute("todayDoCount", todayDoCount);
		int thisWeekDo = service.getWeekDo(task);
		d.addAttribute("thisWeekDo", thisWeekDo);
		Date dueto = service.getDueto(task);
		d.addAttribute("dueto", dueto);
		String dDay = service.getDday(task);
		d.addAttribute("dDay", dDay);
		int countPro = service.getCountPro(task);
		d.addAttribute("countPro", countPro);
		return "tracerPages/index";
		
	}
}
