/**
 * 
 */
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.MedicineBean;
import com.aurospaces.neighbourhood.service.OrderService;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author YOGI
 *
 */
@Controller
public class OrderDetailsController {
	private Logger logger = Logger.getLogger(OrderDetailsController.class);
	@Autowired
	OrderService objOrderService;
	@Autowired
	PopulateService objPopulateService;
	@RequestMapping(value = "/orderDetailsHome", method = RequestMethod.GET)
	public String orderDetailsHome(@ModelAttribute("OrderBean") MedicineBean objOrderBean, HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		/*String json = "";*/
		try {
			objRequest.setAttribute("orderActive", "active");
			List<MedicineBean> listMedicineBean = objOrderService.getOrders(objOrderBean);
			if(listMedicineBean != null){
				System.out.println("size or the list--"+listMedicineBean.size());
			}
			/*ObjectMapper mapper = new ObjectMapper();*/
			/*json = mapper.writeValueAsString(listMedicineBean);*/
			//objRequest.setAttribute("OrderList", listMedicineBean);
			objSession.setAttribute("tabName", "Orders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		return "orderHome";
	}
	@ModelAttribute("vendors")
	public Map<String, String> populateVendor() {
		Map<String, String> objPopulateMap = null;
		try {
			String sSql = "select vendorId , concat_ws(' ',firstName, lastName) from vendor_profile";
			objPopulateMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return objPopulateMap;
	}
	
	@ModelAttribute("services")
	public Map<String, String> populateServices() {
		Map<String, String> objPopulateMap = null;
		try {
			String sSql = "select serviceId, serviceName from services";
			objPopulateMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return objPopulateMap;
	}
	
	@RequestMapping(value = "/relatedOrderHome", method = RequestMethod.POST)
	public @ResponseBody String orderHome(@ModelAttribute("OrderBean") MedicineBean objOrderBean, HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("orderActive", "active");
			String sServiceId = objRequest.getParameter("serviceId");
			
			List<MedicineBean> listMedicineBean = objOrderService.getOrders(objOrderBean);
			if(listMedicineBean != null){
				System.out.println("size or the list--"+listMedicineBean.size());
			}
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listMedicineBean);
			objRequest.setAttribute("OrderList", listMedicineBean);
			objSession.setAttribute("tabName", "Orders");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		return json;
	}
}
