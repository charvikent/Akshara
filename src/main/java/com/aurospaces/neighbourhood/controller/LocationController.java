/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aurospaces.neighbourhood.bean.LocationBean;
import com.aurospaces.neighbourhood.db.dao.City1Dao;
import com.aurospaces.neighbourhood.db.dao.Location1Dao;
import com.aurospaces.neighbourhood.db.model.City1;
import com.aurospaces.neighbourhood.db.model.Location1;
import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;
import com.aurospaces.neighbourhood.service.LocationService;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.util.BrandingUtil;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;

/**
 * @author yogi
 * 
 */
@Controller
public class LocationController {
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	LocationService objLocationService;
	@Autowired
	ServletContext servletContext;
	@Autowired
	City1Dao city1Dao;
	@Autowired Location1Dao location1Dao;
	
	private Logger logger = Logger.getLogger(LocationController.class);

	@RequestMapping(value = "/locationHome", method = RequestMethod.GET)
	public String locationHome(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession) throws JsonGenerationException,
			JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");

		String json = "";
		try {
			objRequest.setAttribute("locationActive", "active");
			List<LocationBean> listLocationBean = objLocationService
					.getLocations(objLocationBean, "all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listLocationBean);
			objRequest.setAttribute("LocationList", json);
			objSession.setAttribute("tabName", "Location");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in LocationHome() Locationcontroller"
					+ e.getMessage());
			logger.fatal("error in LocationHome() Locationcontroller");
		} finally {

		}
		return "locationHome";
	}

	@ModelAttribute("srevices")
	public Map<String, String> populateSrvices() {
		Map<String, String> objPopulateMap = null;
		try {
			String sSql = "select serviceId , serviceName from services";
			objPopulateMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in homeServices() in ServicesController"
					+ e.getMessage());
			logger.fatal("error in homeServices() in ServicesController");

		} finally {

		}
		return objPopulateMap;
	}

	@RequestMapping(value = "/locationAdd", method = RequestMethod.POST)
	public String locationSave(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("locationActive", "active");
			isInsert = objLocationService.insertLocation(objLocationBean);
			/*
			 * int catCount = objStatusService.catDuplicate(objLocationBean); if
			 * (catCount == 0) { isInsert =
			 * objLocationService.saveCategory(objLocationBean, true); }
			 */

			if (isInsert) {
				objSession.setAttribute("locationId",
						objLocationBean.getLocationId());
				return "redirect:locationHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:locationHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.fatal("error in locationSave() in Locationcontroller");
			logger.error("error in locationSave() in Locationcontroller"
					+ e.getMessage());
			return "redirect:locationHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchLocation", method = RequestMethod.GET)
	public String searchLocation(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<LocationBean> listLocationBean = null;
		String sJson = "";
		objRequest.setAttribute("locationActive", "active");
		try {
			listLocationBean = objLocationService.getLocations(objLocationBean,
					"both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listLocationBean);
			objRequest.setAttribute("LocationList", sJson);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in searchLocation in Locationcontroller"
					+ e.getMessage());
			logger.fatal("error in searchLocation in Locationcontroller");
		} finally {

		}
		return "locationHome";
	}

	/*@RequestMapping(value = "/editLocation", method = RequestMethod.GET)
	public String editLocation(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		LocationBean locobjLocationEditBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("locationActive", "active");
			locobjLocationEditBean = objLocationService.getLocation(
					objLocationBean, "all");
			System.out.println(locobjLocationEditBean.getLocationName());
			model.addAttribute("locationCmd", locobjLocationEditBean);
			objMap.addAttribute("locationEdit", locobjLocationEditBean);

			objLocationBean.setLocationId(null);

			List<LocationBean> LocationBeanList = objLocationService
					.getLocations(objLocationBean, "all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(LocationBeanList);
			objRequest.setAttribute("LocationList", sJson);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in editLocation() in Locationcontroller"
					+ e.getMessage());
			logger.fatal("error in editLocation() in Locationcontroller");
		} finally {

		}
		return "locationHome";
	}*/

	/*@RequestMapping(value = "/locationUpdate", method = RequestMethod.POST)
	public String locationUpdate(

	@ModelAttribute("locationCmd") LocationBean objLocationBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {
			bIsUpdate = objLocationService.updateLocation(objLocationBean);
			
			 * int catCount = objTestService.catDuplicate(objLocationBean); if
			 * (catCount == 0) { bIsUpdate =
			 * objTestService.updateCategory(objLocationBean); }
			 
			objRequest.setAttribute("locationActive", "active");
			if (bIsUpdate) {
				return "redirect:locationHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:locationHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			e.printStackTrace();
			logger.error("error in LocationUpdate() in Locationcontroller"
					+ e.getMessage());
			logger.fatal("error in LocationUpdate() in Locationcontroller");
			return "redirect:locationHome.htm?UpdateFail=" + "fail" + "";
		}
	}*/

	/*@RequestMapping(value = "/deleteLocation", method = RequestMethod.POST)
	public @ResponseBody
	String deleteLocation(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sLocationId = objRequest.getParameter("deleteId");
			if (sLocationId != null) {
				objLocationBean.setLocationId(sLocationId);
			}
			isDelete = objLocationService.deleteLocation(objLocationBean);
			objLocationBean.setLocationId(null);
			List<LocationBean> listLocationBean = objLocationService
					.getLocations(objLocationBean, "all");
			for (LocationBean c : listLocationBean) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listLocationBean);
			objRequest.setAttribute("locationActive", "active");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in deleteLocation() in Locationcontroller"
					+ e.getMessage());
			logger.fatal("error in deleteLocation() in Locationcontroller");
			return "redirect:locationHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}
*/
	@RequestMapping(value = "/locationDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String locationDuplicate(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sLocationName = objRequest.getParameter("catname");
			String sLocationId = objRequest.getParameter("catId");
			if (sLocationName != null && sLocationName.length() > 0) {
				objLocationBean.setLocationName(sLocationName);
			}

			if (sLocationId != null && sLocationId.length() > 0) {
				objLocationBean.setLocationId(sLocationId);
			}
			List<LocationBean> listLocationBean = objLocationService
					.getLocations(objLocationBean, "all");
			if (listLocationBean != null && listLocationBean.size() > 0) {
				msg = "Warning ! Location is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("error in LocationDuplicate() in Locationcontroller"
					+ e.getMessage());
			logger.fatal("error in LocationDuplicate() in Locationcontroller");
		} finally {
		}
		return msg;
	}

	@RequestMapping(value = "/locationSave", method = RequestMethod.POST)
	public String locationAdd(
			@ModelAttribute("locationCmd") LocationBean objLocationBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse response, HttpSession objSession) {
		response.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		String sDirPath = null;
		String sTomcatRootPath = null;
		String sFileName = null;
		String line = "";
		String cvsSplitBy = ",";
		String sCSVFile = null;
		String sServiceId = null;
		String sLocationId = null;
		BrandingUtil objBrandingUtil = null;
		MultipartFile objMultipartFile = null;
		List<LocationBean> listLocationBeans = null;
		BufferedReader objBufferReader = null;
		File newFile = null;
		LocationBean objLBean = null;

		NeighbourhoodUtil objNeighbourhoodUtil = null;
		try {
			objMultipartFile = objLocationBean.getCsvFilePath();
			sFileName = objMultipartFile.getOriginalFilename();
			sTomcatRootPath = System.getProperty("catalina.base");
			objBrandingUtil = new BrandingUtil();
			sDirPath = sTomcatRootPath + File.separator + "webapps"
					+ File.separator + "UploadedCsvFiles" + File.separator
					+ "Location";
			objBrandingUtil.createFile(sDirPath, servletContext,
					objLocationBean.getCsvFilePath());
			objNeighbourhoodUtil = new NeighbourhoodUtil();
			sCSVFile = sDirPath
					+ File.separator
					+ "Location"
					+ objNeighbourhoodUtil
							.getCurrentTimestamp("yyyyMMddHHmmss");

			if (sFileName != null && sFileName.length() > 0) {
				newFile = new File(sCSVFile);
				if (!newFile.exists()) {
					FileOutputStream fos = new FileOutputStream(newFile);
					fos.write(objMultipartFile.getBytes());
					fos.flush();
					fos.close();
				}
				objBufferReader = new BufferedReader(new FileReader(sCSVFile));

				int j = 0;
				while ((line = objBufferReader.readLine()) != null) {
					// use comma as separator
					System.out.println(line);
					String[] locationArray = line.split(cvsSplitBy);
					j++;
					if (j == 1) {
						if ("Pathology".equals(locationArray[1])) {
							sServiceId = "001";
							// objLocationBean.setServiceId(sServiceId);
						}
						else if ("Doctors".equals(locationArray[2])) {
							sServiceId = "002";
							// objLocationBean.setServiceId(sServiceId);
						}
						System.out.println(locationArray[1]);
						System.out.println(locationArray[2]);
					}
					if (j > 1) {

						for (int i = 0; i < locationArray.length; i++) {
							LocationBean objLocalLocationBean = new LocationBean();
							if (listLocationBeans == null) {
								listLocationBeans = new ArrayList<LocationBean>();
							}
							if ("HSR LayOut".equals(locationArray[i])) {
								sLocationId = "101";
							}
							else if ("BTM".equals(locationArray[i])) {
								sLocationId = "102";
							}
							if ("1".equals(locationArray[1])) {
								objLocalLocationBean.setServiceId(sServiceId);
								objLocalLocationBean.setLocationId(sLocationId);
								listLocationBeans.add(objLocalLocationBean);
							}
							if ("1".equals(locationArray[2])) {
								objLocalLocationBean.setServiceId(sServiceId);
								objLocalLocationBean.setLocationId(sLocationId);
								listLocationBeans.add(objLocalLocationBean);
							}
							System.out.println(listLocationBeans.size());

							System.out.println(locationArray[i]);

						}
					}

				}
				if (isInsert) {
					return "redirect:locationHome.htm?UploadSuc=" + "Success"
							+ "";
				} else {
					return "redirect:locationHome.htm?UploadFail=" + "fail"
							+ "";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.fatal("error in Pathology save in Pathology controller");
			logger.error(e.getMessage());
			return "redirect:locationHome.htm?UploadFail=" + "fail" + "";
		} finally {

		}
		return "redirect:locationHome.htm?UploadSuc=" + "Success" + "";
	}
	
	@RequestMapping(value="/locaHome")
	public String locationHome(@ModelAttribute("locationCmd") Location1 location1)
	{	
		return "locationHome";
	}
	@ModelAttribute("citys")
	public Map<String, String> getSymptoms() {
		return city1Dao.getAll();
	}
	@RequestMapping("/getLocationsOnCity")
	public @ResponseBody List<Location1> getLocationsOnCity(HttpServletRequest request){
		List<Location1> list = null;
		int city =0;
		try{
			city = Integer.parseInt(request.getParameter("cityId"));
			list = location1Dao.getAll(city);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	@RequestMapping("/insertLocation")
	public String insertLocation(@ModelAttribute("locationCmd") Location1 location1,HttpServletRequest request ){
		List<Location1> list = null;
		String cityName = null;
		City1 objCity = null;
		try{
			int parentCity = Integer.parseInt(location1.getCityId());
			String name = location1.getName();
			String description = location1.getDescription();
			objCity = city1Dao.getById(parentCity);
			cityName = objCity.getName();
			Location1 location = new Location1();
			location.setParentCity(parentCity);
			location.setName(name);;
			location.setDescription(description);
			GeoMain gm = new GeoMain();
			  GeoTag latlong =  gm.getAddr(name.concat(","+cityName));
			  double latitude = latlong.x;
			  double longitude = latlong.y;
			  location.setLatitude(latitude);
			  location.setLongitude(longitude);
			location1Dao.save(location);
			list = location1Dao.getAll(parentCity);
			ObjectMapper objMapper = new ObjectMapper();
			String json  = objMapper.writeValueAsString(list);
			request.setAttribute("list", json);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "locationHome";
	}
	
	 @RequestMapping(value = "/editLocation")
		public String editService(
				@ModelAttribute("locationCmd") Location1 location1,
				Model model, ModelMap objMap, HttpServletResponse objResponse,
				HttpServletRequest objRequest, HttpSession objSession) {
			objResponse.setCharacterEncoding("UTF-8");
			Location1 localobjLocation1 = null;
			List<Location1> list = null;
			int city =0;
			try {
				objRequest.setAttribute("serActive", "active");
				localobjLocation1 = location1Dao.getById(location1.getId());
				localobjLocation1.setCityId(String.valueOf(localobjLocation1.getParentCity()));
				list = location1Dao.getAll(localobjLocation1.getParentCity());
				model.addAttribute("locationCmd", localobjLocation1);
				objMap.addAttribute("locationEdit", localobjLocation1);
				ObjectMapper objMapper = new ObjectMapper();
				String json  = objMapper.writeValueAsString(list);
				objRequest.setAttribute("list", json);
				
			} catch (Exception e) {
				logger.error(e.getMessage());
				logger.fatal("error in edit serivce in category controller");
			} finally {

			}
			return "locationHome";
		}
	 
	 @RequestMapping("/updateLocation")
		public  String updateLocation(@ModelAttribute("locationCmd") Location1 location1, HttpServletRequest request){
			Location1 objLocation1 = null;
			List<Location1> list = null;
			try{
				int parentcityId = Integer.parseInt(location1.getCityId());
				String name = location1.getName();
				String description = location1.getDescription();
				objLocation1 = location1Dao.getById(location1.getId());
				objLocation1.setParentCity(parentcityId);
				objLocation1.setName(name);
				objLocation1.setDescription(description);
				location1Dao.save(objLocation1);
				list =location1Dao.getAll(objLocation1.getParentCity());
				ObjectMapper objMapper = new ObjectMapper();
				String json = objMapper.writeValueAsString(list);
				request.setAttribute("list", json);
			}catch(Exception e){
				e.printStackTrace();
			}
			return "locationHome";
		}
		
		 @RequestMapping("/deleteLocation")
			public @ResponseBody List<Location1> deleteLocation(HttpServletRequest request ){
			 List<Location1> list = null;
			 Location1 objLocation1 = null;
				try{
					String id = request.getParameter("id");
					 objLocation1 = location1Dao.getById(Integer.parseInt(id));
					System.out.println(id);
					 location1Dao.delete(Integer.parseInt(id));
					 list = location1Dao.getAll(objLocation1.getParentCity());
				}catch(Exception e){
					e.printStackTrace();
				}
				return list;
			}

}
