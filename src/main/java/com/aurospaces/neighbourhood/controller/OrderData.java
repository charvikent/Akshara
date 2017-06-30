package com.aurospaces.neighbourhood.controller;

import com.aurospaces.neighbourhood.db.model.Customer1;
import com.aurospaces.neighbourhood.db.model.DoctorBooking;
import com.aurospaces.neighbourhood.custommodel.RestLocation;
import com.aurospaces.neighbourhood.db.model.PathologyBooking;
import com.aurospaces.neighbourhood.custommodel.Service;

public class OrderData {
	// request related..
	RestLocation current_location;
	Customer1 other_booking;
	Service service;
	PathologyBooking pathology_booking;
	DoctorBooking doctor_booking;
	public String payment_mode;
	public String module_name;
	public boolean is_payment_done;
	// response related...
	public String order_id;
	public String txn_id;
	public String merchant_key;
	public String salt_key;
	public String amount;
	public String success_url;
	public String failure_url;

	
	public DoctorBooking getDoctor_booking() {
		return doctor_booking;
	}

	public void setDoctor_booking(DoctorBooking doctor_booking) {
		this.doctor_booking = doctor_booking;
	}

	public PathologyBooking getPathology_booking() {
		return pathology_booking;
	}

	public void setPathology_booking(PathologyBooking pathology_booking) {
		this.pathology_booking = pathology_booking;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public String getTxn_id() {
		return txn_id;
	}

	public void setTxn_id(String txn_id) {
		this.txn_id = txn_id;
	}

	public String getMerchant_key() {
		return merchant_key;
	}

	public void setMerchant_key(String merchant_key) {
		this.merchant_key = merchant_key;
	}

	public String getSalt_key() {
		return salt_key;
	}

	public void setSalt_key(String salt_key) {
		this.salt_key = salt_key;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getSuccess_url() {
		return success_url;
	}

	public void setSuccess_url(String success_url) {
		this.success_url = success_url;
	}

	public String getFailure_url() {
		return failure_url;
	}

	public void setFailure_url(String failure_url) {
		this.failure_url = failure_url;
	}

	public RestLocation getCurrent_location() {
		return current_location;
	}

	public void setCurrent_location(RestLocation current_location) {
		this.current_location = current_location;
	}

	public Customer1 getOther_booking() {
		return other_booking;
	}

	public void setOther_booking(Customer1 other_booking) {
		this.other_booking = other_booking;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public String getPayment_mode() {
		return payment_mode;
	}

	public void setPayment_mode(String payment_mode) {
		this.payment_mode = payment_mode;
	}

	public String getModule_name() {
		return module_name;
	}

	public void setModule_name(String module_name) {
		this.module_name = module_name;
	}

	public boolean isIs_payment_done() {
		return is_payment_done;
	}

	public void setIs_payment_done(boolean is_payment_done) {
		this.is_payment_done = is_payment_done;
	}

}
