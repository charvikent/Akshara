/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * @author YOGI
 *
 */
@Controller
public class CustomerOrderController {
	@RequestMapping(value = "/customerOrder", method = RequestMethod.GET)
	public String customerLoginHome(
			
			HttpServletRequest objRequest) {
		try {
			
		} catch (Exception e) {
			e.printStackTrace();

		} finally {

		}
		return "customerOrder";
	}
}
