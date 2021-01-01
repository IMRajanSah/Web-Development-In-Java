package com.highradius.internship;

import java.sql.*;
import java.util.*;

public class AddData {

	
	public static List<pojo> getRecords(int start,int total,String level){
		List<pojo> list =new ArrayList<pojo>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
        	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","1431");  
            Statement ps=con.createStatement();  
            ResultSet rs=null;
            //System.out.println(level);
            if(level.equals("Level 1"))
            	rs=ps.executeQuery("select * from order_details limit "+(start-1)+","+total);
            else if(level.equals("Level 2"))
            	rs=ps.executeQuery("select * from order_details where Order_Amount between 10000 AND 50001 limit "+(start-1)+","+total);
            else if(level.equals("Level 3"))
            	rs=ps.executeQuery("select * from order_details where Order_Amount > 50000 limit "+(start-1)+","+total);
          
			while(rs.next()) {
				pojo p =new pojo();
				p.setOrder_ID(rs.getString(1));
				p.setCustomer_Name(rs.getString(2));
				p.setCustomer_ID(rs.getString(3));
				p.setOrder_Amount(rs.getString(4));
				p.setApproval_Status(rs.getString(5));
				p.setApproved_By(rs.getString(6));
				p.setNotes(rs.getString(7));
				p.setOrder_Date(rs.getString(8));
				
				list.add(p);
			}
			con.close();
		}catch(Exception e) {System.out.println(e);}
		return list;
	}
}
