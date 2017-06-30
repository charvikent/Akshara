package com.aurospaces.neighbourhood.controller;

import java.math.BigDecimal;

public class RestResponseBean {
	public String order_id;
	public String txn_id;
	public String merchant_key;
	public String salt_key;
	public BigDecimal amount;
	public String success_url;
	public String failure_url;
	public String server_url;
	
	

	public String getServer_url() {
		return server_url;
	}

	public void setServer_url(String server_url) {
		this.server_url = server_url;
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

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
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

}
