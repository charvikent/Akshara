/**
 * 
 */
package com.aurospaces.neighbourhood.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aurospaces.neighbourhood.bean.PathologyTestsBean;
import com.aurospaces.neighbourhood.db.dao.PackageReviewsDao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnitHappinessDao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnitVendorDao;
import com.aurospaces.neighbourhood.db.dao.VendorService1Dao;
import com.aurospaces.neighbourhood.db.model.PackageReviews;
import com.aurospaces.neighbourhood.db.model.ServiceUnit1;
import com.aurospaces.neighbourhood.db.model.ServiceUnitHappiness;
import com.aurospaces.neighbourhood.db.model.ServiceUnitVendor;
import com.aurospaces.neighbourhood.db.model.VendorService1;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.service.ServicesService;
import com.aurospaces.neighbourhood.util.BrandingUtil;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;

/**
 * @author Amit
 * 
 */
@Controller
public class PackegeInsertionController {
	String val="";
	@Autowired
	ServletContext servletContext;
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	ServicesService objServicesService;
	@Autowired
	ServiceUnit1Dao objServiceUnit1Dao;
	@Autowired
	VendorService1Dao objVendorService1Dao;
	@Autowired
	Service1Dao service1Dao;
	@Autowired
	ServiceUnitVendorDao objserviceunitvendorDao;
	@Autowired
	DataSourceTransactionManager transactionManager;
	@Autowired
	ServletContext objContext;
	@Autowired
	ServiceUnitVendorDao objServiceUnitVendorDao;
	@Autowired ServiceUnitHappinessDao objHappinessDao;
	@Autowired PackageReviewsDao packageReviewsDao;
	Logger logger = Logger.getLogger(PackegeInsertionController.class);

	@RequestMapping(value = "/packageHome", method = RequestMethod.GET)
	public String homeServices(
			@ModelAttribute("packCmd")ServiceUnit1 objServiceUnit1,
			HttpSession objSession, HttpServletRequest objRequest,
			HttpServletResponse objResponse) {
		String sJson = null;
		try {
			List<ServiceUnit1> listServiceUnit = objServiceUnit1Dao.getAll(objServiceUnit1);
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(listServiceUnit);
//			objRequest.setAttribute("ServiceList", sJson);
			objRequest.setAttribute("ServiceList", "");
			objSession.setAttribute("tabName", "Services");
			objRequest.setAttribute("packageActive", "active");
		} catch (Exception e) {
e.printStackTrace();
		} finally {

		}
		return "packageHome";
	}

	@RequestMapping(value = "/packageAdd")
	public String insertServices(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			HttpServletRequest objRequest, HttpServletResponse objResponse) {
		String discount = null;
		String price = null;
		try {
			//discount = objServiceUnit1.getDiscount();
			objServiceUnit1.setVendorId(Integer.parseInt(objServiceUnit1.getVendorName()));
			objServiceUnit1.setServiceId(Integer.parseInt(objServiceUnit1.getServiceName()));
			//BigDecimal disco=new BigDecimal(discount);
			//BigDecimal prices=new BigDecimal(price);
			//objServiceUnit1.setPrice(prices);
			//objServiceUnit1.setDiscount(disco);
			/*objServiceUnit1.setDiscountPrice(NeighbourhoodUtil.getDiscountPrice(objServiceUnit1.getPrice(), objServiceUnit1.getDiscount()));
			objServiceUnit1.setFinalPrice(NeighbourhoodUtil.getDiscount(objServiceUnit1.getPrice(), objServiceUnit1.getDiscountPrice()));*/
			objServiceUnit1Dao.save(objServiceUnit1);
			return "redirect:packageHome.htm?AddSus=" + "Success" + "";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:packageHome.htm?AddFail=" + "fail" + "";
		} finally {

		}
	}
	@ModelAttribute("vendors")
	public Map<String, String> populateCateogrys() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id, concat_ws (' ',first_name,last_name) from vendor1";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@RequestMapping(value = "/getServicesForVendors")
	public @ResponseBody String forServices(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<VendorService1> listServiceUnit1=null;
		String json="";
		String vendorId = request.getParameter("vendorId");
		listServiceUnit1=  objVendorService1Dao.getServicesForVendor(vendorId);
		ObjectMapper objmapper=new ObjectMapper();
		json=objmapper.writeValueAsString(listServiceUnit1);
		System.out.println("listServiceUnit1.size()==="+listServiceUnit1.size());
		request.setAttribute("seviceList", json);
	  return json;


	}
	@RequestMapping(value = "/searchPackageName", method = RequestMethod.GET)
	public String searchService(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		List<ServiceUnit1> listServiceUnit1 = null;
		String sJson = "";
		objRequest.setAttribute("serActive", "active");
		try {
			listServiceUnit1 = objServiceUnit1Dao.searchPackage(objServiceUnit1);
			ObjectMapper objMapper = new ObjectMapper();
			sJson = objMapper.writeValueAsString(listServiceUnit1);
			objRequest.setAttribute("ServiceList", sJson);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in search category in category controller");
		} finally {

		}
		return "packageHome";
	}


	/*@RequestMapping(value = "/editPackage", method = RequestMethod.GET)
	public String editPackage(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		ServiceUnit1 localobjServiceUnit1 = null;
		String sJson = null;
		try {
			objRequest.setAttribute("serActive", "active");
			localobjServiceUnit1=objServiceUnit1Dao.editPackage(objServiceUnit1.getId());
			System.out.println(localobjServiceUnit1.getServiceName());
			model.addAttribute("packCmd", localobjServiceUnit1);
			objMap.addAttribute("servEdit", localobjServiceUnit1);
			List<ServiceUnit1> objServiceUnit1List = objServiceUnit1Dao.getAll(objServiceUnit1);
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(objServiceUnit1List);
			objRequest.setAttribute("ServiceList", sJson);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in edit serivce in category controller");
		} finally {

		}
		return "packageHome";
	}*/
	@RequestMapping(value = "/searchPackage")
	public @ResponseBody String serarchPackage(
			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			Model model, ModelMap objMap, HttpServletResponse objResponse,
			HttpServletRequest objRequest, HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		String sJson = "";
		try {
			objRequest.setAttribute("serActive", "active");
			int vendorId=Integer.parseInt(objRequest.getParameter("vendorId"));
			if(StringUtils.isNotBlank(objRequest.getParameter("seId"))){
			 objServiceUnit1.setServiceId(Integer.parseInt(objRequest.getParameter("seId")));
			}
			objServiceUnit1.setVendorId(vendorId);
			List<ServiceUnit1> objServiceUnit1List = objServiceUnit1Dao.getAll(objServiceUnit1);
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(objServiceUnit1List);
			System.out.println(sJson);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in edit serivce in category controller");
		} finally {

		}
		return sJson;
	}

	@RequestMapping(value = "/packageDelete", method = RequestMethod.POST)
	public @ResponseBody String packageDelete(

			@ModelAttribute("packCmd") ServiceUnit1 objServiceUnit1,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession) {
		objResponse.setCharacterEncoding("UTF-8");
		boolean bIsUpdate = false;
		String packageId=objRequest.getParameter("packageId");
		String vendorId = objRequest.getParameter("vendorId");
		objServiceUnit1.setVendorId(Integer.parseInt(vendorId));
		String sJson="";
		try {
			objServiceUnit1Dao.delete(Integer.parseInt(packageId));
			List<ServiceUnit1> objServiceUnit1List = objServiceUnit1Dao.getAll(objServiceUnit1);
			ObjectMapper mapper = new ObjectMapper();
			sJson = mapper.writeValueAsString(objServiceUnit1List);
			System.out.println(sJson);

			bIsUpdate=true;
			objRequest.setAttribute("serActive", "active");
			if (bIsUpdate) {
				 return sJson;
			} else {
				return "redirect:packageHome.htm?UpdateFail=" + "fail" + "";
			}

		} catch (Exception e) {
			bIsUpdate = false;
			e.printStackTrace();
			logger.error(e.getMessage());
			logger.fatal("error in update category in category controller");
			return "redirect:serHome.htm?UpdateFail=" + "fail" + "";
		}
		
	}

// label=&discount=0&description=Description+of+the+service&name=Boombox&price=49994&vendorId=2&id=1617

	@RequestMapping(value = "/updatePackage")
	public @ResponseBody List<ServiceUnit1> updatePackage(
	@RequestParam("id") int id,
	@RequestParam("label") String label,
	@RequestParam("description") String description,
	@RequestParam("vendorId") int vendorId,
	@RequestParam("serviceId") int serviceId,
	@RequestParam("name") String name,
	@RequestParam("price") String price,
	@RequestParam("discount") String discount,
	@RequestParam("couponDiscount") int cdiscount,
			HttpServletRequest objRequest, HttpServletResponse objResponse,
			HttpSession objSession) throws IOException {
				ServiceUnit1 servUnit = null;
				ServiceUnitVendor objServiceUnitVendor=null;
				ServiceUnitHappiness serviceUnitHappiness= null;
				PackageReviews packageReviews= null;
				if(id != 0)
				{
					servUnit = objServiceUnit1Dao.getById(id);
					objServiceUnitVendor = objServiceUnitVendorDao.getByServiceUnitId(id);
					serviceUnitHappiness = objHappinessDao.getByServiceUnitId(id);
					packageReviews = packageReviewsDao.getById(serviceId);
					System.out.println(objServiceUnitVendor.getId());
				}
				else
				{
					servUnit = new  ServiceUnit1();
					servUnit.setVendorId(vendorId);
					servUnit.setServiceId(serviceId);
					objServiceUnitVendor = new ServiceUnitVendor();
					 packageReviews = new PackageReviews();
					serviceUnitHappiness =  new ServiceUnitHappiness();
				}
				servUnit.setDescription(description);
				servUnit.setLabel(label);
				servUnit.setName(name);
				servUnit.setActive(1);
				objServiceUnit1Dao.save(servUnit);
				System.out.println(servUnit.getId());
				
				objServiceUnitVendor.setPrice(new BigDecimal(price));
				objServiceUnitVendor.setDiscount(new BigDecimal(discount));
				objServiceUnitVendor.setLabel(label);
				objServiceUnitVendor.setDiscountPrice(NeighbourhoodUtil.getDiscount(price, discount));
				System.out.println(objServiceUnitVendor.getDiscountPrice());
				objServiceUnitVendor.setFinalPrice(objServiceUnitVendor.getPrice().subtract(objServiceUnitVendor.getDiscountPrice()));
				objServiceUnitVendor.setVendorId(vendorId);
				objServiceUnitVendor.setServiceUnitId(servUnit.getId());
				objServiceUnitVendor.setCouponDiscount(cdiscount);
				objServiceUnitVendorDao.save(objServiceUnitVendor);
				
				serviceUnitHappiness.setServiceUnitId(objServiceUnitVendor.getId());
				serviceUnitHappiness.setVendorId(vendorId);
				serviceUnitHappiness.setHappiness(80);
				serviceUnitHappiness.setTimeToServe(3);
				serviceUnitHappiness.setServedNumber(1);
				serviceUnitHappiness.setFeedback("high rated package.");
				objHappinessDao.save(serviceUnitHappiness);
				
				
				packageReviews.setServiceUnitId(objServiceUnitVendor.getId());
				packageReviews.setName("");
				packageReviews.setProfilePic("");
				packageReviews.setReview("good service provider");
				packageReviewsDao.save(packageReviews);
				  
				
				List<ServiceUnit1> objServiceUnit1List = objServiceUnit1Dao.getAll(servUnit);
				return objServiceUnit1List;
			}

// subclassing ExceptionHandlerExceptionResolver (see below).
  @ExceptionHandler(Exception.class)
  public String handleError(HttpServletRequest req, Exception exception) {
//    logger.error("Request: " + req.getRequestURL() + " raised " + exception);
				exception.printStackTrace();
//    ModelAndView mav = new ModelAndView();
 //   mav.addObject("exception", exception);
  //  mav.addObject("url", req.getRequestURL());
   // mav.setViewName("error");
    return "junk";
  }
  
  @RequestMapping(value = "/csvPackageInsert", method = RequestMethod.GET)
	public String MedicalHome(
			@ModelAttribute("pathologyInventoryCmd1") PathologyTestsBean objPathologyTestsBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("PackActive", "active");

			objRequest.setAttribute("PathologyList", json);
			objSession.setAttribute("tabName", "Pathology Inventory");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in Pathologyhome Pathology controller");
		} finally {

		}
		return "csvPackageInsertHome";
	} 
  
  
  @RequestMapping(value = "/pathologyInventoryAdd1", method = RequestMethod.POST)
	public String pathologyInventoryAdd1(
			@ModelAttribute("pathologyInventoryCmd1") ServiceUnit1 objserviceunit,
			HttpServletRequest objRequest, HttpServletResponse response,
			HttpSession objSession, Model mode) {
		response.setCharacterEncoding("UTF-8");
		
		boolean isInsert = false;
		
		String sDirPath = null;
		String sTomcatRootPath = null;
		String sFileName = null;
		String line = "";
		String cvsSplitBy = "\\|";
		String sCSVFile = null;
		String[] pathologyArray = null;

		BrandingUtil objBrandingUtil = null;
		MultipartFile objMultipartFile = null;
		PathologyTestsBean objLocalPathologyTestsBean = null;
		ServiceUnit1 objServiceUnit = null;
		List<PathologyTestsBean> listPathologyTestBean = null;
		BufferedReader objBufferReader = null;
		File newFile = null;
		NeighbourhoodUtil objNeighbourhoodUtil = null;
		TransactionStatus objTransStatus = null;
		TransactionDefinition objTransDef = null;
		int i = 0;

		try {
			
			objTransDef = new DefaultTransactionDefinition();
			objTransStatus = transactionManager.getTransaction(objTransDef);
			objMultipartFile = objserviceunit.getCvsFilePath();
			sFileName = objMultipartFile.getOriginalFilename();
			sTomcatRootPath = System.getProperty("catalina.base");
			objBrandingUtil = new BrandingUtil();
			sDirPath = sTomcatRootPath + File.separator + "webapps"+ File.separator + "nbdimages" ;
			objBrandingUtil.createFile(sDirPath, servletContext,objserviceunit.getCvsFilePath());
			objNeighbourhoodUtil = new NeighbourhoodUtil();
			sCSVFile  = sDirPath + File.separator + "package.csv";
			if (sFileName != null && sFileName.length() > 0) {
				newFile = new File(sCSVFile);
				if (!newFile.exists()) {
					
					FileOutputStream fos = new FileOutputStream(newFile);
					fos.write(objMultipartFile.getBytes());
					fos.flush();
					fos.close();
					
				}
				objBufferReader = new BufferedReader(new FileReader(sCSVFile));

				while ((line = objBufferReader.readLine()) != null) {
					System.out.println(i);
					i++;
					
					pathologyArray = line.split(cvsSplitBy);
					
					if (pathologyArray != null && pathologyArray.length >= 0) {
						String vendorid=pathologyArray[0];
						String serviceid=pathologyArray[1];
						String name = pathologyArray[2];
						String desc=pathologyArray[3];
						String label=pathologyArray[4];	
						String price1=pathologyArray[5];
						String discountt=pathologyArray[6];
						
						String serviceunitid=null;
						
						
						NeighbourhoodUtil uti = new NeighbourhoodUtil();
						
						
						
						
						
						
						/*orderBen.setLatitude(geo.x);
						orderBen.setLongitude(geo.y);*/
						
						

						BigDecimal price=new BigDecimal(price1);
						BigDecimal discount=new BigDecimal(discountt);
						
						
						serviceunitid=objServiceUnit1Dao.getServiceunitid(name, desc, Integer.parseInt(serviceid));
						if(StringUtils.isNotBlank(serviceunitid)){
							
							ServiceUnitVendor objServiceUnitVendor=new ServiceUnitVendor();
						objServiceUnitVendor.setServiceUnitId(Integer.parseInt(serviceunitid));
						objServiceUnitVendor.setPrice(price);
						objServiceUnitVendor.setVendorId(Integer.parseInt(vendorid));
						objServiceUnitVendor.setLabel(label);
						objServiceUnitVendor.setDiscount(discount);
						objServiceUnitVendor.setDiscountPrice(NeighbourhoodUtil.getDiscountPrice(price, discount));
						objServiceUnitVendor.setFinalPrice(objServiceUnitVendor.getPrice().subtract(objServiceUnitVendor.getDiscountPrice()));
					
						objserviceunitvendorDao.save(objServiceUnitVendor);
						
						/*ServiceUnitHappiness serviceUnitHappiness = new ServiceUnitHappiness();
						serviceUnitHappiness.setServiceUnitId(Integer.parseInt(serviceunitid));
						serviceUnitHappiness.setVendorId(Integer.parseInt(vendorid));
						serviceUnitHappiness.setHappiness(80);
						serviceUnitHappiness.setTimeToServe(3);
						serviceUnitHappiness.setServedNumber(1);
						serviceUnitHappiness.setFeedback("high rated package.");
						objHappinessDao.save(serviceUnitHappiness);*/
						
						/*PackageReviews  packageReviews = new PackageReviews();
						packageReviews.setServiceUnitId(Integer.parseInt(serviceunitid));
						packageReviews.setName("");
						packageReviews.setProfilePic("");
						packageReviews.setReview("good service provider");
						packageReviewsDao.save(packageReviews);*/
						
						
						}else{
							ServiceUnit1 objServiceUnit1 = new ServiceUnit1();
							ServiceUnitVendor objServiceUnitVendor=new ServiceUnitVendor();
							objServiceUnit1.setServiceId(Integer.parseInt(serviceid));
							objServiceUnit1.setVendorId(Integer.parseInt(vendorid));
							if(StringUtils.isNotBlank(name))
							{
							objServiceUnit1.setName(name);
							}
							if(StringUtils.isNotBlank(desc))
							{
							objServiceUnit1.setDescription(desc);
							}else{
								objServiceUnit1.setDescription(name);
							}
							if(StringUtils.isNotBlank(label))
							{
							objServiceUnit1.setLabel(label);
							}
							objServiceUnit1.setActive(1);
							objServiceUnit1Dao.save(objServiceUnit1);
							objServiceUnitVendor.setServiceUnitId(objServiceUnit1.getId());
							objServiceUnitVendor.setPrice(price);
							objServiceUnitVendor.setVendorId(Integer.parseInt(vendorid));
							objServiceUnitVendor.setDiscount(discount);
							objServiceUnitVendor.setLabel(label);
							objServiceUnitVendor.setDiscountPrice(NeighbourhoodUtil.getDiscountPrice(price, discount));
							objServiceUnitVendor.setFinalPrice(objServiceUnitVendor.getPrice().subtract(objServiceUnitVendor.getDiscountPrice()));
							objserviceunitvendorDao.save(objServiceUnitVendor);
							
							ServiceUnitHappiness serviceUnitHappiness = new ServiceUnitHappiness();
							serviceUnitHappiness.setServiceUnitId(objServiceUnit1.getId());
							serviceUnitHappiness.setVendorId(Integer.parseInt(vendorid));
							serviceUnitHappiness.setHappiness(80);
							serviceUnitHappiness.setTimeToServe(3);
							serviceUnitHappiness.setServedNumber(1);
							serviceUnitHappiness.setFeedback("high rated package.");
							objHappinessDao.save(serviceUnitHappiness);
							
							PackageReviews  packageReviews = new PackageReviews();
							packageReviews.setServiceUnitId(objServiceUnit1.getId());
							packageReviews.setName("");
							packageReviews.setProfilePic("");
							packageReviews.setReview("good service provider");
							packageReviewsDao.save(packageReviews);
						}

											}

				}

			}

			transactionManager.commit(objTransStatus);
			isInsert = true;
			
			if (isInsert) {
				// return
				// "redirect:pathologyInventoryHome.htm?UploadSuc=Success?no="+s1;
				
				 
				 String s1=String.valueOf(i); 
				 val = objRequest.getParameter("s1");
				 
				 
				 

				return "redirect:csvPackageInsert.htm?UploadSuc=Success?no="
						+ s1;

			}

			else {
				return "redirect:csvPackageInsert.htm?UploadFail=fail";
			}

		}

		catch (Exception e) {

			transactionManager.rollback(objTransStatus);
			e.printStackTrace();
			logger.fatal("error in Pathology save in Pathology controller");
			logger.error(e.getMessage());
			// return "redirect:pathologyInventoryHome.htm?UploadFail=fail";

		} finally {

		}
		return sCSVFile;

	}

	/*
	 * private void msgbox(String s){ JOptionPane.showMessageDialog(null, s); }
	 */

	private String alert(String string) {
		// TODO Auto-generated method stub
		return null;
	}
  
}


