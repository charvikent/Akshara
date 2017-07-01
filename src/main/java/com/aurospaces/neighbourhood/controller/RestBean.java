package com.aurospaces.neighbourhood.controller;

public class RestBean {
	public int service_id;
	public Packages packages[];
	public long day_slot;
	public int time_slot;
	public String gender;
	public String name;
	public String email;
	public String mobile;
	public String address;
	public String payment_mode;
	public int vendor_id;
	public String coupon_code;
	public double final_price;
	
	public double getFinal_price() {
		return final_price;
	}

	public void setFinal_price(double final_price) {
		this.final_price = final_price;
	}

	public String getCoupon_code() {
		return coupon_code;
	}

	public void setCoupon_code(String coupon_code) {
		this.coupon_code = coupon_code;
	}

	public int getService_id() {
		return service_id;
	}

	public void setService_id(int service_id) {
		this.service_id = service_id;
	}

	public int getVendor_id() {
		return vendor_id;
	}

	public void setVendor_id(int vendor_id) {
		this.vendor_id = vendor_id;
	}

	public Packages[] getPackages() {
		return packages;
	}

	public void setPackages(Packages[] packages) {
		this.packages = packages;
	}

	public long getDay_slot() {
		return day_slot;
	}

	public void setDay_slot(long day_slot) {
		this.day_slot = day_slot;
	}

	

	public int getTime_slot() {
		return time_slot;
	}

	public void setTime_slot(int time_slot) {
		this.time_slot = time_slot;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPayment_mode() {
		return payment_mode;
	}

	public void setPayment_mode(String payment_mode) {
		this.payment_mode = payment_mode;
	}

}
