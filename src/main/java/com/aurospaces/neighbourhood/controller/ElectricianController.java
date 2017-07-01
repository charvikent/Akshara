package com.aurospaces.neighbourhood.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aurospaces.neighbourhood.bean.OrderInfoBean;
import com.aurospaces.neighbourhood.bean.PathologyTestTypeBean;
import com.aurospaces.neighbourhood.bean.TimeSlotBean;
import com.aurospaces.neighbourhood.service.TimeSlotService;

@Controller
public class ElectricianController {
	private Logger logger = Logger.getLogger(ElectricianController.class);
	@Autowired
	TimeSlotService objSlotService;
	@Autowired
	TimeSlotBean objTimeSlotBean;

	@RequestMapping(value = "/electrician", method = RequestMethod.GET)
	public String electrician(
			@ModelAttribute("OrderInfoBean") OrderInfoBean objOrderBean,
			PathologyTestTypeBean objPathologyTestTypeBean,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		List<TimeSlotBean> listSlotBeans = null;
		String sServiceId = null;
		try {
			sServiceId = objRequest.getParameter("serviceId");
			if (StringUtils.isNotEmpty(sServiceId)) {
				objRequest.setAttribute("serviceId", sServiceId);
			} else {
				return "auroHome";
			}
			listSlotBeans = objSlotService.getTimeslots(objTimeSlotBean, "all");
			if (listSlotBeans != null && listSlotBeans.size() > 0) {
				objRequest.setAttribute("timeSlotList", listSlotBeans);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in electricianController" + e.getMessage());
		} finally {

		}
		return "electrician";
	}


}
