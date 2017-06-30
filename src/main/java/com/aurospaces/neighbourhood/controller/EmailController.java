/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.util.EmailSendingUtil;

/**
 * @author YOGI
 * 
 */
@Controller
public class EmailController {
	@Autowired
	ServletContext objContext;
	@Autowired
	OrderInfo1Dao orderInfo1Dao;
	Logger logger = Logger.getLogger(EmailController.class);
	@RequestMapping(value = "/emailFeedback")
	public String emailFeedback(HttpServletRequest objRequest, OrderInfo1 objOrderBean) {
		String sPhoneOrEmail = null;
		String sMessage = null;
		EmailSendingUtil objEmailSendingUtil= null;
		try {
			sPhoneOrEmail = objRequest.getParameter("phone");
			sMessage = objRequest.getParameter("message");
			if(objOrderBean != null){
				if(StringUtils.isNotBlank(sPhoneOrEmail)){
					objOrderBean.setContactEmail(sPhoneOrEmail);
				}
				if(StringUtils.isNotBlank(sMessage)){
					objOrderBean.setDescription(sMessage);
				}
				objEmailSendingUtil = new EmailSendingUtil();
				objEmailSendingUtil.sendEmail(objOrderBean, objContext, "feedback");
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
		} finally {

		}
		return "redirect:auroHome.htm";
	}
	@RequestMapping(value="/cronEmailForOrderDetails")
	public @ResponseBody String cronEmailForOrderDetails(){
		String  result = "";
		try{
			List<OrderInfo1> orderList = orderInfo1Dao.getCronData();
			if(orderList != null && orderList.size() > 0){
				EmailSendingUtil util = new EmailSendingUtil();
				String propertiespath = objContext.getRealPath("Resources" +File.separator+"DataBase.properties");
				result =util.cronEmailForOrderDetails(propertiespath, orderList);
				logger.info(orderList.size());
			}
		}catch(Exception e){
			logger.error(e.getMessage());			
		}
		return result;
	}
}
