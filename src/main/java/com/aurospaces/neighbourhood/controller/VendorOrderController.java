package com.aurospaces.neighbourhood.controller;

import java.io.IOException;

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

import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.service.PopulateService;
@Controller
public class VendorOrderController {
	private Logger logger = Logger.getLogger(VendorOrderController.class);

	@Autowired
	PopulateService objPopulateService;
	@RequestMapping(value = "/vendorOrder", method = RequestMethod.GET)
	public String orderDetailsHome(@ModelAttribute("OrderBean") OrderBean objOrderBean, HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		/*String json = "";*/
		try {
			objRequest.setAttribute("vendorOrderActive", "active");
			/*List<MedicineBean> listMedicineBean = objOrderService.getOrders(objOrderBean);
			if(listMedicineBean != null){
				System.out.println("size or the list--"+listMedicineBean.size());
			}*/
			/*ObjectMapper mapper = new ObjectMapper();*/
			/*json = mapper.writeValueAsString(listMedicineBean);*/
			/*objRequest.setAttribute("OrderList", listMedicineBean);*/
			objSession.setAttribute("tabName", "vendorOrderActive");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in  Order controller");
		} finally {

		}
		return "vendorOrder";
	}


}
