package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.CustomerBean;
import com.aurospaces.neighbourhood.bean.DoctorOrderBean;
import com.aurospaces.neighbourhood.bean.DoctorTypeBean;
import com.aurospaces.neighbourhood.bean.SMSBean;
import com.aurospaces.neighbourhood.bean.SymptomsBean;
import com.aurospaces.neighbourhood.bean.TimeSlotBean;
import com.aurospaces.neighbourhood.service.CustomerService;
import com.aurospaces.neighbourhood.service.DoctorOrderService;
import com.aurospaces.neighbourhood.service.DoctorTypeService;
import com.aurospaces.neighbourhood.service.SymptomsService;
import com.aurospaces.neighbourhood.service.TimeSlotService;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.aurospaces.neighbourhood.util.SMSUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;

@Controller
public class DoctorOrderController {
	@Autowired
	DoctorOrderService objDoctorOrderService;
	@Autowired
	DoctorTypeService objDoctorTypeService;
	@Autowired
	DoctorTypeBean objDoctorTypeBean;
	@Autowired
	SymptomsService objSymptomsService;
	@Autowired
	TimeSlotService objTimeSlotService;
	@Autowired
	TimeSlotBean objTimeSlotBean;
	@Autowired
	CustomerService objCustomerService;
	@Autowired
	CustomerBean objCustomerBean;
	@Autowired
	ServletContext objContext;
	
	private Logger logger = Logger.getLogger(DoctorOrderController.class);

	@RequestMapping(value = "/doctorOrder", method = RequestMethod.GET)
	public String doctorOrder(
			@ModelAttribute("cusCmd") SymptomsBean objSymptomsBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<DoctorTypeBean> listDoctorTypeBeans = null;
		List<SymptomsBean> listSymptomsBeans = null;
		List<TimeSlotBean> listTimeSlotBeans = null;
		String sServiceId = null;
		String sLocationId = null;
		try {
			sServiceId = objRequest.getParameter("serviceId");
			sLocationId = objRequest.getParameter("location");
			if (StringUtils.isNotEmpty(sServiceId) && StringUtils.isNotEmpty(sLocationId)  ) {
				objRequest.setAttribute("serviceId", sServiceId);
				listDoctorTypeBeans = objDoctorTypeService.getDoctorTypes(
						objDoctorTypeBean, "all");
				if (listDoctorTypeBeans != null
						&& listDoctorTypeBeans.size() > 0) {
					objRequest.setAttribute("listDoctorTypes",
							listDoctorTypeBeans);
				}
				listSymptomsBeans = objSymptomsService.getSymptomss(
						objSymptomsBean, null);
				if (listSymptomsBeans != null && listSymptomsBeans.size() > 0) {
					objRequest.setAttribute("listSymptoms", listSymptomsBeans);
				}
				listTimeSlotBeans = objTimeSlotService.getTimeslots(
						objTimeSlotBean, null);
				if (listTimeSlotBeans != null && listTimeSlotBeans.size() > 0) {
					objRequest.setAttribute("listTimeslot", listTimeSlotBeans);
				}
			} else {
				return "redirect:auroHome.htm";
			}

		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in medicineHome medicine controller");
			e.printStackTrace();
		} finally {

		}
		return "doctorOrderOld";
	}

	@RequestMapping(value = "/doctorOrderBooking", method = RequestMethod.POST)
	public @ResponseBody
	String doctorOrderBooking(HttpServletRequest objRequest,
			HttpServletResponse objResponse) throws JsonGenerationException,
			JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		List<SymptomsBean> lisSymptomsBeans = null;
		System.out.println("this is DoctorBooking Data");
		String sJson = "";
		DoctorOrderBean objDoctorOrderBean = null;
		SymptomsBean objSymptomsBean = null;
		NeighbourhoodUtil objNeighbourhoodUtil = null;
		SMSBean objSmsBean =null;
		SMSUtil objSmsUtil = null;
		String doctorScheduleDate = null;
		String doctorScheduleTimeId = null;
		String contactNumber = null;
		String contactAddress = null;
		String sBookedDate = null;
		String emailId = null;
		String doctorTypes = null;
		String symptomsText = null;
		String doctorTypeId = null;
		String sServiceId = null;
		String sPassword = null;
		String sCustomerId = null;
		String sPrice = null;
		String sDiscount= null;
		String sNetAmount=null;
		String sTimeName = null;
		String sFormatedBookedDate = null;
		String sFormatedScheduleDate = null;
		String sLocationId = null;
		boolean isInsert = false;
		try {
			doctorScheduleDate = objRequest.getParameter("doctorScheduleDate");
			doctorScheduleTimeId = objRequest.getParameter("doctorScheduleTimeId");
			System.out.println("doctorScheduleTimeId...."+doctorScheduleTimeId);
			contactNumber = objRequest.getParameter("contactNumber");
			contactAddress = objRequest.getParameter("contactAddress");
			emailId = objRequest.getParameter("emailId");
			doctorTypes = objRequest.getParameter("doctorTypes");
			System.out.println("contact address "+contactAddress);
			symptomsText = objRequest.getParameter("symptomsText");
			doctorTypeId = objRequest.getParameter("doctorTypeId");
			sServiceId = objRequest.getParameter("serviceId");
			sPassword = objRequest.getParameter("password");
			sCustomerId = objRequest.getParameter("customerId");
			sPrice = objRequest.getParameter("price");
			sDiscount = objRequest.getParameter("discount");
			sNetAmount = objRequest.getParameter("youPay");
			sTimeName = objRequest.getParameter("doctorScheduleTime");
			sLocationId = objRequest.getParameter("locationId");
			
			System.out.println("doctorTypeId...." + doctorTypeId);

			objNeighbourhoodUtil = new NeighbourhoodUtil();
			//doctorScheduleDate = objNeighbourhoodUtil.getCurrentTimestamp("");
			objDoctorOrderBean = new DoctorOrderBean();
			if(doctorScheduleDate != null){
				objNeighbourhoodUtil = new NeighbourhoodUtil();
				sBookedDate = objNeighbourhoodUtil.getCurrentTimestamp("");
				if(StringUtils.isNotEmpty(sBookedDate)){
					objDoctorOrderBean.setBookedDate(sBookedDate);
				}
				objDoctorOrderBean.setScheduleName(doctorScheduleDate);
				if ("Day After".equals(doctorScheduleDate)) {
					doctorScheduleDate = objNeighbourhoodUtil.getDate(2);
				} else if ("Tommorow".equals(doctorScheduleDate)) {
					doctorScheduleDate = objNeighbourhoodUtil.getDate(1);
				} else{
					doctorScheduleDate = objNeighbourhoodUtil.getDate(0);
				}
				sFormatedBookedDate = objNeighbourhoodUtil.getSimpleDate(sBookedDate);
				sFormatedScheduleDate = objNeighbourhoodUtil.getSimpleDate(doctorScheduleDate);
				System.out.println("sSchedueDate--"+doctorScheduleDate);
				objDoctorOrderBean.setAppointmentDate(doctorScheduleDate);
			}
			objDoctorOrderBean.setAppointmentSlotId(doctorScheduleTimeId);
			objDoctorOrderBean.setOrderAddress(contactAddress);
			objDoctorOrderBean.setContactNo(contactNumber);
			objDoctorOrderBean.setContactEmail(emailId);
			objDoctorOrderBean.setSymptomsDesc(symptomsText);
			objDoctorOrderBean.setDoctortypeId(doctorTypeId);
			objDoctorOrderBean.setDoctortypeName(doctorTypes);
			objDoctorOrderBean.setTotalPrice(sPrice);
			objDoctorOrderBean.setTotalDiscount(sDiscount);
			objDoctorOrderBean.setNetAmount(sNetAmount);
			objDoctorOrderBean.setLocationId(sLocationId);
			String arrayData = objRequest.getParameter("temp");
			JsonParser jsonParser = new JsonParser();
			JsonArray objAsonArray = (JsonArray) jsonParser.parse(arrayData);
			if (objAsonArray != null) {
				lisSymptomsBeans = new ArrayList<SymptomsBean>();
				for (int i = 0; i < objAsonArray.size(); i++) {
					objSymptomsBean = new SymptomsBean();
					JsonPrimitive objJsonObject = (JsonPrimitive) objAsonArray.get(i);
					System.out.println("objJsonObject--" +String.valueOf(objJsonObject));
					String symptomsid = String.valueOf(objJsonObject).split(",")[0];
					String symptomsName = String.valueOf(objJsonObject).split(",")[1];
					objSymptomsBean.setSymsptomsId(symptomsid.replace("\"", ""));
					objSymptomsBean.setSymptomsName(symptomsName.replace("\"", ""));
					System.out.println("objSymptomsBean--" +objSymptomsBean.getSymsptomsId());
					lisSymptomsBeans.add(objSymptomsBean);
				}
			}
				objDoctorOrderBean.setListSymptomsBean(lisSymptomsBeans);
				objDoctorOrderBean.setServiceId(sServiceId);

				if (StringUtils.isEmpty(sCustomerId)) {
					objCustomerBean.setMobileNumber(contactNumber);
					objCustomerBean.setEmail(emailId);
					objCustomerBean.setAddress1(contactAddress);
					objCustomerBean.setPassword(sPassword);
					objCustomerBean.setRegisterDate(sBookedDate);
					sCustomerId = objCustomerService.insertCustomer(objCustomerBean);
					System.out.println("isCustomerInsert--" + sCustomerId);
					if (StringUtils.isNotEmpty(sCustomerId)) {
						objDoctorOrderBean.setNewCustomer(true);
						objSmsBean = new SMSBean();
						objSmsBean.setMobileNo(contactNumber);
						objSmsBean.setCustomerId(contactNumber);
						objSmsBean.setPassword(sPassword);
						if(StringUtils.isNotBlank(objSmsBean.getCustomerId()) && StringUtils.isNotBlank(objSmsBean.getPassword())){
							objSmsUtil = new SMSUtil();
							//objSmsUtil.sendSms(objContext, objSmsBean, "customer_username");
						}
						objDoctorOrderBean.setCustomerId(sCustomerId);
					}
					objDoctorOrderBean.setPassword(sPassword);
				} else {
					objCustomerBean = new CustomerBean();
					objCustomerBean.setMobileNumber(contactNumber);
					objCustomerBean.setEmail(emailId);
					objCustomerBean.setAddress1(contactAddress);
					objCustomerBean.setCustomerId(sCustomerId);
					objCustomerBean.setPassword(sPassword);
					objCustomerService.updateCustomer(objCustomerBean);
					objDoctorOrderBean.setCustomerId(sCustomerId);
				}
				String serviceName = "Doctor";
				String sArray = serviceName+"..."+sFormatedScheduleDate+"..."+contactNumber+"..."+sTimeName+"..."
						+sPrice+"..."+sDiscount+"..."+sNetAmount+"..."+contactAddress+"..."	+emailId+"..."+sFormatedBookedDate+"..."+doctorTypes;
				objDoctorOrderBean.setOrderDescription(sArray);
				objDoctorOrderBean.setTimeName(sTimeName);
				isInsert = objDoctorOrderService
						.insertDocterOrder(objDoctorOrderBean);
				System.out.println("isInsert--" + isInsert);
				if (isInsert) {
					sJson = "success";
				} else {
					sJson = "fail";
				}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in Doctor controller");
			e.printStackTrace();
		} finally {

		}
		return sJson;
	}

	
	/*@RequestMapping(value = "/getPrice", method = RequestMethod.POST)
	public @ResponseBody
	String getPrice(HttpServletRequest objRequest,
			HttpServletResponse objResponse) throws JsonGenerationException,
			JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = "";
		String sDoctorTypeId = null;
		List<DoctorTypeBean> listDoctorTypeBean = null;
		try {
			ObjectMapper objMapper = new ObjectMapper();
			objDoctorTypeBean = new DoctorTypeBean();
			sDoctorTypeId = objRequest.getParameter("doctorTypesId");
			System.out.println("doctorTypesId"+sDoctorTypeId);
			objDoctorTypeBean.setDoctortypeId(sDoctorTypeId);
			listDoctorTypeBean  = objDoctorTypeService.getDoctorTypes(objDoctorTypeBean, "idList");
			sJson = objMapper.writeValueAsString(listDoctorTypeBean);
			System.out.println(objDoctorTypeBean.getPrice());
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in Doctor controller");
			e.printStackTrace();
		} finally {

		}
		return sJson;
	}*/
}
