package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.db.dao.CouponCodeDao;
import com.aurospaces.neighbourhood.db.dao.PartnerCodeDao;
import com.aurospaces.neighbourhood.db.model.CouponCode;
import com.aurospaces.neighbourhood.db.model.Partner;
import com.aurospaces.neighbourhood.db.model.PartnerCode;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CouponCodeController {
	@Autowired
	CouponCodeDao couponCodeDao;
	@Autowired PartnerCodeDao partnerCodeDao;

	@RequestMapping(value = "/couponHome")
	public String getCouponHome(@ModelAttribute("couponCmd") CouponCode couponcode, HttpSession session,
			HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		session.setAttribute("tabName", "CouponCode");
		request.setAttribute("couponAcitve", "CouponCode");
		List<CouponCode> list = couponCodeDao.getAll();
		System.out.println(list.size()+"===size==");
		ObjectMapper objMapper = new ObjectMapper();
		String json = objMapper.writeValueAsString(list);
		request.setAttribute("couponList", json);
		return "couponHome";
	}

	@RequestMapping(value = "/couponCodeAdd")
	public @ResponseBody String couponAdd(
			@RequestParam("baseCode")  String baseCode,
			@RequestParam("partnerId")  String partnerId,
			@RequestParam("displayText1") String displayText1,
			@RequestParam("displayText2") String displayText2,
			@RequestParam("amount")double amount,
			@RequestParam("numberTimes") int numberTimes,
			@RequestParam("totalCount") int totalCount,
			@RequestParam("expiryTime") Date expiryTime,
			HttpSession session,
			HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		session.setAttribute("tabName", "CouponCode");
		request.setAttribute("couponAcitve", "CouponCode");
		CouponCode couponCode = new CouponCode();
		couponCode.setBaseCode(baseCode);
		couponCode.setDisplayText1(displayText1);
		couponCode.setDisplayText2(displayText2);
		couponCode.setAmount(amount);
		couponCode.setNumberTimes(numberTimes);
		couponCode.setTotalCount(totalCount);
		couponCode.setExpiryTime(expiryTime);
		String sid = request.getParameter("id");
		if(StringUtils.isNotEmpty(sid)){
			int id = Integer.parseInt(request.getParameter("id"));
			if(id != 0){
				couponCode.setId(id);
			}
			
		}
		
		couponCodeDao.save(couponCode);
		
		if(StringUtils.isNotEmpty(sid)){
			int id = Integer.parseInt(request.getParameter("id"));
			if(id == 0){
			couponCodeDao.generateCoupons(couponCode, couponCode.getTotalCount());
			PartnerCode partnerCode = new PartnerCode();
			partnerCode.setCouponCodeId(couponCode.getId());
			partnerCode.setPartnerId(Integer.parseInt(partnerId));
			partnerCodeDao.save(partnerCode);
			}
		}
		
		List<CouponCode> list = couponCodeDao.getAll();
		System.out.println(list.size()+"===size==");
		ObjectMapper objMapper = new ObjectMapper();
		String json = objMapper.writeValueAsString(list);
		request.setAttribute("couponList", json);
		return json;
	}

	/*@RequestMapping(value = "/couponCodeEdit")
	public String couponEdit(@ModelAttribute("couponCmd") CouponCode couponcode,
			Model model,
			HttpSession session,
			@RequestParam("id") int id,
			HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException, ParseException {
		session.setAttribute("tabName", "CouponCode");
		request.setAttribute("couponAcitve", "CouponCode");
		couponcode = couponCodeDao.getById(id);
		 DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		 String date = dateFormat.format(couponcode.getExpiryTime());
		Date date = new Date(couponcode.getExpiryTime().getTime());
		couponcode.setExpiryTime(date);
		System.out.println(couponcode.getExpiryTime());
		model.addAttribute("couponCmd",couponcode) ;
		List<CouponCode> list = couponCodeDao.getAll();
		System.out.println(list.size()+"===size==");
		ObjectMapper objMapper = new ObjectMapper();
		String json = objMapper.writeValueAsString(list);
		request.setAttribute("couponList", json);
		return "couponHome";
	}*/

	@RequestMapping(value = "/couponCodeDelete")
	public @ResponseBody String couponCodeDelete(HttpSession session,
			@RequestParam("id") int id,
			HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		session.setAttribute("tabName", "CouponCode");
		request.setAttribute("couponAcitve", "CouponCode");
		couponCodeDao.delete(id);
		List<CouponCode> list = couponCodeDao.getAll();
		System.out.println(list.size()+"===size==");
		ObjectMapper objMapper = new ObjectMapper();
		String json = objMapper.writeValueAsString(list);
		return json;
	}

	@RequestMapping(value = "/couponCodeSearch")
	public String couponCodeSearch(@ModelAttribute("couponCmd") CouponCode couponcode, HttpSession session,
			HttpServletRequest request) {
		session.setAttribute("tabName", "CouponCode");
		request.setAttribute("couponAcitve", "CouponCode");
		//couponCodeDao.
		return "couponHome";
	}
	@ModelAttribute("partners")
	public Map<String, String> getPartners() {
		return couponCodeDao.getPartners();
	}
	@RequestMapping(value = "/coHome")
	public String couponHome(@ModelAttribute("couponCmd") CouponCode couponcode, HttpSession session,
			HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		session.setAttribute("tabName", "Coupon");
		request.setAttribute("coAcitve", "Coupon");
		Object sid = session.getAttribute("partnerId");
		
		List<CouponCode> list = null;
		if(sid != null){
			if(StringUtils.isNotEmpty(String.valueOf(sid)) ){
				int id = Integer.parseInt(String.valueOf(sid));
				 list = couponCodeDao.getAll(id);
				 couponcode.setPartnerId(String.valueOf(id));
			}
		}
		else{
			list = couponCodeDao.getAll();
		}if(list != null && list.size() > 0){
			System.out.println(list.size()+"===size==");
			ObjectMapper objMapper = new ObjectMapper();
			String json = objMapper.writeValueAsString(list);
			request.setAttribute("couponList", json);
		}
		return "coHome";
	}
	
	@RequestMapping(value = "/partnerCoupon")
	public @ResponseBody String partnerCoupon(HttpSession session,@ModelAttribute("partnerCmd") Partner partner,
			@RequestParam("id") int id,
			HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		session.setAttribute("tabName", "CouponCode");
		request.setAttribute("couponAcitve", "CouponCode");
		List<CouponCode> list = couponCodeDao.getAll(id);
		System.out.println(list.size()+"===size==");
		ObjectMapper objMapper = new ObjectMapper();
		String json = objMapper.writeValueAsString(list);
		return json;
	}
	
}
