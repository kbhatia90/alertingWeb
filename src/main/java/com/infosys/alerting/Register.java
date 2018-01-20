package com.infosys.alerting;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Register")
public class Register extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("psw");
		String nickname = request.getParameter("nickname");
		
		HbaseOperations hbaseOps = new HbaseOperations();
		boolean userExists = hbaseOps.checkRowKey(email);
		
		if(userExists) {
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			response.getWriter().write("exists");
		}
		else {
			
			User user = new User();
			user.setEmailId(email);
			user.setName(nickname);
			user.setBalance(1000);
			user.setEmailPreference("false");
			user.setPushPreference("false");
			user.setSmsPreference("false");
			user.setPassword(password);
			
			hbaseOps.insertData(user);
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			response.getWriter().write("registered");
		}
	}

}
