/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.List;

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

import com.aurospaces.neighbourhood.bean.SymptomsBean;
import com.aurospaces.neighbourhood.service.SymptomsService;

/**
 * @author
 * 
 */
@Controller
public class SymptomsController {
	@Autowired
	SymptomsService objSymptomsService;
	
	private Logger logger = Logger.getLogger(SymptomsController.class);

	@RequestMapping(value = "/SymptomsHome", method = RequestMethod.GET)
	public String SymptomsHome(@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("SymptomsActive", "active");
			List<SymptomsBean> listSymptomsBean = objSymptomsService.getSymptomss(objSymptomsBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listSymptomsBean);
			objRequest.setAttribute("SymptomsList", json);
			objSession.setAttribute("tabName", "Symptoms");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in Symptomshome Symptoms controller");
		} finally {

		}
		return "SymptomsHome";
	}

	

	@RequestMapping(value = "/SymptomsAdd", method = RequestMethod.POST)
	public String symptomsSave(@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("SymptomsActive", "active");
			isInsert = objSymptomsService.insertSymptoms(objSymptomsBean);
			/*int SymptomsCount = objSymptomsService.SymptomsDuplicate(objSymptomsBean);
			if (SymptomsCount == 0) {
				isInsert = objSymptomsService.saveSymptoms(objSymptomsBean, true);
			}*/

			if (isInsert) {
				objSession.setAttribute("SymptomsId", objSymptomsBean.getSymsptomsId());
				return "redirect:SymptomsHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:SymptomsHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in Symptoms save in Symptoms controller");
			logger.error(e.getMessage());
			return "redirect:SymptomsHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchSymptoms", method = RequestMethod.GET)
	public String searchSymptoms(@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<SymptomsBean> listSymptomsBean = null;
		String sJson = "";
		objRequest.setAttribute("SymptomsActive", "active");
		try {
			listSymptomsBean = objSymptomsService.getSymptomss(objSymptomsBean,"both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listSymptomsBean);
			objRequest.setAttribute("SymptomsList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search Symptoms in Symptoms controller");
		} finally {

		}
		return "SymptomsHome";
	}

	@RequestMapping(value = "/editSymptoms", method = RequestMethod.GET)
	public String editSymptoms(@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		SymptomsBean locobjSymptomsEditBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("SymptomsActive", "active");
			String symtomsId=objRequest.getParameter("SymptomsId");
			if(symtomsId!=null){
			objSymptomsBean.setSymsptomsId(objRequest.getParameter("SymptomsId"));
			}
			locobjSymptomsEditBean = objSymptomsService.getSymptoms(objSymptomsBean,"all");
			System.out.println(locobjSymptomsEditBean.getSymptomsName());
			model.addAttribute("SymptomsCmd", locobjSymptomsEditBean);
			objMap.addAttribute("SymptomsEdit", locobjSymptomsEditBean);
			
			
			List<SymptomsBean> listSymptomsBean = objSymptomsService.getSymptomss(objSymptomsBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listSymptomsBean);
			objRequest.setAttribute("SymptomsList", sJson);
		System.out.println(objRequest.getParameter("SymptomsId")+"hii");	
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit Symptoms in Symptoms controller");
		} finally {

		}
		return "SymptomsHome";
	}

	@RequestMapping(value = "/SymptomsUpdate", method = RequestMethod.POST)
	public String symptomsUpdate(

	@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		String symtomsId=objRequest.getParameter("SymptomsId");
		try {	
			System.out.println("hii coooo");
			objSymptomsBean.setSymsptomsId(symtomsId);
			bIsUpdate = objSymptomsService.updateSymptoms(objSymptomsBean);
			/*int SymptomsCount = objTestService.SymptomsDuplicate(objSymptomsBean);
			if (SymptomsCount == 0) {
				bIsUpdate = objTestService.updateSymptoms(objSymptomsBean);
			}*/
			objRequest.setAttribute("SymptomsActive", "active");
			if (bIsUpdate) {
				return "redirect:SymptomsHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:SymptomsHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update Symptoms in Symptoms controller");
			return "redirect:SymptomsHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deleteSymptoms", method = RequestMethod.POST)
	public @ResponseBody
	String deleteSymptoms(@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sSymptomsId = objRequest.getParameter("deleteId");
			if(sSymptomsId != null){
				objSymptomsBean.setSymsptomsId(sSymptomsId);
			}
			isDelete = objSymptomsService.deleteSymptoms(objSymptomsBean);
			objSymptomsBean.setSymsptomsId(null);
			List<SymptomsBean> listSymptomsBean = objSymptomsService.getSymptomss(objSymptomsBean,"all");
			for (SymptomsBean c : listSymptomsBean) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listSymptomsBean);
			objRequest.setAttribute("SymptomsActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete Symptoms in Symptoms controller");
			return "redirect:SymptomsHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

	@RequestMapping(value = "/SymptomsDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String SymptomsDuplicate(@ModelAttribute("SymptomsCmd") SymptomsBean objSymptomsBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sSymptomsName = objRequest.getParameter("symptomsName");
			String sSymptomsId = objRequest.getParameter("symptomsId");
			if (sSymptomsName != null && sSymptomsName.length() > 0) {
				objSymptomsBean.setSymptomsName(sSymptomsName);
			}
			
			if (sSymptomsId != null && sSymptomsId.length() > 0) {
				objSymptomsBean.setSymsptomsId(sSymptomsId);
			}
			List<SymptomsBean> listSymptomsBean = objSymptomsService.getSymptomss(objSymptomsBean, "all");
			if (listSymptomsBean != null && listSymptomsBean.size() > 0) {
				msg = "Warning ! Symptoms is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in duplicating Symptoms in Symptoms controller");
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
