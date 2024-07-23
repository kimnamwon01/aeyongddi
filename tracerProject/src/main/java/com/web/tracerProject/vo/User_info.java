package com.web.tracerProject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class User_info {
	private String email;
	private String password;
	private String nickname;
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	private String phone;
}
