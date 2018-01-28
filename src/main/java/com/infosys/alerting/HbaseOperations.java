package com.infosys.alerting;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.Admin;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.util.Bytes;

public class HbaseOperations {
	
	private Configuration conf = null;
	private Connection connection = null;
	private Admin admin = null;
	
	// Get admin for Table Operation
	public void createAdmin() throws IOException {
		conf = HBaseConfiguration.create();
		connection = ConnectionFactory.createConnection(conf);
		admin = connection.getAdmin();
	}
	
	// Create HBase Table - used once.
	public void createTable() throws IOException {
		createAdmin();
		
		HTableDescriptor tableDescriptor = new HTableDescriptor(TableName.valueOf("users"));
		tableDescriptor.addFamily(new HColumnDescriptor("personal"));
		tableDescriptor.addFamily(new HColumnDescriptor("account"));
		admin.createTable(tableDescriptor);
		
		System.out.println("Table created");
		closeConnection();
	}
	
	// Insert Data in HBase Table
	public void insertData(User user) throws IOException {
		createAdmin();
		Table table = connection.getTable(TableName.valueOf("users"));
		Put put = new Put(Bytes.toBytes(user.getEmailId()));
		put.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("name"), Bytes.toBytes(user.getName()));
		put.addColumn(Bytes.toBytes("account"), Bytes.toBytes("balance"), Bytes.toBytes(user.getBalance()));
		put.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("pushPreference"), Bytes.toBytes(user.getPushPreference()));
		put.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("emailPreference"), Bytes.toBytes(user.getEmailPreference()));
		put.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("smsPreference"), Bytes.toBytes(user.getSmsPreference()));
		put.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("password"), Bytes.toBytes(user.getPassword()));
		put.addColumn(Bytes.toBytes("account"), Bytes.toBytes("allTransactionsCheck"), Bytes.toBytes(user.getAllTransactionsCheck()));
		put.addColumn(Bytes.toBytes("account"), Bytes.toBytes("lowerLimitCheck"), Bytes.toBytes(user.getLowerLimitCheck()));
		put.addColumn(Bytes.toBytes("account"), Bytes.toBytes("lowerLimit"), Bytes.toBytes(user.getLowerLimit()));
		put.addColumn(Bytes.toBytes("account"), Bytes.toBytes("transactionAmountCheck"), Bytes.toBytes(user.getTransactionAmountCheck()));
		put.addColumn(Bytes.toBytes("account"), Bytes.toBytes("transactionAmountLimit"), Bytes.toBytes(user.getTransactionAmountLimit()));
		put.addColumn(Bytes.toBytes("personal"), Bytes.toBytes("userDeviceToken"), Bytes.toBytes(user.getUserDeviceToken()));
		table.put(put);
		
		table.close();
		closeConnection();
	}
	
	// Retrieve data
	public User retrieveData(String emailId) throws IOException {
		createAdmin();
		
		Table table = connection.getTable(TableName.valueOf("users"));
		Get get = new Get(Bytes.toBytes(emailId));
		
		Result result = table.get(get);
		byte [] nameBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("name"));
		byte [] passwordBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("password"));
		byte [] balanceBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("balance"));
		byte [] pushPreferenceBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("pushPreference"));
		byte [] smsPreferenceBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("smsPreference"));
		byte [] emailPreferenceBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("emailPreference"));
		byte [] allTransactionsCheckBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("allTransactionsCheck"));
		byte [] lowerLimitCheckBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("lowerLimitCheck"));
		byte [] lowerLimitBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("lowerLimit"));
		byte [] transactionAmountCheckBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("transactionAmountCheck"));
		byte [] transactionAmountLimitBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("transactionAmountLimit"));
		byte [] userDeviceTokenBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("userDeviceToken"));
		
		String name = Bytes.toString(nameBytes);
		int balance = Bytes.toInt(balanceBytes);
		String pushPreference = Bytes.toString(pushPreferenceBytes);
		String smsPreference = Bytes.toString(smsPreferenceBytes);
		String emailPreference = Bytes.toString(emailPreferenceBytes);
		String password = Bytes.toString(passwordBytes);
		String allTransactionsCheck = Bytes.toString(allTransactionsCheckBytes);
		String lowerLimitCheck = Bytes.toString(lowerLimitCheckBytes);
		int lowerLimit = Bytes.toInt(lowerLimitBytes);
		String transactionAmountCheck = Bytes.toString(transactionAmountCheckBytes);
		int transactionAmountLimit = Bytes.toInt(transactionAmountLimitBytes);
		String userDeviceToken = Bytes.toString(userDeviceTokenBytes);
		
		
		User user = new User();
		user.setEmailId(emailId);
		user.setName(name);
		user.setPassword(password);
		user.setBalance(balance);
		user.setEmailPreference(emailPreference);
		user.setSmsPreference(smsPreference);
		user.setPushPreference(pushPreference);
		user.setAllTransactionsCheck(allTransactionsCheck);
		user.setLowerLimitCheck(lowerLimitCheck);
		user.setLowerLimit(lowerLimit);
		user.setTransactionAmountCheck(transactionAmountCheck);
		user.setTransactionAmountLimit(transactionAmountLimit);
		user.setUserDeviceToken(userDeviceToken);
		
		table.close();
		closeConnection();
		
		return user;
	}
	
	// Check if the row key exists
	public boolean checkRowKey(String email) throws IOException {
		createAdmin();
		
		Table table = connection.getTable(TableName.valueOf("users"));
		Get get = new Get(Bytes.toBytes(email));
		Result result = table.get(get);
		
		table.close();
		closeConnection();
		
		if(result.isEmpty())
			return false;
		else
			return true;
	}
	
	// Close connections with HBase
	public void closeConnection() throws IOException {
		admin.close();
		connection.close();
		conf.clear();
		System.out.println("Connection Closed");
	}
}
