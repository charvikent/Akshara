package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.StatusListDao;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.service.PopulateService;
@Controller
public class FilterController {

	private Logger logger = Logger.getLogger(AdminOrderController.class);
	@Autowired OrderInfo1Dao orderInfo1Dao;
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	Service1Dao service1Dao;
	@Autowired
	StatusListDao  objstatusListDao;
	
	@RequestMapping(value = "/unassignOrder", method = RequestMethod.GET)
	public String unassignOrder(@ModelAttribute("unassignCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setStatusId(3);
			listOrderBeans = orderInfo1Dao.getFilterOrder(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "unassignedOrederHome";
	}
	
	
	
	@RequestMapping(value = "/openOrder", method = RequestMethod.GET)
	public String openOrder(@ModelAttribute("unassignCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setStatusId(4);
			listOrderBeans = orderInfo1Dao.getFilterOrder(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "openOrederHome";
	}
	
	@RequestMapping(value = "/completedOrder", method = RequestMethod.GET)
	public String completedOrder(@ModelAttribute("unassignCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setStatusId(18);
			listOrderBeans = orderInfo1Dao.getFilterOrder(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "closedOrederHome";
	}
	@RequestMapping(value = "/assignOrder", method = RequestMethod.GET)
	public String assignOrder(@ModelAttribute("unassignCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setStatusId(2);
			listOrderBeans = orderInfo1Dao.getFilterOrder(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "assignedOrederHome";
	}
	@RequestMapping(value = "/datebetweenSearch")
	public @ResponseBody String datebetweenSearch( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse,@RequestParam("id") int id )
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		try {
			
			
			
			objRequest.setAttribute("AdminOrderActive", "active");
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setStatusId(id);
			objOrderInfo.setAddress(startdate);
			objOrderInfo.setClientOrderId(enddate);
			listOrderBeans = orderInfo1Dao.getFilterOrder(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				 // System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/statusBetween")
	public @ResponseBody String statusBetween( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		
		try {
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setAddress(startdate);
			objOrderInfo.setClientOrderId(enddate);
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getstatusBetween(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson);
				
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/statusopenBetween")
	public @ResponseBody String statusopenBetween( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		
		try {
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setAddress(startdate);
			objOrderInfo.setClientOrderId(enddate);
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getstatusopenBetween(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson);
				
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/statusclosedBetween")
	public @ResponseBody String statusclosedBetween( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		
		try {
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setAddress(startdate);
			objOrderInfo.setClientOrderId(enddate);
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getstatusclosedBetween(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson);
				
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/statusassignedBetween")
	public @ResponseBody String statusassignedBetween( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		
		try {
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setAddress(startdate);
			objOrderInfo.setClientOrderId(enddate);
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getstatusassignedBetween(objOrderInfo);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson);
				
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/datebetweenTotalAmount")
	public @ResponseBody String datebetweenTotalAmount( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		double listOrderBeans = 0;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		try {
			
			
			
			objRequest.setAttribute("AdminOrderActive", "active");
			OrderInfo1 objOrderInfo = new OrderInfo1();
			objOrderInfo.setAddress(startdate);
			objOrderInfo.setClientOrderId(enddate);
			listOrderBeans = orderInfo1Dao.totalNetAmount(objOrderInfo);
			if(listOrderBeans != 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  //System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	
	@RequestMapping(value = "/monthlyAmount")
	public  String monthlyAmount( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			
			
			
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getMonthlyAmount();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson);
				
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "monthlyOrdersHome";
	}

	@RequestMapping(value = "/WeeklyOrders")
	public  String WeeklyOrders( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			
			
			
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getWeeklyOrders();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "weeklyOrdersHome";
	}
	@RequestMapping(value = "/ServiceReport")
	public  String ServiceReport( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.servicereport(null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "ServiceReportHome";
	}
	@RequestMapping(value = "/ServiceReportFilter")
	public @ResponseBody String ServiceReportFilter( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		String startdate=objRequest.getParameter("startdate");
		String enddate=objRequest.getParameter("enddate");
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.servicereport(startdate, enddate);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
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
	@ModelAttribute("status")
	public Map<String, String> populateStatus() {
		Map<String, String> status = null;
		try {
			String sSql = "select id, name from status_list1";
			status = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return status;
	}
	@RequestMapping(value = "/DailyOrders")
	public  String DailyOrders(@ModelAttribute("dailyCmd") OrderBean objOrderInfo1, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getdailyOrders(null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "dailyOrdersHome";
	}
	@RequestMapping(value = "/DailyOrdersFilter")
	public  @ResponseBody String DailyOrdersFilter(@ModelAttribute("dailyCmd") OrderBean objOrderInfo1, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			String username=objRequest.getParameter("userId");
			String status=objRequest.getParameter("status");
			String startdate = objRequest.getParameter("startdate");
			
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getdailyOrders(username,status,startdate);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/revenueReport", method = RequestMethod.GET)
	public String revenueReport(@ModelAttribute("revenueReportCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getRevenuReport(null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "revenueReportHome";
	}
	
	
	@RequestMapping(value = "/revenueReportDatebetwen")
	public @ResponseBody String revenueReportDatebetwen( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String startdate = objRequest.getParameter("startdate");
		String enddate = objRequest.getParameter("enddate");
		String statusId = objRequest.getParameter("statusId").replaceAll("^\"|\"$", "");
		String userId = objRequest.getParameter("userId").replaceAll("^\"|\"$", "");
		System.out.println(userId);
		String serviceId=objRequest.getParameter("serviceId").replaceAll("^\"|\"$", "");
		String locationId=objRequest.getParameter("locationId").replaceAll("^\"|\"$", "");
		
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getRevenuReport(startdate,enddate,userId,statusId,serviceId,locationId);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); packCmd
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		///System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	
	@RequestMapping(value = "/profitReport", method = RequestMethod.GET)
	public String profitReport(@ModelAttribute("revenueReportCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getRevenuReport(null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				  //System.out.println(sJson); 
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "profitReport";
	}
	@RequestMapping(value = "/vendorsummaryReport")
	public  String VendorSummaryReport( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.vendorsummaryreport(null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "VenSummaryReportHome";
	}
	@RequestMapping(value = "/vendorSummaryFilter")
	public @ResponseBody String vendorSummaryFilter( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		String startdate=objRequest.getParameter("startdate");
		String enddate=objRequest.getParameter("enddate");
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.vendorsummaryreport(startdate, enddate);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@ModelAttribute("vendornames")
	public Map<String, String> populatevendorsname() {
		Map<String, String> vendorstatus = null;
		try {
			String sSql = "select id,concat_ws(' ',first_name,last_name) as name from vendor1";
			vendorstatus = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return vendorstatus;
	}
	@RequestMapping(value = "/VendorDetailReport")
	public  String VendorDetailReport(@ModelAttribute("VendorDetailCmd") OrderBean objOrderInfo1,  
			HttpServletRequest objRequest,HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.vendorDetailreport(null, null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "VendorDetailReportHome";
	}
	@RequestMapping(value = "/VendorDetailFilter")
	public  @ResponseBody String VendorDetailFilter(@ModelAttribute("VendorDetailCmd") OrderBean objOrderInfo1, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			String vendorId=objRequest.getParameter("vendorId");
			String startdate=objRequest.getParameter("startdate");
			String enddate = objRequest.getParameter("enddate");
			
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.vendorDetailreport(vendorId, startdate, enddate);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return sJson;
	}
	@RequestMapping(value = "/clientServiceReport")
	public  String ClientServiceReport( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<Map<String, String>> listOrderBeans = null;
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.servicereport(null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
			}
			
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "clientServiceReportHome";
	}
	@ModelAttribute("locations")
	public Map<String, String> populateLoction() {
		Map<String, String> statesMap = null;
		 StringBuffer objStringBuffer = new StringBuffer();
		try {
			objStringBuffer.append("select id,name from location1 where active=1 and is_dummy=0 ");
			String sSql =objStringBuffer.toString();
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}	
}
