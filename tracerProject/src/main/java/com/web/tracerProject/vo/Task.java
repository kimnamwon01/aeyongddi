package com.web.tracerProject.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Task {
	private String tkid;
	private Date start_date;
	private Date end_date;
	private boolean isend;
	private String name;
	private String description;
	private String sid;
}
