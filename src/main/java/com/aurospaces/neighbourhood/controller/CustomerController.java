/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.CustomerBean;
import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.bean.WeburlBean;
import com.aurospaces.neighbourhood.db.dao.Customer1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.model.Customer1;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.OrderServiceUnit1;
import com.aurospaces.neighbourhood.db.model.OrderStatusLog1;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.TimeSlots;
import com.aurospaces.neighbourhood.db.model.Users;
import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;
import com.aurospaces.neighbourhood.service.CustomerService;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.util.AuroConstants;
import com.aurospaces.neighbourhood.util.EmailSendingUtil;
import com.aurospaces.neighbourhood.util.MiscUtils;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.aurospaces.neighbourhood.util.SMSUtil;

/**
 * @author kanojia
 * @param <CustomerService>
 * 
 */
@Controller
public class CustomerController {
	@Autowired
	CustomerService objCustomerService;
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	Customer1Dao objCustomer;
	@Autowired
	OrderInfo1Dao orderInfo1Dao;
	private Logger logger = Logger.getLogger(CustomerController.class);

	@RequestMapping(value = "/CustomerHome", method = RequestMethod.GET)
	public String CustomerHome(
			@ModelAttribute("cusCmd") CustomerBean objCustomerBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("cusActive", "active");
			List<CustomerBean> listCusBean = objCustomerService.getCustomers(
					objCustomerBean, "all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listCusBean);
			objRequest.setAttribute("CusList", json);
			objSession.setAttribute("tabName", "Customer");

		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in CustomerHome() in CustomerController");
		} finally {

		}
		return "customer";
	}

	@RequestMapping(value = "/customerProfile")
	public @ResponseBody String customerSave(
		HttpServletRequest objRequest, HttpServletResponse objResponse) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		String customerId = null;
		String ressponce = null;
		
		/*ObjectMapper mapper = new ObjectMapper();
        
        //my json variable have the ids that i need, but i dont know how to get them .
 
         Map<String, String> ids;
        ids = mapper.readValue(json, HashMap.class);
 
        String idRoleString = ids.get("mobileNumber");
        String idPermString = ids.get("name");*/
		try {
			String mobileNumber = objRequest.getParameter("mobileNumber");
			int count = objCustomer.customerExistOrNot(mobileNumber);
			if (count > 0){
				return "user already exist";
			}
			 Customer1 objCusBean = new Customer1();
			System.out.println(objRequest.getParameter("name")); 
			objCusBean.setName(objRequest.getParameter("name"));
			objCusBean.setMobileNumber(objRequest.getParameter("mobileNumber"));
			objCusBean.setEmail(objRequest.getParameter("email"));
			objCusBean.setAddress1(objRequest.getParameter("address"));
			objCusBean.setPassword(objRequest.getParameter("password"));
			objRequest.setAttribute("cusActive", "active");
			 objCustomer.save(objCusBean);
			/*if (isInsert) {
				objSession.setAttribute("customerId",customerId);
				return "redirect:CustomerHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:CustomerHome.htm?AddFail=" + "fail" + "";
			}*/
		} catch (Exception e) {
			logger.fatal("error in customer save in customer controller");
			logger.error(e.getMessage());
			e.printStackTrace();
			return "redirect:CustomerHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
return "success";
	}

	@RequestMapping(value = "/searchCustomer")
	public @ResponseBody String searchCustomer(	ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		try {
			String mobileNumber = objRequest.getParameter("mobileNumber");
			int count = objCustomer.customerExistOrNot(mobileNumber);
			if (count > 0){
				return "user already exist";
			}else {
				return "0";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search CustomerBean in CustomerBean controller");
		} finally {

		}
		return null;
	}

	@RequestMapping(value = "/editCustomer", method = RequestMethod.GET)
	public String editCustomer(
			@ModelAttribute("cusCmd") CustomerBean objCustomerBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		CustomerBean locobjCustomerBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("cusActive", "active");
			locobjCustomerBean = objCustomerService.getCustomer(
					objCustomerBean, "all");

			model.addAttribute("cusCmd", locobjCustomerBean);
			objMap.addAttribute("cusEdit", locobjCustomerBean);

			objCustomerBean.setCustomerId(null);

			List<CustomerBean> cusBeanList = objCustomerService.getCustomers(
					objCustomerBean, "all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(cusBeanList);
			objRequest.setAttribute("CusList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit customer in customer controller");
		} finally {

		}
		return "CustomerHome";
	}

	@RequestMapping(value = "/cusUpdate", method = RequestMethod.POST)
	public String cusUpdate(

	@ModelAttribute("cusCmd") CustomerBean objCustomerBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {
			bIsUpdate = objCustomerService.updateCustomer(objCustomerBean);
			/*
			 * int catCount = objTestService.catDuplicate(objCatBean); if
			 * (catCount == 0) { bIsUpdate =
			 * objTestService.updateCategory(objCatBean); }
			 */
			objRequest.setAttribute("cusActive", "active");
			if (bIsUpdate) {
				return "redirect:CustomerHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:CustomerHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update CustomerHome in CustomerHome controller");
			return "redirect:CustomerHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deleteCustomer", method = RequestMethod.POST)
	public @ResponseBody
	String deleteCustomer(
			@ModelAttribute("cusCmd") CustomerBean objCustomerBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sCustomerId = objRequest.getParameter("deleteId");
			if (sCustomerId != null) {
				objCustomerBean.setCustomerId(sCustomerId);
			}
			isDelete = objCustomerService.deleteCustomer(objCustomerBean);
			objCustomerBean.setCustomerId(null);
			List<CustomerBean> listCustomerBean = objCustomerService
					.getCustomers(objCustomerBean, "all");
			for (CustomerBean c : listCustomerBean) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listCustomerBean);
			objRequest.setAttribute("cusActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete Customer in customer controller");
			return "redirect:CustomerHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}
	
	@ModelAttribute("states")
	public Map<String, String> populateStates() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select state_Id,state_Name from states";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	
	
	@RequestMapping(value = "/updatePassword")
	public @ResponseBody String updatePassword(
		HttpServletRequest objRequest, HttpServletResponse objResponse) {
		objResponse.setCharacterEncoding("UTF-8");
		String mobileNumber = objRequest.getParameter("mobileNumber");
		String responce = null;
		 Customer1 objCusBean = null;
		try {
			objCusBean = new Customer1();
			
			  objCusBean = 	objCustomer.getCustomerMobiledata(mobileNumber);
			 if( objCusBean != null){
				 objCusBean.setMobileNumber(objRequest.getParameter("mobileNumber"));
					objCusBean.setPassword(objRequest.getParameter("password"));
					objRequest.setAttribute("cusActive", "active");
					 objCustomer.save(objCusBean);
					 responce = "success update password";
			 }else{
				 responce = "0";
			 }
			
			
		} catch (Exception e) {
			logger.fatal("error in customer save in customer controller");
			logger.error(e.getMessage());
			e.printStackTrace();
			 responce = "mobile number is not register ";
		} finally {

		}
return responce;
	}

	
}
