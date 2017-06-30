package com.aurospaces.neighbourhood.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.db.dao.AurospacesOrderLogDao;
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
import com.aurospaces.neighbourhood.db.dao.UserDao;
import com.aurospaces.neighbourhood.db.model.CustomerDiscount1;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.OrderServiceUnit1;
import com.aurospaces.neighbourhood.db.model.OrderStatusLog1;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.ServiceUnit1;
import com.aurospaces.neighbourhood.db.model.TimeSlots;
import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service1.EmailValidationSrv;
import com.aurospaces.neighbourhood.util.AuroConstants;
import com.aurospaces.neighbourhood.util.EmailSendingUtil;
import com.aurospaces.neighbourhood.util.MessageSender;
import com.aurospaces.neighbourhood.util.MiscUtils;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.aurospaces.neighbourhood.util.SMSUtil;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
public class BulkBookig {
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
	EmailValidationSrv emailServ;

	@Autowired
	OrderStatusLog1Dao orderStatusLog1Dao;
	@Autowired
	ServiceUnit1Dao serviceUnitDao;
	@Autowired
	OrderServiceUnit1Dao orderServiceUnit1Dao;
	@Autowired
	TimeSlotsDao timeSlotsDao;
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
	@Autowired UserDao userDao;	
	@RequestMapping(value = "/bulkbooking", method = RequestMethod.GET)
	public String homeServices(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session) {
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getOrdersByParams(null,null,null,null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
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
		//System.out.println("DOES THIS COME HERE ");
		return "bulkbookingHome";
	}
	
	
	
	@ModelAttribute("users")
	public Map<String, String> populateUsers() {
		Map<String, String> users = null;
		try {
			String sSql = "select id, name from users";
			users = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return users;
	}

	@ModelAttribute("services")
	public Map<String, String> populateServices() {

		return service1Dao.getServicesAsMap();
	}

	
	@RequestMapping(value = "/bulkBookingOrder", method = RequestMethod.POST)
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
		boolean admin = Boolean.parseBoolean(objRequest.getParameter("admin"));
		String cname = objRequest.getParameter("cname");
		String userId = objRequest.getParameter("userId1");
		String sdiscription = objRequest.getParameter("sdiscription");
		String priorityId = objRequest.getParameter("priorityId");
		String wlocationId = objRequest.getParameter("wlocationId");
		String clientOrderId = objRequest.getParameter("clientOrderId");
		String startdate = objRequest.getParameter("startDateId");
		String enddate = objRequest.getParameter("endDateId");
		String dayId=objRequest.getParameter("selectdayId");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate1 = formatter.parse(startdate);
            Date endDate1 = formatter.parse(enddate);

            Calendar start = Calendar.getInstance();
            start.setTime(startDate1);
            Calendar end = Calendar.getInstance();
            end.setTime(endDate1);
           
            OrderInfo1 orderInfo = null;
    for (Date date = start.getTime(); start.before(end); start.add(Calendar.DATE, 1), date = start.getTime()) {
    	   orderInfo = new OrderInfo1();
              String  dt = formatter.format(date);
              Date appointmentdate = formatter.parse(dt);
              //System.out.println(appointmentdate);
              
              Calendar calendar = Calendar.getInstance();
              calendar.setTime(appointmentdate);
    		  int day = calendar.get(Calendar.DAY_OF_WEEK); 
              JSONArray jsonarry = new JSONArray(dayId);
              if(dayId!=""){
            	  for(int i=0;i< jsonarry.length();i++){
            		  if(Integer.parseInt(jsonarry.getString(i))== day){
            			  
            			  //System.out.println(objRequest.getParameter("admin"));
            				Properties prop = new Properties();
            				InputStream input = null;
            				int vendorId = 0;
            				Date aptDate = null;
            				NeighbourhoodUtil objNeighbourhoodUtil = new NeighbourhoodUtil();
            				String propertiespath = objContext.getRealPath("Resources"
            						+ File.separator + "DataBase.properties");
            				// String propertiespath = "C:\\PRO\\Database.properties";
            				input = new FileInputStream(propertiespath);
            				// load a properties file
            				prop.load(input);
            				String couponcode = prop.getProperty("couponcode");
            				if (couponcodeId.equals(couponcode)) {
            					totalNetAmount = BigDecimal.valueOf(0);
            					totalPrice = BigDecimal.valueOf(0);
            					totalDiscount = BigDecimal.valueOf(0);
            				}
            				if(!admin){
            				 aptDate = MiscUtils.getDate(Integer.parseInt(dateId));
            				 orderInfo.setAppointmentDate(aptDate);
            				}else {
            					//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            					//Date date1 = formatter.parse(dateId);
            					 orderInfo.setAppointmentDate(appointmentdate);
            					//aptDate =objNeighbourhoodUtil.getCurrentTimestamp(dateId);
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
            				orderInfo.setTotalPrice((totalPrice));
            				orderInfo.setAppointmentSlotId(timeId);
            				orderInfo.setLocationId(locationId);
            				if (StringUtils.isNotBlank(couponcodeId)) {
            					orderInfo.setCouponCode(couponcodeId);
            				}
            				if(StringUtils.isEmpty(userId)){
            				LoginBean loginBean = (LoginBean)session.getAttribute("cacheUserBean");
            				if(loginBean != null && loginBean.getUserId() != null){
            					orderInfo.setUserId(Integer.parseInt(loginBean.getUserId()));
            				}
            				}else{
            					orderInfo.setUserId(Integer.parseInt(userId));
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
            					for (int j = 0; j < objAsonArray.size(); j++) {
            						JsonObject objJsonObject = (JsonObject) objAsonArray.get(j);
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
            				if (!admin) {
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

            			  
            		  }
            		  
            	  }
              } 
              /*String dayNames[] = new DateFormatSymbols().getWeekdays();
              Calendar date2 = Calendar.getInstance();
              start.setTime(appointmentdate);
              System.out.println("Today is a " 
                + dayNames[date2.get(Calendar.DAY_OF_WEEK)]);*/
		
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
			listOrderBeans = orderInfo1Dao.getOrdersByParams(null,null,null,null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders2", sJson);
				  //System.out.println(sJson); 
			}
		return "success";
	}

}
//33430787468 SBI sbin0000811
