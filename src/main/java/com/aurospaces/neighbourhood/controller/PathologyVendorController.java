/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.ServicesBean;
import com.aurospaces.neighbourhood.bean.PathologyVendorBean;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service.ServicesService;
import com.aurospaces.neighbourhood.service.PathologyVendorService;
import com.aurospaces.neighbourhood.util.BrandingUtil;

/**
 * @author Amit
 * 
 */
@Controller
public class PathologyVendorController {
	Logger logger = Logger.getLogger(ServicesController.class);
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	PathologyVendorService objPathologyVendorService;
	@Autowired
	ServicesService objServicesService;
	@Autowired
	ServicesBean objServicesBean;
	@Autowired
	PathologyVendorBean objVendorBean;
	@Autowired
	ServletContext objContext;

	@RequestMapping(value = "/pathologyHome", method = RequestMethod.GET)
	public String pathologyHome(
			@ModelAttribute("pathologyCmd") PathologyVendorBean objVendorProfileBean,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		List<PathologyVendorBean> listPathologyVendorBean = null;
		String sJson = "";
		try {
			listPathologyVendorBean = objPathologyVendorService.getVendors(objVendorProfileBean);
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listPathologyVendorBean);
			objRequest.setAttribute("PathologyList", sJson);
			objRequest.setAttribute("pathologyActive", "active");
			objSession.setAttribute("tabName", "Vendor");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return "pathologyHome";
	}

	@RequestMapping(value = "/pathologyProfileHome", method = RequestMethod.GET)
	public String vendorProfileHome(HttpSession objSession,
			HttpServletRequest objRequest, HttpServletResponse objResponse) {
		try {
			objRequest.setAttribute("pathologyActive", "active");
			objSession.setAttribute("tabName", "Vendor");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return "pathologyProfileHome";
	}

	@RequestMapping(value = "/pathologyAdd", method = RequestMethod.POST)
	public String vendorSave(
			@ModelAttribute("pathologyCmd") PathologyVendorBean objPathologyVendorBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objServicesBean.setCategoryId(objPathologyVendorBean.getCategoryId());
			List<ServicesBean> listServicesBeans = objServicesService.getServices(objServicesBean, "all");
			
			List<ServicesBean> listSerbean = new ArrayList<ServicesBean>();
			
			for(ServicesBean localServicesBean:listServicesBeans){
				ServicesBean objLocalService = new ServicesBean();
				String checkValue = objRequest.getParameter(localServicesBean.getServiceId()+"ser");
				if("on".equals(checkValue)){
					objLocalService.setServiceId(localServicesBean.getServiceId());
				}
				listSerbean.add(objLocalService);
			}
			objPathologyVendorBean.setListServicesBean(listSerbean);
			String tomcatRootPath = System.getProperty("catalina.base");
			BrandingUtil objBrandingUtil = new BrandingUtil();
			String sFilePath =  tomcatRootPath+File.separator+"webapps"+File.separator+"VendorImages"+File.separator;
			objBrandingUtil.createFile(sFilePath, objContext, objPathologyVendorBean.getImageOrVedio());
			isInsert = objPathologyVendorService.insertVendor(objPathologyVendorBean);
			
			  /*objRequest.setAttribute("catActive", "active"); isInsert =
			  objCategoryService.insertCategory(objCatBean);
			 
			
			 int catCount = objCategoryService.catDuplicate(objCatBean); if
			  (catCount == 0) { isInsert =
			 *objCategoryService.saveCategory(objCatBean, true); }*/
			 

			if (isInsert) {
				// objSession.setAttribute("cateogryId",
				// objCatBean.getCategoryId());
				return "redirect:pathologyHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:pathologyHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in category save in category controller");
			logger.error(e.getMessage());
			return "redirect:pathologyHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@ModelAttribute("states")
	public Map<String, String> populateStates() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select state_Id,state_Name from states";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	
	@ModelAttribute("cateogrys")
	public Map<String, String> populateCateogrys() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select categoryId,categoryName from category";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	
	@ModelAttribute("experiences")
	public Map<String, String> populateExperiences() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select experianceId,experianceName from experience";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	
	

	@RequestMapping(value = "/searchpathology", method = RequestMethod.GET)
	public String searchVendor(@ModelAttribute("pathologyCmd") PathologyVendorBean objPathologyVendorBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<PathologyVendorBean> listPathologyVendorBean = null;
		String sJson = "";
		objRequest.setAttribute("pathologyActive", "active");
		try {
			listPathologyVendorBean = objPathologyVendorService.getVendors(objPathologyVendorBean);
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listPathologyVendorBean);
			objRequest.setAttribute("PathologyList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search category in category controller");
		} finally {

		}
		return "pathologyHome";
	}

	@RequestMapping(value = "/editpathologyvendor", method = RequestMethod.GET)
	public String editVendor(@ModelAttribute("pathologyCmd") PathologyVendorBean objRegistrationBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		PathologyVendorBean locobjVendorEditBean = null;
		String sJson = null;
		ObjectMapper mapper = null;
		String serJson = "";
		try {
			objRequest.setAttribute("pathologyActive", "active");
			objRegistrationBean.setEditMode("edit");
			
			locobjVendorEditBean = objPathologyVendorService.getVendor(objRegistrationBean);
			List<ServicesBean> servList = locobjVendorEditBean.getListServicesBean();
			for(ServicesBean obj : servList){
				System.out.println(obj.getCategoryId());
			}
			mapper = new ObjectMapper();
			serJson = mapper.writeValueAsString(servList);
			objSession.setAttribute("serviceList", serJson);
			System.out.println(locobjVendorEditBean.getFirstName());
			model.addAttribute("pathologyCmd", locobjVendorEditBean);
			objMap.addAttribute("pathologyvendorEdit", locobjVendorEditBean);
			
			objRegistrationBean.setVendorId(null);
			
			List<PathologyVendorBean> pathologyList = objPathologyVendorService.getVendors(objRegistrationBean);
			sJson = mapper.writeValueAsString(pathologyList);
			objRequest.setAttribute("PathologyList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit category in category controller");
		} finally {

		}
		return "pathologyHome";
	}

	@RequestMapping(value = "/pathologyVendorUpdate", method = RequestMethod.POST)
	public String vendorUpdate(

	@ModelAttribute("pathologyCmd") PathologyVendorBean objPathologyVendorBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {	
			bIsUpdate = objPathologyVendorService.updateVendor(objPathologyVendorBean);
			/*int catCount = objTestService.catDuplicate(objCatBean);
			if (catCount == 0) {
				bIsUpdate = objTestService.updateCategory(objCatBean);
			}*/
			objRequest.setAttribute("pathologyActive", "active");
			if (bIsUpdate) {
				return "redirect:pathologyHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:pathologyHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update vendor in vendor controller");
			return "redirect:catHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deletepathologyVendor", method = RequestMethod.POST)
	public @ResponseBody
	String deleteVendor(@ModelAttribute("pathologyCmd") PathologyVendorBean objPathologyVendorBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sVendorId = objRequest.getParameter("deleteId");
			if(sVendorId != null){
				objPathologyVendorBean.setVendorId(sVendorId);
			}
			isDelete = objPathologyVendorService.deleteVendor(objPathologyVendorBean);
			objPathologyVendorBean.setVendorId(null);
			List<PathologyVendorBean> listRegistrationBeans= objPathologyVendorService.getVendors(objPathologyVendorBean);
			for (PathologyVendorBean c : listRegistrationBeans) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listRegistrationBeans);
			objRequest.setAttribute("pathologyActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete category in category controller");
			return "redirect:catHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

	@RequestMapping(value = "/pathologyVendorDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String vendorDuplicate(@ModelAttribute("pathologyCmd") PathologyVendorBean objPathologyVendorBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sFirstName = objRequest.getParameter("firstname");
			String sCategoryId = objRequest.getParameter("catId");
			if (sFirstName != null && sFirstName.length() > 0) {
				objPathologyVendorBean.setFirstName(sFirstName);
			}
			
			if (sCategoryId != null && sCategoryId.length() > 0) {
				objPathologyVendorBean.setCategoryId(sCategoryId);
			}
			List<PathologyVendorBean> listPathologyVendorBean = objPathologyVendorService.getVendors(objPathologyVendorBean);
			if (listPathologyVendorBean  != null && listPathologyVendorBean .size() > 0) {
				msg = "Warning ! Vendor is already exists. Please try some other name";
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

	/*@RequestMapping(value = "/searchingBasedOnDepartment", method = RequestMethod.POST)
	public @ResponseBody
	String searchingBasedOnDepartment(

	@ModelAttribute("catCmd") CatBean objCatBean, HttpServletRequest request,
			HttpServletResponse response, @RequestParam("deptId") String sDeptId) {
		response.setCharacterEncoding("UTF-8");
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		List<CatBean> listCatSearch = null;
		try {

			session.setAttribute("deptId", sDeptId);
			listCatSearch = objTestService.categorySearch(objCatBean);

			if ("All".equals(sDeptId)) {
				listCatSearch = objTestService.categorySearch(objCatBean);
			} else {
				session.setAttribute("deptId", sDeptId);
				listCatSearch = objTestService.categorySearch(objCatBean);
			}
			json = mapper.writeValueAsString(listCatSearch);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnDepartment in category controller");
			logger.error(e.getMessage());
		} finally {

		}
		return json;
	}

	@RequestMapping(value = "/searchingBasedOnClient", method = RequestMethod.POST)
	public @ResponseBody
	String searchingBasedOnClient(@ModelAttribute("catCmd") CatBean objCatBean,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam("clientId") String clientId) {
		response.setCharacterEncoding("UTF-8");
		List<CatBean> listCatSearch = null;
		String json = null;
		ObjectMapper mapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		try {
			if ("All".equals(clientId)) {
				listCatSearch = objTestService.categorySearch(objCatBean);
			} else {
				session.setAttribute("cid", clientId);
				listCatSearch = objTestService.categorySearch(objCatBean);
			}
			json = mapper.writeValueAsString(listCatSearch);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnClient in category controller");
			logger.error(e.getMessage());
		} finally {
		}
		return json;
	}*/
}
