package com.aurospaces.neighbourhood.controller;


import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

/**
 * 
 */

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aurospaces.neighbourhood.bean.AttendanceBean;
import com.aurospaces.neighbourhood.bean.ClassBean;
import com.aurospaces.neighbourhood.bean.FacultyBean;
import com.aurospaces.neighbourhood.bean.FacultySubjectsBean;
import com.aurospaces.neighbourhood.bean.FilterBean;
import com.aurospaces.neighbourhood.bean.LoginBean;
import com.aurospaces.neighbourhood.bean.StudentBean;
import com.aurospaces.neighbourhood.bean.StudentFeeBean;
import com.aurospaces.neighbourhood.bean.UsersBean;
import com.aurospaces.neighbourhood.db.dao.AttendanceDao;
import com.aurospaces.neighbourhood.db.dao.BirthDayNotificationDao;
import com.aurospaces.neighbourhood.db.dao.ClassCreationDao;
import com.aurospaces.neighbourhood.db.dao.EventDao;
import com.aurospaces.neighbourhood.db.dao.StudentDao;
import com.aurospaces.neighbourhood.db.dao.StudentFeeDao;
import com.aurospaces.neighbourhood.db.dao.SubjectDao;
import com.aurospaces.neighbourhood.db.dao.usersDao1;
import com.aurospaces.neighbourhood.db.model.Faculty;
import com.aurospaces.neighbourhood.service.PopulateService;
import com.aurospaces.neighbourhood.util.BrandingUtil;
import com.aurospaces.neighbourhood.util.MailSender;
import com.aurospaces.neighbourhood.util.MiscUtils;
import com.aurospaces.neighbourhood.util.SendAttachmentInEmail;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/*SELECT   s.id, s.name as studentName,ct.name as className,bn.name as boardName,st.name as sectionName,m.name as medium,s.netFee, SUM(sf.fee), ( s.netFee - SUM(sf.fee)) AS remainBal FROM classtable ct,sectiontable st,boardname bn,mediam m ,   student s INNER JOIN
studentfee sf ON sf.studentId = s.id  where s.className=ct.id and s.boardName=bn.id and m.id=s.medium and s.section=st.id   GROUP BY sf.studentId
*/
/**
 * @author koti
 *
 */
@Controller
public class SchoolHomecontroller {
	@Autowired
	PopulateService objPopulateService;
	@Autowired
	ClassCreationDao objClassCreation;
	Logger log = Logger.getLogger(SchoolHomecontroller.class);
	@Autowired ServletContext objContext;
	@Autowired Faculty faculty;
	@Autowired StudentDao studentDao;
	@Autowired AttendanceDao attendanceDao;
	@Autowired StudentFeeDao objStudentFeeDao;
	@Autowired usersDao1 usesDao1;
	@Autowired com.aurospaces.neighbourhood.db.dao.FacultySubjectsDao objfacultysubjectDao;
	@Autowired
	DataSourceTransactionManager transactionManager;
	@Autowired EventDao eventDao;
	@Autowired BirthDayNotificationDao birthDayNotificationDao;
	@Autowired SubjectDao subjectDao;
	/*LoginHome1*/
	
	
	@RequestMapping(value = "/HomePage")
	public String HomePage(@ModelAttribute("packCmd") UsersBean objUsersBean,ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("HomePage page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		List<StudentBean> liststudentBean = null;
		List<StudentBean> liststudentBeanBirthDay = null;
		String mobileNumber = null;
		 String username = "RKKIDS";
         String password = "RK@kids987";
         String from = "RKKIDS";
         String requestUrl = null;
         String toAddress = null;
         AttendanceBean attendanceBean =null;
         String message =null;
         
		try{
			String propertiespath = objContext.getRealPath("Resources"+ File.separator + "DataBase.properties");

			// String propertiespath = "C:\\PRO\\Database.properties";
			FileInputStream input = new FileInputStream(propertiespath);
			Properties prop = new Properties();
			// load a properties file
			prop.load(input);
			  message = prop.getProperty("birthDayMessage");
			  System.out.println(message);
			
			liststudentBean = birthDayNotificationDao.activeOrNot();
			if(liststudentBean.size() == 0){
				liststudentBeanBirthDay = birthDayNotificationDao.todayBirthDay();
				if(liststudentBeanBirthDay.size() !=0){
					for(StudentBean studentBean : liststudentBeanBirthDay){
						mobileNumber = studentBean.getMobile();
						if(StringUtils.isNotBlank(mobileNumber)){
						message =message.replaceAll("#1", studentBean.getName());
						requestUrl  = "http://182.18.160.225/index.php/api/bulk-sms?username="+URLEncoder.encode(username, "UTF-8")+"&password="+ URLEncoder.encode(password, "UTF-8")+"&from="+from+"&to="+URLEncoder.encode(mobileNumber, "UTF-8")+"&message="+URLEncoder.encode(message, "UTF-8")+"&sms_type=2";
		                URL url = new URL(requestUrl);
		                HttpURLConnection uc = (HttpURLConnection)url.openConnection();
		                System.out.println(uc.getResponseMessage());
		                uc.disconnect();
						}
						toAddress=  studentBean.getEmail();
						if(StringUtils.isNotBlank(toAddress)){
						MailSender.sendEmailWithAttachment(toAddress, "Regarding, Your Children BirthDay",message,null);
						}
						attendanceBean =new AttendanceBean();
						int studentId = studentBean.getId();
						attendanceBean.setStudentId(String.valueOf(studentId));
						attendanceBean.setActive(1);
						attendanceBean.setMessage(message);
						UsersBean loginBean = (UsersBean)session.getAttribute("cacheUserBean");
						if(loginBean != null){
							attendanceBean.setSenderId(loginBean.getRolId());
						}
						birthDayNotificationDao.save(attendanceBean);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			return "loginHome1";
			
		}
		return "loginHome1";
	}
	@RequestMapping(value = "/LoginHome1")
	public String HomePage(ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("LoginHome1 page...");
		UsersBean userBean = null;
		String name = null;
		String password = null;
		String rolId = null;
		try{
			
			userBean= new UsersBean();
			name = request.getParameter("name");
			password = request.getParameter("password");
			rolId = request.getParameter("rolId");
			userBean.setRolId(rolId);
			userBean.setPassword(password);
			userBean.setName(name);
			 userBean = usesDao1.loginDetails(userBean);
			if (userBean != null) {
				session.setAttribute("cacheUserBean", userBean);
				if(StringUtils.isNotBlank(rolId)){
					if(Integer.parseInt(userBean.getRolId()) == 1){
					return "redirect:dashBoard.htm";
					}
				}
			}
			else{
				if(name != null)
				session.setAttribute("message", "Invalid Credentials");
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			session.setAttribute("message", "fail login");
		}
		return "redirect:HomePage";
	}
	@RequestMapping(value = "/logoutHome1")
	public String logoutHome(ModelMap model,HttpServletRequest request,HttpSession objSession,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("logout page...");
		try{
			
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.removeAttribute("cacheUserBean");
				session.invalidate();
				  response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");//HTTP 1.1
				    response.setHeader("Pragma","no-cache"); //HTTP 1.0
				    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//				    String baseUrl = MiscUtils.getBaseUrl(request);
//			 		System.out.println(baseUrl);
//			 		response.sendRedirect(baseUrl+"/LoginHome1.htm" );
			}
			return "redirect:HomePage.htm";
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "loginHome1";
	}
	
	
	
	@RequestMapping(value = "/HomeControl1")
	public String getaluminiHomePage(@ModelAttribute("packCmd") ClassBean objClassBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		try{
			listOrderBeans = objClassCreation.getClassCreationData();
			
			String message = "null";
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "HomeControl2";
	}
	
	
	@RequestMapping(value = "/dashBoard")
	public String dashBoard(ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		try{
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "dashBoard";
	}
	
	
	@RequestMapping(value = "/addclass")
	public String addclass(@ModelAttribute("packCmd") ClassBean objClassBean, ModelMap model,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		ClassBean classbean=null;
		try{
			listOrderBeans = objClassCreation.getClassCreationData();
			 
			int id = 0;
			id = objClassBean.getId();
			 classbean=	objClassCreation.getExistingOrNot(objClassBean);
			 if(id != 0 ){
				 session.setAttribute("message", "Sucessfully Class is Updated");
				 objClassCreation.save(objClassBean);
			 }else{
			if(classbean == null ){
				objClassCreation.save(objClassBean);
				session.setAttribute("message", "Successfully Class is Created");
				 System.out.println("class not exist");
			}else {
				System.out.println("exist");
				session.setAttribute("message", "Already Existed Record");
			}
			 }
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
//				  return "redirect:HomeControl1.htm?class=exist";
			}/*else{
				session.setAttribute("message", "No Records found");
			}*/
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			session.setAttribute("message", "fail");
		}

		return "redirect:HomeControl1";
	}
	@RequestMapping(value = "/getClassFee")
	public @ResponseBody String getClassFee( ClassBean objClassBean, ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		ClassBean classbean =new ClassBean();
		try{
			 classbean=	objClassCreation.getExistingOrNot(objClassBean);
			if(classbean != null) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(classbean);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return sJson;  
	}
	@RequestMapping(value = "/deleteClass")
	public @ResponseBody String deleteClass( ModelMap model,HttpServletRequest request,HttpSession session)  {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		String message =null;
		String classId = null;
		int id=0;
		try{
			classId = request.getParameter("classId");
			if(StringUtils.isNotBlank(classId)){
				id=Integer.parseInt(classId);
				objClassCreation.delete(id);
//				session.setAttribute("message", "Successfully Class is Deleted");
			}
			
			listOrderBeans = objClassCreation.getClassCreationData();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			session.setAttribute("message", "Failed");
		}

		return sJson;
	}
	
	@RequestMapping(value = "/addFaculty")
	public String getaddFaculty(@ModelAttribute("packCmd") FacultyBean objClassBean,ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try{
			listOrderBeans = faculty.getallFaculty();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
				 // faculty.save(objClassBean);
			}else{
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
//				session.setAttribute("message", "No Records found");
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "facultyHome";
	}
	
	
	@RequestMapping(value = "/facultySubmit")
	public String facultySubmit(@ModelAttribute("packCmd") FacultyBean facultybean, ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans =null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		System.out.println(facultybean.getName());
		FacultyBean objfacultyBean =null;
		try{
		
			
			
			int id = 0;
			id = facultybean.getId();
			objfacultyBean=	faculty.getExistingOrNot(facultybean);
			 if(id != 0 ){
				 session.setAttribute("message", "Sucessfully Faculty is Updated");
					faculty.save(facultybean);
			 }else{
			if(objfacultyBean == null ){
				faculty.save(facultybean);
				session.setAttribute("message", "Successfully Faculty is Created");
				 System.out.println("class not exist");
			}else {
				System.out.println("exist");
				session.setAttribute("message", "Already Existed Record");
			}
			
			 }
			
			
			listOrderBeans = faculty.getallFaculty();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
			}else{
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString("null");
				 request.setAttribute("allOrders1", sJson);
			}
		
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			session.setAttribute("message", "fail");
		}

		return "redirect:addFaculty.htm";
	}
	@RequestMapping(value = "/deleteFaculty")
	public @ResponseBody String deleteFaculty(ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String facultyId = null;
		try{
			facultyId=request.getParameter("facultyId");
			if(StringUtils.isNotBlank(facultyId)){
				faculty.delete(Integer.parseInt(facultyId));
				objfacultysubjectDao.deleteFacultySubject(Integer.parseInt(facultyId));
//				session.setAttribute("message", "delete Record");
			}
			
			listOrderBeans = faculty.getallFaculty();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
				 // faculty.save(objClassBean);
			}else{
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return sJson;
	}
	
	@RequestMapping(value = "/facultySubject")
	public String addFacultySubject(@ModelAttribute("packCmd") FacultySubjectsBean objClassBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try{
			listOrderBeans = objfacultysubjectDao.getallFacultySubjects(null, null, null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
				 // faculty.save(objClassBean);
			}else{
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "facultySubject";
	}
	
	
	@RequestMapping(value = "/addFacultySubjects")
	public String addFacultySubjects(@ModelAttribute("packCmd") FacultySubjectsBean facultySubjectBean, ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		System.out.println(facultySubjectBean.getName());
		
		try{
			int id= facultySubjectBean.getId();
			if(id != 0){
				objfacultysubjectDao.save(facultySubjectBean);
				session.setAttribute("message", "Successfully Faculty-Subject is Updated");
			}else{
				FacultySubjectsBean bean = objfacultysubjectDao.facultySubjectExistOrNot(facultySubjectBean);
				if(bean == null){
				objfacultysubjectDao.save(facultySubjectBean);
				session.setAttribute("message", "Successfully Faculty-Subject is Created");
				}else{
					session.setAttribute("message", "Already Faculty-Subject is Exist");
				}
			}
			
			listOrderBeans = objfacultysubjectDao.getallFacultySubjects(null, null, null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "redirect:facultySubject";
	}
	
	@RequestMapping(value = "/deleteFacultySubject")
	public @ResponseBody List<Map<String, String>> deleteFacultySubject( ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String facultySubjectId = null;
		
		try{
			facultySubjectId=request.getParameter("facultySubject");
			if(StringUtils.isNotBlank(facultySubjectId)){
				objfacultysubjectDao.delete(Integer.parseInt(facultySubjectId));
			}
			listOrderBeans = objfacultysubjectDao.getallFacultySubjects(null, null, null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return listOrderBeans;
	}
	@RequestMapping(value = "/studentHome")
	public String studentHome(@ModelAttribute("packCmd") StudentBean objClassBean, ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		System.out.println(objClassBean.getName());
		String baseUrl = MiscUtils.getBaseUrl(request);
		try{
			listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				  request.setAttribute("baseUrl", baseUrl);
				 // System.out.println(sJson); 
			}else{
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "studentHome";  
	}

	@RequestMapping(value = "/addStudent")
	public String addStudent(@ModelAttribute("packCmd") StudentBean objClassBean,@RequestParam("imageName") MultipartFile file, ModelMap model,HttpServletRequest request,HttpSession session) throws JsonGenerationException, JsonMappingException, IOException, ParseException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String name=null;
		String sTomcatRootPath = null;
		String sDirPath = null;
		
		String filepath = null;
		String baseUrl = MiscUtils.getBaseUrl(request);
		System.out.println(objClassBean.getName());
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	if(StringUtils.isNotBlank(objClassBean.getDiscountFee1())){
		double discount = Double.parseDouble(objClassBean.getDiscountFee1());
		objClassBean.setDiscountFee(discount);
	} 
		
		if(StringUtils.isNotBlank(objClassBean.getDob1())){
			Date date1 = formatter.parse(objClassBean.getDob1());
			objClassBean.setDob(date1);
		}
		objClassBean.setNetFee((objClassBean.getTotalFee()-objClassBean.getDiscountFee()));
		if (!file.isEmpty()) {
				byte[] bytes = file.getBytes();
				name =file.getOriginalFilename();
				int n=name.lastIndexOf(".");
				/*name=name.substring(n + 1);
				name=name+".png";*/
				filepath= objClassBean.getAdmissionNum()+".png";
				
				
				
				 String latestUploadPhoto = "";
			        String rootPath = request.getSession().getServletContext().getRealPath("/");
			        File dir = new File(rootPath + File.separator + "img");
			        if (!dir.exists()) {
			            dir.mkdirs();
			        }
			         
			        File serverFile = new File(dir.getAbsolutePath() + File.separator + filepath);
			      //  latestUploadPhoto = file.getOriginalFilename();
//			        file.transferTo(serverFile);
			    //write uploaded image to disk
			        try {
			            try (InputStream is = file.getInputStream(); BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
			                int i;
			                while ((i = is.read()) != -1) {
			                    stream.write(i);
			                }
			                stream.flush();
			                //send photo name to jsp
			            }
			        } catch (IOException e) {
			            System.out.println("error : " + e.getMessage());
			        }
				  
				
			        filepath= "img/"+filepath;
			        objClassBean.setImagePath(filepath);
			        
			     /*   ----------------------------------------*/
			        sTomcatRootPath = System.getProperty("catalina.base");
					sDirPath = sTomcatRootPath + File.separator + "webapps"+ File.separator + "img" ;
					System.out.println(sDirPath);
					File file1 = new File(sDirPath);
				    file.transferTo(file1);
				
		}else{/*
			filepath= baseUrl+"/img/default.png";
			objClassBean.setImagePath(filepath);*/
		}
		int id =objClassBean.getId();
		if(id!=0){
			StudentBean sbean = studentDao.getById(id);
			System.out.println(sbean.getImagePath());
			if(StringUtils.isBlank(file.getOriginalFilename())){
			objClassBean.setImagePath(sbean.getImagePath());
			}
			studentDao.save(objClassBean);
			session.setAttribute("message", "Successfully Student Profile is Updated");
		}else{
			StudentBean sbean = studentDao.duplicateCheckStudent(objClassBean.getAdmissionNum());
			if(sbean == null){
			studentDao.save(objClassBean);
			session.setAttribute("message", "Successfully Student is Added");
		
			}else{
				session.setAttribute("message", "Already student exist");
			}
		}
		try{
			listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				  request.setAttribute("baseUrl", baseUrl);
				 // System.out.println(sJson); 
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			session.setAttribute("message", "Failed");
		}

		return "redirect:studentHome";  
	}
	@RequestMapping(value = "/getDueFee")
	public @ResponseBody String getDueFee( ModelMap model,HttpServletRequest request)  {
		System.out.println("Home controller...");
		ObjectMapper objectMapper = null;
		String sJson = "";
		String studentId = null;
		StudentFeeBean studentFeeBean = null;
		try{
			studentId=	request.getParameter("studentId");
			if(StringUtils.isNotBlank(studentId)){
			 studentFeeBean = objStudentFeeDao.getDueFee(studentId);
			}
			if(studentFeeBean != null ) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(studentFeeBean);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return sJson;
	}
	
	@RequestMapping(value = "/deleteStudent")
	public @ResponseBody List<Map<String, String>> deleteStudent( ModelMap model,HttpServletRequest request)  {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String message =null;
		String studentId = null;
		try{
			studentId = request.getParameter("studentId");
				studentDao.delete(studentId);
			
				listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  /*objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);*/
				 // System.out.println(sJson); 
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return listOrderBeans;
	}
	@RequestMapping(value = "/viewStudent")
	public  String viewStudent(@ModelAttribute("packCmd") StudentBean objClassBean, ModelMap model,HttpServletRequest request)  {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "null";
		String message =null;
		String studentId = null;
		String baseUrl = MiscUtils.getBaseUrl(request);
		try{
			
				listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				  request.setAttribute("baseUrl", baseUrl);
				 // System.out.println(sJson); 
			}else{
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
				  request.setAttribute("baseUrl", baseUrl);
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "viewStudent";
	}
	
	/*SELECT   s.id, s.name,s.netFee, SUM(sf.fee), ( s.netFee - SUM(sf.fee)) AS remainBal FROM     student s INNER JOIN
    studentfee sf ON sf.studentId = s.id
GROUP BY sf.studentId*/
	@RequestMapping(value = "/studentFeeHome")
	public String studentFeeHome(@ModelAttribute("packCmd") StudentFeeBean objStudentFeeBean, ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try{
			listOrderBeans = objStudentFeeDao.getallStudentsFee(null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "studentFeeHome";  
	}
	@RequestMapping(value = "/addStudentFee")
	public String addStudentFee(@ModelAttribute("packCmd") StudentFeeBean objStudentFeeBean, ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try{
			objStudentFeeDao.save(objStudentFeeBean);
			listOrderBeans = objStudentFeeDao.getallStudentsFee(null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "redirect:studentFeeHome";  
	}
	@RequestMapping(value = "/viewStudentFee")
	public String viewStudentFee( @ModelAttribute("packCmd") StudentFeeBean objStudentFeeBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try{
			//SendAttachmentInEmail.send();
			listOrderBeans = objStudentFeeDao.getViwStudentFee(null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "viewStudentFee";  
	}
	@RequestMapping(value = "/searchStudetnFee")
	public @ResponseBody String searchStudetnFee1( ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("searchStudetnFee controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String studetnId = null;
		String boardId = null;
		String classId = null;
		String sectionId = null;
		String mediamId = null;
		String studentId = null;
		try{
			studetnId = request.getParameter("studentId");
			boardId = request.getParameter("boardId");
			classId = request.getParameter("classId");
			sectionId = request.getParameter("sectionId");
			mediamId = request.getParameter("mediumId");
		
			listOrderBeans = objStudentFeeDao.getViwStudentFee(studetnId,boardId,classId,sectionId,mediamId);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return sJson;  
	}
	@RequestMapping(value = "/getPrintFee")
	public @ResponseBody String getPrintFee( ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String studentFeeId = null;
		try{
			studentFeeId = request.getParameter("studentFeeId");
			if(StringUtils.isNotBlank(studentFeeId)){
			listOrderBeans = objStudentFeeDao.getPrintFee(Integer.parseInt(studentFeeId));
			}
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return sJson;  
	}
	@RequestMapping(value = "/attendanceHome")
	public String attendance(@ModelAttribute("packCmd") StudentBean objClassBean, ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		String name=null;
		

		try{
			listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "attendanceHome";  
	}
	@RequestMapping(value = "/getStudetnDetails")
	public @ResponseBody List<Map<String, String>> getStudetnDetails(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session)
					throws JsonGenerationException, JsonMappingException, IOException {
		objResponse.setCharacterEncoding("UTF-8");
		
		/*if(StringUtils.isNotBlank(orderId)){
		String[] array = orderId.split(",");
		for(int i=0;i<array.length;i++){
			if(i==0){
				orderId1  = "'"+array[i]+"'";
			}else{
			orderId1  =orderId1  + ",'"+array[i]+"'";
			}
		}
		}*/
	/*	if(StringUtils.isNotBlank(clientId)){
		String[] array1 = clientId.split(",");
		for(int i=0;i<array1.length;i++){
			if(i==0){
				clientId1  = "'"+array1[i]+"'";
			}else{
				clientId1 = clientId1  + ",'"+array1[i]+"'";
			}
		}
		}
		if(StringUtils.isNotBlank(emailId)){
		String[] array2 = emailId.split(",");
		for(int i=0;i<array2.length;i++){
			if(i==0){
				emailId1  = "'"+array2[i]+"'";
			}else{
				emailId1 = emailId1  + ",'"+array2[i]+"'";
			}
		}
		}*/
		/*if(StringUtils.isNotEmpty(userId)){
			session.setAttribute("userId", userId);
		}*/
		/*int serviceId =0;
		if(sid !=""){
		 serviceId =Integer.parseInt(sid);
		}*/
		
		/*int statusId = 0;
		if(status != ""){
		 statusId = Integer.parseInt(status);
		}*/
		String boardName =null;
		String medium = null;
		String className = null;
		String section = null;
		String email = null;
		String caste = null;
		String admissionNum =null;
		String studentName =null;
		try {
			 boardName = objRequest.getParameter("boardName");
			 medium = objRequest.getParameter("medium");
			 className = objRequest.getParameter("className");
			 section = objRequest.getParameter("section");
			 email = objRequest.getParameter("email");
			 caste = objRequest.getParameter("caste");
			 admissionNum = objRequest.getParameter("admissionNum"); 
			 studentName = objRequest.getParameter("studentName"); 
			return studentDao.getallStudentDetails(boardName,medium,className,section,email,caste,admissionNum,studentName);

		} catch (Exception e) {
			e.printStackTrace();
			e.printStackTrace();
		} finally {

		}
		return null;
	}
	@RequestMapping(value = "/viewAttendanceHome")
	public String viewAttendanceHome(@ModelAttribute("packCmd") StudentBean objClassBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("viewAttendanceHome controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;

		try{
			
			 
			
			listOrderBeans = attendanceDao.getAttendance(objClassBean);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "viewAttendance";  
	}
	
	@RequestMapping(value = "/filterAttendance")
	public @ResponseBody List<Map<String, String>> viewAttendance(@ModelAttribute("packCmd") StudentBean objClassBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String boardName=null;
		String className=null;
		String section=null;
		String admissionNum=null;
		String studentName=null;
		
		

		try{
			 
			
			/*listOrderBeans = attendanceDao.getAttendance(objClassBean);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}*/
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return attendanceDao.getAttendance(objClassBean);  
	}
	
	@RequestMapping(value = "/sendAttendance")
	public @ResponseBody String sendAttendance(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session)
					throws JsonGenerationException, JsonMappingException, IOException, AddressException, MessagingException {
		objResponse.setCharacterEncoding("UTF-8");
		String message = objRequest.getParameter("message");
		String absentId = objRequest.getParameter("absentId");
		String notificatinId = objRequest.getParameter("notificatinId");
		String studentId = objRequest.getParameter("studentId");
		   String username = "RKKIDS";
           String password = "RK@kids987";
           String from = "RKKIDS";
           String requestUrl = null;
		String[] array = studentId.split(",");
		StudentBean objStudentBean = null;
		String mobileNumber = null;
		int studentIdInt =0;
		InputStream input = null;
		Properties prop = new Properties();
		Map<String, String> mapInlineImages = new HashMap<String, String>();
		String htmlBody = null;
		String toAddress = null;
		String subject = "Regarding, Your Children Attendance";
		String ccAddress = null; 
		String bccAddress=null;
		//email 
		StringBuffer stringBuffer = new StringBuffer();
		String message1 = null;

htmlBody = stringBuffer.toString();

try {
	
		int nid= Integer.parseInt(notificatinId);
		for(int i=0;i<array.length;i++){
			AttendanceBean objAttendanceBean = new AttendanceBean();
			studentIdInt = Integer.parseInt(array[i]);
			objStudentBean = studentDao.getById(studentIdInt);
			message =message.replaceAll("#1", objStudentBean.getName());
			message =message.replaceAll("#2", objStudentBean.getFatherName());
			mobileNumber = objStudentBean.getMobile();
			
			if(nid ==1){
				mobileNumber = objStudentBean.getMobile();
				if(StringUtils.isNotBlank(mobileNumber)){
				requestUrl  = "http://182.18.160.225/index.php/api/bulk-sms?username="+URLEncoder.encode(username, "UTF-8")+"&password="+ URLEncoder.encode(password, "UTF-8")+"&from="+from+"&to="+URLEncoder.encode(mobileNumber, "UTF-8")+"&message="+URLEncoder.encode(message, "UTF-8")+"&sms_type=2";
                URL url = new URL(requestUrl);
                HttpURLConnection uc = (HttpURLConnection)url.openConnection();
                System.out.println(uc.getResponseMessage());
                uc.disconnect();
                session.setAttribute("message", "Succesfully SMS has been Sended");
				}
			}
			if(nid ==2){
				toAddress=  objStudentBean.getEmail();
				if(StringUtils.isNotBlank(toAddress)){
				MailSender.sendEmailWithAttachment(toAddress, "Regarding, Your Children Attendance",message,null);
				session.setAttribute("message", "Succesfully Mail has been Sended");
				}
				
			}
			if(nid ==3){
				mobileNumber = objStudentBean.getMobile();
				if(StringUtils.isNotBlank(mobileNumber)){
				requestUrl  = "http://182.18.160.225/index.php/api/bulk-sms?username="+URLEncoder.encode(username, "UTF-8")+"&password="+ URLEncoder.encode(password, "UTF-8")+"&from="+from+"&to="+URLEncoder.encode(mobileNumber, "UTF-8")+"&message="+URLEncoder.encode(message, "UTF-8")+"&sms_type=2";
                URL url = new URL(requestUrl);
                HttpURLConnection uc = (HttpURLConnection)url.openConnection();
                System.out.println(uc.getResponseMessage());
                uc.disconnect();
				}
				toAddress=  objStudentBean.getEmail();
				if(StringUtils.isNotBlank(toAddress)){
				MailSender.sendEmailWithAttachment(toAddress, "Regarding, Your Children Attendance",message,null);
				}
				session.setAttribute("message", "Succesfully SMS+Email has been Sended");
			}
			objAttendanceBean.setStudentId(String.valueOf(studentIdInt));
			objAttendanceBean.setAbsentSection(absentId);
			objAttendanceBean.setMessage(message);
			objAttendanceBean.setNotificationId(notificatinId);
			UsersBean loginBean = (UsersBean)session.getAttribute("cacheUserBean");
			if(loginBean != null){
				objAttendanceBean.setSenderId(loginBean.getRolId());
			}
			attendanceDao.save(objAttendanceBean);
			message1="sucess";
		}
		


		} catch (Exception e) {
			e.printStackTrace();
			e.printStackTrace();
			message1 = "fail";
			session.setAttribute("message", "Fail to Send Message/Email");
		} finally {

		}
		return message1;
	}
	@RequestMapping(value = "/exportStudent")
	public String exportStudent(@ModelAttribute("packCmd") StudentBean objClassBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		try{
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "ExportStudent";
	}
	@RequestMapping(value = "/exportStudent1")
	public ModelAndView exportStudent(@ModelAttribute("packCmd") StudentBean objStudentBean, ModelMap model,HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		ObjectMapper objectMapper = null;
		String sJson = "";
		String name=null;
		String filename="c:/data.xls" ;
		int i=1;
		int sno=0;
		try{
//			listOrderBeans = studentDao.getallStudentDetails(null,null,null,null);
			List<StudentBean> studentdetails = studentDao.getByIdAll(objStudentBean);
			if(studentdetails != null && studentdetails.size() > 0) {
				HSSFWorkbook hwb=new HSSFWorkbook();
				HSSFSheet sheet =  hwb.createSheet("new sheet");

				
				 // System.out.println(sJson); 
				 filename="c:/data.xls" ;
				
				HSSFRow rowhead=   sheet.createRow((short)0);
				rowhead.createCell((short) 0).setCellValue("SNo");		
				rowhead.createCell((short) 1).setCellValue("Student Name");
			    rowhead.createCell((short) 2).setCellValue("Board Name");
			   	rowhead.createCell((short) 3).setCellValue("Medium");
			   	rowhead.createCell((short) 4).setCellValue("Class");
			   	rowhead.createCell((short) 5).setCellValue("Section");
			   	rowhead.createCell((short) 6).setCellValue("Roll Number");
			   	rowhead.createCell((short) 7).setCellValue("Admission Number");
			   	rowhead.createCell((short) 8).setCellValue("Father Name");
			   	rowhead.createCell((short) 9).setCellValue("Mobile");
			   	rowhead.createCell((short) 10).setCellValue("Alternate Number");
			   	rowhead.createCell((short) 11).setCellValue("E-mail");
			   	rowhead.createCell((short) 12).setCellValue("Blood Group");
			   	rowhead.createCell((short) 13).setCellValue("Gender");
			   	rowhead.createCell((short) 14).setCellValue("DOB");
			   	rowhead.createCell((short) 15).setCellValue("Religion");
			   	rowhead.createCell((short) 16).setCellValue("Address");
			   	rowhead.createCell((short) 17).setCellValue("Previous Institute");
			   	rowhead.createCell((short) 18).setCellValue("Caste");
			   	rowhead.createCell((short) 19).setCellValue("Accommodation");
			   	rowhead.createCell((short) 20).setCellValue("Bus Facility");
			   	rowhead.createCell((short) 21).setCellValue("Bus Route");
			   	rowhead.createCell((short) 22).setCellValue("Registered On");
			   	
			   	for(StudentBean list12 : studentdetails){
			   		sno++;
			   		System.out.println(list12.getSection());
			   		
				HSSFRow row=   sheet.createRow((short)i);
				row.createCell((short) 0).setCellValue(sno);
				row.createCell((short) 1).setCellValue(list12.getName());
				row.createCell((short) 2).setCellValue(list12.getBoardName());
				row.createCell((short) 3).setCellValue(list12.getMedium());
				row.createCell((short) 4).setCellValue(list12.getClassName());
				row.createCell((short) 5).setCellValue(list12.getSection());
				row.createCell((short) 6).setCellValue(list12.getRollNum());
				row.createCell((short) 7).setCellValue(list12.getAdmissionNum());
				row.createCell((short) 8).setCellValue(list12.getFatherName());
				row.createCell((short) 9).setCellValue(list12.getMobile());
				row.createCell((short) 10).setCellValue(list12.getAlternativeMobile());
				row.createCell((short) 11).setCellValue(list12.getEmail());
				row.createCell((short) 12).setCellValue(list12.getBlodgroup());
				row.createCell((short) 13).setCellValue(list12.getGender());
				row.createCell((short) 14).setCellValue(list12.getDob());
				row.createCell((short) 15).setCellValue(list12.getRegion());
				row.createCell((short) 16).setCellValue(list12.getAddress());
				row.createCell((short) 17).setCellValue(list12.getPreviousInstitue());
				row.createCell((short) 18).setCellValue(list12.getCaste());
				row.createCell((short) 19).setCellValue(list12.getAcomitation());
				row.createCell((short) 20).setCellValue(list12.getBuspesility());
				row.createCell((short) 21).setCellValue(list12.getBusroute());
				row.createCell((short) 22).setCellValue(list12.getCreatedTime());
				i++;
				}

			//studentDao.save(objClassBean);
				ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
				hwb.write(outByteStream);
				byte [] outArray = outByteStream.toByteArray();
				response.setContentType("application/ms-excel");
				response.setContentLength(outArray.length);
				response.setHeader("Expires:", "0"); // eliminates browser caching
				response.setHeader("Content-Disposition", "attachment; filename=AllStudentsList.xls");
				OutputStream outStream = response.getOutputStream();
				outStream.write(outArray);
				outStream.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return null;  
	}

	@RequestMapping(value = "/importStudent")
	public String importStudent(ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("alumini page...");
	
		try{
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}
		return "ImportStudent";
	}
	
	@RequestMapping(value = "/processExcel", method = RequestMethod.POST)
	public String processExcel(Model model, @RequestParam("excelfile2007") MultipartFile excelfile) {	
		TransactionStatus objTransStatus = null;
		TransactionDefinition objTransDef = null;
		boolean isInsert =false;
		String val ="";
		try {
			objTransDef = new DefaultTransactionDefinition();
			objTransStatus = transactionManager.getTransaction(objTransDef);
			int i = 0;
			int count = 0;
			// Creates a workbook object from the uploaded excelfile
			org.apache.poi.ss.usermodel.Workbook workbook = WorkbookFactory.create(excelfile.getInputStream());
		//	XSSFWorkbook workbook = new XSSFWorkbook(excelfile.getInputStream());
			// Creates a worksheet object representing the first sheet
			org.apache.poi.ss.usermodel.Sheet worksheet = workbook.getSheetAt(0);
			//XSSFSheet worksheet = workbook.getSheetAt(0);
			// Reads the data in excel file until last row is encountered
				// Creates an object for the UserInfo Model
			
			
			while (i <= worksheet.getLastRowNum()) {
				// Creates an object for the UserInfo Model
				// Creates an object representing a single row in excel
			Row	 row = worksheet.getRow(i++);
			  int i1 = row.getRowNum();
			  if(i1>=1){
				// Sets the Read data to the model class
				//user.setId((int) row.getCell(0).getNumericCellValue());
			System.out.println(row.getCell(1).getStringCellValue());
			System.out.println(row.getCell(2).getStringCellValue());
			StudentBean objStudentBean1  =  new StudentBean();
        	
            System.out.println(row.getCell(0).getStringCellValue());
            objStudentBean1.setName(row.getCell(0).getStringCellValue());
            
            StudentBean sb = studentDao.getBordId(row.getCell(1).getStringCellValue());
            if(sb !=null){
        	objStudentBean1.setBoardName(String.valueOf(sb.getId()));
            }
        	
        	StudentBean sb1 = studentDao.getMediumId((row.getCell(2).getStringCellValue()));
        	 if(sb1 !=null){
        	objStudentBean1.setMedium(String.valueOf(sb1.getId()));
        	 }
        	//objStudentBean1.setMedium(row.getCell(2).getStringCellValue());
        	
        	StudentBean sb2 = studentDao.getClassId((row.getCell(3).getStringCellValue()));
        	 if(sb2 !=null){
        	objStudentBean1.setClassName(String.valueOf(sb2.getId()));
        	 }
//        	objStudentBean1.setClassName(row.getCell(3).getStringCellValue());
        	StudentBean sb3 = studentDao.getSectionId((row.getCell(4).getStringCellValue()));
        	 if(sb3 !=null){
        	objStudentBean1.setSection(String.valueOf(sb3.getId()));
        	 }
        	
//        	objStudentBean1.setSection(row.getCell(4).getStringCellValue());
        	objStudentBean1.setFatherName(row.getCell(5).getStringCellValue());
        	String mobile =NumberFormat.getInstance().format(row.getCell(6).getNumericCellValue());
        	mobile =mobile.replace(",", "");
        	objStudentBean1.setMobile(mobile);
        	objStudentBean1.setEmail(row.getCell(7).getStringCellValue());
        	studentDao.save(objStudentBean1);
//        	transactionManager.commit(objTransStatus);
        	count++;
			isInsert = true;
			  }
				// persist data into database in here
			}			
			workbook.close();
				// Creates an object representing a single row in excel
			
			((Closeable) workbook).close();
			if (isInsert) {
				// return
				// "redirect:pathologyInventoryHome.htm?UploadSuc=Success?no="+s1;
				
				 
				 String s1=String.valueOf(count); 
				 
				 
				 

				return "redirect:importStudent.htm?UploadSuc=Success?no="
						+ s1;

			}

			else {
				return "redirect:importStudent.htm?UploadFail=fail";
			}
//			model.addAttribute("lstUser", lstUser);
		} catch (Exception e) {
			e.printStackTrace();
			transactionManager.rollback(objTransStatus);
		}
		return null;
	}
	
	@RequestMapping(value = "/getClassNameFilter")
	public @ResponseBody String getClassNameFilter(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<FilterBean> filterBean=null;
		String json="";
		String boardId = request.getParameter("boardId");
		filterBean =  objClassCreation.getClassName(boardId);
		ObjectMapper objmapper=new ObjectMapper();
		json=objmapper.writeValueAsString(filterBean);
		//System.out.println("listServiceUnit1.size()==="+listServiceUnit1.size());
		request.setAttribute("seviceList", json);
	  return json;


	}
	@RequestMapping(value = "/getSectionFilter")
	public @ResponseBody String getSectionFilter(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<FilterBean> filterBean=null;
		String json="";
		String boardId = null;
		String classId = null;
		try{
		 boardId = request.getParameter("boardId");
		 classId = request.getParameter("classId");
		
		filterBean =  objClassCreation.getSectionFilter(boardId,classId);
		ObjectMapper objmapper=new ObjectMapper();
		json=objmapper.writeValueAsString(filterBean);
		//System.out.println("listServiceUnit1.size()==="+listServiceUnit1.size());
		request.setAttribute("seviceList", json);
		}catch(Exception e){
			e.printStackTrace();
		}
	  return json;


	}
	@RequestMapping(value = "/getMediumFilter")
	public @ResponseBody String getMediumFilter(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<FilterBean> filterBean=null;
		String json="";
		String boardId = null;
		String classId = null;
		String sectionId = null;
		try{
		 boardId = request.getParameter("boardId");
		 classId = request.getParameter("classId");
		 sectionId = request.getParameter("sectionId");
		
		filterBean =  objClassCreation.getMediumFilter(boardId, classId, sectionId);
		ObjectMapper objmapper=new ObjectMapper();
		json=objmapper.writeValueAsString(filterBean);
		//System.out.println("listServiceUnit1.size()==="+listServiceUnit1.size());
		request.setAttribute("seviceList", json);
		}catch(Exception e){
			e.printStackTrace();
		}
	  return json;


	}
	@RequestMapping(value = "/studentFilterDropdown")
	public @ResponseBody List<Map<String, String>> studentFilterDropdown(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;
		String json="";
		String boardId = null;
		String classId = null;
		String sectionId = null;
		String mediumId = null;
		try{
		 boardId = request.getParameter("boardId");
		 classId = request.getParameter("classId");
		 sectionId = request.getParameter("sectionId");
		 mediumId = request.getParameter("mediumId");
		 listOrderBeans = studentDao.getallStudentDetails(boardId, mediumId, classId, sectionId, null, null, null, null);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 request.setAttribute("allOrders1", sJson);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	  return listOrderBeans;


	}
	@RequestMapping(value = "/getMedium")
	public @ResponseBody String getMedium(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<FacultyBean> listServiceUnit1=null;
		String json="";
		String mediumId = request.getParameter("mediumId");
		listServiceUnit1=  faculty.getBoardName(mediumId);
		ObjectMapper objmapper=new ObjectMapper();
		json=objmapper.writeValueAsString(listServiceUnit1);
		//System.out.println("listServiceUnit1.size()==="+listServiceUnit1.size());
		request.setAttribute("seviceList", json);
	  return json;


	}

	@ModelAttribute("board")
	public Map<String, String> populateCateogrys() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from boardname";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("allClasses")
	public Map<String, String> allClasses() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from classtable";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("allSection")
	public Map<String, String> allSection() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from sectiontable";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("mediam")
	public Map<String, String> populateMediam() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from mediam";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}

	@ModelAttribute("subject")
	public Map<String, String> populateClass() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from subject";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("faculty")
	public Map<String, String> populatefaculty() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from faculty";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@ModelAttribute("allStudents")
	public Map<String, String> populateStudent() {
		Map<String, String> statesMap = null;
		try {
			String sSql = "select id,name from student";
			statesMap = objPopulateService.populatePopUp(sSql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return statesMap;
	}
	@RequestMapping(value = "/backupData")
	public String backUpdata(
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
	
		try{
			
			String propertiespath = objContext.getRealPath("Resources"+ File.separator + "DataBase.properties");

			FileInputStream input = new FileInputStream(propertiespath);
			Properties prop = new Properties();
			// load a properties file
			prop.load(input);
			String  usermail = prop.getProperty("usermail");
			String  to = prop.getProperty("to");
			String mailpassword = prop.getProperty("mailpassword");
			String port = prop.getProperty("port");
			String userName = prop.getProperty("userName");
			String password = prop.getProperty("password");
			String dbname = prop.getProperty("db");
			String dbport = prop.getProperty("dbport");
			
			
//			Properties prop = new Properties();
//			   String propertiespath = objContext.getRealPath("Resources"
//						+ File.separator + "DataBase.properties");
//			   FileInputStream input = new FileInputStream(propertiespath);
//				// load a properties file
//				prop.load(input);
//				String couponcode = prop.getProperty("usermail");
			 byte[] data = SendAttachmentInEmail.getData("localhost", dbport,
					 userName, password, dbname).getBytes();		
					   File filedst = new File("D://backup1.sql");
					   FileOutputStream dest = new FileOutputStream(filedst);
					   dest.write(data);
			SendAttachmentInEmail.send( to , usermail , mailpassword, port);
		}catch(Exception e){
			e.printStackTrace();
		}
	  return "redirect:dashBoard.htm";


	}
	@RequestMapping(value = "/eventsHome")
	public String upCommingBirthDay(@ModelAttribute("packCmd") StudentBean objStudentBean,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<StudentBean>  studentBean = null;
	String sJson =null;
	String calasssName =null;
	String boardName =null;
	String section =null;
	String medium = null;
	List<Map<String, String>> listOrderBeans = null;
		try{
			//studentBean = 	studentDao.upCommingBirthdays( objStudentBean);
			listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(studentBean != null && studentBean.size() > 0) {
				ObjectMapper objmapper=new ObjectMapper();
				  sJson =objmapper.writeValueAsString(studentBean);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 request.setAttribute("allOrders1", "''");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	  return "eventsHome";


	}
	@RequestMapping(value = "/viewEvents")
	public String viewEvents(@ModelAttribute("packCmd") StudentBean objStudetnBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("viewAttendanceHome controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = null;

		try{
			
			 
			
			listOrderBeans = eventDao.getEvents(objStudetnBean);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 request.setAttribute("allOrders1", sJson);
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "viewEventsHome";  
	}
	@RequestMapping(value = "/filterEvent")
	public @ResponseBody List<Map<String, String>> filterEvent(@ModelAttribute("packCmd") StudentBean objStudentBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String boardName=null;
		String className=null;
		String section=null;
		String admissionNum=null;
		String studentName=null;
		
		

		try{
			 
			
			/*listOrderBeans = attendanceDao.getAttendance(objClassBean);
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}*/
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return eventDao.getEvents(objStudentBean);  
	}
	@RequestMapping(value = "/eventsHomeJson")
	public @ResponseBody String upCommingBirthDayJson(@ModelAttribute("packCmd") StudentBean objStudentBean,
			HttpServletResponse response, HttpServletRequest request,
			HttpSession objSession) throws JsonGenerationException, JsonMappingException, IOException {
		List<StudentBean>  studentBean = null;
	String sJson =null;
	String calasssName =null;
	String boardName =null;
	String section =null;
	String medium = null;
	List<Map<String, String>> listOrderBeans = null;
		try{
			//studentBean = 	studentDao.upCommingBirthdays( objStudentBean);
			listOrderBeans = studentDao.getallStudentDetails(null,null,null,null,null,null,null,null);
			if(studentBean != null && studentBean.size() > 0) {
				ObjectMapper objmapper=new ObjectMapper();
				  sJson =objmapper.writeValueAsString(studentBean);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				 request.setAttribute("allOrders1", "''");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	  return sJson;


	}
	@RequestMapping(value = "/sendEvent")
	public @ResponseBody String sendEvent(HttpServletRequest objRequest,
			HttpServletResponse objResponse, HttpSession session)
					throws JsonGenerationException, JsonMappingException, IOException, AddressException, MessagingException {
		objResponse.setCharacterEncoding("UTF-8");
		String message = objRequest.getParameter("message");
		String notificatinId = objRequest.getParameter("notificatinId");
		String studentId = objRequest.getParameter("studentId");
		   String username = "RKKIDS";
           String password = "RK@kids987";
           String from = "RKKIDS";
           String requestUrl = null;
		String[] array = studentId.split(",");
		StudentBean objStudentBean = null;
		String mobileNumber = null;
		int studentIdInt =0;
		InputStream input = null;
		Properties prop = new Properties();
		Map<String, String> mapInlineImages = new HashMap<String, String>();
		String htmlBody = null;
		String toAddress = null;
		String subject = "Regarding, Your Children Attendance";
		String ccAddress = null; 
		String bccAddress=null;
		//email 
		StringBuffer stringBuffer = new StringBuffer();
		String message1 = null;

			htmlBody = stringBuffer.toString();

try {
	
		int nid= Integer.parseInt(notificatinId);
		for(int i=0;i<array.length;i++){
			AttendanceBean objAttendanceBean = new AttendanceBean();
			studentIdInt = Integer.parseInt(array[i]);
			objStudentBean = studentDao.getById(studentIdInt);
			mobileNumber = objStudentBean.getMobile();
			
			if(nid ==1){
				mobileNumber = objStudentBean.getMobile();
				if(StringUtils.isNotBlank(mobileNumber)){
				requestUrl  = "http://182.18.160.225/index.php/api/bulk-sms?username="+URLEncoder.encode(username, "UTF-8")+"&password="+ URLEncoder.encode(password, "UTF-8")+"&from="+from+"&to="+URLEncoder.encode(mobileNumber, "UTF-8")+"&message="+URLEncoder.encode(message, "UTF-8")+"&sms_type=2";
                URL url = new URL(requestUrl);
                HttpURLConnection uc = (HttpURLConnection)url.openConnection();
                System.out.println(uc.getResponseMessage());
                uc.disconnect();
                session.setAttribute("message", "Succesfully SMS has been Sended");
				}
			}
			if(nid ==2){
				toAddress=  objStudentBean.getEmail();
				if(StringUtils.isNotBlank(toAddress)){
				MailSender.sendEmailWithAttachment(toAddress, "Regarding, Your Children Attendance",message,null);
				session.setAttribute("message", "Succesfully Mail has been Sended");
				}
				
			}
			if(nid ==3){
				mobileNumber = objStudentBean.getMobile();
				if(StringUtils.isNotBlank(mobileNumber)){
				requestUrl  = "http://182.18.160.225/index.php/api/bulk-sms?username="+URLEncoder.encode(username, "UTF-8")+"&password="+ URLEncoder.encode(password, "UTF-8")+"&from="+from+"&to="+URLEncoder.encode(mobileNumber, "UTF-8")+"&message="+URLEncoder.encode(message, "UTF-8")+"&sms_type=2";
                URL url = new URL(requestUrl);
                HttpURLConnection uc = (HttpURLConnection)url.openConnection();
                System.out.println(uc.getResponseMessage());
                uc.disconnect();
				}
				toAddress=  objStudentBean.getEmail();
				if(StringUtils.isNotBlank(toAddress)){
				MailSender.sendEmailWithAttachment(toAddress, "Regarding, Your Children Attendance",message,null);
				}
				session.setAttribute("message", "Succesfully SMS+Email has been Sended");
			}
			objAttendanceBean.setStudentId(String.valueOf(studentIdInt));
			objAttendanceBean.setMessage(message);
			objAttendanceBean.setNotificationId(notificatinId);
			UsersBean loginBean = (UsersBean)session.getAttribute("cacheUserBean");
			if(loginBean != null){
				objAttendanceBean.setSenderId(loginBean.getRolId());
			}
			eventDao.save(objAttendanceBean);
			message1="sucess";
		}
		


		} catch (Exception e) {
			e.printStackTrace();
			e.printStackTrace();
			message1 = "fail";
			session.setAttribute("message", "Fail to Send Message/Email");
		} finally {

		}
		return message1;
	}
	
	@RequestMapping(value = "/subjectHome")
	public String subjectHome(@ModelAttribute("packCmd") StudentBean objStudentBean,ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String boardName=null;
		String className=null;
		String section=null;
		String admissionNum=null;
		String studentName=null;
		try{
			listOrderBeans = subjectDao.getSubjects();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return "subjectHome";  
	}
	@RequestMapping(value = "/addSubject")
	public String addSubject(@ModelAttribute("packCmd") StudentBean objStudentBean,ModelMap model,HttpServletRequest request, HttpSession session) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		List<Map<String, String>> listOrderBeans1 = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		try{
			if(objStudentBean.getId() == 0){
				listOrderBeans1 = subjectDao.existingOrNot(objStudentBean.getName());
				if(listOrderBeans1.size() == 0){
					subjectDao.save(objStudentBean);
					session.setAttribute("message", "Successfully Subject is Created");
				}
				else{
					session.setAttribute("message", "Subject is Already Existed ");
				}
			}else{
				subjectDao.save(objStudentBean);
				session.setAttribute("message", "Successfully Subject is Updated");
			}
			
			
			listOrderBeans = subjectDao.getSubjects();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
			session.setAttribute("message", "Failed");
		}

		return "redirect:subjectHome";  
	}
	@RequestMapping(value = "/deleteSubject")
	public @ResponseBody String deleteSubject(ModelMap model,HttpServletRequest request) throws JsonGenerationException, JsonMappingException, IOException {
		System.out.println("Home controller...");
		List<Map<String, String>> listOrderBeans = null;
		ObjectMapper objectMapper = null;
		String sJson = "";
		String subjectId = null;
		try{
			subjectId = request.getParameter("id");
			if(StringUtils.isNotBlank(subjectId)){
			subjectDao.delete(Integer.parseInt(subjectId));		
			}
			listOrderBeans = subjectDao.getSubjects();
			if(listOrderBeans != null && listOrderBeans.size() > 0) {
				  objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", sJson);
				 // System.out.println(sJson); 
			}else{
				objectMapper = new ObjectMapper(); 
				  sJson =objectMapper.writeValueAsString(listOrderBeans);
				  request.setAttribute("allOrders1", "''");
			}
			//studentDao.save(objClassBean);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e);
		}

		return sJson;  
	}
}

