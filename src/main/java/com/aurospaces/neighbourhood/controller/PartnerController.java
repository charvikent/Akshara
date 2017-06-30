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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.db.dao.PartnerDao;
import com.aurospaces.neighbourhood.db.model.Partner;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author savitha
 *
 */
@Controller
public class PartnerController {
	@Autowired
	PartnerDao objPartnerDao;

	private Logger logger = Logger.getLogger(PartnerController.class);
	@RequestMapping(value = "/partnerLoginHome")
	public String partner( HttpServletResponse response,
			HttpServletRequest request, HttpSession objSession) {
		return "partnerLogin";
	}
	@RequestMapping(value = "/partnerReg")
	public  String partnerReg( @ModelAttribute("partnerCmd") Partner partner,
			HttpServletRequest request, HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		request.setAttribute("tabName", "Partner");
		objSession.setAttribute("tabName", "Parner");
		List<Partner> list = objPartnerDao.getAll();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		request.setAttribute("pList", json);
		return "partnerReg";
	}
	
	@RequestMapping(value = "/partnerDelete")
	public @ResponseBody String partnerDelete( HttpServletResponse response,@RequestParam("id") int id,
			HttpServletRequest request, HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		objPartnerDao.delete(id);
		List<Partner> list = objPartnerDao.getAll();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		request.setAttribute("pList", json);
		return json;
	}
	@RequestMapping(value = "/partnerAdd")
	public @ResponseBody String partnerAdd( 
			@RequestParam("id") int id,
			@RequestParam("mobile") String mobile,
			@RequestParam("email") String email,
			@RequestParam("name") String name,
			@RequestParam("password") String password) {
		Partner partner = new Partner();
		partner.setId(id);
		partner.setEmail(email);
		partner.setMobile(mobile);
		partner.setPassword(password);
		partner.setName(name);
		partner.setSalt("this");
		List<Partner> list = null; 
		try{
			objPartnerDao.save(partner);
			list = objPartnerDao.getAll();
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(list);
			return json;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(value = "/partnerLogin")
	public String partnerLogin( HttpServletResponse response,
			HttpServletRequest request, HttpSession objSession) {
		response.setCharacterEncoding("UTF-8");
		String succMsg = null;
		Partner objPartner = null;
		try {
			String sUserName = request.getParameter("name");
			String sPassword = request.getParameter("password");
			System.out.println(sUserName + "" + sPassword);
			if (sUserName != null && sPassword != null) {
				objPartner = new Partner();
				objPartner.setEmail(sUserName);
				objPartner.setPassword(sPassword);
				Partner localBean = objPartnerDao.getPartnerDetails(objPartner);
					if (localBean != null) {
						LoginBean objLoginBean=new LoginBean();
						objLoginBean.setUserName(objPartner.getEmail());
						objSession.setAttribute("partnerId", localBean.getId());
						objSession.setAttribute("cacheUserBean", objLoginBean);
						succMsg = "redirect:coHome.htm";
					} else {
						succMsg = "partnerLogin";
					}
				}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in userLogin method in PartnerController class ");
		} finally {
		}
		return succMsg;
	}
}
