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

import com.aurospaces.neighbourhood.bean.PathologyTestTypeBean;
import com.aurospaces.neighbourhood.service.PathologyTestTypeService;


/**
 * @author 
 *
 */
@Controller
public class PathologyTestTypeController {
	@Autowired
	PathologyTestTypeService objPathologyTestTypeService;
	
	private Logger logger = Logger.getLogger(PathologyTestTypeController.class);
	
	@RequestMapping(value = "/PathologyTestTypeHome", method = RequestMethod.GET)
	public String TypeHome(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws  IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("PathologyTestTypeActive", "active");
			List<PathologyTestTypeBean> listPathologyTestTypeBean = objPathologyTestTypeService.getPathologyTestTypes(objPathologyTestTypeBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listPathologyTestTypeBean);
			objRequest.setAttribute("PathologyTestTypeList", json);
			objSession.setAttribute("tabName", "PathologyTestType");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in PathologyTestTypehome PathologyTestType controller");
		} finally {

		}
		return "PathologyTestTypeHome";
	}

	

	@RequestMapping(value = "/PathologyTestTypeAdd", method = RequestMethod.POST)
	public String TypeSave(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("PathologyTestTypeActive", "active");
			isInsert = objPathologyTestTypeService.insertPathologyTestType(objPathologyTestTypeBean);
			/*int TypeCount = objPathologyTestTypeService.PathologyTestTypeDuplicate(objPathologyTestTypeBean);
			if (TypeCount == 0) {
				isInsert = objPathologyTestTypeService.saveType(objPathologyTestTypeBean, true);
			}*/

			if (isInsert) {
				objSession.setAttribute("PathologyTestTypeId", objPathologyTestTypeBean.getTestTypeId());
				return "redirect:PathologyTestTypeHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:PathologyTestTypeHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in PathologyTestType save in PathologyTestType controller");
			logger.error(e.getMessage());
			return "redirect:PathologyTestTypeHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchPathologyTestType", method = RequestMethod.GET)
	public String searchType(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<PathologyTestTypeBean> listPathologyTestTypeBean = null;
		String sJson = "";
		objRequest.setAttribute("PathologyTestTypeActive", "active");
		try {
			listPathologyTestTypeBean = objPathologyTestTypeService.getPathologyTestTypes(objPathologyTestTypeBean,"both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listPathologyTestTypeBean);
			objRequest.setAttribute("PathologyTestTypeList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search PathologyTestType in PathologyTestType controller");
		} finally {

		}
		return "PathologyTestTypeHome";
	}

	@RequestMapping(value = "/editPathologyTestType", method = RequestMethod.GET)
	public String editType(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		PathologyTestTypeBean locobjPathologyTestTypeEditBean = null;
		String sJson = null;
		try {
			String sPathologyTestTypeId = objRequest.getParameter("testTypeId");
			objRequest.setAttribute("PathologyTestTypeActive", "active");
			objPathologyTestTypeBean.setTestTypeId(sPathologyTestTypeId);
			System.out.println(sPathologyTestTypeId);
			locobjPathologyTestTypeEditBean = objPathologyTestTypeService.getPathologyTestType(objPathologyTestTypeBean,"all");
			System.out.println(locobjPathologyTestTypeEditBean.getTestTypeName());
			model.addAttribute("PathologyTestTypeCmd", locobjPathologyTestTypeEditBean);
			objMap.addAttribute("PathologyTestTypeEdit", locobjPathologyTestTypeEditBean);
			
			objPathologyTestTypeBean.setTestTypeId(null);
			
			List<PathologyTestTypeBean> PathologyTestTypeBeanList = objPathologyTestTypeService.getPathologyTestTypes(objPathologyTestTypeBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(PathologyTestTypeBeanList);
			objRequest.setAttribute("PathologyTestTypeList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit PathologyTestType in PathologyTestType controller");
		} finally {

		}
		return "PathologyTestTypeHome";
	}

	@RequestMapping(value = "/PathologyTestTypeUpdate", method = RequestMethod.POST)
	public String TypeUpdate(

	@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {	
			bIsUpdate = objPathologyTestTypeService.updatePathologyTestType(objPathologyTestTypeBean);
			/*int PathologyTestTypeCount = objPathologyTestTestService.PathologyTestTypeDuplicate(objPathologyTestTypeBean);
			if (PathologyTestTypeCount == 0) {
				bIsUpdate = objPathologyTestTestService.updatePathologyTestType(objPathologyTestTypeBean);
			}*/
			objRequest.setAttribute("PathologyTestTypeActive", "active");
			if (bIsUpdate) {
				return "redirect:PathologyTestTypeHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:PathologyTestTypeHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update PathologyTestType in PathologyTestType controller");
			return "redirect:PathologyTestTypeHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deletePathologyTestType", method = RequestMethod.POST)
	public @ResponseBody
	String deleteType(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sPathologyTestTypeId = objRequest.getParameter("deletePathologyTestTypeId");
			if(sPathologyTestTypeId != null){
				objPathologyTestTypeBean.setTestTypeId(sPathologyTestTypeId);
			}
			isDelete = objPathologyTestTypeService.deletePathologyTestType(objPathologyTestTypeBean);
			objPathologyTestTypeBean.setTestTypeId(null);
			List<PathologyTestTypeBean> listPathologyTestTypeBean = objPathologyTestTypeService.getPathologyTestTypes(objPathologyTestTypeBean,"all");
			for (PathologyTestTypeBean c : listPathologyTestTypeBean) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listPathologyTestTypeBean);
			objRequest.setAttribute("TypeActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete PathologyTestType in PathologyTestType controller");
			return "redirect:PathologyTestTypeHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

	@RequestMapping(value = "/PathologyTestTypeDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String TypeDuplicate(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sPathologyTestTypeName = objRequest.getParameter("PathologyTestTypeName");
			System.out.println(sPathologyTestTypeName);
			String sPathologyTestTypeId = objRequest.getParameter("PathologyTestTypeId");
			if (sPathologyTestTypeName != null && sPathologyTestTypeName.length() > 0) {
				objPathologyTestTypeBean.setTestTypeName(sPathologyTestTypeName);
			}
			
			if (sPathologyTestTypeId != null && sPathologyTestTypeId.length() > 0) {
				objPathologyTestTypeBean.setTestTypeId(sPathologyTestTypeId);
			}
			List<PathologyTestTypeBean> listPathologyTestTypeBean = objPathologyTestTypeService.getPathologyTestTypes(objPathologyTestTypeBean, "all");
			if (listPathologyTestTypeBean != null && listPathologyTestTypeBean.size() > 0) {
				msg = "Warning ! Type is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in duplicating PathologyTestType in PathologyTestType controller");
		} finally {
		}
		return msg;
	}



	public static void main(String[] args) {
		
	}

	/*@RequestMapping(value = "/searchingBasedOnDepartment", method = RequestMethod.POST)
	public @ResponseBody
	String searchingBasedOnDepartment(

	@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean, HttpServletRequest request,
			HttpServletResponse response, @RequestParam("deptId") String sDeptId) {
		response.setCharacterEncoding("UTF-8");
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		List<PathologyTestTypeBean> listPathologyTestTypeSearch = null;
		try {

			session.setAttribute("deptId", sDeptId);
			listPathologyTestTypeSearch = objPathologyTestTestService.PathologyTestTypeSearch(objPathologyTestTypeBean);

			if ("All".equals(sDeptId)) {
				listPathologyTestTypeSearch = objPathologyTestTestService.PathologyTestTypeSearch(objPathologyTestTypeBean);
			} else {
				session.setAttribute("deptId", sDeptId);
				listPathologyTestTypeSearch = objPathologyTestTestService.PathologyTestTypeSearch(objPathologyTestTypeBean);
			}
			json = mapper.writeValueAsString(listPathologyTestTypeSearch);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnDepartment in PathologyTestType controller");
			logger.error(e.getMessage());
		} finally {

		}
		return json;
	}

	@RequestMapping(value = "/PathologyTestsearchingBasedOnClient", method = RequestMethod.POST)
	public @ResponseBody
	String searchingBasedOnClient(@ModelAttribute("PathologyTestTypeCmd") PathologyTestTypeBean objPathologyTestTypeBean,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam("clientId") String clientId) {
		response.setCharacterEncoding("UTF-8");
		List<PathologyTestTypeBean> listPathologyTestTypeSearch = null;
		String json = null;
		ObjectMapper mapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		try {
			if ("All".equals(clientId)) {
				listPathologyTestTypeSearch = objPathologyTestTestService.PathologyTestTypeSearch(objPathologyTestTypeBean);
			} else {
				session.setAttribute("cid", clientId);
				listPathologyTestTypeSearch = objPathologyTestTestService.PathologyTestTypeSearch(objPathologyTestTypeBean);
			}
			json = mapper.writeValueAsString(listPathologyTestTypeSearch);
		} catch (Exception e) {
			logger.fatal("error in searchingBasedOnClient in PathologyTestType controller");
			logger.error(e.getMessage());
		} finally {
		}
		return json;
	}*/
}

