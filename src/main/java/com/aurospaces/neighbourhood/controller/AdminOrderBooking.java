package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.db.dao.ClientOrderLogDao;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.model.ClientOrderLog;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.ServiceUnit1;
import com.aurospaces.neighbourhood.service.PopulateService;

@Controller
public class AdminOrderBooking {
	Logger logger = Logger.getLogger(PackegeInsertionController.class);
	@Autowired
	ServiceUnit1Dao objServiceUnit1Dao;
	@Autowired
	PopulateService objPopulateService;
	@Autowired 
	Service1Dao service1Dao;
	@Autowired
	OrderInfo1Dao orderInfo1Dao;
	@Autowired
	ClientOrderLogDao clientorderlogDao;
	@RequestMapping(value = "/adminBooking", method = RequestMethod.GET)
	public String homeServices(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session) {
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getBookingOrders();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  System.out.println(sJson); 
			}
			LoginBean loginBean = (LoginBean) session.getAttribute("cacheUserBean");
			if(loginBean != null){
				objServiceUnit1.setUserId(loginBean.getUserId());
			}
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		System.out.println("DOES THIS COME HERE ");
		return "adminBooking";
	}
	@RequestMapping(value = "/searchPackage1")
	public @ResponseBody String serarchPackage(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = "";
		try {
			objRequest.setAttribute("serActive", "active");
			String vendorId=objRequest.getParameter("vendorId");
			String serviceId=objRequest.getParameter("serviceId");
			
			if(StringUtils.isNotBlank(vendorId)){
				objServiceUnit1.setVendorId(Integer.parseInt(vendorId));
			}
			if(StringUtils.isNotBlank(serviceId)){
				objServiceUnit1.setServiceId(Integer.parseInt(serviceId));
			}
			
			List<ServiceUnit1> objServiceUnit1List = objServiceUnit1Dao.getAll(objServiceUnit1);
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(objServiceUnit1List);
			System.out.println(sJson);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in edit serivce in category controller");
		} finally {

		}
		return sJson;
	}
	@ModelAttribute("vendors1")
	public Map<String, String> populateCateogrys() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id, concat_ws (' ',first_name,last_name) from vendor1";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}



@ModelAttribute("users")
public Map<String, String> populateUsers() {
	Map<String, String> users = null;
	try {
		String sSql = "select id, name from users";
		users = objPopulateService.populatePopUp(sSql);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
	}
	return users;
}

@ModelAttribute("services")
public Map<String, String> populateServices() {

	return service1Dao.getServicesAsMap();
}
@RequestMapping(value = "/clientcommentUpdate")
public @ResponseBody String clientcommentUpdate(
		Model model, ModelMap objMap, HttpServletResponse objResponse,
		HttpServletRequest objRequest, HttpSession objSession,
		@RequestParam("orderid") String orderid,
		@RequestParam("clientComments") String clientComments,
		@RequestParam("gid") int gid,
		@RequestParam("userId") int userId
		
		) {
	objResponse.setCharacterEncoding("UTF-8");
	String sJson = "";
	List<Map<String, String>> listOrderBeans = null;
	ObjectMapper objectMapper = null;
	OrderInfo1 objOrderInfo = null ;
	try {
		objOrderInfo = new OrderInfo1();
		objOrderInfo = orderInfo1Dao.getById(gid);
		if(StringUtils.isNotBlank(clientComments))
		{
			if(!(clientComments.equals(objOrderInfo.getClientLog()))){
		objOrderInfo.setClientLog(clientComments);
		orderInfo1Dao.save(objOrderInfo);
		ClientOrderLog clientorderLog = new ClientOrderLog();
		clientorderLog.setClientLog(clientComments);
		clientorderLog.setOrderId(gid);
		System.out.println(gid);
		clientorderLog.setUserId(userId);
		clientorderlogDao.save(clientorderLog);
		}
		}
		listOrderBeans = orderInfo1Dao.getOrdersByParams(null,null,null,null,null,null,null,null,null,null,null);
		if(listOrderBeans != null && listOrderBeans.size() > 0) {
			  objectMapper = new ObjectMapper(); 
			  sJson =objectMapper.writeValueAsString(listOrderBeans);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(e.getMessage());
		logger.fatal("error in admin orderbooking controller");
	} finally {

	}
	return sJson;
}

@RequestMapping(value = "/grapicHome")
public  String monthlyAmount( HttpServletRequest objRequest,
		HttpSession objSession, HttpServletResponse objResponse)
				throws JsonGenerationException, JsonMappingException, IOException {
	objResponse.setCharacterEncoding("UTF-8");
	ObjectMapper objectMapper = null;
	String sJson = "";
	List<Map<String, String>> listOrderBeans = null;
	try {
		OrderInfo1 obj = new OrderInfo1();
		
		
		objRequest.setAttribute("AdminOrderActive", "active");
		listOrderBeans = orderInfo1Dao.getstatusBetween(obj);
		if(listOrderBeans != null && listOrderBeans.size() > 0) {
			
			objectMapper = new ObjectMapper(); 
			  sJson =objectMapper.writeValueAsString(listOrderBeans);
			  objRequest.setAttribute("allOrders1", sJson);
			  System.out.println(sJson);
			
		}
		
		objSession.setAttribute("tabName", "AdminOrders");
	} catch (Exception e) {
		logger.error(e.getMessage());
		logger.fatal("error in  Order controller");
	} finally {

	}
	System.out.println("DOES THIS COME HERE ");
	return "grapicHome";
}
@RequestMapping(value = "/graphic")
public @ResponseBody  String graphic(
		Model model, ModelMap objMap, HttpServletResponse objResponse,
		HttpServletRequest objRequest, HttpSession objSession
		
		) {
	objResponse.setCharacterEncoding("UTF-8");
	String sJson = "";
	List<Map<String, String>> listOrderBeans = null;
	ObjectMapper objectMapper = null;
	try {
		listOrderBeans = orderInfo1Dao.grapic();
		if(listOrderBeans != null && listOrderBeans.size() > 0) {
			  objectMapper = new ObjectMapper(); 
			  sJson =objectMapper.writeValueAsString(listOrderBeans);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(e.getMessage());
		logger.fatal("error in admin orderbooking controller");
	} finally {

	}
	return sJson;
}
}