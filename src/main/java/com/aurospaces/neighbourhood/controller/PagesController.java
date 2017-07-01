package com.aurospaces.neighbourhood.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aurospaces.neighbourhood.bean.PagesBean;
import com.aurospaces.neighbourhood.service.PagesService;
import com.aurospaces.neighbourhood.service.PopulateService;

@Controller
public class PagesController {
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	PagesService objPagesService;
	Logger logger = Logger.getLogger(ServicesController.class);

	@RequestMapping(value = "/pageHome", method = RequestMethod.GET)
	public String homeServices(
			@ModelAttribute("pageCmd") PagesBean objPagesBean,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		String sJson = null;
		// String sCateogryId = null;
		try {
			
			 // sCateogryId = (String) objSession.getAttribute("cateogryId"); if
			 // (sCateogryId != null) { System.out.println(sCateogryId);
			 // objServicesBean.setCategoryId(sCateogryId); }
				List<PagesBean> listServicesBean = objPagesService.getServices(objPagesBean, "all"); 
				ObjectMapper mapper = new  ObjectMapper();
				sJson =	  mapper.writeValueAsString(listServicesBean);
			  //objServicesBean.setCategoryId(sCateogryId );
			 
			objRequest.setAttribute("ServiceList", sJson);
			objSession.setAttribute("tabName", "Services");
			objRequest.setAttribute("serActive", "active");
		} catch (Exception e) {

		} finally {

		}
		return "pageHome";
	}

	@ModelAttribute("services")
	public Map<String, String> populateCategory() {
		Map<String, String> objPopulateMap = null;
		try {
			String sSql = "SELECT `serviceId` , `serviceName` FROM `services`";
			objPopulateMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return objPopulateMap;
	}
	@RequestMapping(value = "/pageAdd", method = RequestMethod.POST)
	public String insertServices(
			@ModelAttribute(value = "pageCmd") PagesBean objPagesBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse) {
		boolean isInsert = false;
		try {
			System.out.println("pages controller");
			objRequest.setAttribute("serActive", "active");
			isInsert = objPagesService.insertPages(objPagesBean);
			/*
			 * int catCount = objCategoryService.catDuplicate(objCatBean); if
			 * (catCount == 0) { isInsert =
			 * objCategoryService.saveCategory(objCatBean, true); }
			 */

			if (isInsert) {
				//System.out.println(objServicesBean.getCategoryId());
				return "redirect:pageHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:pageHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:pageHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}
	
	
	@RequestMapping(value = "/searchPage", method = RequestMethod.POST)
	public String searchService(
			@ModelAttribute("pageCmd") PagesBean objPagesBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		List<PagesBean> listPagesBeans = null;
		String sJson = "";
		objRequest.setAttribute("serActive", "active");
		try {
			listPagesBeans = objPagesService.getServices(objPagesBean, "both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listPagesBeans);
			objRequest.setAttribute("ServiceList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search pages in page controller");
		} finally {

		}
		return "serHome";
	}


}
