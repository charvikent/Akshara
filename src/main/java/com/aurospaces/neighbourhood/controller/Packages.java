package com.aurospaces.neighbourhood.controller;

import java.math.BigDecimal;

public class Packages {
	public int id;
	public String img_url;
	public BigDecimal base_price;
	public String vendor;
	public int vendor_id;
	public String category;
	public String description;
	public String name;
	public BigDecimal discount_price;
	public BigDecimal total_price;
	public BigDecimal discount_percent;
	public String happy_percentage;
	public String served_number;
	public String time_to_serve;
	
	
	

	

	public int getVendor_id() {
		return vendor_id;
	}

	public void setVendor_id(int vendor_id) {
		this.vendor_id = vendor_id;
	}

	public String getHappy_percentage() {
		return happy_percentage;
	}

	public void setHappy_percentage(String happy_percentage) {
		this.happy_percentage = happy_percentage;
	}

	public String getServed_number() {
		return served_number;
	}

	public void setServed_number(String served_number) {
		this.served_number = served_number;
	}

	public String getTime_to_serve() {
		return time_to_serve;
	}

	public void setTime_to_serve(String time_to_serve) {
		this.time_to_serve = time_to_serve;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}

	public BigDecimal getBase_price() {
		return base_price;
	}

	public void setBase_price(BigDecimal base_price) {
		this.base_price = base_price;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getDiscount_price() {
		return discount_price;
	}

	public void setDiscount_price(BigDecimal discount_price) {
		this.discount_price = discount_price;
	}

	public BigDecimal getTotal_price() {
		return total_price;
	}

	public void setTotal_price(BigDecimal total_price) {
		this.total_price = total_price;
	}

	public BigDecimal getDiscount_percent() {
		return discount_percent;
	}

	public void setDiscount_percent(BigDecimal discount_percent) {
		this.discount_percent = discount_percent;
	}

}