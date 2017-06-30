package com.aurospaces.neighbourhood.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ClassUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.bean.WeburlBean;
import com.aurospaces.neighbourhood.db.dao.AurospacesOrderLogDao;
import com.aurospaces.neighbourhood.db.dao.AurospacesTransactionsDao;
import com.aurospaces.neighbourhood.db.dao.ClientTransactionsDao;
import com.aurospaces.neighbourhood.db.dao.Coupon1Dao;
import com.aurospaces.neighbourhood.db.dao.CustomerDiscount1Dao;
import com.aurospaces.neighbourhood.db.dao.DoctorType1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderStatusLog1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderSymptom1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.Symptom1Dao;
import com.aurospaces.neighbourhood.db.dao.TimeSlotsDao;
import com.aurospaces.neighbourhood.db.dao.UsersDao;
import com.aurospaces.neighbourhood.db.model.AurospacesOrderLog;
import com.aurospaces.neighbourhood.db.model.AurospacesTransactions;
import com.aurospaces.neighbourhood.db.model.Category1;
import com.aurospaces.neighbourhood.db.model.ClientTransactions;
import com.aurospaces.neighbourhood.db.model.Coupon1;
import com.aurospaces.neighbourhood.db.model.CouponCode;
import com.aurospaces.neighbourhood.db.model.CustomerDiscount1;
import com.aurospaces.neighbourhood.db.model.DiscountBean;
import com.aurospaces.neighbourhood.db.model.DoctorType1;
import com.aurospaces.neighbourhood.db.model.Reports;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.OrderServiceUnit1;
import com.aurospaces.neighbourhood.db.model.OrderStatusLog1;
import com.aurospaces.neighbourhood.db.model.OrderSymptom1;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.Symptom1;
import com.aurospaces.neighbourhood.db.model.TimeSlots;
import com.aurospaces.neighbourhood.db.model.Users;
import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service1.EmailValidationSrv;
import com.aurospaces.neighbourhood.util.AddressValidation;
import com.aurospaces.neighbourhood.util.AuroConstants;
import com.aurospaces.neighbourhood.util.DownloadFileServlet;
import com.aurospaces.neighbourhood.util.EmailSendingUtil;
import com.aurospaces.neighbourhood.util.MessageSender;
import com.aurospaces.neighbourhood.util.MiscUtils;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.aurospaces.neighbourhood.util.SMSUtil;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import freemarker.core.ReturnInstruction.Return;

@Controller
public class OrderController {
	Logger logger = Logger.getLogger(OrderController.class);
	
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	EmailValidationSrv emailServ;

	@Autowired
	OrderStatusLog1Dao orderStatusLog1Dao;
	@Autowired
	ServiceUnit1Dao serviceUnitDao;
	@Autowired
	OrderServiceUnit1Dao orderServiceUnit1Dao;
	@Autowired
	Service1Dao service1Dao;
	@Autowired
	TimeSlotsDao timeSlotsDao;
	@Autowired
	OrderInfo1Dao orderInfo1Dao;
	@Autowired
	DoctorType1Dao doctorType1Dao;
	@Autowired
	Symptom1Dao symptom1Dao;
	@Autowired
	ServletContext objContext;
	@Autowired
	OrderSymptom1Dao orderSymptom1Dao;
	@Autowired
	MessageSender messageSender;
	@Autowired
	CustomerDiscount1Dao cusotmerDiscount;
	@Autowired AurospacesOrderLogDao auroOrderLog;
	@Autowired UsersDao userDao;
	@Autowired Coupon1Dao coupon1Dao;
	@Autowired AurospacesTransactionsDao aurospacesTransactionsDao;
	@Autowired ClientTransactionsDao clientTransactionsDao;
	@RequestMapping(value = "/browseServices/{locationName}/{serviceName}/{locationId}/{serviceId}")
	public String browseServices(HttpSession objSession,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			Model mod, @PathVariable("locationId") int locationId,
			@PathVariable("serviceId") int serviceId) {
		String baseUrl = MiscUtils.getBaseUrl(objRequest);
		//System.out.println(baseUrl);
		DateTime date = new DateTime();
		int hour = date.getHourOfDay();
		/*
		 * int locationId =
		 * Integer.parseInt(objRequest.getParameter("locationId")); int
		 * serviceId = Integer.parseInt(objRequest.getParameter("serviceId"));
		 */
		//System.out.println("locationId------------" + locationId);
		//System.out.println("serviceId-----" + serviceId);
		Service1 service = service1Dao.getById(serviceId);
		mod.addAttribute("service", service);
		objRequest.setAttribute("baseUrl", baseUrl);
		objRequest.setAttribute("locationId", locationId);
		objRequest.setAttribute("serviceId", serviceId);
		objRequest.setAttribute("hour", hour);
		if (service.getPageName().equals("pathologyOrder")) {
			insertPathologyOrderDetails(service, serviceId, locationId, mod);
		} else if (service.getPageName().equals("doctorOrder")) {
			insertDoctorOrderDetails(service, serviceId, locationId, mod);
		}
		//System.out.println(service.getPageName());
		return service.getPageName();

	}

	@RequestMapping(value = "/orderTemplate")
	public String createOrder(HttpSession objSession,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			@RequestParam("serviceId") int serviceId,
			@RequestParam("locationId") int locationId, Model mod) {
		String baseUrl = MiscUtils.getBaseUrl(objRequest);
		Service1 service = service1Dao.getById(serviceId);
		mod.addAttribute("service", service);
		/* mod.addAttribute("baseUrl", baseUrl); */
		objRequest.setAttribute("baseUrl", baseUrl);
		objRequest.setAttribute("locationId", locationId);
		objRequest.setAttribute("serviceId", serviceId);
		if (service.getPageName().equals("pathologyOrder")) {
			insertPathologyOrderDetails(service, serviceId, locationId, mod);
		} else if (service.getPageName().equals("doctorOrder")) {
			insertDoctorOrderDetails(service, serviceId, locationId, mod);
		}

		return service.getPageName();

	}

	public void insertDoctorOrderDetails(Service1 service, int serviceId,
			int locationId, Model mod) {
		List<DoctorType1> doctorTypes = doctorType1Dao.getAll();
		mod.addAttribute("doctorTypes", doctorTypes);
	}

	public void insertPathologyOrderDetails(Service1 service, int serviceId,
			int locationId, Model mod) {
		List<String> labelList = serviceUnitDao.getAllLabels(serviceId,
				locationId);
		Map labelMap = new LinkedHashMap<String, String>();
		for (String label : labelList) {
			labelMap.put(label, label.replace(" ", "_"));
		}
		mod.addAttribute("labelMap", labelMap);
	}

	@RequestMapping(value = "/getServiceUnits")
	public @ResponseBody List<Map<String, String>> getServiceUnits(
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse

	) {
		String baseUrl = MiscUtils.getBaseUrl(objRequest);
		int serviceId = Integer.parseInt(objRequest.getParameter("serviceId"));
		int locationId = Integer.parseInt(objRequest.getParameter("locationId"));
		List<Map<String, String>> list = serviceUnitDao.getAllServiceUnit1s(serviceId, locationId,baseUrl);
		return list;
	}

	@ModelAttribute("listSymptoms")
	public List<Symptom1> getSymptoms() {

		return symptom1Dao.getAll();
	}

	@ModelAttribute("timeSlotList")
	public List<TimeSlots> getTimeSlots() {

		return timeSlotsDao.getAll();
	}

	
	@RequestMapping(value = "/webBooking")
	public @ResponseBody String bookWEBPackages(@RequestBody OrderBean objOrderBean,HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		String sJson = "";
		try{
			OrderInfo1 orderInfo = new OrderInfo1();
			NeighbourhoodUtil objNeighbourhoodUtil = new NeighbourhoodUtil();
		String couponcode = objOrderBean.getCouponcode();
		if(StringUtils.isNotBlank(couponcode)){
			orderInfo.setCouponCode(couponcode);
		}
		BigDecimal totalprice = new BigDecimal(objOrderBean.getTotalPrice());
		orderInfo.setTotalPrice(totalprice);
		BigDecimal totalNetAmount = new BigDecimal(objOrderBean.getNetAmount());
		orderInfo.setNetAmount(totalNetAmount);
		BigDecimal totaldiscount = new BigDecimal(objOrderBean.getTotalDiscount());
		orderInfo.setTotalDiscount(totaldiscount);
			
		Date  aptDate = MiscUtils.getDate(Integer.parseInt(objOrderBean.getBookedDate()));
		 orderInfo.setAppointmentDate(aptDate);
		 
		
		GeoMain gm = new GeoMain();
		GeoTag geo = gm.getAddr(objOrderBean.getOrderAddress());
		String generatedOrderId = objNeighbourhoodUtil.randNum();
		orderInfo.setGeneratedId(generatedOrderId);
		orderInfo.setContactNumber(objOrderBean.getContactNo());
		orderInfo.setContactEmail(objOrderBean.getContactEmail());
		orderInfo.setAddress(objOrderBean.getOrderAddress());
		orderInfo.setServiceId(objOrderBean.getServiceId());
		orderInfo.setStatusId(AuroConstants.ordered);
		System.out.println("web url");
	
		orderInfo.setAppointmentSlotId(Integer.parseInt(objOrderBean.getTimeSlotId()));
		orderInfo.setLocationId(Integer.parseInt(objOrderBean.getLocationId()));
		if (StringUtils.isNotBlank(objOrderBean.getCouponcode())) {
			orderInfo.setCouponCode(objOrderBean.getCouponcode());
		}
			Users objUsers=new Users();
			objUsers.setName("aurospace");
			int userid=userDao.getUserId(objUsers);
		
		if(userid != 0){
			orderInfo.setUserId(userid);
		}
		else{
			orderInfo.setUserId(1);
		}

		
		
		// orderInfo.setLocationId(24);
		
		orderInfo.setLatitude(geo.x);
		orderInfo.setLongitude(geo.y);
		
		//System.out.println(geo.x +"---"+geo.y);
		int vendorId = 0;
		if(StringUtils.isNotEmpty(objOrderBean.getVendorId())){
		 vendorId = Integer.parseInt(objOrderBean.getVendorId());
		}
		orderInfo.setVendorId(vendorId);
		
		orderInfo1Dao.save(orderInfo);
		
		
		List<WeburlBean> weburl = objOrderBean.getObjJson();
		
		if (weburl != null && weburl.size() > 0) {
			for(WeburlBean obj1 : weburl){
				OrderServiceUnit1 os1 = new OrderServiceUnit1();
				os1.setOrderId(orderInfo.getId());
				os1.setServiceUnitId(Integer.parseInt(obj1.getUnitId()));
				orderServiceUnit1Dao.save(os1);
			}
		}
		
		OrderStatusLog1 osl1 = new OrderStatusLog1();
		osl1.setOrderId(orderInfo.getId());
		osl1.setStatusId(orderInfo.getStatusId());
		orderStatusLog1Dao.save(osl1);
		
		Service1 objService1 = service1Dao.getById(orderInfo.getServiceId());
		String serviceName = null;
		if (objService1 != null) {
			serviceName = objService1.getName();
			if (StringUtils.isNotBlank(serviceName)) {
				orderInfo.setServiceName(serviceName);
			}
		}

		TimeSlots objTimeSlots = timeSlotsDao.getById(Integer.parseInt(objOrderBean.getTimeSlotId()));
		String timeName = null;
		if (objTimeSlots != null) {
			timeName = objTimeSlots.getLabel();
			if (StringUtils.isNotBlank(timeName)) {
				orderInfo.setAppointTimeName(timeName);
			}
		}

		EmailSendingUtil objEmailSendingUtil = new EmailSendingUtil();
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer");
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "admin");
		SMSUtil objSmsUtil = new SMSUtil();
		objSmsUtil.sendSms(objContext, orderInfo, "customer");
		objSmsUtil.sendSms(objContext, orderInfo, "order_admin");
		
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		
			objRequest.setAttribute("AdminOrderActive", "active");
			/*listOrderBeans = orderInfo1Dao.getBookingOrders();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders2", sJson);
				  //System.out.println(sJson); 
			}*/
			sJson = "success";
			
		}catch(Exception e){
			e.printStackTrace();
			
		}
		return sJson;
	}
	
	@RequestMapping(value = "/bookPackages")
	public @ResponseBody String bookPackages(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session,
			@RequestParam("serviceId") int serviceId,
			@RequestParam("locationId") int locationId,
			@RequestParam("contactNumber") String contactNumber,
			@RequestParam("contactAddress") String contactAddress,
			@RequestParam("selectedTests") String arrayData,
			@RequestParam("totalNetAmount") BigDecimal totalNetAmount,
			@RequestParam("totalDiscount") BigDecimal totalDiscount,
			@RequestParam("totalPrice") BigDecimal totalPrice,
			@RequestParam("emailId") String contactEmail,
			@RequestParam("dateId") String dateId,
			@RequestParam("timeId") int timeId,
			@RequestParam("couponcodeId") String couponcodeId

	) throws JsonGenerationException, JsonMappingException, IOException,
			AddressException, MessagingException, ParseException {
		
		objResponse.setCharacterEncoding("UTF-8");
		try{
		/*int serviceId = Integer.parseInt(objRequest.getParameter("serviceId"));
		int locationId = Integer.parseInt(objRequest.getParameter("locationId"));
		String contactNumber = objRequest.getParameter("contactNumber");
		String arrayData = objRequest.getParameter("selectedTests");
		String contactAddress = objRequest.getParameter("contactAddress");*/
		/*String tna = objRequest.getParameter("totalNetAmount");
		String td = objRequest.getParameter("totalDiscount");
		String tp = objRequest.getParameter("totalPrice");*/
		/*BigDecimal totalNetAmount = new BigDecimal(tna);
		BigDecimal totalDiscount = new BigDecimal(td);
		BigDecimal totalPrice = new BigDecimal(tp);
		String contactEmail = objRequest.getParameter("emailId");
		String dateId = objRequest.getParameter("dateId");
		String couponcodeId = objRequest.getParameter("couponcodeId");
		int timeId = Integer.parseInt(objRequest.getParameter("timeId"));*/
		
		
		boolean admin = Boolean.parseBoolean(objRequest.getParameter("admin"));
		String cname = objRequest.getParameter("cname");
		String userId = objRequest.getParameter("userId1");
		String sdiscription = objRequest.getParameter("sdiscription");
		String priorityId = objRequest.getParameter("priorityId");
		String wlocationId = objRequest.getParameter("wlocationId");
		String clientOrderId = objRequest.getParameter("clientOrderId");
		String bookedDateId = objRequest.getParameter("bookedDateId");
		//System.out.println(objRequest.getParameter("admin"));
		Properties prop = new Properties();
		InputStream input = null;
		int vendorId = 0;
		Date aptDate = null;
		NeighbourhoodUtil objNeighbourhoodUtil = new NeighbourhoodUtil();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		OrderInfo1 orderInfo = new OrderInfo1();
		String propertiespath = objContext.getRealPath("Resources"
				+ File.separator + "DataBase.properties");
		// String propertiespath = "C:\\PRO\\Database.properties";
		input = new FileInputStream(propertiespath);
		// load a properties file
		prop.load(input);
		/*String couponcode = prop.getProperty("couponcode");
		if (couponcodeId.equals(couponcode)) {
			totalNetAmount = BigDecimal.valueOf(0);
			totalPrice = BigDecimal.valueOf(0);
			totalDiscount = BigDecimal.valueOf(0);
		}*/
		if(!admin){
		 aptDate = MiscUtils.getDate(Integer.parseInt(dateId));
		 orderInfo.setAppointmentDate(aptDate);
		 orderInfo.setCompletionDate(aptDate);
		}else {
			
			Date date = formatter.parse(dateId);
			 orderInfo.setAppointmentDate(date);
			
			//aptDate =objNeighbourhoodUtil.getCurrentTimestamp(dateId);
		}
		if(StringUtils.isNotBlank(bookedDateId)){
			Date date1 = formatter.parse(bookedDateId);
			 orderInfo.setBookedDate(date1);
		}
		GeoMain gm = new GeoMain();
		GeoTag geo = gm.getAddr(contactAddress);
		String generatedOrderId = objNeighbourhoodUtil.randNum();
		orderInfo.setGeneratedId(generatedOrderId);
		orderInfo.setContactNumber(contactNumber);
		orderInfo.setContactEmail(contactEmail);
		orderInfo.setAddress(contactAddress);
		orderInfo.setServiceId(serviceId);
		orderInfo.setStatusId(AuroConstants.ordered);

		orderInfo.setNetAmount((totalNetAmount));
		orderInfo.setTotalDiscount((totalDiscount));
		orderInfo.setTotalPrice(totalPrice);
		orderInfo.setFixedCharge((totalPrice.doubleValue()));
		orderInfo.setAppointmentSlotId(timeId);
		orderInfo.setLocationId(locationId);
		if (StringUtils.isNotBlank(couponcodeId)) {
			orderInfo.setCouponCode(couponcodeId);
		}
			Users objUsers=new Users();
			objUsers.setName("aurospace");
			int userid=userDao.getUserId(objUsers);
		
		if(userid != 0){
			orderInfo.setUserId(userid);
		}
		else{
			orderInfo.setUserId(1);
		}

		
		
		// orderInfo.setLocationId(24);
		
		orderInfo.setLatitude(geo.x);
		orderInfo.setLongitude(geo.y);
		
		orderInfo.setClientOrderId(clientOrderId);
		orderInfo.setCustomerName(cname);
		orderInfo.setDescription(sdiscription);
		orderInfo.setPriority(priorityId);
		orderInfo.setWatsupLocation(wlocationId);
		//System.out.println(geo.x +"---"+geo.y);
		
		if(StringUtils.isNotEmpty(objRequest.getParameter("vendorId"))){
		 vendorId = Integer.parseInt(objRequest.getParameter("vendorId"));
		}
		orderInfo.setVendorId(vendorId);
		//System.out.println("vendor id in order controller..." + vendorId);
		int count = orderInfo1Dao.getCustomerInfo(orderInfo.getContactNumber());
		orderInfo1Dao.save(orderInfo);
		JsonParser jsonParser = null;
		JsonArray objAsonArray = null;
		ArrayList<String> unitIds = new ArrayList<String>();
		jsonParser = new JsonParser();
		objAsonArray = (JsonArray) jsonParser.parse(arrayData);
		if (objAsonArray != null && objAsonArray.size() > 0) {
			for (int i = 0; i < objAsonArray.size(); i++) {
				JsonObject objJsonObject = (JsonObject) objAsonArray.get(i);
				String unitId = objJsonObject.get("unitId").getAsString();
				unitIds.add(unitId);
			}
		}

		for (String unitId : unitIds) {
			OrderServiceUnit1 os1 = new OrderServiceUnit1();
			os1.setOrderId(orderInfo.getId());
			os1.setServiceUnitId(Integer.parseInt(unitId));
			orderServiceUnit1Dao.save(os1);
		}

		OrderStatusLog1 osl1 = new OrderStatusLog1();
		osl1.setOrderId(orderInfo.getId());
		osl1.setStatusId(orderInfo.getStatusId());
		orderStatusLog1Dao.save(osl1);
		/*if (!admin) {
			if (count == 0) {
				//System.out.println("customer is booking");
				CustomerDiscount1 customerDiscount1 = new CustomerDiscount1();
				customerDiscount1.setMobileNumber(orderInfo.getContactNumber());
				customerDiscount1.setOrderId(orderInfo.getId());
				String sPropFilePath = objContext.getRealPath("Resources"
						+ File.separator + "DataBase.properties");
				if (StringUtils.isNotBlank(sPropFilePath)) {
					Properties objProperties = new Properties();
					InputStream objStream = new FileInputStream(sPropFilePath);
					objProperties.load(objStream);
					String sCustomerDiscount = objProperties
							.getProperty("CustomerDiscount");
					customerDiscount1.setDiscount(new BigDecimal(
							sCustomerDiscount));
					cusotmerDiscount.save(customerDiscount1);
				}
			} else {
				//System.out.println("customer is booking");
				CustomerDiscount1 customerDiscount1 = new CustomerDiscount1();
				customerDiscount1.setMobileNumber(orderInfo.getContactNumber());
				customerDiscount1.setOrderId(orderInfo.getId());
				String sPropFilePath = objContext.getRealPath("Resources"
						+ File.separator + "DataBase.properties");
				if (StringUtils.isNotBlank(sPropFilePath)) {
					Properties objProperties = new Properties();
					InputStream objStream = new FileInputStream(sPropFilePath);
					objProperties.load(objStream);
					String sCustomerDiscount = objProperties
							.getProperty("existingCustomerDiscount");
					customerDiscount1.setDiscount(new BigDecimal(
							sCustomerDiscount));
					cusotmerDiscount.save(customerDiscount1);

				}
			}
		}*/
		Service1 objService1 = service1Dao.getById(serviceId);
		String serviceName = null;
		if (objService1 != null) {
			serviceName = objService1.getName();
			if (StringUtils.isNotBlank(serviceName)) {
				orderInfo.setServiceName(serviceName);
			}
		}

		TimeSlots objTimeSlots = timeSlotsDao.getById(timeId);
		String timeName = null;
		if (objTimeSlots != null) {
			timeName = objTimeSlots.getLabel();
			if (StringUtils.isNotBlank(timeName)) {
				orderInfo.setAppointTimeName(timeName);
			}
		}

		EmailSendingUtil objEmailSendingUtil = new EmailSendingUtil();
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer");
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "admin");
		SMSUtil objSmsUtil = new SMSUtil();
		objSmsUtil.sendSms(objContext, orderInfo, "customer");
		objSmsUtil.sendSms(objContext, orderInfo, "order_admin");
		
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getBookingOrders();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders2", sJson);
				  //System.out.println(sJson); 
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}

	@RequestMapping(value = "/bookSimple")
	public @ResponseBody String bookSimple(HttpServletRequest objRequest,
			HttpServletResponse objResponse,HttpSession session

	) throws JsonGenerationException, JsonMappingException, IOException,
			AddressException, MessagingException {
		objResponse.setCharacterEncoding("UTF-8");

		int serviceId = Integer.parseInt(objRequest.getParameter("serviceId"));
		int locationId = Integer
				.parseInt(objRequest.getParameter("locationId"));
		String contactNumber = objRequest.getParameter("contactNumber");
		String contactAddress = objRequest.getParameter("contactAddress");
		String description = objRequest.getParameter("description");
		String contactEmail = objRequest.getParameter("emailId");
		String dateStr = objRequest.getParameter("dateId");
		String customerId = objRequest.getParameter("customerId");
		Date aptDate = MiscUtils.getDate(Integer.parseInt(dateStr));
		int timeId = Integer.parseInt(objRequest.getParameter("timeId"));
		int vendorId = Integer.parseInt(objRequest.getParameter("vendorId"));
		String couponcodeId = objRequest.getParameter("couponcodeId");
		String userId = objRequest.getParameter("userId1");
		System.out.println("couponcodeId...." + couponcodeId);
		NeighbourhoodUtil objNeighbourhoodUtil = new NeighbourhoodUtil();

		OrderInfo1 orderInfo = new OrderInfo1();
		String generatedOrderId = objNeighbourhoodUtil.randNum();
		orderInfo.setGeneratedId(generatedOrderId);
		orderInfo.setContactNumber(contactNumber);
		orderInfo.setContactEmail(contactEmail);
		orderInfo.setDescription(description);
		orderInfo.setAddress(contactAddress);
		orderInfo.setServiceId(serviceId);
		orderInfo.setLocationId(locationId);
		orderInfo.setStatusId(AuroConstants.ordered);
		orderInfo.setAppointmentDate(aptDate);
		orderInfo.setAppointmentSlotId(timeId);
		orderInfo.setVendorId(vendorId);
		orderInfo.setCouponCode(couponcodeId);
		int count = orderInfo1Dao.getCustomerInfo(orderInfo.getContactNumber());
			Users objUsers=new Users();
			objUsers.setName("aurospace");
			int userid=userDao.getUserId(objUsers);
		
		if(userid != 0){
			orderInfo.setUserId(userid);
		}
		else{
			orderInfo.setUserId(1);
		}
			
		orderInfo1Dao.save(orderInfo);
		OrderStatusLog1 osl1 = new OrderStatusLog1();
		osl1.setOrderId(orderInfo.getId());
		osl1.setStatusId(orderInfo.getStatusId());
		orderStatusLog1Dao.save(osl1);

		// customer discount....'D
		//System.out.println("count----" + count);
		if (count == 0) {
			CustomerDiscount1 customerDiscount1 = new CustomerDiscount1();
			customerDiscount1.setMobileNumber(orderInfo.getContactNumber());
			customerDiscount1.setGeneratedOrderId(orderInfo.getGeneratedId());
			String sPropFilePath = objContext.getRealPath("Resources"
					+ File.separator + "DataBase.properties");
			if (StringUtils.isNotBlank(sPropFilePath)) {
				Properties objProperties = new Properties();
				InputStream objStream = new FileInputStream(sPropFilePath);
				objProperties.load(objStream);
				String sCustomerDiscount = objProperties
						.getProperty("CustomerDiscount");
				customerDiscount1
						.setDiscount(new BigDecimal(sCustomerDiscount));
				cusotmerDiscount.save(customerDiscount1);
			}
		}
		// for sending emails to customer

		Service1 objService1 = service1Dao.getById(serviceId);
		String serviceName = null;
		if (objService1 != null) {
			serviceName = objService1.getName();
			if (StringUtils.isNotBlank(serviceName)) {
				orderInfo.setServiceName(serviceName);
			}
		}
		TimeSlots objTimeSlots = timeSlotsDao.getById(timeId);
		String timeName = null;
		if (objTimeSlots != null) {
			timeName = objTimeSlots.getLabel();
			if (StringUtils.isNotBlank(timeName)) {
				orderInfo.setAppointTimeName(timeName);
			}
		}

		EmailSendingUtil objEmailSendingUtil = new EmailSendingUtil();
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer");
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "admin");
		SMSUtil objSmsUtil = new SMSUtil();
		objSmsUtil.sendSms(objContext, orderInfo, "customer");
		objSmsUtil.sendSms(objContext, orderInfo, "order_admin");

		// System.out.println("CHIDDU SAVING ORDER: " + generatedOrderId);

		return "success";
	}

	@RequestMapping(value = "/bookDoctor")
	public @ResponseBody String bookDoctor(HttpServletRequest objRequest,
			HttpServletResponse objResponse,HttpSession session

	) throws JsonGenerationException, JsonMappingException, IOException,
			AddressException, MessagingException {
		objResponse.setCharacterEncoding("UTF-8");

		int serviceId = Integer.parseInt(objRequest.getParameter("serviceId"));
		int locationId = Integer
				.parseInt(objRequest.getParameter("locationId"));

		String symptomIds = objRequest.getParameter("symptomIds");
		/*
		 * TODO : Above list is a json array, need to convert it and add to
		 * relevant table
		 */

		ArrayList<Integer> symptomIdArray = new Gson().fromJson(symptomIds,
				new TypeToken<ArrayList<Integer>>() {
				}.getType());

		String contactNumber = objRequest.getParameter("contactNumber");
		String contactAddress = objRequest.getParameter("contactAddress");
		String description = objRequest.getParameter("description");
		String contactEmail = objRequest.getParameter("emailId");
		String dateStr = objRequest.getParameter("dateId");
		Date aptDate = MiscUtils.getDate(Integer.parseInt(dateStr));
		int timeId = Integer.parseInt(objRequest.getParameter("timeId"));
		String price = objRequest.getParameter("price");
		String discount = objRequest.getParameter("discount");
		String couponcodeId = objRequest.getParameter("couponcodeId");
		String userId=null;
		NeighbourhoodUtil objNeighbourhoodUtil = new NeighbourhoodUtil();
		OrderInfo1 orderInfo = new OrderInfo1();
		String generatedOrderId = objNeighbourhoodUtil.randNum();
		orderInfo.setGeneratedId(generatedOrderId);
		orderInfo.setContactNumber(contactNumber);
		orderInfo.setContactEmail(contactEmail);
		orderInfo.setDescription(description);
		orderInfo.setAddress(contactAddress);
		orderInfo.setServiceId(serviceId);
		orderInfo.setStatusId(AuroConstants.ordered);
		orderInfo.setLocationId(locationId);
		orderInfo.setAppointmentDate(aptDate);
		orderInfo.setAppointmentSlotId(timeId);
		orderInfo.setTotalPrice(new BigDecimal(price));
		orderInfo.setTotalDiscount(new BigDecimal(discount));
		orderInfo.setNetAmount(NeighbourhoodUtil.getDiscount(price, discount));
		orderInfo.setCouponCode(couponcodeId);
		int count = orderInfo1Dao.getCustomerInfo(orderInfo.getContactNumber());
		
			Users objUsers=new Users();
			objUsers.setName("aurospace");
			int userid=userDao.getUserId(objUsers);
		
		if(userid != 0){
			orderInfo.setUserId(userid);
		}
		else{
			orderInfo.setUserId(1);
		}
		
		orderInfo1Dao.save(orderInfo);

		for (Integer symptom : symptomIdArray) {
			OrderSymptom1 os1 = new OrderSymptom1();
			os1.setGeneratedOrderId(orderInfo.getGeneratedId());
			os1.setOrderId(orderInfo.getId());
			os1.setSymptomId(symptom);
			orderSymptom1Dao.save(os1);
		}
		OrderStatusLog1 osl1 = new OrderStatusLog1();
		osl1.setOrderId(orderInfo.getId());
		osl1.setStatusId(orderInfo.getId());
		osl1.setStatusId(AuroConstants.ordered);
		orderStatusLog1Dao.save(osl1);

		//System.out.println("count----" + count);
		if (count == 0) {
			CustomerDiscount1 customerDiscount1 = new CustomerDiscount1();
			customerDiscount1.setMobileNumber(orderInfo.getContactNumber());
			customerDiscount1.setOrderId(orderInfo.getId());
			String sPropFilePath = objContext.getRealPath("Resources"
					+ File.separator + "DataBase.properties");
			if (StringUtils.isNotBlank(sPropFilePath)) {
				Properties objProperties = new Properties();
				InputStream objStream = new FileInputStream(sPropFilePath);
				objProperties.load(objStream);
				String sCustomerDiscount = objProperties
						.getProperty("CustomerDiscount");
				customerDiscount1
						.setDiscount(new BigDecimal(sCustomerDiscount));
				cusotmerDiscount.save(customerDiscount1);
			}
		}

		Service1 objService1 = service1Dao.getById(serviceId);
		String serviceName = null;
		if (objService1 != null) {
			serviceName = objService1.getName();
			if (StringUtils.isNotBlank(serviceName)) {
				orderInfo.setServiceName(serviceName);
			}
		}
		TimeSlots objTimeSlots = timeSlotsDao.getById(timeId);
		String timeName = null;
		if (objTimeSlots != null) {
			timeName = objTimeSlots.getLabel();
			if (StringUtils.isNotBlank(timeName)) {
				orderInfo.setAppointTimeName(timeName);
			}
		}

		EmailSendingUtil objEmailSendingUtil = new EmailSendingUtil();
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer");
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "admin");
		SMSUtil objSmsUtil = new SMSUtil();
		objSmsUtil.sendSms(objContext, orderInfo, "customer");
		objSmsUtil.sendSms(objContext, orderInfo, "order_admin");
		return "success";
	}

	@RequestMapping(value = "/getCustomerDetails")
	public @ResponseBody int getCustomerDetails(HttpServletRequest objRequest,
			HttpServletResponse objResponse

	) throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		int response = -1;
		return -1;
		// String phoneNo = objRequest.getParameter("phoneNo");
		// Customer1 objCustomer1 = orderInfo1Dao.getCustomer(phoneNo);
		// if (objCustomer1 != null) {
		// responce = objCustomer1.getId();
		// return responce;
		// } else {
		// return responce;
		// }

	}

	/* ------------------------Email algorithm ------------------------- */

	@RequestMapping(value = "/emailIsValid", method = RequestMethod.POST)
	public @ResponseBody Boolean emailIsValid(
			HttpServletRequest objHttpServletRequest) {
		String sResponse = "";
		String email = null;
		boolean isValid = false;
		try {
			email = objHttpServletRequest.getParameter("email");
			//System.out.println("email ::" + email);
			//System.out.println(System.currentTimeMillis());
			if (StringUtils.isNotEmpty(email)) {
				isValid = emailServ.isAddressValid(email);
			}
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("error in getCustomerDetails() " + e.getMessage());
		} finally {
		}
		return isValid;
	}

	/*-------------------Address Lgorithem------------*/
	@RequestMapping(value = "/addressIsValid", method = RequestMethod.POST)
	public @ResponseBody Boolean addressIsValid(
			HttpServletRequest objHttpServletRequest) {
		boolean sResponse = false;
		String address = null;
		int count = 0;
		AddressValidation objAddressValidation = null;
		try {
			address = objHttpServletRequest.getParameter("address");
			//System.out.println("address ::" + address);
			if (StringUtils.isNotEmpty(address)) {
				objAddressValidation = new AddressValidation();
				objAddressValidation.process(address, objContext);
				count = objAddressValidation.getValidity();
				if (count == 1 || count == 2) {
					sResponse = true;
				} else {
					sResponse = false;
				}
			}
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("error in getCustomerDetails() " + e.getMessage());
		} finally {
		}
		return sResponse;
	}

	@RequestMapping(value = "/getPrice")
	public @ResponseBody DoctorType1 getPrice(HttpServletRequest objRequest) {
		int id = Integer.parseInt(objRequest.getParameter("doctorTypesId"));
		return doctorType1Dao.getById(id);
	}

	@RequestMapping(value = "/customerExist")
	public @ResponseBody DiscountBean customerExist(
			HttpServletRequest objRequest, HttpServletResponse objResponse

	) throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		int noOfcustomers = 0;
		DiscountBean objDiscountBean = null;
		String sPropFilePath = objContext.getRealPath("Resources"
				+ File.separator + "DataBase.properties");
		if (StringUtils.isNotBlank(sPropFilePath)) {
			Properties objProperties = new Properties();
			InputStream objStream = new FileInputStream(sPropFilePath);
			objProperties.load(objStream);
			int sCustomerDiscount = Integer.parseInt(objProperties
					.getProperty("CustomerDiscount"));
			int existingCustomerDiscount = Integer.parseInt(objProperties
					.getProperty("existingCustomerDiscount"));
			objDiscountBean = new DiscountBean();
			objDiscountBean.setsCustomerDiscount(sCustomerDiscount);
			objDiscountBean
					.setExistingCustomerDiscount(existingCustomerDiscount);
		}

		String phoneNo = objRequest.getParameter("phoneNo");
		noOfcustomers = orderInfo1Dao.get(phoneNo);
		objDiscountBean.setNoOfcustomers(noOfcustomers);
		return objDiscountBean;
	}

	// subclassing ExceptionHandlerExceptionResolver (see below).
	@ExceptionHandler(Exception.class)
	public String handleError(HttpServletRequest req, Exception exception) {
		// logger.error("Request: " + req.getRequestURL() + " raised " +
		// exception);
		//exception.printStackTrace();
		// ModelAndView mav = new ModelAndView();
		// mav.addObject("exception", exception);
		// mav.addObject("url", req.getRequestURL());
		// mav.setViewName("error");
		return "junk";
	}

	@RequestMapping(value = "/validateCouponcode" )
	public @ResponseBody boolean validateCouponcode(
			HttpServletRequest request) {
		String substring=null;
		Coupon1 objCoupon1 = null;
		boolean	 coupon=false;
		try {
			String serviceId = request.getParameter("serviceId");
			String couponCodeId = request.getParameter("couponcodeId");
			
				if (StringUtils.isNotBlank(couponCodeId)) {

				 coupon =  coupon1Dao.couponweb(couponCodeId,Integer.parseInt(serviceId));

					
			}
		/*if(StringUtils.isNotBlank(objCoupon1.getPercentage())){
			substring = objCoupon1.getPercentage();
		}else{
			substring = null;
		}*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return coupon;
	}
	@RequestMapping(value = "/validateCoupon")
	public @ResponseBody List<CouponCode> validateCoupon(
			HttpServletRequest request) {
		List<CouponCode> list = null;
		try {
			String couponCode = request.getParameter("couponCode");
			if (StringUtils.isNotBlank(couponCode)) {
				list = orderInfo1Dao.validateCoupon(couponCode);
			}
		} catch (Exception e) {
			//e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/vendorDetailsInsert", method = RequestMethod.POST)
	public @ResponseBody String vendorDetailsInsert(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session,
			@RequestParam("oid") int oid,
			/*@RequestParam("regionId") String regionId,*/
			@RequestParam("vendorChargeId") double vendorChargeId,
			@RequestParam("goodsId") double goodsId,
			@RequestParam("marginId") double marginId,
			@RequestParam("hoursId") int hoursId,
			@RequestParam("tchargeId") double tchargeId,
			@RequestParam("novId") int novId,
			@RequestParam("fcId") double fcId,
			@RequestParam("watsappId") String watsappId

	) throws JsonGenerationException, JsonMappingException, IOException,
			AddressException, MessagingException {
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String aurolog = objRequest.getParameter("aurolog");
		String goodsName = objRequest.getParameter("goodsName");
		String gpby = objRequest.getParameter("gpby");
		try{
			double c = (goodsId+vendorChargeId+tchargeId+fcId+marginId);
	        BigDecimal totalPrice = new BigDecimal(c);
			OrderInfo1 orderInfo = orderInfo1Dao.getById(oid);
			orderInfo.setId(oid);
			orderInfo.setGoodsCharge(goodsId);
			orderInfo.setMarginValue(marginId);
			orderInfo.setNoOfHoursWork(hoursId);
			orderInfo.setTransportaionCharge(tchargeId);
			orderInfo.setNoOfVisits(novId);
			orderInfo.setWatsupLocation(watsappId);
			orderInfo.setVendorServiceCharge(vendorChargeId);
			orderInfo.setFixedCharge(fcId);
			orderInfo.setTotalPrice(totalPrice);
			orderInfo.setNetAmount(totalPrice);
			if(StringUtils.isNotEmpty(aurolog)){
			orderInfo.setAuroLog(aurolog);
			AurospacesOrderLog objAurospaceLog =new AurospacesOrderLog();
			objAurospaceLog.setOrderId(orderInfo.getId());
			objAurospaceLog.setUserId(orderInfo.getUserId());
			objAurospaceLog.setAurospacesLog(aurolog);
			auroOrderLog.save(objAurospaceLog);
			}
			if(StringUtils.isNotBlank(goodsName)){
				orderInfo.setGoodsName(goodsName);
			}
			if(StringUtils.isNotBlank(gpby)){
				orderInfo.setGoodPaidBy(gpby);
			}
			orderInfo1Dao.save(orderInfo);
			
			listOrderBeans = orderInfo1Dao.getOrdersByParams(null, null, null, orderInfo.getGeneratedId(), null,null,null,null,null,null,null);
			 if(listOrderBeans != null && listOrderBeans.size() > 0) {
			  objectMapper = new ObjectMapper(); 
			  sJson =objectMapper.writeValueAsString(listOrderBeans);
			  objRequest.setAttribute("newOrderList", sJson);
			  //System.out.println(sJson);
			  }
		}catch(Exception e){
			//e.printStackTrace();
		}
		
				return sJson;
	}
	
	@RequestMapping(value = "/invoiceGenerate",method = RequestMethod.GET)
	public String orderDetailsHome( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		String orderId = objRequest.getParameter("orderId");
		String bookedDate = objRequest.getParameter("bookedDate");
		String userId = objRequest.getParameter("userId");
		int uid = 0;
		if(StringUtils.isNotBlank(userId)){
			uid = Integer.parseInt(userId);
		}
		System.out.println(orderId+" --"+bookedDate+"---"+userId);
		try {
			List<OrderInfo1>  list = orderInfo1Dao.getInvoiceDetails(orderId,bookedDate,uid);
			for (OrderInfo1 order : list) {
				System.out.println(order.getAddress());
				String sPropFilePath = objContext.getRealPath("Resources"
						+ File.separator + "DataBase.properties");
				if (StringUtils.isNotBlank(sPropFilePath)) {
					Properties objProperties = new Properties();
					InputStream objStream = new FileInputStream(sPropFilePath);
					objProperties.load(objStream);
					String servicetax = objProperties.getProperty("serviceTax");
					objSession.setAttribute("servicetax", servicetax);
					String sbses=objProperties.getProperty("sbcease");
					objSession.setAttribute("sbses", sbses);
					String kisantax = objProperties.getProperty("kisantax");
					objSession.setAttribute("kisantax", kisantax);
				}
				
				String houseid=null;
				String house=null;
				if(order.getOwnername()!=null){
				 houseid=order.getOwnername();
				 int intIndex = houseid.indexOf("(");
				 if(intIndex != -1){
				 house=houseid.substring(houseid.indexOf('('));
				 }
				}
				if(house!=null){
				objSession.setAttribute("houseId", house);
				}else{
					
					objSession.setAttribute("houseId", "");
				}
			objSession.setAttribute("orderId", order.getOrderId());
			objSession.setAttribute("totalPrice", order.getTotalPrice());
			System.out.println(String.valueOf(order.getTotalDiscount()));
			if(String.valueOf(order.getTotalDiscount()) != "null"){
				objSession.setAttribute("totalDiscount", order.getTotalDiscount());
			}else{
				objSession.setAttribute("totalDiscount", "0.00");
			}
			
			
			objSession.setAttribute("userId", order.getUserId());
			objSession.setAttribute("address", order.getAddress());
			objSession.setAttribute("fixedCharge", order.getFixedCharge());
			objSession.setAttribute("goodscharge", order.getGoodsCharge());
			if(StringUtils.isNotBlank(order.getGoodsName())){
			objSession.setAttribute("goodsDiscription", order.getGoodsName());
			}else{
			objSession.setAttribute("goodsDiscription", "---");
			}
			objSession.setAttribute("vendorServiceCharge", order.getVendorServiceCharge());
			objSession.setAttribute("transportaionCharge", order.getTransportaionCharge());
			objSession.setAttribute("marginValue", order.getMarginValue());
			objSession.setAttribute("serviceName", order.getServiceName());
			objSession.setAttribute("bookedDate", order.getBookedDate());
			objSession.setAttribute("completionDate", order.getCompletionDate());
			objSession.setAttribute("serviceName", order.getServiceName());
			objSession.setAttribute("invoiceId", order.getId());
			objSession.setAttribute("clientId", order.getClientOrderId());
			objSession.setAttribute("customerName", order.getCustomerName());
			objSession.setAttribute("userName", order.getUserName());
			objSession.setAttribute("displayName", order.getDisplayName());
			System.out.println(order.getBillingto());
			System.out.println(order.getCustomerName());
			if(StringUtils.isNotBlank(order.getBillingto())){
				objSession.setAttribute("billingTo", order.getBillingto());
			}else{
				objSession.setAttribute("billingTo", "null");
			}
			if(StringUtils.isNotBlank(order.getDescription())){
				objSession.setAttribute("description", order.getDescription());
			}else{
				objSession.setAttribute("description", order.getServiceName());
			}
			if(StringUtils.isNotBlank(order.getOwnername())){
				objSession.setAttribute("ownerName", order.getOwnername());
			}else{
				objSession.setAttribute("ownerName","null");
			}
			if(order.getInvoiceDate().toString() != null){
				objSession.setAttribute("invoiceDate", order.getInvoiceDate());
			}else{
				objSession.setAttribute("invoiceDate", order.getCompletionDate());
			}
			
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		return "totalNetAmoutnt";
	}
	
	@RequestMapping(value = "/vendorInvoice",method = RequestMethod.GET)
	public String vendorInvoice( HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		String orderId = objRequest.getParameter("orderId");
		String bookedDate = objRequest.getParameter("bookedDate");
		String userId = objRequest.getParameter("userId");
		int uid = 0;
		if(StringUtils.isNotBlank(userId)) {
			uid = Integer.parseInt(userId);
		}
		System.out.println(orderId+" --"+bookedDate+"---"+userId);
		try {
			List<OrderInfo1>  list = orderInfo1Dao.getInvoiceDetails(orderId,bookedDate,uid);
			for (OrderInfo1 order : list) {
				System.out.println(order.getAddress());
				String sPropFilePath = objContext.getRealPath("Resources"
						+ File.separator + "DataBase.properties");
				if (StringUtils.isNotBlank(sPropFilePath)) {
					Properties objProperties = new Properties();
					InputStream objStream = new FileInputStream(sPropFilePath);
					objProperties.load(objStream);
					String servicetax = objProperties.getProperty("serviceTax");
					objSession.setAttribute("servicetax", servicetax);
					String sbses=objProperties.getProperty("sbcease");
					objSession.setAttribute("sbses", sbses);
					String kisantax = objProperties.getProperty("kisantax");
					objSession.setAttribute("kisantax", kisantax);
				}
				objSession.removeAttribute("orderId");
				String houseid=null;
				String house=null;
				if(order.getOwnername()!=null){
				 houseid=order.getOwnername();
				 int intIndex = houseid.indexOf("(");
				 if(intIndex != -1){
				 house=houseid.substring(houseid.indexOf('('));
				 }
				}
				if(house!=null){
				objSession.setAttribute("houseId", house);
				}else{
					
					objSession.setAttribute("houseId", "");
				}
			objSession.setAttribute("orderId", order.getOrderId());
			objSession.setAttribute("address", order.getAddress());
			objSession.setAttribute("fixedCharge", order.getFixedCharge());
			objSession.setAttribute("goodscharge", order.getGoodsCharge());
			objSession.setAttribute("vendorServiceCharge", order.getVendorServiceCharge());
			objSession.setAttribute("transportaionCharge", order.getTransportaionCharge());
			objSession.setAttribute("marginValue", order.getMarginValue());
			objSession.setAttribute("serviceName", order.getServiceName());
			objSession.setAttribute("bookedDate", order.getBookedDate());
			objSession.setAttribute("serviceDate", order.getAppointmentDate());
			objSession.setAttribute("serviceName", order.getServiceName());
			objSession.setAttribute("invoiceId", order.getId());
			objSession.setAttribute("clientId", order.getClientOrderId());
			objSession.setAttribute("customerName", order.getCustomerName());
			objSession.setAttribute("userName", order.getUserName());
			objSession.setAttribute("vendoraddress", order.getVendoraddress());
			objSession.setAttribute("vendorName", order.getVendorName());
			objSession.setAttribute("noOfHoursWork", order.getNoOfHoursWork());
			objSession.setAttribute("vendorServiceCharge", order.getVendorServiceCharge());
			System.out.println(order.getBillingto());
			System.out.println(order.getCustomerName());
			if(StringUtils.isNotBlank(order.getBillingto())){
				objSession.setAttribute("billingTo", order.getBillingto());
			}else{
				objSession.setAttribute("billingTo", "null");
			}
			if(StringUtils.isNotBlank(order.getOwnername())){
				objSession.setAttribute("ownerName", order.getOwnername());
			}else{
				objSession.setAttribute("ownerName","null");
			}
			if(StringUtils.isNotBlank(order.getAccountNumber())){
				objSession.setAttribute("accountNumber", order.getAccountNumber());
			}else{
				objSession.setAttribute("accountNumber", "null");
			}
			if(StringUtils.isNotBlank(order.getBankName())){
				objSession.setAttribute("bankName", order.getBankName());
			}else{
				objSession.setAttribute("bankName", "null");
			}
			if(StringUtils.isNotBlank(order.getIfscCode())){
				objSession.setAttribute("ifscCode", order.getIfscCode());
			}else{
				objSession.setAttribute("ifscCode", "null");
			}
			if(StringUtils.isNotBlank(order.getBranchName())){
				objSession.setAttribute("branchName", order.getBranchName());
			}else{
				objSession.setAttribute("branchName", "null");
			}
			objSession.removeAttribute("orderId");
			
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		return "vendorInvoice";
	}
	
	@RequestMapping(value = "/MonthlyReports")
	public @ResponseBody String dbtocsv(
			HttpServletRequest request,HttpServletResponse response) {
		List<Reports> list = null;
		String filename ="MonthlyOrederReport.csv";
		try {
			FileWriter fw = new FileWriter(filename);
				list = orderInfo1Dao.monthlyReport();
				System.out.println(list.size());
				fw.append("Count");
				fw.append(',');
				fw.append("SumAmount");
				fw.append(',');
				fw.append("Month");
				fw.append(',');
				fw.append("Year");
				fw.append('\n');
				for(int i=0;i<list.size();i++){
					fw.append( list.get(i).getCount());
					fw.append(',');
					fw.append( list.get(i).getSumofNetAmount());
					fw.append(',');
					fw.append( list.get(i).getMonthName());
					fw.append(',');
					fw.append( list.get(i).getYear());
					fw.append('\n');
				}
				 fw.flush();
		         fw.close();
		         String baseUrl = MiscUtils.getBaseUrl(request);
		 		System.out.println(baseUrl);
		 		response.sendRedirect(baseUrl+"/DownloadFileServlet?Name="+filename );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	@RequestMapping(value = "/clientMonthlyReport1")
	public @ResponseBody String clientMonthlyReport1(
			HttpServletRequest request,HttpServletResponse response) {
		List<Reports> list = null;
		String filename ="clientMonthlyReport1.csv";
		try {
			FileWriter fw = new FileWriter(filename);
				list = orderInfo1Dao.clientReport();
				System.out.println(list.size());
				fw.append("ClientName");
				fw.append(',');
				fw.append("Count");
				fw.append(',');
				fw.append("SumAmount");
				fw.append(',');
				fw.append("Month");
				fw.append(',');
				fw.append("Year");
				fw.append('\n');
				for(int i=0;i<list.size();i++){
					fw.append( list.get(i).getClientNmae());
					fw.append(',');
					fw.append( list.get(i).getCount());
					fw.append(',');
					fw.append( list.get(i).getSumofNetAmount());
					fw.append(',');
					fw.append( list.get(i).getMonthName());
					fw.append(',');
					fw.append( list.get(i).getYear());
					fw.append('\n');
				}
				 fw.flush();
		         fw.close();
		         String baseUrl = MiscUtils.getBaseUrl(request);
		 		System.out.println(baseUrl);
		 		response.sendRedirect(baseUrl+"/DownloadFileServlet?Name="+filename );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	@RequestMapping(value = "/serviceMonthlyReport")
	public @ResponseBody String serviceMonthlyReport(
			HttpServletRequest request,HttpServletResponse response) {
		List<Reports> list = null;
		String filename ="serviceMonthlyReport.csv";
		try {
			FileWriter fw = new FileWriter(filename);
				list = orderInfo1Dao.monthlyServiceReport();
				System.out.println(list.size());
				fw.append("ServiceName");
				fw.append(',');
				fw.append("Count");
				fw.append(',');
				fw.append("SumAmount");
				fw.append(',');
				fw.append("Month");
				fw.append(',');
				fw.append("Year");
				fw.append('\n');
				for(int i=0;i<list.size();i++){
					fw.append( list.get(i).getServiceName());
					fw.append(',');
					fw.append( list.get(i).getCount());
					fw.append(',');
					fw.append( list.get(i).getSumofNetAmount());
					fw.append(',');
					fw.append( list.get(i).getMonthName());
					fw.append(',');
					fw.append( list.get(i).getYear());
					fw.append('\n');
				}
				 fw.flush();
		         fw.close();
		         String baseUrl = MiscUtils.getBaseUrl(request);
		 		System.out.println(baseUrl);
		 		response.sendRedirect(baseUrl+"/DownloadFileServlet?Name="+filename );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	@RequestMapping(value = "/vendorMonthlyReport")
	public @ResponseBody String vendorMonthlyReport(
			HttpServletRequest request,HttpServletResponse response) {
		List<Reports> list = null;
		String filename ="vendorMonthlyReport.csv";
		try {
			 
			FileWriter fw = new FileWriter(filename);
			
				list = orderInfo1Dao.monthlyVendorReport();
				fw.append("VendorName");
				fw.append(',');
				fw.append("Count");
				fw.append(',');
				fw.append("SumAmount");
				fw.append(',');
				fw.append("Month");
				fw.append(',');
				fw.append("Year");
				fw.append('\n');
				System.out.println(list.size());
				for(int i=0;i<list.size();i++){
					fw.append( list.get(i).getVendorName());
					fw.append(',');
					fw.append( list.get(i).getCount());
					fw.append(',');
					fw.append( list.get(i).getSumofNetAmount());
					fw.append(',');
					fw.append( list.get(i).getMonthName());
					fw.append(',');
					fw.append( list.get(i).getYear());
					fw.append('\n');
				}
				 fw.flush();
		         fw.close();
		         String baseUrl = MiscUtils.getBaseUrl(request);
		 		System.out.println(baseUrl);
		 		response.sendRedirect(baseUrl+"/DownloadFileServlet?Name="+filename );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	@RequestMapping(value="/customerBankDetail")
	
	public  String customerBankDetails(@ModelAttribute("trancationCmd") AurospacesTransactions aurospacesTransactions,
			HttpServletRequest request,HttpServletResponse response) {
		 List<Map<String,String>> listOrderBeans = orderInfo1Dao.getAuroTransactionDetails();
		ObjectMapper objectMapper = null;
		String sJson = null;
		try{
			 objectMapper = new ObjectMapper();
			  sJson =objectMapper.writeValueAsString(listOrderBeans);
			 
			  if(listOrderBeans == null){
				  request.setAttribute("transactionList", "null");
				}else{
			  request.setAttribute("transactionList", sJson);
				}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "customerBankDetails";
	}
@RequestMapping(value="/customerBankDetail1")
	
	public @ResponseBody  String customerBankDetails1(
			HttpServletRequest request,HttpServletResponse response) {
	String accholderName=null;
	String accountNumber=null;
	String bankNameId=null;
	String branchNameId=null;
	String ifscCodeId=null;
	String dateId=null;
	String amountid=null;
	String id = null;
	ObjectMapper objectMapper = null;
	String sJson = null;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	AurospacesTransactions aurospacesTransactions= null;
		try{
		 accholderName= 	request.getParameter("accholderName");
		 accountNumber= 	request.getParameter("accountNumber");
		 bankNameId= 	request.getParameter("bankNameId");
		 branchNameId= 	request.getParameter("branchNameId");
		 ifscCodeId= 	request.getParameter("ifscCodeId");
		 amountid=request.getParameter("amountid");
		 dateId= 	request.getParameter("dateId");
		 id = request.getParameter("id");
		 
		 if(id.equals("0")){
			 aurospacesTransactions = new AurospacesTransactions(); 
		 }else{
			 aurospacesTransactions = aurospacesTransactionsDao.getById(Integer.parseInt(id));
		 }
		 if(StringUtils.isNotBlank(accholderName)){
			 aurospacesTransactions.setVendorId(Integer.parseInt(accholderName));
		 }
		 if(StringUtils.isNotBlank(accountNumber)){
			 aurospacesTransactions.setAcNumber(Integer.parseInt(accountNumber));
		 }
		 if(StringUtils.isNotBlank(bankNameId)){
			 aurospacesTransactions.setBankName(bankNameId);
		 }
		 if(StringUtils.isNotBlank(branchNameId)){
			 aurospacesTransactions.setBranchName(branchNameId);
		 }
		 if(StringUtils.isNotBlank(ifscCodeId)){
			 aurospacesTransactions.setIfscCode(ifscCodeId);
		 }
		 if(StringUtils.isNotBlank(amountid)){
			 aurospacesTransactions.setAmount(Integer.parseInt(amountid));
		 }
		 if(StringUtils.isNotBlank(dateId)){
			 Date date=formatter.parse(dateId);
			 aurospacesTransactions.setTransactionDate(date);
		 }
		 aurospacesTransactionsDao.save(aurospacesTransactions);
		 
		 List<Map<String,String>> listOrderBeans = orderInfo1Dao.getAuroTransactionDetails();
		 objectMapper = new ObjectMapper(); 
		  sJson =objectMapper.writeValueAsString(listOrderBeans);
		}catch(Exception e){
			
		}
		return sJson;
	}
@ModelAttribute("vendornames")
public Map<String, String> populatevendorsname() {
	Map<String, String> vendorstatus = null;
	
	 StringBuffer objStringBuffer = new StringBuffer();
	try {
		objStringBuffer.append(" select id,concat_ws(' ',first_name,last_name) as vendorId from vendor1 ");
		String sSql = objStringBuffer.toString();
		vendorstatus = objPopulateService.populatePopUp(sSql);
	} catch (Exception e) {
		//e.printStackTrace();
	} finally {
	}
	return vendorstatus;
}
@ModelAttribute("users")
public Map<String, String> populateUsers() {
	Map<String, String> users = null;
	 StringBuffer objStringBuffer = new StringBuffer();
	try {
		objStringBuffer.append(" select id, name from users ");
		String sSql = objStringBuffer.toString();
		users = objPopulateService.populatePopUp(sSql);
	} catch (Exception e) {
		//e.printStackTrace();
	} finally {
	}
	return users;
}

@RequestMapping(value="/clientTransaction")

public  String clientTransaction(@ModelAttribute("clientTransactionCmd") ClientTransactions clientTransactions,
		HttpServletRequest request,HttpServletResponse response) {
	 List<Map<String,String>> listOrderBeans = clientTransactionsDao.getClientTransaction();
	ObjectMapper objectMapper = null;
	String sJson = null;
	try{
		 objectMapper = new ObjectMapper();
		  sJson =objectMapper.writeValueAsString(listOrderBeans);
		 
		  if(listOrderBeans == null){
			  request.setAttribute("transactionList", "null");
			}else{
		  request.setAttribute("transactionList", sJson);
			}
	}catch(Exception e){
		e.printStackTrace();
	}
	return "clientTransactionHome";
}
@RequestMapping(value="/saveClientBankDetails")

public @ResponseBody  String saveClientBankDetails(
		HttpServletRequest request,HttpServletResponse response) {
String accholderName=null;
String accountNumber=null;
String bankNameId=null;
String branchNameId=null;
String ifscCodeId=null;
String dateId=null;
String amountid=null;
String id = null;
ObjectMapper objectMapper = null;
String sJson = null;
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
ClientTransactions clientTransactions= null;
	try{
	 accholderName= 	request.getParameter("accholderName");
	 accountNumber= 	request.getParameter("accountNumber");
	 bankNameId= 	request.getParameter("bankNameId");
	 branchNameId= 	request.getParameter("branchNameId");
	 ifscCodeId= 	request.getParameter("ifscCodeId");
	 amountid=request.getParameter("amountid");
	 dateId= 	request.getParameter("dateId");
	 id = request.getParameter("id");
	 
	 if(id.equals("0")){
		 clientTransactions = new ClientTransactions(); 
	 }else{
		 clientTransactions = clientTransactionsDao.getById(Integer.parseInt(id));
	 }
	 if(StringUtils.isNotBlank(accholderName)){
		 clientTransactions.setClientId(Integer.parseInt(accholderName));
	 }
	 if(StringUtils.isNotBlank(accountNumber)){
		 clientTransactions.setAcNumber(Integer.parseInt(accountNumber));
	 }
	 if(StringUtils.isNotBlank(bankNameId)){
		 clientTransactions.setBankName(bankNameId);
	 }
	 if(StringUtils.isNotBlank(branchNameId)){
		 clientTransactions.setBranchName(branchNameId);
	 }
	 if(StringUtils.isNotBlank(ifscCodeId)){
		 clientTransactions.setIfscCode(ifscCodeId);
	 }
	 if(StringUtils.isNotBlank(amountid)){
		 clientTransactions.setAmount(Integer.parseInt(amountid));
	 }
	 if(StringUtils.isNotBlank(dateId)){
		 Date date=formatter.parse(dateId);
		 clientTransactions.setTransactionDate(date);
	 }
	 clientTransactionsDao.save(clientTransactions);
	 
	 List<Map<String,String>> listOrderBeans = clientTransactionsDao.getClientTransaction();
	 objectMapper = new ObjectMapper(); 
	  sJson =objectMapper.writeValueAsString(listOrderBeans);
	}catch(Exception e){
		
	}
	return sJson;
}
}
