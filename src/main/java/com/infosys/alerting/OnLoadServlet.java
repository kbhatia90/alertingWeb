package com.infosys.alerting;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/OnLoadServlet")
public class OnLoadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String emailId = request.getParameter("emailId");
		
		HbaseOperations hbaseOps = new HbaseOperations();
		User user = hbaseOps.retrieveData(emailId);
		
		Map<String, String> userData = new LinkedHashMap<>();
	    userData.put("name", user.getName());
	    userData.put("balance", Integer.toString(user.getBalance()));
	    userData.put("pushPreference", user.getPushPreference());
	    userData.put("smsPreference", user.getSmsPreference());
	    userData.put("emailPreference", user.getEmailPreference());
	    userData.put("allTransactionsCheck", user.getAllTransactionsCheck());
	    userData.put("lowerLimitCheck", user.getLowerLimitCheck());
	    userData.put("lowerLimit", Integer.toString(user.getLowerLimit()));
	    userData.put("transactionAmountCheck", user.getTransactionAmountCheck());
	    userData.put("transactionAmountLimit", Integer.toString(user.getTransactionAmountLimit()));
	    
	    String json = new Gson().toJson(userData);
		
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	}

}
