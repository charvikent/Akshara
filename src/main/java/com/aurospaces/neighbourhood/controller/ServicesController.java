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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.ServicesBean;
import com.aurospaces.neighbourhood.db.dao.LocationService1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.model.LocationService1;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service.ServicesService;

/**
 * @author Amit
 * 
 */
@Controller
public class ServicesController {
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	ServicesService objServicesService;
	@Autowired Service1Dao objService1Dao;
	@Autowired LocationService1Dao locationService1Dao;
	Logger logger = Logger.getLogger(ServicesController.class);

	@RequestMapping(value = "/serviceHome")
	public String homeServices(
			@ModelAttribute("servCmd") Service1 objServicesBean,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		String sJson = null;
		String sCateogryId = null;
		try {
			sCateogryId = (String) objSession.getAttribute("Id");
			if (sCateogryId != null) {
				System.out.println(sCateogryId);
				objServicesBean.setId(0);
			}
			List<Service1> listServicesBean = objService1Dao.getAll(null);
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listServicesBean);
			objServicesBean.setId(0);
			objRequest.setAttribute("ServiceList", sJson);
			objSession.setAttribute("tabName", "Services");
			objRequest.setAttribute("serActive", "active");
		} catch (Exception e) {

		} finally {

		}
		return "serHome";
	}

	@ModelAttribute("categorys")
	public Map<String, String> populateCategory() {
		Map<String, String> objPopulateMap = null;
		try {
			String sSql = "select id , name as parentCategory from category1";
			objPopulateMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return objPopulateMap;
	}
	@RequestMapping(value = "/serviceAdd", method = RequestMethod.POST)
	public String insertServices(
			@ModelAttribute(value = "servCmd") Service1 objServicesBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse) {
		boolean isInsert = false;
		try {
			objRequest.setAttribute("serActive", "active");
			objServicesBean.setActive(1);
			String locationIds = objServicesBean.getLocationId();
			String both[]=locationIds.split(",");
			
			System.out.println(both.length);
			objService1Dao.save(objServicesBean);
			
				for(int i =0 ;i<both.length ;i++){
					LocationService1 locationService = new LocationService1();
					locationService.setServiceId(objServicesBean.getId());
					locationService.setLocationId(Integer.parseInt(both[i]));
					locationService1Dao.save(locationService);
					}
			
			
			objServicesBean.getId();
			isInsert = true;
			//isInsert = objServicesService.insertServices(objServicesBean);
			/*
			 * int catCount = objCategoryService.catDuplicate(objCatBean); if
			 * (catCount == 0) { isInsert =
			 * objCategoryService.saveCategory(objCatBean, true); }
			 */

			if (isInsert) {
				//System.out.println(objServicesBean.getCategoryId());
				return "redirect:serviceHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:serviceHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:serviceHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchService", method = RequestMethod.GET)
	public String searchService(
			@ModelAttribute("servCmd") Service1 objServicesBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		List<Service1> listServicesBean = null;
		String sJson = "";
		objRequest.setAttribute("serActive", "active");
		try {
			listServicesBean = objService1Dao.searchService(objServicesBean);
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listServicesBean);
			objRequest.setAttribute("ServiceList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search category in category controller");
		} finally {

		}
		return "serHome";
	}

	  @RequestMapping(value = "/editService")
		public String editService(
				@ModelAttribute("servCmd") Service1 objServicesBean,
				Model model, ModelMap objMap, HttpServletResponse objResponse,
				HttpServletRequest objRequest, HttpSession objSession) {
			objResponse.setCharacterEncoding("UTF-8");
			Service1 localobjServicesBean = null;
			String sJson = null;
			try {
				objRequest.setAttribute("serActive", "active");
				localobjServicesBean = objService1Dao.getById(objServicesBean.getId());
				model.addAttribute("servCmd", localobjServicesBean);
				objMap.addAttribute("servEdit", localobjServicesBean);
				List<Service1> listServicesBean = objService1Dao.getByDisplayOrder("asc");
				ObjectMapper mapper = new ObjectMapper();
				sJson = mapper.writeValueAsString(listServicesBean);
				objRequest.setAttribute("ServiceList", sJson);
			} catch (Exception e) {
				logger.error(e.getMessage());
				logger.fatal("error in edit serivce in category controller");
			} finally {

			}
			return "serHome";
		}

		@RequestMapping(value = "/serviceUpdate")
		public String serviceUpdate(
				@ModelAttribute("servCmd") Service1 objServicesBean,
				HttpServletRequest objRequest, HttpServletResponse objResponse,
				HttpSession objSession) {
			objResponse.setCharacterEncoding("UTF-8");
			boolean bIsUpdate = false;
			Service1 localobjServicesBean = null;
			try {
				localobjServicesBean = objService1Dao.getById(objServicesBean.getId());
				localobjServicesBean.setName(objServicesBean.getName());
				localobjServicesBean.setPageName(objServicesBean.getPageName());
				localobjServicesBean.setDescription(objServicesBean.getDescription());
				localobjServicesBean.setKeywords(objServicesBean.getKeywords());
				objService1Dao.save(localobjServicesBean);
				bIsUpdate = true;
				/* int catCount = objTestService.catDuplicate(objServicesBean); if
				  (catCount == 0) { bIsUpdate =
				  objTestService.updateCategory(objServicesBean); }*/
				 
				objRequest.setAttribute("serActive", "active");
				if (bIsUpdate) {
					return "redirect:serviceHome.htm?UpdateSus=" + "Success" + "";
				} else {
					return "redirect:serviceHome.htm?UpdateFail=" + "fail" + "";
				}

			} catch (Exception e) {
				bIsUpdate = false;
				logger.error(e.getMessage());
				logger.fatal("error in update category in category controller");
				return "redirect:serviceHome.htm?UpdateFail=" + "fail" + "";
			}
		}

		@RequestMapping(value = "/deleteService")
		public @ResponseBody
		String deleteService(
				@ModelAttribute("servCmd") Service1 objServicesBean,
				HttpServletResponse objResponse, HttpServletRequest objRequest,
				HttpSession objSession) {
			objResponse.setCharacterEncoding("UTF-8");
			String sJson = null;
			boolean isDelete = false;
			int id = Integer.parseInt(objRequest.getParameter("id"));
			
			try {
				objService1Dao.delete(id);
				List<Service1> listServicesBean = objService1Dao.getByDisplayOrder(null);
				ObjectMapper mapper = new ObjectMapper();
				sJson = mapper.writeValueAsString(listServicesBean);
				objServicesBean.setId(0);
				objRequest.setAttribute("ServiceList", sJson);
				objRequest.setAttribute("serActive", "active");
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e.getMessage());
				logger.fatal("error in delete category in category controller");
				return "redirect:serviceHome.htm?DeleteFail=" + "fail" + "";
			} finally {

			}
			return sJson;
		}

	@RequestMapping(value = "/serviceDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String serviceDuplicate(
			@ModelAttribute("servCmd") ServicesBean objServicesBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sServicesName = objRequest.getParameter("serviceName");
			String sServicesId = objRequest.getParameter("serviceId");
			String sCatId = objRequest.getParameter("categoryId");
			if (sServicesName != null && sServicesName.length() > 0) {
				objServicesBean.setServiceName(sServicesName);
			}

			if (sServicesId != null && sServicesId.length() > 0) {
				objServicesBean.setServiceId(sServicesId);
			}
			if (sCatId != null && sCatId.length() > 0) {
				objServicesBean.setCategoryId(sCatId);
			}

			List<ServicesBean> listServicesBean = objServicesService
					.getServices(objServicesBean, "all");
			if (listServicesBean != null && listServicesBean.size() > 0) {
				msg = "Warning ! Service is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in duplicating category in category controller");
		} finally {
		}
		return msg;
	}

	@RequestMapping(value = "/searchBasedOnCateogry", method = RequestMethod.POST)
	public @ResponseBody
	String searchBasedOnCateogry(
			@ModelAttribute("servCmd") Service1 objServicesBean,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession objSession) {
		response.setCharacterEncoding("UTF-8");
		String json = "";
		try {
			String id = request.getParameter("id");
			
			objServicesBean.setParentCategory(id);
			List<Service1> listServicesBean1 = objService1Dao.getCatageryList(objServicesBean);
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listServicesBean1);
			objServicesBean.setId(0);
			request.setAttribute("ServiceList", json);
			request.setAttribute("serActive", "active");
			
			json = mapper.writeValueAsString(listServicesBean1);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnDepartment in category controller");
			logger.error(e.getMessage());
		} finally {

		}
		return json;
	}


	/*
	 * @RequestMapping(value = "/searchingBasedOnClient", method =
	 * RequestMethod.POST) public @ResponseBody String
	 * searchingBasedOnClient(@ModelAttribute("catCmd") CatBean objCatBean,
	 * HttpServletRequest request, HttpServletResponse response,
	 * 
	 * @RequestParam("clientId") String clientId) {
	 * response.setCharacterEncoding("UTF-8"); List<CatBean> listCatSearch =
	 * null; String json = null; ObjectMapper mapper = new ObjectMapper();
	 * HttpSession session = request.getSession(false); try { if
	 * ("All".equals(clientId)) { listCatSearch =
	 * objTestService.categorySearch(objCatBean); } else {
	 * session.setAttribute("cid", clientId); listCatSearch =
	 * objTestService.categorySearch(objCatBean); } json =
	 * mapper.writeValueAsString(listCatSearch); } catch (Exception e) {
	 * logger.fatal("error in searchingBasedOnClient in category controller");
	 * logger.error(e.getMessage()); } finally { } return json; }
	 */
	@ModelAttribute("locations")
	public Map<String, String> populateLoction() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from location1 where active=1 and is_dummy=0";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
}
