/**
 * 
 */
package com.aurospaces.neighbourhood.controller;
import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;

import java.awt.Frame;
import java.awt.Window;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.metamodel.SetAttribute;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.plaf.OptionPaneUI;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.velocity.app.event.ReferenceInsertionEventHandler.referenceInsertExecutor;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.eclipse.jdt.internal.compiler.parser.diagnose.DiagnoseParser;
import org.exolab.castor.xml.handlers.ValueOfFieldHandler;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.aurospaces.neighbourhood.bean.OrderBean;
import com.aurospaces.neighbourhood.bean.PathologyTestsBean;
import com.aurospaces.neighbourhood.db.dao.OrderInfo1Dao;
import com.aurospaces.neighbourhood.db.dao.OrderStatusLog1Dao;
import com.aurospaces.neighbourhood.db.dao.Service1Dao;
import com.aurospaces.neighbourhood.db.dao.ServiceUnit1Dao;
import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.aurospaces.neighbourhood.db.model.OrderInfo1;
import com.aurospaces.neighbourhood.db.model.OrderStatusLog1;
import com.aurospaces.neighbourhood.db.model.ServiceUnit1;
/*import com.aurospaces.neighbourhood.patent.GeoMain;
import com.aurospaces.neighbourhood.patent.GeoTag;*/
import com.aurospaces.neighbourhood.service.PathologyInventoryService;
import com.aurospaces.neighbourhood.util.AuroConstants;
import com.aurospaces.neighbourhood.util.BrandingUtil;
import com.aurospaces.neighbourhood.util.NeighbourhoodUtil;
import com.squareup.okhttp.Request;

import freemarker.core.ReturnInstruction.Return;

/**
 * @author
 * 
 */
@Controller
public class PathologyInventoryConroller {
	String val=""; 
	private Logger logger = Logger.getLogger(PathologyInventoryConroller.class);
	@Autowired
	ServletContext servletContext;
	@Autowired
	PathologyInventoryService objPathologyInventoryService;
	@Autowired
	Vendor1Dao objVendordao;
	@Autowired
	Service1Dao objServiceDao;
	@Autowired
	ServiceUnit1Dao objServiceUnitDao;
	@Autowired
	DataSourceTransactionManager transactionManager;
	@Autowired
	OrderInfo1Dao objOrderInfo1Dao;
	@Autowired
	OrderStatusLog1Dao orderStatusLog1Dao;

	@RequestMapping(value = "/pathologyInventoryHome", method = RequestMethod.GET)
	public String MedicalHome(
			@ModelAttribute("pathologyInventoryCmd") PathologyTestsBean objPathologyTestsBean,
			HttpServletRequest objRequest, HttpServletResponse objResponse)
			throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		HttpSession objSession = objRequest.getSession(false);
		String json = "";
		try {
			objRequest.setAttribute("PathologyInventoryActive", "active");

			objRequest.setAttribute("PathologyList", json);
			objSession.setAttribute("tabName", "Pathology Inventory");
			objSession.setAttribute("ss", 0);
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.fatal("error in Pathologyhome Pathology controller");
		} finally {

		}
		return "pathologyInventoryHome";
	}

	@RequestMapping(value = "/pathologyInventoryAdd", method = RequestMethod.POST)
	public String pathologyInventoryAdd(
			@ModelAttribute("pathologyInventoryCmd") OrderInfo1 objOrderInfo1,
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
			objMultipartFile = objOrderInfo1.getCvsFilePath();
			sFileName = objMultipartFile.getOriginalFilename();
			sTomcatRootPath = System.getProperty("catalina.base");
			objBrandingUtil = new BrandingUtil();
			sDirPath = sTomcatRootPath + File.separator + "webapps"+ File.separator + "nbdimages" ;
			objBrandingUtil.createFile(sDirPath, servletContext,objOrderInfo1.getCvsFilePath());
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
					i++;
					
					pathologyArray = line.split(cvsSplitBy);
					
					if (pathologyArray != null && pathologyArray.length >= 0) {
						
						String clientId = pathologyArray[0];
						String bookedDate = pathologyArray[1];
						System.out.println(bookedDate);
						
						SimpleDateFormat objDateFormate = new SimpleDateFormat("dd/MM/yyyy");
						
					
					
						
						String ownerName = pathologyArray[2];
						String address = pathologyArray[3];
					
						/*Matcher m = Pattern.compile("\\(([^)]+)\\)").matcher(address);
					    System.out.println(ownerName);
						address = address.substring(0,address.indexOf("("));
					     while(m.find()) {
					       System.out.println(m.group(1)); 
					     }*/
						System.out.println(i);
						int firstIndex = address.indexOf('(');
					     int secondIndex = address.indexOf(')');
					     if(firstIndex != -1){
					    	 Matcher m = Pattern.compile("\\(([^)]+)\\)").matcher(address);
							    
								/*address = address.substring(0,address.indexOf("("));*/
							     while(m.find()) {
							       //System.out.println(m.group(1));
							    	 ownerName= (ownerName + "(" + m.group(1) + ")");
					      address = address.substring(0, firstIndex) +   address.substring(secondIndex+1,address.length());
					     
						     }
					     }
					     System.out.println(address);
						/*GeoMain gm = new GeoMain();
						GeoTag geo = gm.getAddr(address);*/
						String bhk = pathologyArray[4];
						String clientName = pathologyArray[5];
						String phoneNumber = pathologyArray[6];
						String time = pathologyArray[7];
						String sid = pathologyArray[8];
						if(sid.equals("Multiple"))
						{
							sid="4";
						}
						else if(sid.equals("Others"))
						{
							sid="37";
						}
						
						/*String serviceName = pathologyArray[9];
						
						System.out.println(serviceName);*/
						/*String serviceDescription = pathologyArray[9];*/
						/*System.out.println(serviceDescription);*/
						String appointmentDate = pathologyArray[9];
						String billto=pathologyArray[10];
						String serviceDescription = pathologyArray[11];
						String locid=pathologyArray[12];
						String uid=pathologyArray[13];
						String vendorId=pathologyArray[14];
						String vendorPrice=pathologyArray[15];
						String marginPrice=pathologyArray[16];
						String goodsPrice=pathologyArray[17];
						String orderStatus=pathologyArray[18];
						String completionDate=pathologyArray[19];
						String emailId=pathologyArray[20];
						
						OrderInfo1 orderBen = new OrderInfo1();
						NeighbourhoodUtil uti = new NeighbourhoodUtil();
						orderBen.setGeneratedId(uti.randNum());
						if(StringUtils.isNotBlank(clientId)){
						orderBen.setClientOrderId(clientId);
						}
						Date d2 = (Date)objDateFormate.parse(bookedDate);
						orderBen.setBookedDate(d2);
						System.out.println("d2:"+d2);
						if(StringUtils.isNotBlank(ownerName)){
						orderBen.setOwnername(ownerName);
						}
						if(StringUtils.isNotBlank(address)){
						orderBen.setAddress(address);
						}
						if(StringUtils.isNotBlank(bhk)){
						orderBen.setNoBhk(bhk);
						}
						if(StringUtils.isNotBlank(clientName)){
						orderBen.setCustomerName(clientName);
						}
						if(StringUtils.isNotBlank(phoneNumber)){
						orderBen.setContactNumber(phoneNumber);
						}
						if(StringUtils.isNotBlank(sid)){
						orderBen.setServiceId(Integer.parseInt(sid));
						}
						if(StringUtils.isNotBlank(serviceDescription)){
						orderBen.setDescription(serviceDescription);
						}
						if(StringUtils.isNotBlank(billto)){
						orderBen.setBillingto(billto);
						
						}
						if(StringUtils.isNotBlank(locid)){
						orderBen.setLocationId(Integer.parseInt(locid));
						}
						if(StringUtils.isNotBlank(uid)){
						orderBen.setUserId(Integer.parseInt(uid));
						}
						if(StringUtils.isNotBlank(time)){
							orderBen.setAppointmentSlotId(Integer.parseInt(time));
							}
						
					
						
						
						/*orderBen.setLatitude(geo.x);
						orderBen.setLongitude(geo.y);*/
						
						Date app = (Date)objDateFormate.parse(appointmentDate);

						orderBen.setAppointmentDate(app);
						System.out.println("app"+app);
						if(StringUtils.isNotBlank(orderStatus)){
						orderBen.setStatusId(Integer.parseInt(orderStatus));
						}
						if(StringUtils.isNotBlank(vendorId)){
							orderBen.setVendorId(Integer.parseInt(vendorId));
							}
						if(StringUtils.isNotBlank(vendorPrice)){
							orderBen.setVendorServiceCharge(Double.parseDouble(vendorPrice));
							}
						
						if(StringUtils.isNotBlank(marginPrice)){
							orderBen.setMarginValue(Double.parseDouble(marginPrice));
							}
						if(StringUtils.isNotBlank(goodsPrice)){
							orderBen.setGoodsCharge(Double.parseDouble(goodsPrice));
							}
						if(StringUtils.isNotBlank(completionDate)){
							Date comlitionDate = (Date)objDateFormate.parse(completionDate);
							orderBen.setCompletionDate(comlitionDate);
							System.out.println("comlitionDate"+comlitionDate);
							}
						if(StringUtils.isNotBlank(emailId)){
							orderBen.setContactEmail(emailId);
							}
						double netAmount = Double.parseDouble(vendorPrice)+Double.parseDouble(marginPrice)+Double.parseDouble(goodsPrice);
						BigDecimal net = new BigDecimal(netAmount);
						orderBen.setNetAmount(net);
						orderBen.setTotalPrice(net);
						objOrderInfo1Dao.save(orderBen);

						OrderStatusLog1 osl1 = new OrderStatusLog1();
						osl1.setOrderId(orderBen.getId());
						if(StringUtils.isNotBlank(orderStatus)){
						osl1.setStatusId(Integer.parseInt(orderStatus));
						}
						orderStatusLog1Dao.save(osl1);
						
						
						/*
						 * if(vendorName == null || (vendorName != null &&
						 * vendorName.length() == 0)){ packageName = vendorName;
						 * }
						 */
						/*
						 * if (vendorName != null && vendorName.length() > 0 &&
						 * packageDescription != null &&
						 * packageDescription.length() > 0 ) {
						 * objLocalPathologyTestsBean = new
						 * PathologyTestsBean(); objServiceUnit = new
						 * ServiceUnit(); if(listPathologyTestBean == null ){
						 * listPathologyTestBean = new
						 * ArrayList<PathologyTestsBean>(); }
						 * objLocalPathologyTestsBean.setTestDesc(packageName);
						 * objLocalPathologyTestsBean
						 * .setPrice(packageDescription);
						 * listPathologyTestBean.add
						 * (objLocalPathologyTestsBean); }
						 */
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
				 
				 
				 

				return "redirect:pathologyInventoryHome.htm?UploadSuc=Success?no="
						+ s1;

			}

			else {
				return "redirect:pathologyInventoryHome.htm?UploadFail=fail";
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


}
