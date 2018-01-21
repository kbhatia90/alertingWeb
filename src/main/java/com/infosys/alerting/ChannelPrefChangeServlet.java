package com.infosys.alerting;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChannelPrefChangeServlet")
public class ChannelPrefChangeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String pushPrefFront = request.getParameter("pushRequest");
		String smsPrefFront = request.getParameter("smsRequest");
		String emailPrefFront = request.getParameter("emailRequest");
		String emailId = request.getParameter("emailId");
		
		
		HbaseOperations hbaseOps = new HbaseOperations();
		User user = new User();
		user = hbaseOps.retrieveData(emailId);
		
		user.setSmsPreference(smsPrefFront);
		user.setEmailPreference(emailPrefFront);
		user.setPushPreference(pushPrefFront);
		
		hbaseOps.insertData(user);
	}

}
