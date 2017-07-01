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

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.aurospaces.neighbourhood.bean.DoctorDetailsBean;
import com.aurospaces.neighbourhood.bean.DoctorTypeBean;
import com.aurospaces.neighbourhood.service.DoctorDetailsService;
import com.aurospaces.neighbourhood.service.DoctorTypeService;
import com.aurospaces.neighbourhood.util.BrandingUtil;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;

/**
 * @author yogi
 * 
 */
@Controller
public class DoctorDetailsController {
	private static final int BUFFER_SIZE = 4096;

	@Autowired
	DoctorDetailsService objDoctorDetailsService;
	
	@Autowired
	DoctorTypeService objDoctorTypeService;

	private Logger logger = Logger.getLogger(DoctorDetailsController.class);
	@Autowired
	ServletContext servletContext;

	@RequestMapping(value = "/doctorHome", method = RequestMethod.GET)
	public String doctorDetailsHome(
			@ModelAttribute("doctorCmd") DoctorDetailsBean objDoctorDetailsBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("doctorActive", "active");
			objRequest.setAttribute("DoctorList", json);
			objSession.setAttribute("tabName", "doctorHome");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in doctorHome doctor controller");
		} finally {

		}
		return "doctorHome";
	}

	@RequestMapping(value = "/doctorAdd", method = RequestMethod.POST)
	public String doctordetailsAdd(
			@ModelAttribute("doctorCmd") DoctorDetailsBean objDoctorDetailsBean,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession objSession) {
		response.setCharacterEncoding("UTF-8");
		String stomcatRootPath = null;
		String sFileName = null;
		String sFilePath = null;
		String sCsvFile = null;
		String line = "";
		String cvsSplitBy = ",";
		String[] doctorArray = null;
		DoctorDetailsBean objdoctorBean = null;
		File newFile = null;
		MultipartFile objMultipartFile = null;
		List<DoctorDetailsBean> listDoctorDetailsBean = null;
		BufferedReader objBufferReader = null;
		BrandingUtil objBrandingUtil = null;
		NeighbourhoodUtil objNeighbourhoodUtil = null;
		boolean isInsert = false;
		DoctorTypeBean objDoctorTypeBean=null;
		try {
			objMultipartFile = objDoctorDetailsBean.getCsvFilePath();
			sFileName = objMultipartFile.getOriginalFilename();
			stomcatRootPath = System.getProperty("catalina.base");
			objBrandingUtil = new BrandingUtil();
			sFilePath = stomcatRootPath + File.separator + "webapps"+ File.separator + "UploadedCsvFiles" + File.separator+ "Doctor";
			System.out.println(sFilePath);
			System.out.println(objDoctorDetailsBean.getCsvFilePath());
			objBrandingUtil.createFile(sFilePath, servletContext,
			objDoctorDetailsBean.getCsvFilePath());
			objNeighbourhoodUtil = new NeighbourhoodUtil();
			sCsvFile = sFilePath+ File.separator+ "Doctor"+ objNeighbourhoodUtil.getCurrentTimestamp("yyyyMMddHHmmss")+".csv";
			// objRequest.setAttribute("doctorActive", "active");

			if (sFileName != null && sFileName.length() > 0) {
				 newFile = new File(sCsvFile);
				if (!newFile.exists()) {
					FileOutputStream fos = new FileOutputStream(newFile);
					fos.write(objMultipartFile.getBytes());
					fos.flush();
					fos.close();
				}
                System.out.println(sCsvFile);
				objBufferReader = new BufferedReader(new FileReader(sCsvFile));
				listDoctorDetailsBean = new ArrayList<DoctorDetailsBean>();

				while ((line = objBufferReader.readLine()) != null) {

					// use comma as separator
					doctorArray = line.split(cvsSplitBy);
					if (doctorArray != null && doctorArray.length > 0) {
						String stypeName= doctorArray[0];
						
						String sname = doctorArray[1];
						String smobileNo = doctorArray[2];
						String semail = doctorArray[3];
						String saddress = doctorArray[4];
						String sclinic=doctorArray[5];
						objDoctorTypeBean=new DoctorTypeBean();
						System.out.println(stypeName);
						
						
							
					

						if (sname != null && sname.length() > 0) {
							objdoctorBean = new DoctorDetailsBean();
							objDoctorTypeBean=new DoctorTypeBean();
							objDoctorTypeBean.setDoctortypeName(stypeName);
							objDoctorTypeBean=objDoctorTypeService.getDoctorTypename(objDoctorTypeBean, "");
							if (objDoctorTypeBean.getDoctortypeId()!= null) {
								objdoctorBean.setDoctortypeId(objDoctorTypeBean.getDoctortypeId());
							}

							objdoctorBean.setName(sname);
							objdoctorBean.setMobileNo(smobileNo);
							objdoctorBean.setEmailId(semail);
							objdoctorBean.setAddress(saddress);
							objdoctorBean.setClinic(sclinic);
							listDoctorDetailsBean.add(objdoctorBean);
						}

					}
				}
			}

			System.out.println("Doctor [code= " + doctorArray[0]);

			isInsert = objDoctorDetailsService.insertDoctorDetails(listDoctorDetailsBean);
			if (isInsert) {

				return "redirect:doctorHome.htm?AddSus=" + "Success" + "";
			} else {
				return "redirect:doctorHome.htm?AddFail=" + "fail" + "";
			}
		}

		catch (Exception e) {
			e.printStackTrace();
			logger.fatal("error in doctordetailsAdd() in DoctorDetailsController");
			logger.error("error in doctordetailsAdd() in DoctorDetailsController"+e.getMessage());
			return "redirect:doctorHome.htm?AddFail=" + "fail" + "";
		} finally {
			
		}
	}

}
