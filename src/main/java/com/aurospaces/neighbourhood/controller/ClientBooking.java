package com.aurospaces.neighbourhood.controller;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.bean.UserRoleBean;
import com.aurospaces.neighbourhood.db.dao.AurospacesOrderLogDao;
import com.aurospaces.neighbourhood.db.dao.ClientOrderLogDao;
import com.aurospaces.neighbourhood.db.dao.CouponDao;
import com.aurospaces.neighbourhood.db.dao.CustomerDiscount1Dao;
import com.aurospaces.neighbourhood.db.dao.DoctorType1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderStatusLog1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderSymptom1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.StatusListDao;
import com.aurospaces.neighbourhood.db.dao.Symptom1Dao;
import com.aurospaces.neighbourhood.db.dao.TimeSlotsDao;
import com.aurospaces.neighbourhood.db.dao.UsersDao;
import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.aurospaces.neighbourhood.db.model.AurospacesOrderLog;
import com.aurospaces.neighbourhood.db.model.ClientOrderLog;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.OrderStatusLog1;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.TimeSlots;
import com.aurospaces.neighbourhood.db.model.Users;
import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;
import com.aurospaces.neighbourhood.service.AdminOrderService;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service.VendorRegisrationService;
import com.aurospaces.neighbourhood.util.AuroConstants;
import com.aurospaces.neighbourhood.util.EmailSendingUtil;
import com.aurospaces.neighbourhood.util.MessageSender;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.aurospaces.neighbourhood.util.SMSUtil;

@Controller
public class ClientBooking {

	private Logger logger = Logger.getLogger(ClientBooking.class);
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
	@Autowired AurospacesOrderLogDao auroOrderLog;
	ServiceUnit1Dao serviceUnitDao;
	@Autowired
	OrderServiceUnit1Dao orderServiceUnit1Dao;
	@Autowired
	DoctorType1Dao doctorType1Dao;
	@Autowired
	Symptom1Dao symptom1Dao;
	@Autowired
	OrderSymptom1Dao orderSymptom1Dao;
	@Autowired
	MessageSender messageSender;
	@Autowired
	CustomerDiscount1Dao cusotmerDiscount;
	@Autowired UsersDao userDao;
	@Autowired ClientOrderLogDao clientlogDao;
	@Autowired HttpSession session;
	@RequestMapping(value = "/clientBooking", method = RequestMethod.GET)
	
	public String orderDetailsHome(@ModelAttribute("adminCmd") OrderBean objOrderBean, HttpServletRequest objRequest,
			HttpSession objSession,Model model, HttpServletResponse objResponse)
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
			}else{
				 objRequest.setAttribute("allOrders1", "null");
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
			LoginBean objUserBean =(LoginBean)objSession.getAttribute("cacheUserBean");
			objOrderBean.setUserId(objUserBean.getUserId());
			model.addAttribute(objOrderBean);
			listLogs = new ArrayList<OrderInfo1>();
			objRequest.setAttribute("orderLog", listLogs);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		//System.out.println("DOES THIS COME HERE ");
		return "clientBookingHome";
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
	@ModelAttribute("services")
	public Map<String, String> populateServices() {

		return service1Dao.getServicesAsMap();
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
	@ModelAttribute("status")
	public Map<String, String> populateStatus() {
		return statusListDao.getStatusesAsMap();
	}
	@ModelAttribute("locations")
	public Map<String, String> populateLoction() {
		Map<String, String> statesMap = null;
		 LoginBean loginBean = (LoginBean)session.getAttribute("cacheUserBean");
		 StringBuffer objStringBuffer = new StringBuffer();
		try {
			objStringBuffer.append("select id,name from location1 where active=1 and is_dummy=0 ");
			if(loginBean != null){
			if(loginBean.getLocationId() != 0){
			objStringBuffer.append( " and id="+loginBean.getLocationId());
			}
			}
			String sSql =objStringBuffer.toString();
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
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
	@RequestMapping(value = "/clientBooking1")
	public @ResponseBody String bookPackages(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session,
			@RequestParam("locationId") int locationId,
			@RequestParam("contactNumber") String contactNumber,
			@RequestParam("contactAddress") String contactAddress,
			@RequestParam("emailId") String contactEmail,
			@RequestParam("timeId") int timeId,
			@RequestParam("couponcodeId") String couponcodeId,		
			@RequestParam("orderId") int id
			
	)  {
		try{
			objResponse.setCharacterEncoding("UTF-8");
			String cname = objRequest.getParameter("cname");
			String userId = objRequest.getParameter("userId1");
			String sdiscription = objRequest.getParameter("sdiscription");
			String priorityId = objRequest.getParameter("priorityId");
			String wlocationId = objRequest.getParameter("wlocationId");
			String clientOrderId = objRequest.getParameter("clientOrderId");
			String bookedDateId = objRequest.getParameter("bookedDateId");
			String scheduledateId = objRequest.getParameter("scheduledateId");
			String ownernameId=objRequest.getParameter("ownernameId");
			String bhkid=objRequest.getParameter("bhkid");
			String clientCommentsId=objRequest.getParameter("clientCommentsId");
			String completionDateId=objRequest.getParameter("completionDateId");
			String billingId=objRequest.getParameter("billingId");
			String serviceId =objRequest.getParameter("serviceId");
			 JSONArray jsonarry = new JSONArray(serviceId);
			for(int i=0;i< jsonarry.length();i++){
			OrderInfo1 orderInfo = null;
			if(id !=0)
			{
				orderInfo = orderInfo1Dao.getById(id);
				String oldClientlog = orderInfo.getClientLog();
				if(StringUtils.isNotBlank(clientCommentsId)){
					if(!clientCommentsId.equals(oldClientlog)){
					ClientOrderLog objclientlog =new ClientOrderLog();
					objclientlog.setOrderId(orderInfo.getId());
					objclientlog.setUserId(orderInfo.getUserId());
					objclientlog.setClientLog(clientCommentsId);
					clientlogDao.save(objclientlog);
				orderInfo.setClientLog(clientCommentsId);
					}
				}
				
			}else{
				orderInfo = new OrderInfo1();
				NeighbourhoodUtil objNeighbourhoodUtil = new NeighbourhoodUtil();
			String generatedOrderId = objNeighbourhoodUtil.randNum();
			orderInfo.setGeneratedId(generatedOrderId);
			orderInfo.setClientLog(clientCommentsId);
			orderInfo.setStatusId(3);
			}
		
		//String image = objRequest.getParameter("image");
				//uploadImage
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		 /*if(StringUtils.isNotBlank(image)){
			 MultipartFile file = (MultipartFile);
			 String nFilePath = servletContext.getRealPath("Branding"+File.separator+"Brand"+File.separator);
		 }*/
		
		if(StringUtils.isNotBlank(bookedDateId)){
			Date date1 = formatter.parse(bookedDateId);
			 orderInfo.setBookedDate(date1);
		}
		if(StringUtils.isNotBlank(scheduledateId)){
			Date date1 = formatter.parse(scheduledateId);
			 orderInfo.setAppointmentDate(date1);
		}
		if(StringUtils.isNotBlank(completionDateId)){
			Date date1 = formatter.parse(completionDateId);
			 orderInfo.setCompletionDate(date1);
		}else{
			Date date1 = formatter.parse(scheduledateId);
			 orderInfo.setCompletionDate(date1);
		}
		//GeoMain gm = new GeoMain();
		//GeoTag geo = gm.getAddr(contactAddress);
		orderInfo.setContactNumber(contactNumber);
		if(StringUtils.isBlank(contactEmail)){
			contactEmail = "care@aurospaces.com";
		}
		orderInfo.setContactEmail(contactEmail);
		orderInfo.setAddress(contactAddress);
		orderInfo.setServiceId(Integer.parseInt(jsonarry.getString(i)));
		

		orderInfo.setAppointmentSlotId(timeId);
		orderInfo.setLocationId(locationId);
		if (StringUtils.isNotBlank(couponcodeId)) {
			orderInfo.setCouponCode(couponcodeId);
		}
		if(StringUtils.isEmpty(userId)){
			Users objUsers=new Users();
			objUsers.setName("aurospace");
			int userid=userDao.getUserId(objUsers);
		LoginBean loginBean = (LoginBean)session.getAttribute("cacheUserBean");
		if(loginBean != null && loginBean.getUserId() != null){
			orderInfo.setUserId(userid);
		}
		}else{
			orderInfo.setUserId(Integer.parseInt(userId));
		}
		//orderInfo.setLatitude(geo.x);
		//orderInfo.setLongitude(geo.y);
		orderInfo.setClientOrderId(clientOrderId);
		orderInfo.setCustomerName(cname);
		orderInfo.setDescription(sdiscription);
		orderInfo.setPriority(priorityId);
		orderInfo.setWatsupLocation(wlocationId);
		orderInfo.setOwnername(ownernameId);
		orderInfo.setNoBhk(bhkid);
		
		orderInfo.setBillingto(billingId);
		
		
		//System.out.println(geo.x +"---"+geo.y);
		
		
		orderInfo1Dao.save(orderInfo);

		
		OrderStatusLog1 osl1 = new OrderStatusLog1();
		osl1.setOrderId(orderInfo.getId());
		osl1.setStatusId(orderInfo.getStatusId());
		orderStatusLog1Dao.save(osl1);
		System.out.println(orderInfo.getUserId());
		
	//sending mail
		Service1 objService1 = service1Dao.getById(Integer.parseInt(jsonarry.getString(i)));
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
		//int userid1=Integer.parseInt(userId);
		
		if(id == 0){
			EmailSendingUtil objEmailSendingUtil = new EmailSendingUtil();
			objEmailSendingUtil.sendEmail(orderInfo, objContext, "admin");
		if(StringUtils.isNotBlank(contactEmail)){
		
		objEmailSendingUtil.sendEmail(orderInfo, objContext, "customer");
		}
		if(orderInfo.getUserId() != 3 ){
			orderInfo.setContactNumber("9742557757");
		}
		SMSUtil objSmsUtil = new SMSUtil();
		objSmsUtil.sendSms(objContext, orderInfo, "customer");
		objSmsUtil.sendSms(objContext, orderInfo, "order_admin");
		}
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
		 }
		}catch(Exception e){
			e.printStackTrace();
			return "insert failed";
		}
		if(id == 0){
		return "success insert";
		}else{
			return "success update";
		}
	}
	@RequestMapping(value = "/clientUpdateStatus")
	public @ResponseBody  String clientUpdateStatus(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session,
			@RequestParam("phoneNo") String contactNumber,
			@RequestParam("email") String contactEmail,
			@RequestParam("stime") int timeId,
			@RequestParam("id") int id,
			@RequestParam("status") int statusId,
			@RequestParam("serviceId") int serviceId
			
	)  {
		String sJson = "";
		try{
			List<Map<String, String>> listOrderBeans = null;
			ObjectMapper objectMapper = null;
			
			objResponse.setCharacterEncoding("UTF-8");
			String bookedDateId = objRequest.getParameter("bookeddate");
			String scheduledateId = objRequest.getParameter("appointmentDate");
			String clientCommentsId=objRequest.getParameter("clientcomment");
			OrderInfo1 orderInfo = new OrderInfo1();
				orderInfo = orderInfo1Dao.getById(id);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			 
		
		if(StringUtils.isNotBlank(bookedDateId)){
			Date date1 = formatter.parse(bookedDateId);
			 orderInfo.setBookedDate(date1);
		}
		if(StringUtils.isNotBlank(scheduledateId)){
			Date date1 = formatter.parse(scheduledateId);
			 orderInfo.setAppointmentDate(date1);
		}
		orderInfo.setContactNumber(contactNumber);
		orderInfo.setContactEmail(contactEmail);
		orderInfo.setServiceId(serviceId);
		orderInfo.setStatusId(statusId);
		orderInfo.setAppointmentSlotId(timeId);
		String oldClientlog = orderInfo.getClientLog();
		if(StringUtils.isNotBlank(clientCommentsId)){
			if(!clientCommentsId.equals(oldClientlog)){
			ClientOrderLog objclientlog =new ClientOrderLog();
			objclientlog.setOrderId(orderInfo.getId());
			objclientlog.setUserId(orderInfo.getUserId());
			objclientlog.setClientLog(clientCommentsId);
			clientlogDao.save(objclientlog);
		orderInfo.setClientLog(clientCommentsId);
			}
		}
		orderInfo1Dao.save(orderInfo);

		
		if (orderInfo.getStatusId() != statusId) {
			OrderStatusLog1 osl1 = new OrderStatusLog1();
			osl1.setOrderId(orderInfo.getId());
			osl1.setStatusId(statusId);
			orderInfo.setStatusId(statusId);
			orderStatusLog1Dao.save(osl1);
		}
		listOrderBeans = orderInfo1Dao.getOrdersByParams(null, null, null, orderInfo.getGeneratedId(), null,null,null,null,null,null,null);
		 if(listOrderBeans != null && listOrderBeans.size() > 0) {
		  objectMapper = new ObjectMapper(); 
		  sJson =objectMapper.writeValueAsString(listOrderBeans);
		  objRequest.setAttribute("newOrderList", sJson);
		  //System.out.println(sJson);
		  }
		
		}catch(Exception e){
			e.printStackTrace();
			return "fail";
		}
		return sJson;
	}
	@RequestMapping(value = "/logsDetails")
	public @ResponseBody List<OrderInfo1> orderDetails( OrderInfo1 objOrderBean,

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
}
