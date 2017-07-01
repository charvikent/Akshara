package com.aurospaces.neighbourhood.controller;

import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Repository;

import com.aurospaces.neighbourhood.bean.GeoLocations;

@Repository(value = "sContext")
public class SContext {

	public Map<String, String> vendorLocations;
	public Map<String, String> customerLocations;
	public Map<String, GeoLocations> objGeoLocation;
	public TrackingBean trackBean;
	
	public void serTrackBean(TrackingBean trackBean){
		this.trackBean = trackBean;
	}
	public TrackingBean getTrackBean(){
		return this.trackBean;
	}
	
	public ServletContext myContext;

	public SContext() {
		vendorLocations = new Hashtable<String, String>();
		customerLocations = new Hashtable<String, String>();
		objGeoLocation = new  Hashtable<String, GeoLocations>();
		trackBean = new TrackingBean();
	}
	
	public void setCustomerLocation(String orderId, String location) {
		customerLocations.put(orderId, location);
	}

	public String getCustomerLocation(String orderId) {
		return customerLocations.get(orderId);
	}

	public String getVendorLocation(String orderId) {
		return vendorLocations.get(orderId);
	}

	public void setVendorLocation(String orderId, String location) {
		vendorLocations.put(orderId, location);
	}

	public GeoLocations getObjGeoLocation(String orderId) {
		return objGeoLocation.get(orderId);
	}

	public void setObjGeoLocation(GeoLocations objGeoLocation) {
		this.objGeoLocation.put(objGeoLocation.getOrder_id(),objGeoLocation);
	}

	

}
