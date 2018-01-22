package com.infosys.alerting;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

			if(debitAmount>user.getBalance()) {
				response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("insufficient");
			}else
			{
				user.setBalance(user.getBalance()-debitAmount);
				hbaseOps.insertData(user);
				if(user.getPushPreference().equalsIgnoreCase("true") 
						|| user.getSmsPreference().equalsIgnoreCase("true") 
						|| user.getEmailPreference().equalsIgnoreCase("true")) {
			

					if(user.getAllTransactionsCheck().equalsIgnoreCase("true")) {
						response.setContentType("text/plain");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write("notifyDebitAmount");
					}
					else if(user.getLowerLimitCheck().equalsIgnoreCase("true") && user.getBalance()<=user.getLowerLimit()) {
						response.setContentType("text/plain");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write("notifyLowerLimit");
					}
					else if(user.getTransactionAmountCheck().equalsIgnoreCase("true") && debitAmount>=user.getTransactionAmountLimit()) {
						response.setContentType("text/plain");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write("notifyBigAmount");
					}
				}
			}
		}

	}

}
