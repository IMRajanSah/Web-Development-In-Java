package com.highradius.internship;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.io.*;
/**
 * Servlet implementation class authenticateservlet
 */
@WebServlet("/authenticateservlet")
public class authenticateservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

		String username = request.getParameter("username");
        String password = request.getParameter("password");
        String level="";
        Connection dbCon=null;
		
		boolean st=false;
		try{
		Class.forName("com.mysql.jdbc.Driver");
		dbCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","1431"); 
		PreparedStatement ps = dbCon.prepareStatement("select * from user_details where username=? and password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs =ps.executeQuery();
            st = rs.next();
            

            level=rs.getString(4);
            }
            
	   catch(Exception e) {
            e.printStackTrace();
        }
        if(st)
        {
        	if(level.equals("Level 1"))
        	{
        		String str="level1_dashboard.jsp?page=1&level="+level;
         	   RequestDispatcher rs = request.getRequestDispatcher(str);
 	           rs.include(request, response);
        	}
        	else
        	{
        		String str="highlevel_dashboard.jsp?page=1&level="+level;
         	   RequestDispatcher rs = request.getRequestDispatcher(str);
 	           rs.include(request, response);
        	}
        	
        	
        }
        else
        {
        	
        	
        	out.println("<script type=\"text/javascript\">");  
        	out.println("alert('Invalid Login...Try Again');");  
        	out.println("window.history.back();");
        	out.println("</script>");
        	
        }
    }  


}
