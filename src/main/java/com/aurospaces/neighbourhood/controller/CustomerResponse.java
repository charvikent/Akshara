package com.aurospaces.neighbourhood.controller;

import java.util.List;

import com.aurospaces.neighbourhood.bean.GeoLocations;

public class CustomerResponse {
	public String order_id;
	public List<GeoLocations> customer_orders;

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public List<GeoLocations> getCustomer_orders() {
		return customer_orders;
	}

	public void setCustomer_orders(List<GeoLocations> customer_orders) {
		this.customer_orders = customer_orders;
	}

}
