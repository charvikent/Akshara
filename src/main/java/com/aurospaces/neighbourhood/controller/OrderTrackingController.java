package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.List;

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

import com.aurospaces.neighbourhood.bean.CategoryBean;
import com.aurospaces.neighbourhood.bean.CustomerBean;
import com.aurospaces.neighbourhood.bean.OrderTrackingBean;
import com.aurospaces.neighbourhood.service.CustomerService;
import com.aurospaces.neighbourhood.service.OrderTrackingService;
import com.aurospaces.neighbourhood.service.PopulateService;
@Controller
public class OrderTrackingController {


	@Autowired
	OrderTrackingService objOrderTrackingService;
	private Logger logger = Logger.getLogger(CustomerController.class);
	@RequestMapping(value = "/ordertracking", method = RequestMethod.GET)
	public String CustomerHome(
			@ModelAttribute("OrderTrackingBean") OrderTrackingBean objOrderTrackingBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse,HttpSession objSession )
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		
		String json = "";
		
		try {
			objRequest.setAttribute("ordertraking", "active");
			List<OrderTrackingBean> listOrderTrackingBeans = objOrderTrackingService.getTypes(objOrderTrackingBean);
			/*ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listCatBean);*/
			//objRequest.setAttribute("OrderTrakingList", json);
			objSession.setAttribute("OrderTrakingList", listOrderTrackingBeans);
			for(OrderTrackingBean objBean : listOrderTrackingBeans){
				System.out.println(objBean.getOrderId());
			}
			objSession.setAttribute("tabName", "OrderTraking");
			

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in CustomerHome customer controller");
		} finally {

		}
		return "ordertracking";
	}


}
