/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.CustomerBean;
import com.aurospaces.neighbourhood.bean.OrderInfoBean;
import com.aurospaces.neighbourhood.bean.SMSBean;
import com.aurospaces.neighbourhood.bean.ServicesBean;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.UserOtpDao;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.ServiceUnit1;
import com.aurospaces.neighbourhood.service.BookingOrderService;
import com.aurospaces.neighbourhood.service.CustomerService;
import com.aurospaces.neighbourhood.util.MiscUtils;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.aurospaces.neighbourhood.util.SMSUtil;

/**
 * @author YOGI
 *
 */
@Controller
public class BookingController {
	@Autowired
	CustomerService objCustomerService;
	@Autowired
	ServletContext objContext;
	Logger objLogger = Logger.getLogger(BookingController.class);
	@Autowired
	BookingOrderService objBookingOrderService;
	@Autowired
	UserOtpDao objUserOtpDao;
	@Autowired
	Service1Dao service1Dao;
	@Autowired
	ServiceUnit1Dao serviceUnit1Dao;
	@RequestMapping(value = "/bookingInformation", method = RequestMethod.POST)
	public @ResponseBody
	String bookingInformation(HttpServletRequest objRequest,
			HttpServletResponse objResponse) throws JsonGenerationException,
			JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = "";
		String sCustomerId = null;
		String sSchedueDate = null;
		String sBookedDate = null;
		String sContactNumber = null;
		String sContactAddress = null;
		String totalPrice = null;
		String totalDiscount = null;
		String totalNetAmount = null;
		String sSchedueTime = null;
		String sPassword = null;
		String sEmailId = null;
		String sServiceId = null;
		String sScheduleTimeId = null;
		String sProblemId = null;
		String sArray = null;
		String serviceName = null;
		String sTimeName = null;
		String sLocationId = null;
		String sFormatedScheduleDate = null;
		String sFormatedBookedDate = null;
		NeighbourhoodUtil objNeighbourhoodUtil = null;
		OrderInfoBean objOrderInfoBean = null;
		CustomerBean objCustomerBean = null;
		SMSBean objSmsBean =null;							
		SMSUtil objSmsUtil = null;
		boolean isInsert = false;
		ServicesBean objServicesBean =null;
		ServicesBean objLocalServicesBean =null;
		try {
			sProblemId = objRequest.getParameter("problemId");
			System.out.println(sProblemId);
			 sSchedueDate = objRequest.getParameter("scheduleDate");
			 System.out.println(sSchedueDate);
			 sScheduleTimeId = objRequest.getParameter("scheduleTimeId");
			 sContactNumber = objRequest.getParameter("contactNumber");
			 System.out.println("sContactNumber"+sContactNumber);
			 sContactAddress = objRequest.getParameter("contactAddress");
			 System.out.println("sContactAddress"+sContactAddress);
			 sEmailId = objRequest.getParameter("emailId");
			// serviceName = objRequest.getParameter("serviceName");
			 sTimeName = objRequest.getParameter("scheduleTime");
			 /*totalPrice = objRequest.getParameter("totalPrice");
			 totalDiscount = objRequest.getParameter("totalDiscount");
			 totalNetAmount = objRequest.getParameter("totalNetAmount");*/
			 
			 sPassword = objRequest.getParameter("password");
			 sServiceId = objRequest.getParameter("serviceId");
			 sCustomerId = objRequest.getParameter("customerId");
			 sLocationId = objRequest.getParameter("locationId");
			 System.out.print("customerId--"+sCustomerId);
					if(sServiceId != null){
						objServicesBean = new ServicesBean();
						objServicesBean.setServiceId(sServiceId);
						objLocalServicesBean = objBookingOrderService.getServiceName(objServicesBean);
						if(objLocalServicesBean != null){
							serviceName = objLocalServicesBean.getServiceName();
							System.out.println("service Name......."+serviceName);
						}
					}
					if(sSchedueDate != null){
						objNeighbourhoodUtil = new NeighbourhoodUtil();
						sBookedDate = objNeighbourhoodUtil.getCurrentTimestamp("");
						objOrderInfoBean = new OrderInfoBean();
						if(StringUtils.isNotEmpty(sBookedDate)){
							//objPathologyOrderInfoBean.setBookedDate(sBookedDate);
							objOrderInfoBean.setBookedDate(sBookedDate);
						}
						objOrderInfoBean.setSheduleName(sSchedueDate);
						if ("Day After".equals(sSchedueDate)) {
							sSchedueDate = objNeighbourhoodUtil.getDate(2);
						} else if ("Tomorrow".equals(sSchedueDate)) {
							sSchedueDate = objNeighbourhoodUtil.getDate(1);
						} else{
							sSchedueDate = objNeighbourhoodUtil.getDate(0);
						}
						System.out.println("sSchedueDate--"+sSchedueDate);
						objOrderInfoBean.setAppointmentDate(sSchedueDate);
						objOrderInfoBean.setOrderAddress(sContactAddress);
						objOrderInfoBean.setOrderDescription(sProblemId);
						objOrderInfoBean.setContactNo(sContactNumber);
						objOrderInfoBean.setLocationId(sLocationId);
						sFormatedBookedDate = objNeighbourhoodUtil.getSimpleDate(sBookedDate);
						sFormatedScheduleDate = objNeighbourhoodUtil.getSimpleDate(sSchedueDate);
						objOrderInfoBean.setAppointmentSlotId(sScheduleTimeId);
					if(StringUtils.isEmpty(sCustomerId)){
						objCustomerBean = new CustomerBean();
						objCustomerBean.setMobileNumber(sContactNumber);
						objCustomerBean.setEmail(sEmailId);
						objCustomerBean.setPassword(sPassword);
						objCustomerBean.setAddress1(sContactAddress);
						objCustomerBean.setRegisterDate(sBookedDate);
						 sCustomerId = objCustomerService.insertCustomer(objCustomerBean);
						 objLogger.error("customer Id--"+sCustomerId);
						System.out.println("isCustomerInsert--"+sCustomerId );
						if(StringUtils.isNotEmpty(sCustomerId)){
							// sms to customer
							objOrderInfoBean.setNewCustomer(true);
							objSmsBean = new SMSBean();
							objSmsBean.setMobileNo(sContactNumber);
							objSmsBean.setCustomerId(sContactNumber);
							objSmsBean.setPassword(sPassword);
							if(StringUtils.isNotBlank(objSmsBean.getCustomerId()) && StringUtils.isNotBlank(objSmsBean.getPassword())){
								objSmsUtil = new SMSUtil();
								//objSmsUtil.sendSms(objContext, objSmsBean, "customer_username");
							}
							objOrderInfoBean.setCustomerId(sCustomerId);
						}
						objOrderInfoBean.setPassword(sPassword);
					}else{
						objCustomerBean = new CustomerBean();
						objCustomerBean.setMobileNumber(sContactNumber);
						objCustomerBean.setEmail(sEmailId);
						objCustomerBean.setPassword(sPassword);
						objCustomerBean.setAddress1(sContactAddress);
						objCustomerBean.setCustomerId(sCustomerId);
						objCustomerService.updateCustomer(objCustomerBean);
						objOrderInfoBean.setCustomerId(sCustomerId);	
					}
					objOrderInfoBean.setContactEmail(sEmailId);
					objOrderInfoBean.setServiceId(sServiceId);
				}
					sArray = serviceName+"..."+sFormatedScheduleDate+"..."+sFormatedBookedDate+"..."+sContactNumber+"..."
							+sTimeName+"..."+sEmailId+"..."+sContactAddress+"..."+sProblemId;
					objOrderInfoBean.setTimeName(sTimeName);
					System.out.println("stimename ----"+sTimeName);
				objOrderInfoBean.setOrderDescription(sArray);
				objOrderInfoBean.setServiceName(serviceName);
					isInsert =	objBookingOrderService.insertOrderInformation(objOrderInfoBean);
				
				if (isInsert) {
					sJson = "success";
				} else {
					sJson = "fail";
				}
			
		} catch (Exception e) {
			objLogger.error(e);
			objLogger.error("error in allPathologyBookData() controller"+e.getMessage());
			e.printStackTrace();
			
		} finally {
			
		
		}
		
	
		return sJson;
	}
	
	@RequestMapping(value = "/getServiceName", method = RequestMethod.POST)
	public @ResponseBody
	String getServiceName(HttpServletRequest objRequest,
			HttpServletResponse objResponse) throws JsonGenerationException,
			JsonMappingException, IOException {
		String sServiceId = null;
		ServicesBean objServicesBean = null;
		ServicesBean objLocalServicesBean = null;
		String serviceName = null;
		try{
			 sServiceId = objRequest.getParameter("serviceId");
			 if(sServiceId != null){
					objServicesBean = new ServicesBean();
					objServicesBean.setServiceId(sServiceId);
					objLocalServicesBean = objBookingOrderService.getServiceName(objServicesBean);
					if(objLocalServicesBean != null){
						serviceName = objLocalServicesBean.getServiceName();
						System.out.println("service Name......."+serviceName);
					}
				}
			 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		
		return serviceName;
	}
	
	/*@RequestMapping(value = "/otpGenerate", method = RequestMethod.POST)
	public @ResponseBody
	String otpGenerate(HttpServletRequest objRequest,
			HttpServletResponse objResponse) throws JsonGenerationException,
			JsonMappingException, IOException {
		String phoneNo = null;
		UserOtp objUserOtp = null;
		NeighbourhoodUtil objNeighbourhoodUtil =null;
		String otp =null;
		String sPropFilePath = null;
		Properties objProperties = null;
		InputStream objStream = null;
		String otpContent = null;
		SMSBean objSmsBean = null;
		SMSUtil objSmsUtil =null;
		try{
			phoneNo = objRequest.getParameter("phoneNo");
			 if(phoneNo != null){
				 objNeighbourhoodUtil = new NeighbourhoodUtil();
				 otp = objNeighbourhoodUtil.randNum();
				 Random rand = new Random();
					int num = (rand.nextInt(900000) + 100000);
				 
				 StringBuilder sb = new StringBuilder();
				 sb.append("");
				 sb.append(num);
				 otp = sb.toString();
				
				 System.out.println("num...."+otp);
				 
				 
				 objUserOtp = new UserOtp();
				 System.out.println("phoneNo...."+phoneNo);
				 objUserOtp.setPhoneNo(phoneNo);
				 objUserOtp.setOtp(otp);
				 objUserOtp.setStatus("initiated");
				 objUserOtpDao.save(objUserOtp);
				 objSmsBean = new SMSBean();
				 objSmsBean.setOtp(objUserOtp.getOtp());
				 objSmsBean.setMobileNo(phoneNo);
				 objSmsUtil = new SMSUtil();
				 objSmsUtil.sendSms(objContext, objSmsBean, "user_otp");
				 
			 }
			 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		
		return phoneNo;
	}*/
	
	@RequestMapping(value = "/getPackageImages")
	public @ResponseBody List<String> getPackageImages(HttpServletRequest request) {
		int serviceId = Integer.parseInt(request.getParameter("serviceId"));
		List<String> imageUrlList =null;
		try{
			if(serviceId != 0){
				Service1 service =  service1Dao.getById(serviceId);
			String regPath = "nbdimages"+File.separator+"mobile"+File.separator+"package"+File.separator+service.getName().toLowerCase().replace(' ', '_');
			String path = objContext.getRealPath("nbdimages"+File.separator+"mobile"+File.separator+"package"+File.separator+service.getName().toLowerCase().replace(' ', '_'));
			 imageUrlList =NeighbourhoodUtil.insertImage(path,regPath);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		
		return imageUrlList;
	}
	
	@RequestMapping(value = "/updateImgaesUrl")
	public @ResponseBody 
	ServiceUnit1  updateImgaesUrl(@ModelAttribute("packCmd") ServiceUnit1 serviceUnit1, HttpServletRequest request) {
		int packId = Integer.parseInt(request.getParameter("packageId"));
		String url = request.getParameter("val");
		System.out.println(url);
		int serid = Integer.parseInt(request.getParameter("serId"));
		List<ServiceUnit1> objServiceUnit1List = null;
		try{
			if(packId != 0 ){
				serviceUnit1 = serviceUnit1Dao.getById(packId);
				serviceUnit1.setImgUrl(url);
				serviceUnit1Dao.save(serviceUnit1);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		
		return serviceUnit1;
	}
	
}
