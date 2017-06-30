/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.VendorRegistrationBean;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.aurospaces.neighbourhood.db.dao.VendorService1Dao;
import com.aurospaces.neighbourhood.db.model.Service1;
import com.aurospaces.neighbourhood.db.model.Vendor1;
import com.aurospaces.neighbourhood.db.model.VendorService1;
import com.aurospaces.neighbourhood.service.PopulateService;

/**
 * @author Amit
 * 
 */
@Controller
public class VendorController {
	Logger logger = Logger.getLogger(ServicesController.class);
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	Vendor1Dao objvendorDao;
	@Autowired
	Service1Dao objService1Dao;
	@Autowired
	VendorRegistrationBean objVendorBean;
	@Autowired
	ServletContext objContext;
	@Autowired VendorService1Dao objVendorService1Dao;

	@RequestMapping(value = "/vendorHome", method = RequestMethod.GET)
	public String vendorHome(
			@ModelAttribute("vendorCmd") Vendor1 objProfileBean,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		
		String sJson = "";
		try {
			objRequest.setAttribute("catActive", "active");
			List<Vendor1> listProfileBean = objvendorDao.getByDisplay(null);
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listProfileBean);
			objRequest.setAttribute("VendorList", sJson);
			objRequest.setAttribute("venActive", "active");
			objSession.setAttribute("tabName", "Vendor");
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {

		}
		return "vendorHome";
	}
	@RequestMapping(value = "/vendorDetails", method = RequestMethod.GET)
	public String vendorHome1(
			@ModelAttribute("vendorCmd") Vendor1 objProfileBean,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		
		String sJson = "";
		try {
			
			List<Vendor1> listProfileBean = objvendorDao.getByDisplay(null);
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listProfileBean);
			objRequest.setAttribute("VendorList", sJson);
			objRequest.setAttribute("venActive", "active");
			objSession.setAttribute("tabName", "savitha");
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {

		}
		return "vendorDetails";
	}
	@RequestMapping(value = "/vendorProfileHome", method = RequestMethod.GET)
	public String vendorProfileHome(HttpSession objSession,
			HttpServletRequest objRequest, HttpServletResponse objResponse) {
		try {
			objRequest.setAttribute("venActive", "active");
			objSession.setAttribute("tabName", "Vendor");
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {

		}
		return "vendorProfileHome";
	}

	@RequestMapping(value = "/vendorAdd")
	public String vendorSave( 
			@ModelAttribute("vendorCmd") Vendor1 objProfileBean,
			ModelMap map, HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		int vendorserviceId=0;
		int id=0;
	
		
		try {
			if(objProfileBean.getLastName()!=null){
			
				objProfileBean.setServingCity(Integer.parseInt(objProfileBean.getLocationName()));
			}
			 objvendorDao.save(objProfileBean);
			 /*String lId=vendorlocation.getLocationsId();
				String[] array = lId.split(","); 
				for(int i =0;i<array.length;i++){
					vendorlocation.setVendorId(vendorId);
					locationId =Integer.parseInt(array[i]);
					vendorlocation.setLocationId(locationId);
					vendorlocation.setId(id);
					objVendorLocation.save(vendorlocation);
				}*/
			 VendorService1 objvendorService1=new VendorService1();
			
			 String Lid=objProfileBean.getSubCategory1();
			 String[] array = Lid.split(",");
			 for(int i =0;i<array.length;i++){
				 objvendorService1.setVendorId(objProfileBean.getId());
				 vendorserviceId=Integer.parseInt(array[i]);
				 objvendorService1.setServiceId(vendorserviceId);
				 objvendorService1.setId(id);
				 objVendorService1Dao.save(objvendorService1);
			 }
			 //objvendorService1.setServiceId(Integer.parseInt(objProfileBean.getSubCategory1()));
			 
			 
			 /*String tomcatRootPath = System.getProperty("catalina.base");
				BrandingUtil objBrandingUtil = new BrandingUtil();
				String sFilePath =  tomcatRootPath+File.separator+"webapps"+File.separator+"VendorImages"+File.separator;*/
				/*objBrandingUtil.createFile(sFilePath, objContext, objVendorRegistrationBean.getImageOrVedio());*/
		} catch (Exception e) {
			//e.printStackTrace();
			logger.fatal("error in category save in category controller");
			logger.error(e.getMessage());
			return "redirect:vendorHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
		return "redirect:vendorHome.htm?AddSus=" + "Success" + "";
	}

	@RequestMapping(value = "/patnerRegistration")
	public @ResponseBody String patnerRegistration(
			//@RequestBody  Vendor1 objProfileBean,
			 HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		int vendorserviceId=0;
		int id=0;
		// System.out.println(objRequest.getParameter("firstName"));
		/*objProfileBean.setFirstName(objRequest.getParameter("firstName"));
		objProfileBean.setServingCity(Integer.parseInt(objRequest.getParameter("locationId")));
		objProfileBean.setEmail(objRequest.getParameter("email"));
		objProfileBean.setMobileNumber(objRequest.getParameter("mobileNumber"));
		objProfileBean.setSubCategory1(objRequest.getParameter("serviceId"));*/
		
		Vendor1 objProfileBean = new Vendor1();
		System.out.println(objRequest.getParameter("firstName"));
		objProfileBean.setFirstName(objRequest.getParameter("firstName"));
		objProfileBean.setServingCity((Integer.parseInt(objRequest.getParameter("servingCity"))));
		objProfileBean.setEmail(objRequest.getParameter("email"));
		objProfileBean.setMobileNumber(objRequest.getParameter("mobileNumber"));
		objProfileBean.setSubCategory1(objRequest.getParameter("serviceId"));
		try {
			if(objProfileBean.getLastName()!=null){
			
				objProfileBean.setServingCity(Integer.parseInt(objProfileBean.getLocationName()));
			}
			 objvendorDao.save(objProfileBean);
			 /*String lId=vendorlocation.getLocationsId();
				String[] array = lId.split(","); 
				for(int i =0;i<array.length;i++){
					vendorlocation.setVendorId(vendorId);
					locationId =Integer.parseInt(array[i]);
					vendorlocation.setLocationId(locationId);
					vendorlocation.setId(id);
					objVendorLocation.save(vendorlocation);
				}*/
			 VendorService1 objvendorService1=new VendorService1();
			
			 String Lid=objProfileBean.getSubCategory1();
			 String[] array = Lid.split(",");
			 for(int i =0;i<array.length;i++){
				 objvendorService1.setVendorId(objProfileBean.getId());
				 vendorserviceId=Integer.parseInt(array[i]);
				 objvendorService1.setServiceId(vendorserviceId);
				 objvendorService1.setId(id);
				 objVendorService1Dao.save(objvendorService1);
			 }
			 //objvendorService1.setServiceId(Integer.parseInt(objProfileBean.getSubCategory1()));
			 
			 
			 /*String tomcatRootPath = System.getProperty("catalina.base");
				BrandingUtil objBrandingUtil = new BrandingUtil();
				String sFilePath =  tomcatRootPath+File.separator+"webapps"+File.separator+"VendorImages"+File.separator;*/
				/*objBrandingUtil.createFile(sFilePath, objContext, objVendorRegistrationBean.getImageOrVedio());*/
		} catch (Exception e) {
			//e.printStackTrace();
			logger.fatal("error in category save in category controller");
			logger.error(e.getMessage());
			return "fail";
		} finally {

		}
		return "Success";
	}

	
	@ModelAttribute("states")
	public Map<String, String> populateStates() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select state_Id,state_Name from states";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	
	@ModelAttribute("cateogrys")
	public Map<String, String> populateCateogrys() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id ,name from category1";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("Services")
	public Map<String, String> populateServices() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id ,name from service1 where is_bold=0";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("locations")
	public Map<String, String> populateLoction() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id as serservingCity,name as locationName from location1 where active=1 and is_dummy=0";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@RequestMapping(value = "/editVendor", method = RequestMethod.GET)
	public String editVendor(@ModelAttribute("vendorCmd") Vendor1 objProfileBean,
			Model model,ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		Vendor1 objVendor=null;
		String sJson = null;
		try {
			objRequest.setAttribute("venActive", "active");
			objVendor = objvendorDao.getById(objProfileBean.getId());
			//System.out.println(objVendor);
			model.addAttribute("vendorCmd", objVendor);
			objMap.addAttribute("vendorEdit", objVendor);
			List<Vendor1> listProfileBean = objvendorDao.getByDisplay();
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listProfileBean);
			objRequest.setAttribute("VendorList", sJson);
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in edit vendor in vendor controller");
		} finally {

		}
		return "vendorHome";
	}

	@RequestMapping(value = "/vendorUpdate", method = RequestMethod.POST)
	public String vendorUpdate(

	@ModelAttribute("vendorCmd") Vendor1 objVendorBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		String vendorId=null;
		int vendorserviceId=0;
		try {
			if(objVendorBean.getLastName()!=null){
				
				objVendorBean.setServingCity(Integer.parseInt(objVendorBean.getLocationName()));
			}
			objvendorDao.save(objVendorBean);
			
			objVendorService1Dao.getLastOrder(objVendorBean.getId());
				  vendorId = objVendorBean.getSubCategory1();
			  String[] array = vendorId.split(",");
			 for(int i =0;i<array.length;i++){
				 VendorService1 objvendorService1=new VendorService1();
				objvendorService1.setVendorId(objVendorBean.getId());
				 vendorserviceId=Integer.parseInt(array[i]);
				 objvendorService1.setServiceId(vendorserviceId);
				 objVendorService1Dao.save(objvendorService1);
			 }
			bIsUpdate=true;
			objRequest.setAttribute("vendorActive", "active");
			if (bIsUpdate) {
				return "redirect:vendorHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:vendorHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
		e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in update vendor in vendor controller");
			return "redirect:vendorHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deleteVendor", method = RequestMethod.POST)
	public @ResponseBody
	String deleteVendor(@ModelAttribute("vendorCmd") Vendor1 objVendorBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sVendorId = objRequest.getParameter("deleteId");
			
			objvendorDao.delete(Integer.parseInt(sVendorId));  
		
			List<Vendor1> listBeans= objvendorDao.getByDisplay(null);
			/*for (VendorRegistrationBean c : listRegistrationBeans) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}*/
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listBeans);
			objRequest.setAttribute("vendorActive", "active");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in delete vendor in vendor controller");
			return "redirect:vendorHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}
	@RequestMapping(value = "/getServicesForCategory")
	public @ResponseBody String forServices(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<Service1> listServiceUnit1=null;
		String json="";
		String ParentCategory = request.getParameter("parentCategoryId");
		listServiceUnit1=  objService1Dao.getServicesForCategory(ParentCategory);
		ObjectMapper objmapper=new ObjectMapper();
		json=objmapper.writeValueAsString(listServiceUnit1);
		//System.out.println("listServiceUnit1.size()==="+listServiceUnit1.size());
		request.setAttribute("seviceList", json);
	  return json;


	}
	
	@RequestMapping(value = "/vendorNameSearch")
	public @ResponseBody List<Vendor1> vendorNameSearch(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		String vendorName = objRequest.getParameter("vendorNameSearch");
		try {
			return objvendorDao.getByDisplay(vendorName);

		} catch (Exception e) {
			logger.error("error in vendorNameSearch() vendor controller" + e.getMessage());
			logger.fatal("error in vendorNameSearch vendor controller");
			//e.printStackTrace();
		} finally {

		}
		return null;
	}
	
}
