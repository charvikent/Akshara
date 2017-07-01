/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.CustomerBean;
import com.aurospaces.neighbourhood.bean.CustomerLoginBean;
import com.aurospaces.neighbourhood.dao.CustomerDao;
import com.aurospaces.neighbourhood.db.dao.Customer1Dao;
import com.aurospaces.neighbourhood.db.model.Customer1;
import com.aurospaces.neighbourhood.service.CustomerLoginService;

/**
 * @author Amit
 * 
 */
@Controller
public class CustomerLoginController {
	@Autowired
	CustomerLoginService objCustomerLoginService;
	@Autowired
	Customer1Dao objCustomer1Dao;
	@RequestMapping(value = "/customerLogin", method = RequestMethod.GET)
	public String customerLoginHome(
			@ModelAttribute("cusLoginCmd") CustomerLoginBean objLoginCustomer,
			HttpServletRequest objRequest) {
		try {

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

		}
		return "customerLoginHome";
	}

	@RequestMapping(value = "/validateCustomer", method = RequestMethod.POST)
	public String validateCustomer(
			@ModelAttribute("cusLoginCmd") CustomerLoginBean objLoginCustomer,
			HttpServletRequest objRequest, HttpSession objSession) {
		CustomerBean localCustomerLogin = null;
		try {
			String mobileOrEmail = objRequest.getParameter("mobileOrEmail");
			String password = objRequest.getParameter("password");
			System.out.println(mobileOrEmail+"--"+password);
			objLoginCustomer.setMobileOrEmail(mobileOrEmail);
			objLoginCustomer.setPassword(password);
			localCustomerLogin = objCustomerLoginService.validateCustomerLogin(objLoginCustomer);
			if (localCustomerLogin != null && localCustomerLogin.getRoleId()==2) {
				//objSession.setAttribute("customerBean", localCustomerLogin);
				return "redirect:medicineOrder.htm";
			}else if(localCustomerLogin != null && localCustomerLogin.getRoleId()== 3){
				//objSession.setAttribute("vedorBean", localCustomerLogin);
				return "redirect:vendorOrder.htm";
			}else if(localCustomerLogin != null && localCustomerLogin.getRoleId()== 1){
				//objSession.setAttribute("vedorBean", localCustomerLogin);
				return "redirect:vendorOrder.htm";
			}
			else  {
				return "redirect:customerLoginHome?AddFail=" + "Fail" + "'";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:customerLoginHome?AddFail=" + "Fail" + "'";
		} finally {

		}

	}
	
	@RequestMapping(value = "/customervalidate")
	public @ResponseBody String validate(
			HttpServletRequest objRequest, HttpSession objSession) {
		boolean listCustomerBean;
		String sJson = "";
		String sMobileno = null;
		String sPassword = null;
		ObjectMapper objectMapper = null;
		List<Map<String, String>> list  = null;
		try {
			sMobileno =objRequest.getParameter("mobileNumber");
			sPassword = objRequest.getParameter("password");
			
			listCustomerBean  = objCustomer1Dao.validtecustomer(sMobileno,sPassword);
			if (listCustomerBean) {
				//objSession.setAttribute("customerBean", listCustomerBean);
				
				
				 
				System.out.println("customer is exist");
				sJson = "customer is exist";
				list = objCustomer1Dao.getCustomerDetails(sMobileno, sPassword);
				objectMapper = new ObjectMapper();
				sJson = objectMapper.writeValueAsString(list);
			}else{
				System.out.println("customer is not exist");
				sJson = "0";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {

		}
		return sJson;
	}
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public @ResponseBody String resetPassword(HttpServletRequest objRequest, HttpSession objSession) {
		CustomerBean objLoginCustomer = null;
		String responce = null;
		String mobileNum = null;
		String password = null;
		boolean validate = false;
		try {
			objLoginCustomer = new CustomerBean();
			mobileNum = objRequest.getParameter("pnum");
			password = objRequest.getParameter("password");
			System.out.println(mobileNum+"--"+password);
			objLoginCustomer.setMobileNumber(mobileNum);
			objLoginCustomer.setPassword(password);
			validate = objCustomerLoginService.resetPassword(objLoginCustomer);
			if(validate){
				responce = "sucess";
			}else{
				responce = "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {

		}
		return responce;
	}

}
