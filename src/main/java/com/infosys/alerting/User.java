package com.infosys.alerting;

public class User {
	
	private String emailId;
	private String name;
	private int balance;
	private String pushPreference;
	private String emailPreference;
	private String smsPreference;
	private String password;
	private String allTransactionsCheck;
	private String lowerLimitCheck;
	private int lowerLimit;
	private String transactionAmountCheck;
	private int transactionAmountLimit;
	
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public String getPushPreference() {
		return pushPreference;
	}
	public void setPushPreference(String pushPreference) {
		this.pushPreference = pushPreference;
	}
	public String getEmailPreference() {
		return emailPreference;
	}
	public void setEmailPreference(String emailPreference) {
		this.emailPreference = emailPreference;
	}
	public String getSmsPreference() {
		return smsPreference;
	}
	public void setSmsPreference(String smsPreference) {
		this.smsPreference = smsPreference;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAllTransactionsCheck() {
		return allTransactionsCheck;
	}
	public void setAllTransactionsCheck(String allTransactionsCheck) {
		this.allTransactionsCheck = allTransactionsCheck;
	}
	public String getLowerLimitCheck() {
		return lowerLimitCheck;
	}
	public void setLowerLimitCheck(String lowerLimitCheck) {
		this.lowerLimitCheck = lowerLimitCheck;
	}
	public int getLowerLimit() {
		return lowerLimit;
	}
	public void setLowerLimit(int lowerLimit) {
		this.lowerLimit = lowerLimit;
	}
	public String getTransactionAmountCheck() {
		return transactionAmountCheck;
	}
	public void setTransactionAmountCheck(String transactionAmountCheck) {
		this.transactionAmountCheck = transactionAmountCheck;
	}
	public int getTransactionAmountLimit() {
		return transactionAmountLimit;
	}
	public void setTransactionAmountLimit(int transactionAmountLimit) {
		this.transactionAmountLimit = transactionAmountLimit;
	}
}
