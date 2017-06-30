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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aurospaces.neighbourhood.bean.DoctorTypeBean;
import com.aurospaces.neighbourhood.service.DoctorTypeService;
import com.aurospaces.neighbourhood.service.PopulateService;

/**
 * @author kanojia
 * @param <DoctorTypeService>
 * 
 */
@Controller
public class DoctorTypeController {
	@Autowired
	DoctorTypeService objDoctorTypeService;
	@Autowired
	PopulateService objPopulateService;

	private Logger logger = Logger.getLogger(DoctorTypeController.class);

	@RequestMapping(value = "/doctortypeHome", method = RequestMethod.GET)
	public String DoctorTypeHome(
			@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("doctortypeActive", "active");
			List<DoctorTypeBean> listDoctorTypeBean = objDoctorTypeService.getDoctorTypes(
					objDoctorTypeBean, "all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listDoctorTypeBean);
			objRequest.setAttribute("doctortypeList", json);
			objSession.setAttribute("tabName", "DoctorType");

		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in DoctorTypeHome customer controller");
		} finally {

		}
		return "doctortypeHome";
	}

	@RequestMapping(value = "/doctortypeAdd", method = RequestMethod.POST)
	public String doctortypeSave(
			@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean, ModelMap map,
			HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("doctortypeActive", "active");
			isInsert = objDoctorTypeService.insertDoctorType(objDoctorTypeBean);
			/*
			 * int catCount = objDoctorTypeService.catDuplicate(objCatBean); if
			 * (catCount == 0) { isInsert =
			 * objDoctorTypeService.saveDoctorType(objCatBean, true); }
			 */

			if (isInsert) {
				//objSession.setAttribute("doctortypeId", objDoctorTypeBean.getDoctortypeId());
				return "redirect:doctortypeHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:doctortypeHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in doctortype save in customer controller");
			logger.error(e.getMessage());
			return "redirect:doctortypeHome.htm?AddFail=" + "fail" + "";
		} finally {

		}

	}

	@RequestMapping(value = "/searchDoctorType", method = RequestMethod.GET)
	public String searchDoctorType(
			@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<DoctorTypeBean> listDoctorTypeBean = null;
		String sJson = "";
		objRequest.setAttribute("doctortypeActive", "active");
		try {
			listDoctorTypeBean = objDoctorTypeService.getDoctorTypes(objDoctorTypeBean,
					"both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listDoctorTypeBean);
			objRequest.setAttribute("doctortypeList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search DoctorTypeBean in DoctorTypeBean controller");
		} finally {

		}
		return "doctortypeHome";
	}

	@RequestMapping(value = "/editDoctorType", method = RequestMethod.GET)
	public String editDoctorType(
			@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		DoctorTypeBean locobjDoctorTypeBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("doctortypeActive", "active");
			locobjDoctorTypeBean = objDoctorTypeService.getDoctorType(
					objDoctorTypeBean, "all");

			model.addAttribute("doctortypeCmd", locobjDoctorTypeBean);
			objMap.addAttribute("editDoctorType", locobjDoctorTypeBean);

			objDoctorTypeBean.setDoctortypeId(null);

			List<DoctorTypeBean> DoctorTypeBeanList = objDoctorTypeService.getDoctorTypes(
					objDoctorTypeBean, "all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(DoctorTypeBeanList);
			objRequest.setAttribute("doctortypeList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit customer in customer controller");
		} finally {

		}
		return "doctortypeHome";
	}

	@RequestMapping(value = "/doctortypeUpdate", method = RequestMethod.POST)
	public String doctortypeUpdate(

	@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {
			bIsUpdate = objDoctorTypeService.updateDoctorType(objDoctorTypeBean);
			/*
			 * int catCount = objTestService.catDuplicate(objCatBean); if
			 * (catCount == 0) { bIsUpdate =
			 * objTestService.updateDoctorType(objCatBean); }
			 */
			objRequest.setAttribute("doctortypeActive", "active");
			if (bIsUpdate) {
				return "redirect:doctortypeHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:doctortypeHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update doctortypeHome in doctortypeHome controller");
			return "redirect:doctortypeHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deleteDoctorType", method = RequestMethod.POST)
	public @ResponseBody
	String deleteDoctorType(
			@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sDoctorTypeId = objRequest.getParameter("deleteId");
			if (sDoctorTypeId != null) {
				objDoctorTypeBean.setDoctortypeId(sDoctorTypeId);
			}
			isDelete = objDoctorTypeService.deleteDoctorType(objDoctorTypeBean);
			objDoctorTypeBean.setDoctortypeId(null);
			List<DoctorTypeBean> listDoctorTypeBean = objDoctorTypeService
					.getDoctorTypes(objDoctorTypeBean, "all");
			for (DoctorTypeBean c : listDoctorTypeBean) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listDoctorTypeBean);
			objRequest.setAttribute("doctortypeActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete DoctorType in customer controller");
			return "redirect:doctortypeHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}
	
	
	@RequestMapping(value = "/doctortypeDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String doctortypeDuplicate(@ModelAttribute("doctortypeCmd") DoctorTypeBean objDoctorTypeBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sdoctortypeName = objRequest.getParameter("doctortypeName");
			//String sdoctortypeName =objRequest.getParameter("email");
			//String sDoctorTypeId = objRequest.getParameter("cusId");
			if (sdoctortypeName != null && sdoctortypeName.length() > 0) {
				objDoctorTypeBean.setDoctortypeName(sdoctortypeName);
			}
			/*if (sdoctortypeName != null && sdoctortypeName.length() > 0) {
				objDoctorTypeBean.setDoctortypeName(sdoctortypeName);
			}*/
			/*if (sDoctorTypeId != null && sDoctorTypeId.length() > 0) {
				objDoctorTypeBean.setDoctorTypeId(sDoctorTypeId);
			}*/
			int DoctorTypeBean = objDoctorTypeService.getduplicatechecks(objDoctorTypeBean, "all");
			if (DoctorTypeBean != 0 && DoctorTypeBean > 0) {
				msg = "Warning ! DoctorType is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in duplicating DoctorType in DoctorType controller");
		} finally {
		}
		return msg;
	}

}
