package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.CustomerLoginBean;
import com.aurospaces.neighbourhood.bean.HomeBean;
import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.db.dao.Category1Dao;
import com.aurospaces.neighbourhood.db.dao.Location1Dao;
import com.aurospaces.neighbourhood.db.dao.LocationService1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.UserOtpDao;
import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.aurospaces.neighbourhood.db.model.Location1;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.UserOtp;
import com.aurospaces.neighbourhood.service.LoginService;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service1.ClusterService;
import com.aurospaces.neighbourhood.util.SMSUtil;

@Controller
public class HomeController {

	@Autowired ClusterService clusterService;



	@Autowired ServletContext objContext;



	@Autowired SContext sContext;
	@Autowired Category1Dao category1Dao;
	@Autowired Vendor1Dao vendor1Dao;

	@Autowired LocationService1Dao locationService1Dao;
	
	@Autowired Service1Dao service1Dao;
	@Autowired  ServiceUnit1Dao serviceUnitDao;

	@Autowired Location1Dao location1Dao;

	@Autowired UserOtpDao objUserOtpDao;
	
	@Autowired
	ServletContext servletContext;
	@Autowired
	LoginService objLoginService;
	@Autowired
	PopulateService objPopulateService;

	private Logger logger = Logger.getLogger(HomeController.class);

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginHomePage(
			@ModelAttribute("loginCmd") CustomerLoginBean loginUser,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String home = "login";
		/*
		 * if (session != null) { int count =
		 * loginServiceImpl.loginUser((String) session.getAttribute("userName"),
		 * (String) session.getAttribute("password")); if (count != 0) { home =
		 * "home"; } }
		 */
		return home;
	}

	@RequestMapping(value = "/loginHome", method = RequestMethod.GET)
	public String loginHome(
			@ModelAttribute("loginCmd") CustomerLoginBean loginUser,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String home = "login";
		return home;
	}


	@RequestMapping(value = "/testHome", method = RequestMethod.GET)
	public String testHome(@ModelAttribute("homeCmd") HomeBean objHomeBean,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		return "testHome";
	}
	@RequestMapping(value = "/auroHome", method = RequestMethod.GET)
	public String auroHome(@ModelAttribute("homeCmd") HomeBean objHomeBean,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		return "auroHome";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logOut(HttpServletRequest request,
			@ModelAttribute("loginCmd") CustomerLoginBean loginUser,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute("userId");
			session.invalidate();
		}
		return "redirect:login.htm";
	}

	@ModelAttribute("servces")
	public List<Service1> populateServices() {
		return service1Dao.getByDisplayOrder("asc");
	}


	@ModelAttribute("defaultLocation")
	public Location1 getDefaultLocation() {
		return location1Dao.getDefaultLocation();
	}


	@ModelAttribute("location")
	public List<Location1> populateLocation() {
		return location1Dao.getActiveByDisplayOrder("asc");
	}

	@RequestMapping(value = "/loginUserHome", method = RequestMethod.POST)
	public String loginUserHome(
			@ModelAttribute("loginCmd") CustomerLoginBean loginUser,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) {
		response.setCharacterEncoding("UTF-8");
		String succMsg = null;
		System.out.println("login controller");
		LoginBean objLoginBean = null;
		try {
			String sUserName = request.getParameter("mobileOrEmail");
			String sPassword = request.getParameter("password");
			System.out.println(sUserName + "" + sPassword);
			if (sUserName != null && sPassword != null) {
				objLoginBean = new LoginBean();
				objLoginBean.setUserName(sUserName);
				objLoginBean.setPassword(sPassword);
				LoginBean localBean = objLoginService.getUserDetails(objLoginBean);
				if (localBean != null) {
					if(localBean.getUserName().equals("admin")){
					objSession.setAttribute("cacheUserBean", localBean);
					succMsg = "redirect:adminOrderHome.htm";
					}else{
						objSession.setAttribute("cacheUserBean", localBean);
						succMsg = "redirect:clientBooking.htm";
					}
				} else {
					succMsg = "login";
				}
			}

		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in userLogin method in LoginController class ");
		} finally {

		}

		return succMsg;
	}


	@RequestMapping(value = "/forServices")
	public @ResponseBody
	List<Map<String,String>> forServices(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) {
		String locationId = request.getParameter("locationId");
	return  locationService1Dao.getServicesForLocation(locationId);


	}

	@RequestMapping(value = "/getLocationsForService")
	public @ResponseBody
	List<Map<String,String>> getLocationsForService(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) 
	{
		String serviceId = request.getParameter("serviceId");
		return locationService1Dao.getLocationsForService(serviceId);
	}


	@RequestMapping(value = "/createOtp")
	public @ResponseBody String
 createOtp(
		@RequestParam("phoneNo") String phoneNo,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession,
			Model mod) 
	{
		UserOtp objUserOtp = null;
		SMSUtil objSmsUtil = null;
		System.out.println("phoneNo..."+phoneNo);
		Map otpList = (Map)objSession.getAttribute("otplist");
		System.out.println(otpList);
		if(otpList == null)
			otpList = new HashMap<String, UserOtp>();
		objSession.setAttribute("otplist", otpList);
		String otp = genOtp();
		System.out.println(otp);
		otpList.put(phoneNo, otp);
		mod.addAttribute("message", "The otp has been added for phoneNo " + phoneNo + " and otp is " + otp);
		
		objUserOtp = new UserOtp();
		 System.out.println("phoneNo...."+phoneNo);
		 objUserOtp.setPhoneNo(phoneNo);
		 objUserOtp.setOtp(otp);
		 objUserOtp.setStatus("initiated");
		 objUserOtpDao.save(objUserOtp);

		 OrderInfo1 objSmsBean = new OrderInfo1();
		 objSmsBean.setOtp(objUserOtp.getOtp());
		 objSmsBean.setContactNumber(phoneNo);
		 objSmsUtil = new SMSUtil();
		 objSmsUtil.sendSms(objContext, objSmsBean, "user_otp");
		
		 return otp;

	}

	public String genOtp()
	{
		String tempStr = System.currentTimeMillis() + "";
		String otp = tempStr.substring(7);
		return otp;
	}

	@RequestMapping(value = "/showOtp")
	public @ResponseBody String   showOtp(
		//@RequestParam("phoneNo") String phoneNo,
		//@RequestParam("otp1") String otp1,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession,
			Model mod) 
			
	{ 
		String phoneNo = request.getParameter("phoneNo");
		 String otp1 = request.getParameter("otp1");
		UserOtp objUserOtp = null;
		String json = "";
		Map otpList = (Map)objSession.getAttribute("otplist");
		System.out.println(otpList);
		if(otpList == null)
		{
			mod.addAttribute("message", "There is no otp created for this user ");
		}
		else
		{
			String otp = (String)otpList.get(phoneNo);
			System.out.println("otp....."+otp);
			System.out.println("otp1..."+otp1);
			/*if(otp == null)
					mod.addAttribute("message", "There is no otp created for this order ");
			else
					mod.addAttribute("message", "The otp for this order is " + otp);*/
			if(otp.equals(otp1)){
				objUserOtp = new UserOtp();
				objUserOtp.setPhoneNo(phoneNo);
				objUserOtp.setOtp(otp1);
				objUserOtpDao.updateOtpStatus(objUserOtp);
				json = "success";
			}else{
				json = "fail";
			}
		}
		return json;

	}



	@RequestMapping(value = "/setVendorLocation")
	public  String setVendorLocation(@RequestParam("orderId") String orderId,
		@RequestParam("location") String location,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession,
			Model mod) 
	{
		
		sContext.setVendorLocation(orderId, location);
		mod.addAttribute("message", "Vendor location has been added ");
		return "showMsg";

	}


	@RequestMapping(value = "/getVendorLocation")
	public @ResponseBody String getVendorLocation(	@RequestParam("orderId") String orderId,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession,
			Model mod) 
	{
		String vendorLocation = sContext.getVendorLocation(orderId );
		mod.addAttribute("message", "Vendor location is " + vendorLocation);
		return "showMsg";

	}

	/*@RequestMapping(value = "/rest/getCustomerLocation", method = RequestMethod.POST)
	public @ResponseBody
	RestResponse insertOrder(@RequestBody GeoLocations objOrder) {
		RestResponse rr = null;
		
		rr = new RestResponse("200", objOrder);
		return rr;
	}

	/*@RequestMapping(value = "/getCustomerLocation", method = RequestMethod.POST)
	public  @ResponseBody RestResponse getCustomerLocation(
			@RequestBody CustomerBean jsonString,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession,
			Model mod) 
	{
		System.out.println("order id---"+glocation.getOrder_id());
		GeoLocations vendorLocation = sContext.getgLocations(glocation.getOrder_id());
		vendorLocation.setCust_longitude("12.94748374");
		vendorLocation.setCust_longitude("77.48748382");
		//mod.addAttribute("message", "Customer location is " + vendorLocation);
		return new RestResponse("200", "success");

	}*/


	@RequestMapping(value = "/setCustomerLocation")
	public  String
 setCustomerLocation(
		@RequestParam("orderId") String orderId,
		@RequestParam("location") String location,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession,
			Model mod) 
	{
		sContext.setCustomerLocation(orderId, location);
		mod.addAttribute("message", "Customer location has been added ");
		return "showMsg";

	}




// empty comment
}

