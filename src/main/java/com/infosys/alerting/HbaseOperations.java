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
		byte [] balanceBytes = result.getValue(Bytes.toBytes("account"), Bytes.toBytes("balance"));
		byte [] pushPreferenceBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("pushPreference"));
		byte [] smsPreferenceBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("smsPreference"));
		byte [] emailPreferenceBytes = result.getValue(Bytes.toBytes("personal"), Bytes.toBytes("emailPreference"));
		
		String name = Bytes.toString(nameBytes);
		int balance = Bytes.toInt(balanceBytes);
		String pushPreference = Bytes.toString(pushPreferenceBytes);
		String smsPreference = Bytes.toString(smsPreferenceBytes);
		String emailPreference = Bytes.toString(emailPreferenceBytes);
		
		User user = new User();
		user.setEmailId(emailId);
		user.setName(name);
		user.setBalance(balance);
		user.setEmailPreference(emailPreference);
		user.setSmsPreference(smsPreference);
		user.setPushPreference(pushPreference);
		
		table.close();
		closeConnection();
		
		return user;
	}
	
	// Check if the row key exists
	public void checkRowKey() throws IOException {
		createAdmin();
		
		Table table = connection.getTable(TableName.valueOf("users"));
		Get get = new Get(Bytes.toBytes("login.bhatia@gmail.com"));
		Result result = table.get(get);
		if(result.isEmpty())
			System.out.println("User doesn't exist.");
		else
			System.out.println("User exists");
		
		table.close();
		closeConnection();
	}
	
	// Close connections with HBase
	public void closeConnection() throws IOException {
		admin.close();
		connection.close();
		conf.clear();
		System.out.println("Connection Closed");
	}
}
