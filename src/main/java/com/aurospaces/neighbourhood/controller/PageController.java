package com.aurospaces.neighbourhood.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aurospaces.neighbourhood.bean.HomeBean;
import com.aurospaces.neighbourhood.bean.PagesBean;
import com.aurospaces.neighbourhood.service.PagesService;
import com.aurospaces.neighbourhood.service.ServicesService;

@Controller
public class PageController {
	@Autowired
	ServicesService objService;
	@Autowired
	PagesService objPagesService;

	@RequestMapping(value = "/pageRedirection", method = RequestMethod.POST)
	public String pageRedirection(
			@ModelAttribute("homeCmd") HomeBean objHomeBean,
			HttpServletRequest objRequest) {
		String sServiceId = null;
		PagesBean objPagesBean = null;
		PagesBean objLocalPagesBean = null;
		try {
			sServiceId = objHomeBean.getServiceId();
			sServiceId = objRequest.getParameter("serviceId");
			System.out.println(sServiceId);
			if (StringUtils.isNotEmpty(sServiceId) && StringUtils.isNotBlank(objHomeBean.getLocationId())) {
				objPagesBean = new PagesBean();
				objPagesBean.setServiceId(sServiceId);
				objLocalPagesBean = objPagesService.getPage(objPagesBean, null);
				/*if (objLocalPagesBean != null) {
					return "redirect:" + objLocalPagesBean.getPageName()
							+ ".htm?serviceId=" + sServiceId+"&location="+objHomeBean.getLocationId();
				} else {
					return "redirect:auroHome.htm";
				}*/
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
		}
		//return "redirect:auroHome.htm";
		return "pathologyTemplate";
	}
}
