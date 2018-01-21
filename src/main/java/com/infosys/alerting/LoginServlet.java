package com.infosys.alerting;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String emailId = request.getParameter("email");
		String password = request.getParameter("psw");
		
		HbaseOperations hbaseOps = new HbaseOperations();
		boolean idExists = hbaseOps.checkRowKey(emailId);
		
		if(idExists) {
			User user = hbaseOps.retrieveData(emailId);
			boolean matchPassword = user.getPassword().equalsIgnoreCase(password);
			if (matchPassword) {
				response.setContentType("text/plain");
			    response.setCharacterEncoding("UTF-8");
				response.getWriter().write("authenticated");	
			}
			else {
				response.setContentType("text/plain");
			    response.setCharacterEncoding("UTF-8");
				response.getWriter().write("badPassword");
			}
		}
		else {
			response.setContentType("text/plain");
		    response.setCharacterEncoding("UTF-8");
			response.getWriter().write("doesNotExist");
		}
	}
	

}
