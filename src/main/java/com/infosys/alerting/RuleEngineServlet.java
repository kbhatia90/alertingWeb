package com.infosys.alerting;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/RuleEngineServlet")
public class RuleEngineServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String emailId = request.getParameter("emailId");
		String type = request.getParameter("type");

		HbaseOperations hbaseOps = new HbaseOperations();
		User user = hbaseOps.retrieveData(emailId);

		if(type.equalsIgnoreCase("credit")) {
			int creditAmount = Integer.parseInt(request.getParameter("creditAmount"));
			user.setBalance(user.getBalance()+creditAmount);
			hbaseOps.insertData(user);
			
		}

		else {
			int debitAmount = Integer.parseInt(request.getParameter("debitAmount"));
			System.out.println(debitAmount);
			
			Map<String, String> ruleResponse = new LinkedHashMap<>();
			
			if(debitAmount>user.getBalance()) {
				
				ruleResponse.put("insufficient", "insufficient");
				
				String json = new Gson().toJson(ruleResponse);
				
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json);
			    
			}else
			{
				user.setBalance(user.getBalance()-debitAmount);
				hbaseOps.insertData(user);
				if(user.getPushPreference().equalsIgnoreCase("true") 
						|| user.getSmsPreference().equalsIgnoreCase("true") 
						|| user.getEmailPreference().equalsIgnoreCase("true")) {

					if(user.getAllTransactionsCheck().equalsIgnoreCase("true")) {
						ruleResponse.put("notifyDebitAmount", "notifyDebitAmount");
					}
					if(user.getLowerLimitCheck().equalsIgnoreCase("true") && user.getBalance()<=user.getLowerLimit()) {
						ruleResponse.put("notifyLowerLimit", "notifyLowerLimit");
					}
					if(user.getTransactionAmountCheck().equalsIgnoreCase("true") && debitAmount>=user.getTransactionAmountLimit()) {
						ruleResponse.put("notifyBigAmount", "notifyBigAmount");
					}
					
					String json = new Gson().toJson(ruleResponse);
					
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");
				    response.getWriter().write(json);
					
				} else {
					ruleResponse.put("noNotification", "noNotification");
					
					String json = new Gson().toJson(ruleResponse);
					
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");
				    response.getWriter().write(json);
				}
			}
		}

	}

}
