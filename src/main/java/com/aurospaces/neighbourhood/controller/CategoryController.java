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

import com.aurospaces.neighbourhood.db.dao.Category1Dao;
import com.aurospaces.neighbourhood.db.model.Category1;

/**
 * @author yogi
 * 
 */
@Controller
public class CategoryController {
	@Autowired
	Category1Dao objCategory1Dao;
	private Logger logger = Logger.getLogger(CategoryController.class);

	@RequestMapping(value = "/catHome", method = RequestMethod.GET)
	public String categoryHome(@ModelAttribute("catCmd") Category1 objCategoryBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("catActive", "active");
			List<Category1> listCatBean  = objCategory1Dao.getAll();
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listCatBean);
			objRequest.setAttribute("CatList", json);
			objSession.setAttribute("tabName", "Category");

			
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in cathome category controller");
		} finally {

		}
		return "catHome";
	}

	

	@RequestMapping(value = "/catAdd")
	public String categorySave(@ModelAttribute("catCmd") Category1 objCatBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("catActive", "active");
			 objCategory1Dao.save(objCatBean);
			 isInsert = true;
			/*int catCount = objCategoryService.catDuplicate(objCatBean);
			if (catCount == 0) {
				isInsert = objCategoryService.saveCategory(objCatBean, true);
			}*/

			if (isInsert) {
				objSession.setAttribute("cateogryId", objCatBean.getId());
				return "redirect:catHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:catHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in category save in category controller");
			logger.error(e.getMessage());
			return "redirect:catHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchCat")
	public String searchCat(@ModelAttribute("catCmd") Category1 objCategory1,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<Category1> listCatBean =  null;
		String sJson = "";
		objRequest.setAttribute("catActive", "active");
		try {
			listCatBean = objCategory1Dao.getAll();
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listCatBean);
			objRequest.setAttribute("CatList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search category in category controller");
		} finally {

		}
		return "catHome";
	}

	@RequestMapping(value = "/editCat")
	public String editCat(@ModelAttribute("catCmd") Category1 objCategory1,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		Category1 locobjCatEditBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("catActive", "active");
			locobjCatEditBean = objCategory1Dao.getById(objCategory1.getId());
			model.addAttribute("catCmd", locobjCatEditBean);
			objMap.addAttribute("catEdit", locobjCatEditBean);
			objCategory1.setId(0);
			List<Category1> catBeanList = objCategory1Dao.getAll();
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(catBeanList);
			objRequest.setAttribute("CatList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit category in category controller");
		} finally {

		}
		return "catHome";
	}

	@RequestMapping(value = "/catUpdate")
	public String catUpdate(

	@ModelAttribute("catCmd") Category1 objCategory1,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {	
			
			objCategory1Dao.save(objCategory1);	
			bIsUpdate =true;
			/*int catCount = objTestService.catDuplicate(objCatBean);
			if (catCount == 0) {
				bIsUpdate = objTestService.updateCategory(objCatBean);
			}*/
			objRequest.setAttribute("catActive", "active");
			if (bIsUpdate) {
				return "redirect:catHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:catHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in update category in category controller");
			return "redirect:catHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deleteCat", method = RequestMethod.POST)
	public @ResponseBody
	String deleteCat(@ModelAttribute("catCmd") Category1 objCategory1,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sCategoryId = objRequest.getParameter("deleteId");
			/*if(sCategoryId != null){
				objCatBean.setid(sCategoryId);
			}*/
//			isDelete = objCategoryService.deleteCategory(objCategory1);
//			objCategory1.setId(0);
			List<Category1> listCatBean = objCategory1Dao.getAll();
			for (Category1 c : listCatBean) {
				/*if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}*/
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listCatBean);
			objRequest.setAttribute("catActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete category in category controller");
			return "redirect:catHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

/*	@RequestMapping(value = "/catDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String categoryDuplicate(@ModelAttribute("catCmd") CategoryBean objCatBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		try {
			String sCategoryName = objRequest.getParameter("catname");
			String sCategoryId = objRequest.getParameter("catId");
			if (sCategoryName != null && sCategoryName.length() > 0) {
				objCatBean.setCategoryName(sCategoryName);
			}
			
			if (sCategoryId != null && sCategoryId.length() > 0) {
				objCatBean.setCategoryId(sCategoryId);
			}
			List<CategoryBean> listCatBean = objCategoryService.getCategorys(objCatBean, "all");
			if (listCatBean != null && listCatBean.size() > 0) {
				msg = "Warning ! Category is already exists. Please try some other name";
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
*/
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
