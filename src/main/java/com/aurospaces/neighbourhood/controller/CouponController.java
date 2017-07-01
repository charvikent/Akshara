package com.aurospaces.neighbourhood.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.aurospaces.neighbourhood.db.dao.CouponCodeDao;

@Controller
public class CouponController {
	@Autowired
	CouponCodeDao couponCodeDao;
	
}