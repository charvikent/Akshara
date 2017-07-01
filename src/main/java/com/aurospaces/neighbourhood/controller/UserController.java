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
import com.aurospaces.neighbourhood.bean.UserRoleBean;
import com.aurospaces.neighbourhood.dao.UserRoleDao;
import com.aurospaces.neighbourhood.db.dao.PartnerDao;
import com.aurospaces.neighbourhood.db.dao.UserRole1Dao;
import com.aurospaces.neighbourhood.db.dao.UsersDao;
import com.aurospaces.neighbourhood.db.model.Partner;
import com.aurospaces.neighbourhood.db.model.UserRole;
import com.aurospaces.neighbourhood.db.model.UserRole1;
import com.aurospaces.neighbourhood.db.model.Users;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author savitha
 *
 */
@Controller
public class UserController {
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	UsersDao objUsersDao;
	@Autowired UserRole1Dao userRole1Dao;
	private Logger logger = Logger.getLogger(UserController.class);
	/*@RequestMapping(value = "/partnerLoginHome")
	public String partner( HttpServletResponse response,
			HttpServletRequest request, HttpSession objSession) {
		return "partnerLogin";
	}*/
	@RequestMapping(value = "/userReg")
	public  String partnerReg( @ModelAttribute("userCmd") Users Users,
			HttpServletRequest request, HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		request.setAttribute("tabName", "Partner");
		objSession.setAttribute("tabName", "Parner");
		List<Users> list = objUsersDao.getAll();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		request.setAttribute("pList", json);
		return "userReg";
		
	}
	@ModelAttribute("locations")
	public Map<String, String> populateLoction(HttpSession objSession) {
		 Map<String, String> statesMap = null;
		 LoginBean loginBean = (LoginBean)objSession.getAttribute("cacheUserBean");
		 StringBuffer objStringBuffer = new StringBuffer();
		try {
			objStringBuffer.append("select id,name from location1 where active=1 and is_dummy=0 ");
			if(loginBean != null){
			if(loginBean.getLocationId() != 0){
			objStringBuffer.append( " and id="+loginBean.getLocationId());
			}
			}
			String sSql =objStringBuffer.toString();
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	
	@RequestMapping(value = "/userDelete")
	public @ResponseBody String partnerDelete( HttpServletResponse response,@RequestParam("id") int id,
			HttpServletRequest request, HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		objUsersDao.delete(id);
		List<Users> list = objUsersDao.getAll();
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		request.setAttribute("pList", json);
		return json;
	}
	@RequestMapping(value = "/userAdd")
	public @ResponseBody String partnerAdd( 
			@RequestParam("id") int id,
			@RequestParam("name") String name,
			@RequestParam("password") String password,@RequestParam("locationId") int locationId) {
		Users user = new Users();
		user.setId(id);
		user.setPassword(password);
		user.setName(name);
		user.setLocationId(locationId);
		List<Users> list = null; 
		try{
			objUsersDao.save(user);
			System.out.println(user.getId());
			list = objUsersDao.getAll();
			UserRole1 userRoleBean = new UserRole1();
			
			if(user.getName().equals("opshyd") || user.getName().equals("opsban")){
				userRoleBean.setUserId(user.getId());
				userRoleBean.setRoleId(1);
			}else{
				userRoleBean.setUserId(user.getId());
			userRoleBean.setRoleId(2);
			}
			userRole1Dao.save(userRoleBean);
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(list);
			return json;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/*@RequestMapping(value = "/partnerLogin")
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
	}*/
}

