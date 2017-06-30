package com.aurospaces.neighbourhood.db.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.ParameterizedBeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.aurospaces.neighbourhood.controller.VendorLoginInput;
import com.aurospaces.neighbourhood.custommodel.VendorLocation;
import com.aurospaces.neighbourhood.custommodel.VendorOrderDetail;
import com.aurospaces.neighbourhood.db.basedao.BaseVendor1Dao;
import com.aurospaces.neighbourhood.db.callback.BeanUtilsCallbackHandler;
import com.aurospaces.neighbourhood.db.callback.KeyValueCallbackHandler;
import com.aurospaces.neighbourhood.db.callback.RowValueCallbackHandler;
import com.aurospaces.neighbourhood.db.callback.VendorLocationHandler;
import com.aurospaces.neighbourhood.db.model.OrderSequence;
import com.aurospaces.neighbourhood.db.model.Vendor1;
import com.aurospaces.neighbourhood.util.AuroConstants;


@Repository(value = "vendor1Dao")
public class Vendor1Dao extends BaseVendor1Dao
{

	public List<Vendor1> getAll() {
		String sql = "SELECT * from vendor1 ";
		List<Vendor1> retlist = jdbcTemplate.query(sql,
		new Object[]{},
		BeanPropertyRowMapper.newInstance(Vendor1.class));
		return retlist;
	}

	public List<Vendor1> getByClusterId(int clusterId) {
		String sql = "SELECT * from vendor1 where cluster_id =  " + clusterId;
		List<Vendor1> retlist = jdbcTemplate.query(sql,
		new Object[]{},
		BeanPropertyRowMapper.newInstance(Vendor1.class));
		return retlist;
	}

	public List<Vendor1> getByDisplay() {
		String sql = "select id,first_name,last_name,address,city,state_Name as state,mobile_number from vendor1 v,states s where s.state_Id=v.state order by first_name ";
		List<Vendor1> retlist = jdbcTemplate.query(sql,
		new Object[]{},
		ParameterizedBeanPropertyRowMapper.newInstance(Vendor1.class));
		return retlist;
	}

	 public List<Map<String,String>> getVendorsForServices(int serviceId) {

	 RowValueCallbackHandler handler = new RowValueCallbackHandler(new String[]{"id","name"});
			String query = "SELECT v.id as id, concat_ws(' ',v.first_name, v.last_name)  as name from vendor1 v, vendor_service1 vs  where vs.service_id = "
			+ serviceId + " and vs.vendor_id = v.id ";
     jdbcTemplate.query(query,handler);
     return handler.getResult();
		}


	 public Map<String,String> getVendorNamesAsMap() {
	 KeyValueCallbackHandler handler = new KeyValueCallbackHandler("id","name");
	 String query = "select id , concat_ws(' ',first_name, last_name) as name from vendor1";
     jdbcTemplate.query(query,handler);
     return handler.getResult();
		}


/* Please write functions where it is obvious what is being passed to the server.
Passing a Vendor1 object to get a list of Vendor1s is poor design 
	 public List<Vendor1> getVendor1s(
			 Vendor1 objProfileBean) {
		List<Vendor1> listVendor1 = null;
			try {
				StringBuffer objStringBuffer = new StringBuffer();
				objStringBuffer.append("select id,first_name,last_name,address,mobile_number from vendor1 v, states s where s.state_Id = v.state");
				if(objProfileBean.getId() != 0){
					objStringBuffer.append(" and v.Id = '"+objProfileBean.getId()+"'");
				}
				String sSql = objStringBuffer.toString();
				System.out.println(sSql);
				listVendor1 = jdbcTemplate.query(
						sSql,
						new BeanPropertyRowMapper<Vendor1>(
								Vendor1.class));
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
			}
			return listVendor1;
		}
*/




	 public List<Map<String,String>> getOrderVendors(String order_icon, String customerNumber ) {
String query = " select v.id as id , concat_ws(' ',v.first_name, v.last_name)  as name, v.mobile_number as phoneNo, o.generated_id as orderId,  v.photograph as vendorImg,  v.latitude as latitude, v.longitude as longitude, o.id as order_id , \"" + order_icon + 
	"\" as order_icon , o.status_id as order_status from  vendor1 v, order_info1 o where v.id = o.vendor_id and o.contact_number = '" +
		customerNumber  + "'  and o.status_id in ( " 
+ AuroConstants.confirmed  + ", " +AuroConstants.assigned  + ", " + 
		AuroConstants.ordered  + ", " + 
		AuroConstants.paid  + ", " + 
		AuroConstants.reachedSite  + ") " ;

	 RowValueCallbackHandler handler = new RowValueCallbackHandler(new String[]
		{"id","name", "latitude", "longitude","order_icon", "order_status", "phoneNo","vendorImg", "orderId" });
     jdbcTemplate.query(query, handler);
     return handler.getResult();
		}


	 public int getVendorId(String vendorName){
		 int result = 0;
		/* String vendor= vendorName.trim();*/
		 if(StringUtils.isNotBlank(vendorName)){
		 /*vendorName = vendorName.replaceAll("\\s+","");*/
		 System.out.println("vendorName..."+vendorName);
		 String sql = "select id from vendor1 where concat(first_name, last_name) like '"+vendorName+"%'";
			result = jdbcTemplate.queryForInt(sql);
		 }
		 return result;
	 }


	 public List<Map<String,String>> getMapLocations(String baseUrl ) {

	 RowValueCallbackHandler handler = new RowValueCallbackHandler(new String[]{"id","name", "latitude", "longitude","map_icon"});
			String query = "SELECT id,  concat_ws(' ',v.first_name, v.last_name)  as name , latitude, longitude , concat('"
			+ baseUrl + "', map_icon) as map_icon from vendor1 v where latitude != '' and longitude != '' ";
     jdbcTemplate.query(query,handler);
     return handler.getResult();
		}

	public List<VendorLocation> getAllVendorLocations() {
	 VendorLocationHandler handler = new VendorLocationHandler();
			String query = "SELECT id,  concat_ws(' ',v.first_name, v.last_name)  as name , latitude, longitude from vendor1 v where latitude != '' and longitude != '' ";
     jdbcTemplate.query(query,handler);
     return handler.getList();

	}

	public List<Object> getVendorOrders(VendorLoginInput vendorData) throws Exception
	{
		String sql = "select * from vendor1 where mobile_number='"+vendorData.vendorId+"' and password ='"+vendorData.password+"'";
		Vendor1 vendor = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<Vendor1>(Vendor1.class));
		
		if(vendor != null){
			 BeanUtilsCallbackHandler handler = new BeanUtilsCallbackHandler(
			"com.aurospaces.neighbourhood.custommodel.VendorOrderData" , new String[] { "order_id", "category","img_url", "email" ,"details", "latitude", "longitude"  , "order_status" , "order_status_id", 
			"mobile", "address", "day_slot", "time_slot", "name" });
			String query = " select o.appointment_slot_id as time_slot ,  UNIX_TIMESTAMP(o.appointment_date) as day_slot, o.address as address , o.contact_number as mobile,\"Dummy Name\" as name,     o.status_id as order_status_id , sl.name as order_status, o.generated_id as order_id, s1.name as category, v.photograph as img_url, o.contact_email as  email , \"A random string as filler\" as details, o.latitude as latitude, o.longitude as longitude from order_info1 o, service1 s1, status_list1 sl, vendor1 v where v.id = o.vendor_id and s1.id = o.service_id and o.status_id = sl.id and o.status_id not in (4,6,9,12,18) and o.vendor_id = "  + vendor.getId() ;
			jdbcTemplate.query(query,handler);
			return handler.getResult();
		}else{
			return null;
		}
	}


	public List<Object> getVendorOrderDetail(String vendorId, Map<String , OrderSequence> orderSeqMap) throws Exception
	{

	 BeanUtilsCallbackHandler handler = new BeanUtilsCallbackHandler(
	 "com.aurospaces.neighbourhood.custommodel.VendorOrderDetail" , new String[] { "order_id", "category","img_url", "email" ,"details", "latitude", "longitude"  ,  "order_status_id", "service_id", 
	 "mobile", "address", "day_slot", "time_slot", "name" });
	 
	String query = " select o.appointment_slot_id as time_slot ,  UNIX_TIMESTAMP(o.appointment_date) as day_slot, o.address as address , o.contact_number as mobile,\"Dummy Name\" as name,     o.status_id as order_status_id , o.generated_id as order_id, s1.id as service_id, s1.name as category, v.photograph as img_url, o.contact_email as  email , \"A random string as filler\" as details, o.latitude as latitude, o.longitude as longitude from order_info1 o, service1 s1, status_list1 sl, vendor1 v where v.id = o.vendor_id and s1.id = o.service_id and o.status_id = sl.id and o.status_id not in (4,6,9,12,18) and o.vendor_id = "  + vendorId ;
	
     jdbcTemplate.query(query,handler);
     List<Object> details  =  handler.getResult();
		 for(Object obj  : details)
		 {
		 		VendorOrderDetail  detail = (VendorOrderDetail ) obj;
		 		OrderSequence stat = orderSeqMap.get(detail.service_id);
				detail.setStatus(stat);
		 }
		 return details;
}
	@Autowired
	public JdbcTemplate jdbcTemplate;

	public Map<String, String> getAllVendors() {
		KeyValueCallbackHandler handler = new KeyValueCallbackHandler("id", "first_name");
		String query = "SELECT id  , first_name  from vendor1	";
		jdbcTemplate.query(query, handler);
		return handler.getResult();
	}

	public List<Vendor1> getByDisplay(String vendorName) {
		StringBuffer objStringBuffer = new StringBuffer();
		objStringBuffer.append("select id,first_name,last_name,  address,city,mobile_number from vendor1 v  ");
		if(StringUtils.isNotEmpty(vendorName)){
			objStringBuffer.append(" where concat_ws(' ',v.first_name,v.last_name)  LIKE '%"+ vendorName +"%'" );
		}
		objStringBuffer.append(" order by first_name");
		String sql = objStringBuffer.toString();
		List<Vendor1> retlist = jdbcTemplate.query(sql,	new Object[]{},
		ParameterizedBeanPropertyRowMapper.newInstance(Vendor1.class));
		return retlist;
	}
  public String vendorLogin(String mobile_number,String password){
	  List<Vendor1> retlist =null;
	  try{
		  String sql = "SELECT * from vendor1 where mobile_number = ?  and password = ?";
			retlist = jdbcTemplate.query(sql, new Object[] {mobile_number,password},
					ParameterizedBeanPropertyRowMapper
							.newInstance(Vendor1.class));
			if (retlist.size() > 0){
				return "success";
			}else{
				return "Invalid Mobile Number and Password";
			}
				
		  
	  }catch(Exception e){
		  return "fail";
	  }
  }
  public List<Map<String,String>> getVendorProfile(String mobile_number ) {
	  String query = "select v.id as id,concat_ws(' ',v.first_name, v.last_name) as name,v.mobile_number as mobile_no,v.email as email_id,l.name as locality,v.address as address,GROUP_CONCAT(s.name) as subscribed_services from vendor1 v left join vendor_service1 vs on( v.id=vs.vendor_id) left join service1 s on(vs.service_id=s.id) left join location1 l on(v.serving_city=l.id) where v.mobile_number='"+mobile_number+"' group by v.id limit 1" ;

	  	 RowValueCallbackHandler handler = new RowValueCallbackHandler(new String[]
	  		{"id","name","mobile_no", "email_id", "locality","address","subscribed_services" });
	       jdbcTemplate.query(query, handler);
	       return handler.getResult();
	  		}
  
  /*public  int getNoOfVendors(String  mobile_number) {
	  int retlist = 0;
		String sql = "SELECT * from vendor1  where mobile_number = '"+mobile_number+"'  ";
		System.out.println(sql);
		 retlist = jdbcTemplate.queryForObject(
              sql, new Object[] {  }, Integer.class);
		
		return retlist;
	}*/
  public int getNoOfVendors(String mobile_number){
	  String sql = "SELECT count(*) from vendor1  where mobile_number ='"+mobile_number+"'" ;
		int count = jdbcTemplate.queryForInt(sql);
		//System.out.println(sql);
		return count;
	 }

}

