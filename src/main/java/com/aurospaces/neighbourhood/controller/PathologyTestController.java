/**
 * 
 *//*
package com.aurospaces.neighbourhood.controller;

import java.io.IOException;
import java.util.List;

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

import com.aurospaces.neighbourhood.bean.CategoryBean;
import com.aurospaces.neighbourhood.bean.PathologyBean;
import com.aurospaces.neighbourhood.service.CategoryService;
import com.aurospaces.neighbourhood.service.PathologyTestService;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

*//**
 * @author Divya
 *
 *//*
@Controller
public class PathologyTestController {
	@Autowired
PathologyTestService objPathologyService;
	
	private Logger logger = Logger.getLogger(PathologyController.class);

	@RequestMapping(value = "/PathologyHome", method = RequestMethod.GET)
	public String PathologyHome(@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("PathologyActive", "active");
			List<PathologyBean> listPathologyBean = objPathologyService.getPathologys(objPathologyBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listPathologyBean);
			objRequest.setAttribute("PathologyList", json);
			objSession.setAttribute("tabName", "Pathology");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in Pathologyhome Pathology controller");
		} finally {

		}
		return "PathologyHome";
	}

	

	@RequestMapping(value = "/PathologyAdd", method = RequestMethod.POST)
	public String PathologySave(@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("PathologyActive", "active");
			isInsert = objPathologyService.insertPathology(objPathologyBean);
			int PathologyCount = objPathologyService.PathologyDuplicate(objPathologyBean);
			if (PathologyCount == 0) {
				isInsert = objPathologyService.savePathology(objPathologyBean, true);
			}

			if (isInsert) {
				objSession.setAttribute("TestName", objPathologyBean.getTestName());
				return "redirect:PathologyHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:PathologyHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in Pathology save in Pathology controller");
			logger.error(e.getMessage());
			return "redirect:PathologyHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchPathology", method = RequestMethod.GET)
	public String searchCat(@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<CategoryBean> listCatBean = null;
		String sJson = "";
		objRequest.setAttribute("PathologyActive", "active");
		try {
			listCatBean = objPathologyService.getCategorys(objPathologyBean,"both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listCatBean);
			objRequest.setAttribute("CatList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search Pathology in Pathology controller");
		} finally {

		}
		return "PathologyHome";
	}

	@RequestMapping(value = "/editCat", method = RequestMethod.GET)
	public String editCat(@ModelAttribute("PathologyCmd") CategoryBean objCatBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		PathologyBean locobjPathologyEditBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("PathologyActive", "active");
			locobjPathologyEditBean = objPathologyService.getPathology(objPathologyBean,"all");
			System.out.println(locobjPathologyEditBean.getPathologyName());
			model.addAttribute("PathologyCmd", locobjPathologyEditBean);
			objMap.addAttribute("PathologyEdit", locobjPathologyEditBean);
			
			objPathologyBean.setTestName(null);
			
			List<PathologyBean> PathologyBeanList = objPathologyBean.getPathologys(objPathologyBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(PathologyBeanList);
			objRequest.setAttribute("PathologyList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit Pathology in Pathology controller");
		} finally {

		}
		return "PathologyHome";
	}

	@RequestMapping(value = "/PathologyUpdate", method = RequestMethod.POST)
	public String PathologyUpdate(

	@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {	
			bIsUpdate = objPathologyService.updatePathology(objPathologyBean);
			int PathologyCount = objTestService.PathologyDuplicate(objPathologyBean);
			if (PathologyCount == 0) {
				bIsUpdate = objTestService.updatePathology(objPathologyBean);
			}
			objRequest.setAttribute("PathologyActive", "active");
			if (bIsUpdate) {
				return "redirect:PathologyHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:PathologyHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update Pathology in Pathology controller");
			return "redirect:PathologyHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deletePathology", method = RequestMethod.POST)
	public @ResponseBody
	String deleteCat(@ModelAttribute("PathologyCmd") PathologyBean objCatBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sTestName = objRequest.getParameter("deleteId");
			if(sTestName != null){
				objCatBean.setTestName(sTestName);
			}
			isDelete = objPathologyService.deletePathology(objPathologyPatBean);
			objCatBean.setTestName(null);
			List<PathologyBean> listPathologyBean = objPathologyService.getPathologys(objPathologyBean,"all");
			for (PathologyBean c : listPathologyBean) {
				if (isDelete) {
					c.setPrice("Success");
				} else {
					c.setPrice("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listPathologyBean);
			objRequest.setAttribute("PathologyActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete Pathology in Pathology controller");
			return "redirect:PathologyHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

	@RequestMapping(value = "/PathologyDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String PathologyDuplicate(@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sTestName = objRequest.getParameter("Testname");
			String sTestDesc = objRequest.getParameter("Price");
			if (sTestName != null && sTestName.length() > 0) {
				objPathologyBean.setPrice(sTestName);
			}
			
			if (sTestName != null && sTestName.length() > 0) {
				objPathologyBean.setCategoryId(sTestName);
			}
			List<PathologyBean> listPathologyBean = objPathologyService.getPathologys(objPathologyBean, "all");
			if (listCatBean != null && listCatBean.size() > 0) {
				msg = "Warning ! Pathology is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in duplicating Pathology in Pathology controller");
		} finally {
		}
		return msg;
	}

	@RequestMapping(value = "/searchingBasedOnDepartment", method = RequestMethod.POST)
	public @ResponseBody
	String searchingBasedOnDepartment(

	@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean, HttpServletRequest request,
			HttpServletResponse response, @RequestParam("TestName") String sTestName) {
		response.setCharacterEncoding("UTF-8");
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		List<PathologyBean> listPathologySearch = null;
		try {

			session.setAttribute("TestName", sTestName);
			listPathologySearch = objTestService.PathologySearch(objPathologyBean);

			if ("All".equals(sDeptId)) {
				listPathologySearch = objTestService.PathologySearch(objPathologyBean);
			} else {
				session.setAttribute("deptId", sDeptId);
				listPathologySearch = objTestService.PathologySearch(objPathologyBean);
			}
			json = mapper.writeValueAsString(listPathologySearch);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnDepartment in Pathology controller");
			logger.error(e.getMessage());
		} finally {

		}
		return json;
	}

	@RequestMapping(value = "/searchingBasedOnClient", method = RequestMethod.POST)
	public @ResponseBody
	String searchingBasedOnClient(@ModelAttribute("PathologyCmd") PathologyBean objPathologyBean,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam("clientId") String clientId) {
		response.setCharacterEncoding("UTF-8");
		List<PathologyBean> listPathologySearch = null;
		String json = null;
		ObjectMapper mapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		try {
			if ("All".equals(clientId)) {
				listPathologySearch = objTestService.PathologySearch(objPathologyBean);
			} else {
				session.setAttribute("cid", clientId);
				listPathologySearch = objTestService.PathologySearch(objPathologyBean);
			}
			json = mapper.writeValueAsString(listPathologySearch);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnClient in Pathology controller");
			logger.error(e.getMessage());
		} finally {
		}
		return json;
	}
}
*/
