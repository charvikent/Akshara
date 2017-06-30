package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.db.dao.AurospacesOrderLogDao;
import com.aurospaces.neighbourhood.db.dao.CouponDao;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderStatusLog1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.StatusListDao;
import com.aurospaces.neighbourhood.db.dao.TimeSlotsDao;
import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.aurospaces.neighbourhood.db.model.CouponCode;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.OrderStatusLog1;
import com.aurospaces.neighbourhood.db.model.TimeSlots;
import com.aurospaces.neighbourhood.db.model.Vendor1;
import com.aurospaces.neighbourhood.service.AdminOrderService;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service.VendorRegisrationService;
import com.aurospaces.neighbourhood.util.AuroConstants;
import com.aurospaces.neighbourhood.util.EmailSendingUtil;
import com.aurospaces.neighbourhood.util.MiscUtils;
import com.aurospaces.neighbourhood.util.SMSUtil;
import com.google.gson.Gson;

@Controller
public class AdminOrderController {

	private Logger logger = Logger.getLogger(AdminOrderController.class);
	@Autowired
	AdminOrderService objAdminOrderService;
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	VendorRegisrationService objVendorRegisrationService;

	@Autowired
	OrderInfo1Dao orderInfo1Dao;

	@Autowired
	StatusListDao statusListDao;

	@Autowired
	OrderStatusLog1Dao orderStatusLog1Dao;

	@Autowired
	TimeSlotsDao timeSlotsDao;
	@Autowired
	Service1Dao service1Dao;
	@Autowired
	ServletContext objContext;
	@Autowired
	Vendor1Dao vendor1Dao;
	@Autowired CouponDao couponDao;
	@Autowired HttpSession session;
	@Autowired AurospacesOrderLogDao auroOrderLog;
	@RequestMapping(value = "/adminOrderHome", method = RequestMethod.GET)
	public String orderDetailsHome(@ModelAttribute("adminCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		List<OrderInfo1> listLogs = null;
		try {
			objRequest.setAttribute("AdminOrderActive", "active");
			listOrderBeans = orderInfo1Dao.getOrdersByParams(null,null,null,null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  objRequest.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
			/*
			 * listOrderBeans = objAdminOrderService.getOrders(objOrderBean); if
			 * (listOrderBeans != null && listOrderBeans.size() > 0) {
			 * objectMapper = new ObjectMapper(); sJson =
			 * objectMapper.writeValueAsString(listOrderBeans);
			 * objRequest.setAttribute("orderListJson", sJson);
			 * System.out.println(sJson); }
			 */
			objSession.setAttribute("tabName", "AdminOrders");
			listLogs = new ArrayList<OrderInfo1>();
			objRequest.setAttribute("orderLog", listLogs);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
			e.printStackTrace();
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "adminOrderHome";
	}
	@RequestMapping(value = "/newadminHome", method = RequestMethod.GET)
	public String orderHome(@ModelAttribute("adminCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession, HttpServletResponse objResponse)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try {
			objRequest.setAttribute("NewOrderActive", "active");

			
			 listOrderBeans = orderInfo1Dao.getOrdersByParams(null, null, null, null, null,null,null,null,null,null,null);
			 if(listOrderBeans != null && listOrderBeans.size() > 0) {
			  objectMapper = new ObjectMapper(); 
			  sJson =objectMapper.writeValueAsString(listOrderBeans);
			  objRequest.setAttribute("newOrderList", sJson);
			 // System.out.println(sJson); 
			  }
			 
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  OadminOrderHomerder controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "newadminHome";
	}
	
	@ModelAttribute("users")
	public Map<String, String> populateUsers() {
		Map<String, String> users = null;
		 LoginBean loginBean = (LoginBean)session.getAttribute("cacheUserBean");
		 StringBuffer objStringBuffer = new StringBuffer();
		try {
			objStringBuffer.append(" select id, name from users ");
			if(loginBean != null){
			if(loginBean.getLocationId() != 0){
				 objStringBuffer.append(" where location_id ="+loginBean.getLocationId());
			 }else{
				 objStringBuffer.append(" where location_id  in(select id from location1)");
			 }
			}
			String sSql = objStringBuffer.toString();
			users = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return users;
	}
	
	@ModelAttribute("vendorServicebased")
	public String populateVendors() {
		Map<Integer, String> listAuroLog =null;
		String sJson = " ";
		ObjectMapper objectMapper = null;
		try {
			 objectMapper = new ObjectMapper(); 
				 listAuroLog = orderInfo1Dao.getAllVendors1();
				 sJson =objectMapper.writeValueAsString(listAuroLog);
				 //System.out.println(sJson);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return sJson;
	}
	
	
	
	
	@ModelAttribute("venstatus")
	public Map<String, String> populatevendorstatus() {
		Map<String, String> vendorstatus = null;
		try {
			String sSql = "select id, statusname from vendor_status";
			vendorstatus = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return vendorstatus;
	}
	@ModelAttribute("vendornames")
	public Map<String, String> populatevendorsname() {
		Map<String, String> vendorstatus = null;
		
		 LoginBean loginBean = (LoginBean)session.getAttribute("cacheUserBean");
		 StringBuffer objStringBuffer = new StringBuffer();
		try {
			objStringBuffer.append(" select id,concat_ws(' ',first_name,last_name) as name from vendor1 ");
			if(loginBean != null){
			if(loginBean.getLocationId() != 0){
				 objStringBuffer.append(" where serving_city ="+loginBean.getLocationId());
			 }
			}
			String sSql = objStringBuffer.toString();
		
			vendorstatus = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return vendorstatus;
	}
	// @ModelAttribute("vendors")
	// public Map<String, String> populateVendor() {
	// return vendor1Dao.getVendorNamesAsMap();
	// }
	//
	// @ModelAttribute("timeSlots")
	// public Map<String,String> getTimeSlots() {
	// return timeSlotsDao.getTimeSlotsAsMap();
	// }

	@ModelAttribute("vendors")
	public String populateVendor() {
		Gson gson = new Gson();
		return gson.toJson(vendor1Dao.getVendorNamesAsMap());
	}

	/*@ModelAttribute("timeSlots")
	public String getTimeSlots() {
		Gson gson = new Gson();
		return gson.toJson(timeSlotsDao.getTimeSlotsAsMap());
	}*/
	
	@ModelAttribute("timeSlots")
	public Map<String, String> populApointDate() {
		return statusListDao.getApointmentDateMap();
	}
	@ModelAttribute("status")
	public Map<String, String> populateStatus() {
		return statusListDao.getStatusesAsMap();
	}
	

	@RequestMapping(value = "/forStatus")
	public @ResponseBody List<Map<String, String>> forStatus(HttpServletRequest objRequest,
			HttpServletResponse objResponse)

	throws JsonGenerationException, JsonMappingException, IOException {
		return statusListDao.getAllStatuses();
	}

	@RequestMapping(value = "/forVendor")
	public @ResponseBody List<Map<String, String>> forVendor(HttpServletRequest objRequest,
			HttpServletResponse objResponse, @RequestParam("serviceId") int serviceId)
					throws JsonGenerationException, JsonMappingException, IOException {
		return vendor1Dao.getVendorsForServices(serviceId);
	}

	@RequestMapping(value = "/orderDetails")
	public @ResponseBody List<OrderInfo1> orderDetails(@ModelAttribute("adminCmd") OrderInfo1 objOrderBean,

	HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession session)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		List<OrderInfo1> listpathologyBean = null;
		String sOrderId = null;
		try {
			sOrderId = objRequest.getParameter("orderId");
			//System.out.println("orderId  " + sOrderId);
			objOrderBean.setGeneratedId(sOrderId);
			objRequest.setAttribute("AdminOrderActive", "active");
			listpathologyBean = orderInfo1Dao.getPathologyOrder(objOrderBean);
			if (listpathologyBean != null && listpathologyBean.size() > 0) {
				OrderInfo1 orderInfo1 = orderInfo1Dao.getByGeneratedId(sOrderId);
				if(orderInfo1 != null){ 
					List<OrderInfo1> listClientLog = orderInfo1Dao.getOrderClinetLog(orderInfo1.getId());
					
					if (listClientLog != null && listClientLog.size() > 0) {
						for(OrderInfo1 obj1 : listpathologyBean){
							obj1.setListClientOrder(listClientLog);
						}
					}
					
					List<OrderInfo1> listAuroLog = orderInfo1Dao.getOrderAuroLog(orderInfo1.getId());
					
					
					if (listAuroLog != null && listAuroLog.size() > 0) {
						for(OrderInfo1 obj1 : listpathologyBean){
							obj1.setListAuroOrder(listAuroLog);
						}
					}
				}
			}
			objSession.setAttribute("tabName", "AdminOrders");
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  AdminOrder controller");
		} finally {
		}
		return listpathologyBean;
	}

/* Please  avoid writing functions where you create a Vendor object, fill a parameter or
two and then try and fetch another Vendor object . There is already a function to get vendor
by Id, why write another*/
	@RequestMapping(value = "/vendorDetails")
	public @ResponseBody Vendor1 vendorDetails(HttpServletRequest objRequest)
					throws JsonGenerationException, JsonMappingException, IOException {
		
		Vendor1 v1 = null;
		try {
			int iVendor = Integer.parseInt(objRequest.getParameter("vendorId"));
			//System.out.println("vendor ID" + iVendor);
			 v1 = vendor1Dao.getById(iVendor);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		return v1;
	}
	/* new code CHIDDU added to fulfil order conditions */

	@RequestMapping(value = "/getServiceOrders")
	public @ResponseBody List<Map<String, String>> getServiceOrders(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		String phoneNo = objRequest.getParameter("phoneNo");
		String emailId = objRequest.getParameter("emailId");
		String orderId = objRequest.getParameter("orderId");
		String status = objRequest.getParameter("statusId");
		String sid=objRequest.getParameter("serviceId");
		String userId=objRequest.getParameter("userId");
		String clientId=objRequest.getParameter("clientId");
		String startDate = objRequest.getParameter("startDate");
		String endDate =objRequest.getParameter("endDate");
		String vendorId =objRequest.getParameter("vendorId");
		String vendorstatusId =objRequest.getParameter("vendorstatusId");
		String orderId1 ="";
		String clientId1 ="";
		String emailId1 ="";
		if(StringUtils.isNotBlank(orderId)){
		String[] array = orderId.split(",");
		for(int i=0;i<array.length;i++){
			if(i==0){
				orderId1  = "'"+array[i]+"'";
			}else{
			orderId1  =orderId1  + ",'"+array[i]+"'";
			}
		}
		}
		if(StringUtils.isNotBlank(clientId)){
		String[] array1 = clientId.split(",");
		for(int i=0;i<array1.length;i++){
			if(i==0){
				clientId1  = "'"+array1[i]+"'";
			}else{
				clientId1 = clientId1  + ",'"+array1[i]+"'";
			}
		}
		}
		if(StringUtils.isNotBlank(emailId)){
		String[] array2 = emailId.split(",");
		for(int i=0;i<array2.length;i++){
			if(i==0){
				emailId1  = "'"+array2[i]+"'";
			}else{
				emailId1 = emailId1  + ",'"+array2[i]+"'";
			}
		}
		}
		/*if(StringUtils.isNotEmpty(userId)){
			session.setAttribute("userId", userId);
		}*/
		/*int serviceId =0;
		if(sid !=""){
		 serviceId =Integer.parseInt(sid);
		}*/
		
		/*int statusId = 0;
		if(status != ""){
		 statusId = Integer.parseInt(status);
		}*/
		try {
			return orderInfo1Dao.getOrdersByParams(sid,phoneNo,emailId1,orderId1,status,userId,clientId1,startDate,endDate,vendorId,vendorstatusId);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in ServiceOrder() adminorder controller" + e.getMessage());
			logger.fatal("error in adminOrderHome adminorder controller");
			//e.printStackTrace();
		} finally {

		}
		return null;
	}

	@ModelAttribute("services")
	public Map<String, String> populateServices() {

		return service1Dao.getServicesAsMap();
	}

	@RequestMapping(value = "/assignToAdmin")
	public @ResponseBody String assignToAdmin(HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession, @RequestParam("vendorId") int vendorId, @RequestParam("orderId") String orderId,
			@RequestParam("statusId") int statusId,  @RequestParam("netAmt") String netAmount,
			@RequestParam("vendorstatusId") String vendorstatusId,  HttpServletRequest request) throws JsonGenerationException,
					JsonMappingException, IOException, AddressException, MessagingException, ParseException {
		OrderInfo1 orderInfo = orderInfo1Dao.getByGeneratedId(orderId);
		String customerPhone = orderInfo.getContactNumber();
		int oldStatusId = orderInfo.getStatusId();
		String message = "success..";
		SMSUtil objSms = new SMSUtil();
		int timeSlotId = 0;
		String var = null;
		try{
		if (orderInfo.getStatusId() != statusId) {
			OrderStatusLog1 osl1 = new OrderStatusLog1();
			osl1.setOrderId(orderInfo.getId());
			osl1.setStatusId(statusId);
			orderInfo.setStatusId(statusId);
			orderStatusLog1Dao.save(osl1);
			/*
			 * orderInfo.setStatusId(statusId); orderInfo1Dao.save(orderInfo);
			 */
		}
        if(StringUtils.isNotBlank(vendorstatusId)){
        	orderInfo.setVendorStatus(Integer.parseInt(vendorstatusId));
        }
		if (vendorId != orderInfo.getVendorId()) {
			orderInfo.setVendorId(vendorId);
		}

		Vendor1 vendor = vendor1Dao.getById(orderInfo.getVendorId());
		if(vendor.getLastName() == null ){
			vendor.setLastName("");
		}
		orderInfo.setVendorName(vendor.getFirstName() + " " + vendor.getLastName());
		orderInfo.setVendorMobile(vendor.getMobileNumber());
			orderInfo.setNetAmount(new BigDecimal(netAmount));
		
		String timeId = request.getParameter("timeSlotId");
		String dateId = request.getParameter("pickdate");
		String invoiceDate = request.getParameter("invoiceDate");
		System.out.println(invoiceDate);
		if(StringUtils.isNotBlank(invoiceDate)){
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
	        Date date = dt.parse(invoiceDate);
			orderInfo.setInvoiceDate(date);
		}
		//System.out.println("----" + request.getParameter("timeSlotId"));
		if (StringUtils.isNotBlank(timeId) || StringUtils.isNotBlank(dateId)) {
			// for update time slots ..
			if(StringUtils.isNotEmpty(timeId))
			{
			timeSlotId = Integer.parseInt(request.getParameter("timeSlotId"));
			orderInfo.setAppointmentSlotId(timeSlotId);
			}
			TimeSlots objTimeSlots = timeSlotsDao.getById(timeSlotId);
			String timeName = null;
			if (objTimeSlots != null) {
				timeName = objTimeSlots.getLabel();
				if (StringUtils.isNotBlank(timeName)) {
					orderInfo.setAppointTimeName(timeName);
				}
			}
			// for time update date..
			String pickDate = request.getParameter("pickdate");
			if (StringUtils.isNotBlank(pickDate)) {
				Date bookDate = MiscUtils.getDate2(pickDate);
				orderInfo.setAppointmentDate(bookDate);
				var = objSms.sendSms(objContext, orderInfo, "sms_reschedule_customer");
			}

			
			//System.out.println(var);
			if ("success".equalsIgnoreCase(var)) {
				message = "success";
				//System.out.println("reschedule sms send success");
			} else {
				message = "sms_fail";
				//System.out.println("reschedule sms send fails..");
			}
		} else {
			TimeSlots objTimeSlots = timeSlotsDao.getById(orderInfo.getAppointmentSlotId());
			String timeName = null;
			if (objTimeSlots != null) {
				timeName = objTimeSlots.getLabel();
				if (StringUtils.isNotBlank(timeName)) {
					orderInfo.setAppointTimeName(timeName);
				}
			}
		}

		orderInfo1Dao.save(orderInfo);
		//System.out.println("vendorid===" + vendorId);
		if(orderInfo.getUserId() !=3 ){
			orderInfo.setContactEmail("care@aurospaces.com");
			orderInfo.setContactNumber("9742557757");
		}
		if (statusId != oldStatusId) {
			if (statusId == AuroConstants.confirmed) {
				orderInfo.setContactNumber(vendor.getMobileNumber());
				EmailSendingUtil objEmailSendingUtil = new EmailSendingUtil();
				objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer_vendor");
				//objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer_mail_content");
				orderInfo.setContactNumber(customerPhone);
				if (orderInfo.getNetAmount() == null && orderInfo.getTotalPrice() == null) {
					objSms.sendSms(objContext, orderInfo, "sms_vendor_message");
				} else if (orderInfo.getNetAmount() != null && orderInfo.getTotalPrice() != null) {
					objSms.sendSms(objContext, orderInfo, "sms_cusotmer_orderpriceconfirm");
				} else {
					message = "sms_fail";
				}
				orderInfo.setVendorMobile(orderInfo.getContactNumber());
				orderInfo.setContactNumber(vendor.getMobileNumber());	
				objSms.sendSms(objContext, orderInfo, "sms_vendor_confirmation");
				objSms.sendSms(objContext, orderInfo, "vendor_customer_details");
			} else if (statusId == AuroConstants.cancel) {
				objSms.sendSms(objContext, orderInfo, "sms_cancel_customer");
				if (orderInfo.getVendorId() != 0) {
					orderInfo.setContactNumber(vendor.getMobileNumber());
					objSms.sendSms(objContext, orderInfo, "sms_cancel_vendor");
				}

			} else if (statusId == AuroConstants.paid) {
				List<CouponCode> list = orderInfo1Dao.validateCoupon(orderInfo.getCouponCode());
				if(list != null && list.size() > 0){
					/*Coupon coupn = couponDao.getByCouponCodeId(list.get(0).getId());
					coupn.setSent(1);
					String vendorCode = MiscUtils.genOtp();
					coupn.setVendorCode(vendorCode);
					couponDao.save(coupn);
					orderInfo.setCouponCode(vendorCode);
					objSms.sendSms(objContext, orderInfo, "sms_vendor_couponcode");*/
				}
				objSms.sendSms(objContext, orderInfo, "sms_paid_customer");
				objSms.sendSms(objContext, orderInfo, "sms_customer_feedback");
				orderInfo.setContactNumber(vendor.getMobileNumber());
				objSms.sendSms(objContext, orderInfo, "sms_vendor_feedback");
				// email
				new EmailSendingUtil().sendEmail(orderInfo, objContext, "customer_feedback");
			} else if (statusId == AuroConstants.sampleCollected) {
				objSms.sendSms(objContext, orderInfo, "Customer_Sample_Collected");
			} else if (statusId == AuroConstants.reportsUploaded) {
				message= objSms.sendSms(objContext, orderInfo, "Customer_reports_upload");
			} else if (statusId == AuroConstants.priceOnInspection) {
				//orderInfo.setNetAmount(netAmount);
				message = objSms.sendSms(objContext, orderInfo, "sms_customer_oninspection");
			} else {
				message = "sms_fail";
			}
			//System.out.println("sms sending..."+message);
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		objSession.setAttribute("tabName", "AdminOrders");
		return "succ";

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
	
}
