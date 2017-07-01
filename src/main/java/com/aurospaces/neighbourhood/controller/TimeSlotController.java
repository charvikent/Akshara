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

import com.aurospaces.neighbourhood.bean.TimeSlotBean;
import com.aurospaces.neighbourhood.service.TimeSlotService;

/**
 * @author yogi
 * 
 */
@Controller
public class TimeSlotController {
	@Autowired
	TimeSlotService objTimeSlotService;
	
	private Logger logger = Logger.getLogger(TimeSlotController.class);

	@RequestMapping(value = "/TimeslotHome", method = RequestMethod.GET)
	public String TimeSlotHome(@ModelAttribute("timeslotCmd") TimeSlotBean objTimeslotBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("TimeslotActive", "active");
			List<TimeSlotBean> listCatBean = objTimeSlotService.getTimeslots(objTimeslotBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			json = mapper.writeValueAsString(listCatBean);
			objRequest.setAttribute("TimeslotList", json);
			objSession.setAttribute("tabName", "TimeSlot");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in TimeslotHome TimeSlot controller");
		} finally {

		}
		return "timeSlot";
	}

	

	@RequestMapping(value = "/TimeslotAdd", method = RequestMethod.POST)
	public String TimeSlotSave(@ModelAttribute("timeslotCmd") TimeSlotBean objTimeslotBean,
			ModelMap map, HttpServletRequest objRequest, BindingResult result,
			HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean isInsert = false;
		try {
			objRequest.setAttribute("TimeslotActive", "active");
			System.out.println("objTimeslotBean"+objTimeslotBean.getSlotDesc());
			System.out.println("objTimeslotBean"+objTimeslotBean.getSlotLabel());
			isInsert = objTimeSlotService.insertTimeslot(objTimeslotBean);
			
			/*int catCount = objTimeSlotService.catDuplicate(objTimeslotBean);
			if (catCount == 0) {
				isInsert = objTimeSlotService.saveTimeSlot(objTimeslotBean, true);
			}*/

			if (isInsert) {
				return "redirect:TimeslotHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:TimeslotHome.htm?AddFail=" + "fail" + "";
			}
		} catch (Exception e) {
			logger.fatal("error in TimeSlot save in TimeSlot controller");
			logger.error(e.getMessage());
			return "redirect:catHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}

	@RequestMapping(value = "/searchTimeSlot", method = RequestMethod.GET)
	public String searchCat(@ModelAttribute("timeslotCmd") TimeSlotBean objTimeslotBean,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest) {
		objResponse.setCharacterEncoding("UTF-8");
		List<TimeSlotBean> listCatBean = null;
		String sJson = "";
		objRequest.setAttribute("TimeSlotActive", "active");
		try {
			/*listCatBean = objTimeSlotService.getTimeslots(objTimeslotBean,"both");
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listCatBean);
			objRequest.setAttribute("CatList", sJson);*/
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search TimeSlot in TimeSlot controller");
		} finally {

		}
		return "TimeslotHome";
	}

	@RequestMapping(value = "/editTimeSlot", method = RequestMethod.GET)
	public String editCat(@ModelAttribute("timeslotCmd") TimeSlotBean objTimeslotBean,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		TimeSlotBean locobjCatEditBean = null;
		String sJson = null;
		try {
			objRequest.setAttribute("TimeSlotActive", "active");
			String sSlotId = objRequest.getParameter("slotId");
			if(sSlotId != null){
				objTimeslotBean.setSlotId(sSlotId);
			}
			locobjCatEditBean = objTimeSlotService.getTimeslot(objTimeslotBean,"all");
			//System.out.println(locobjCatEditBean.getCategoryName());
			objRequest.setAttribute("TimeslotActive", "active");
			System.out.println("objTimeslotBean"+locobjCatEditBean.getSlotDesc());
			System.out.println("objTimeslotBean"+locobjCatEditBean.getSlotLabel());
			model.addAttribute("timeslotCmd", locobjCatEditBean);
			objMap.addAttribute("TimeSlotEdit", locobjCatEditBean);
			
			objTimeslotBean.setSlotId(null);
			
			List<TimeSlotBean> catBeanList = objTimeSlotService.getTimeslots(objTimeslotBean,"all");
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(catBeanList);
			objRequest.setAttribute("TimeslotList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in edit TimeSlot in TimeSlot controller");
		} finally {

		}
		return "TimeslotHome";
	}

	@RequestMapping(value = "/TimeSlotUpdate", method = RequestMethod.POST)
	public String catUpdate(

	@ModelAttribute("timeslotCmd") TimeSlotBean objTimeslotBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		try {	
			bIsUpdate = objTimeSlotService.updateTimeslot(objTimeslotBean);
			/*int catCount = objTestService.catDuplicate(objTimeslotBean);
			if (catCount == 0) {
				bIsUpdate = objTestService.updateTimeSlot(objTimeslotBean);
			}*/
			objRequest.setAttribute("catActive", "active");
			if (bIsUpdate) {
				return "redirect:TimeSlotHome.htm?UpdateSus=" + "Success" + "";
			} else {
				return "redirect:TimeSlotHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			logger.error(e.getMessage());
			logger.fatal("error in update TimeSlot in TimeSlot controller");
			return "redirect:TimeSlotHome.htm?UpdateFail=" + "fail" + "";
		}
	}

	@RequestMapping(value = "/deleteTimeSlot", method = RequestMethod.POST)
	public @ResponseBody
	String deleteCat(@ModelAttribute("TimeSlotCmd") TimeSlotBean objTimeslotBean,
			HttpServletResponse objResponse, HttpServletRequest objRequest,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = null;
		boolean isDelete = false;
		try {
			String sTimeSlotId = objRequest.getParameter("deleteId");
			if(sTimeSlotId != null){
				objTimeslotBean.setSlotId(sTimeSlotId);
			}
			isDelete = objTimeSlotService.deleteTimeslot(objTimeslotBean);
			objTimeslotBean.setSlotId(null);
			List<TimeSlotBean> listTimeslotBean = objTimeSlotService.getTimeslots(objTimeslotBean,"all");
			for (TimeSlotBean c : listTimeslotBean) {
				if (isDelete) {
					c.setsMsg("Success");
				} else {
					c.setsMsg("Fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listTimeslotBean);
			objRequest.setAttribute("TimeSlotActive", "active");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in delete TimeSlot in TimeSlot controller");
			return "redirect:TimeSlotHome.htm?DeleteFail=" + "fail" + "";
		} finally {

		}
		return sJson;
	}

	/*@RequestMapping(value = "/TimeSlotDuplicate", method = RequestMethod.POST)
	public @ResponseBody
	String TimeSlotDuplicate(@ModelAttribute("TimeSlotCmd") TimeSlotBean objTimeslotBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		String msg = null;
		System.out.println("response"+response);
		try {
			String sCategoryName = objRequest.getParameter("catname");
			String sCategoryId = objRequest.getParameter("catId");
			if (sCategoryName != null && sCategoryName.length() > 0) {
				objCatBean.setCategoryName(sCategoryName);
			}
			
			if (sCategoryId != null && sCategoryId.length() > 0) {
		objCatBean.setCategoryId(sCategoryId);
			}
			List<TimeSlotBean> listCatBean = objTimeSlotService.getTimeslots(objCatBean, "all");
			if (listCatBean != null && listCatBean.size() > 0) {
				msg = "Warning ! TimeSlot is already exists. Please try some other name";
			} else {
				msg = "";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in duplicating TimeSlot in TimeSlot controller");
		} finally {
		}
		return msg;
	}*/
}
