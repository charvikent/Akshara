package com.aurospaces.neighbourhood.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.db.dao.Location1Dao;
import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.aurospaces.neighbourhood.db.dao.VendorLocationDao;
import com.aurospaces.neighbourhood.db.model.City1;
import com.aurospaces.neighbourhood.db.model.Location1;
import com.aurospaces.neighbourhood.db.model.VendorLocation;

@Controller
public class VendorLocationController {

	@Autowired Vendor1Dao objVendor;
	@Autowired Location1Dao objLocation;
	@Autowired VendorLocationDao objVendorLocation;
	@RequestMapping(value="/vendorLocationHome")
	public String locationHome(@ModelAttribute("vendorLocationCmd") VendorLocation location1)
	{	
		return "vendorLocationHome";
	}
	@ModelAttribute("vendors")
	public Map<String, String> getVendors() {
		return objVendor.getAllVendors();
	}
	@ModelAttribute("locations")
	public Map<String, String> getLocations() {
		return objLocation.getAllLocations();
	}
	@RequestMapping("/insertVendorLocation")
	public  String insertVendorLocation(
			@ModelAttribute("vendorLocationCmd") VendorLocation vendorlocation,HttpServletRequest request){
		boolean insert = false;
		int id = 0;
		int locationId = 0;
		List<VendorLocation> list = null;
		try{
			int vendorId =Integer.parseInt(vendorlocation.getVendorsId());
			String lId=vendorlocation.getLocationsId();
			String[] array = lId.split(","); 
			for(int i =0;i<array.length;i++){
				vendorlocation.setVendorId(vendorId);
				locationId =Integer.parseInt(array[i]);
				vendorlocation.setLocationId(locationId);
				vendorlocation.setId(id);
				objVendorLocation.save(vendorlocation);
			}
			list = objVendorLocation.getAll(vendorId);
			ObjectMapper objMapper =new ObjectMapper();
			String json =objMapper.writeValueAsString(list);
			request.setAttribute("list", json);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "vendorLocationHome";
	}
	
	@RequestMapping("/getvendorAndLocations")
	public @ResponseBody List<VendorLocation> getLocationsOnCity(HttpServletRequest request){
		List<VendorLocation> list = null;
		int vendorId =0;
		try{
			vendorId = Integer.parseInt(request.getParameter("vendorId"));
			list = objVendorLocation.getAll(vendorId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	 @RequestMapping(value = "/editVendorLocation")
		public String editService(
				@ModelAttribute("vendorLocationCmd") VendorLocation location1,
				Model model, ModelMap objMap, HttpServletResponse objResponse,
				HttpServletRequest objRequest, HttpSession objSession) {
			objResponse.setCharacterEncoding("UTF-8");
			VendorLocation localobjLocation1 = null;
			List<VendorLocation> list = null;
			try {
				objRequest.setAttribute("serActive", "active");
				localobjLocation1 = objVendorLocation.getById(location1.getId());
				localobjLocation1.setVendorsId(String.valueOf(localobjLocation1.getVendorId()));
				localobjLocation1.setLocationsId(String.valueOf(localobjLocation1.getLocationId()));
				list = objVendorLocation.getAll(localobjLocation1.getVendorId());
				model.addAttribute("vendorLocationCmd", localobjLocation1);
				objMap.addAttribute("locationEdit", localobjLocation1);
				ObjectMapper objMapper =new ObjectMapper();
				String json =objMapper.writeValueAsString(list);
				objRequest.setAttribute("list", json);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {

			}
			return "vendorLocationHome";
		}
	 @RequestMapping("/updateVendorLocation")
		public  String updateVendorLocation(
				@ModelAttribute("vendorLocationCmd") VendorLocation vendorlocation,HttpServletRequest request){
		 List<VendorLocation> list = null;
			try{
				int vendorId =Integer.parseInt(vendorlocation.getVendorsId());
				int locationId =Integer.parseInt(vendorlocation.getLocationsId());
				
					vendorlocation.setVendorId(vendorId);
					vendorlocation.setLocationId(locationId);
					objVendorLocation.save(vendorlocation);
					list = objVendorLocation.getAll(vendorlocation.getVendorId());
					ObjectMapper objMapper =new ObjectMapper();
					String json =objMapper.writeValueAsString(list);
					request.setAttribute("list", json);
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "vendorLocationHome";
		}
	 @RequestMapping("/deleteVendorLocation")
		public @ResponseBody List<VendorLocation> deleteVendorLocation(HttpServletRequest request ){
			VendorLocation localobjLocation1 = null;
			 List<VendorLocation> list = null;
			try{
				String id = request.getParameter("id");
				localobjLocation1 = objVendorLocation.getById(Integer.parseInt(id));
				objVendorLocation.delete(Integer.parseInt(id));
				list = objVendorLocation.getAll(localobjLocation1.getVendorId());
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return list;
		}
}
