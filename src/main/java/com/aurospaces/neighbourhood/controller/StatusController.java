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
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.db.dao.StatusListDao;
import com.aurospaces.neighbourhood.db.model.StatusList;
import com.aurospaces.neighbourhood.service.PopulateService;

/**
 * @author yogi
 * 
 */
@Controller
public class StatusController {
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	StatusListDao objStatusListDao;
	
	private Logger logger = Logger.getLogger(StatusController.class);

	@RequestMapping(value = "/statusHome", method = RequestMethod.GET)
	public String statusHome(@ModelAttribute("statusCmd") StatusList objStatusList,
			HttpServletRequest objRequest, HttpServletResponse objResponse,HttpSession objSession)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		
		String json = "";
		try {
			objRequest.setAttribute("statusActive", "active");
			List<Map<String,String>> listStatusBean = objStatusListDao.getAllStatuses();
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listStatusBean);
			objRequest.setAttribute("StatusList", json);
			objSession.setAttribute("tabName", "Status");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in statusHome() Statuscontroller"+e.getMessage());
			logger.fatal("error in statusHome() Statuscontroller");
		} finally {

		}
		return "statusHome";
	}
	@ModelAttribute("srevices")
	public Map<String, String> populateSrvices() {
		Map<String, String> objPopulateMap = null;
		try {
			String sSql = "select serviceId , serviceName from services";
			objPopulateMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in homeServices() in ServicesController"+e.getMessage());
			logger.fatal("error in homeServices() in ServicesController");

		} finally {

		}
		return objPopulateMap;
	}
	 @RequestMapping(value = "/statusAdd", method = RequestMethod.POST)
	       public @ResponseBody String statusSave(@ModelAttribute("statusCmd") 
	                        @RequestParam("statusname") String statusname, 
	                        @RequestParam("statusid") int id,HttpServletRequest objRequest,
	                         HttpServletResponse objResponse, HttpSession objSession) {
	                 objResponse.setCharacterEncoding("UTF-8");
	                 try {
	                     StatusList statuslistbean =null;
	                     if(id!=0){
	                    	 statuslistbean=objStatusListDao.getById(id);
	                     
	                     }else{
	                    	 statuslistbean= new StatusList();
	                     }
	                      statuslistbean.setName(statusname);
	                        objStatusListDao.save(statuslistbean);
	                        
	                        
	                 }
	                  catch (Exception e) {
	                         e.printStackTrace();
	                         logger.fatal("error in statusSave() in Statuscontroller");
	                  }
	                         finally {
	  
	                 }
	                return "success";
	         }


	@RequestMapping(value = "/searchStatus", method = RequestMethod.GET)
	public String searchStatus(@ModelAttribute("statusCmd") StatusList objStatusList,
			 HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = "";
		objRequest.setAttribute("statusActive", "active");
		try {
			List<Map<String,String>> listStatusBean1 = objStatusListDao.getAllStatuses();
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listStatusBean1);
			objRequest.setAttribute("StatusList", sJson);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in searchStatus in Statuscontroller"+e.getMessage());
			logger.fatal("error in searchStatus in Statuscontroller");
		} finally {

		}
		return "statusHome";
	}

	
	@RequestMapping(value = "/deleteStatus", method = RequestMethod.POST)
	public @ResponseBody
	String deleteStatus(@ModelAttribute("statusCmd") StatusList objStatusList,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sStatusId = objRequest.getParameter("deleteId");
			
			 objStatusListDao.delete(Integer.parseInt(sStatusId));
			 List<Map<String,String>> listStatusBean = objStatusListDao.getAllStatuses();
			
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listStatusBean);
			objRequest.setAttribute("statusActive", "active");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in deleteStatus() in Statuscontroller"+e.getMessage());
			logger.fatal("error in deleteStatus() in Statuscontroller");
			return "redirect:statusHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

	/*@RequestMapping(value = "/statusDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String statusDuplicate(@ModelAttribute("statusCmd") StatusBean objStatusBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sStatusName = objRequest.getParameter("catname");
			String sStatusId = objRequest.getParameter("catId");
			if (sStatusName != null && sStatusName.length() > 0) {
				objStatusBean.setStatusName(sStatusName);
			}
			
			if (sStatusId != null && sStatusId.length() > 0) {
				objStatusBean.setStatusId(sStatusId);
			}
			List<StatusBean> listStatusBean = objStatusService.getStatuss(objStatusBean, "all");
			if (listStatusBean != null && listStatusBean.size() > 0) {
				msg = "Warning ! Status is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in statusDuplicate() in Statuscontroller"+e.getMessage());
			logger.fatal("error in statusDuplicate() in Statuscontroller");
		} finally {
		}
		return msg;
	}*/

	
}

	
	

	

