<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*,java.util.*,com.highradius.internship.*"%>     
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
//page no passed in get parameter
String spageid=request.getParameter("page");
String level_name = (String)request.getParameter("level");%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="css/dashboard.css">
    <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" data-auto-replace-svg="nest"></script>
    <script type="text/javascript" src="js/index.js"></script>
<title>Level 1 Dashboard</title>
</head>
<body>
	<%//top logo div %>
	<div class="top">
        <div class="logo">
            <img class="image" src="images/hrc-logo.svg">
        </div>
        <div class="comp_name">
            <p style="color: rgb(133, 171, 241);">ABC</p>
            <p>PRODUCT</p>
        </div>
    </div>
    <br>
    <%//div for add,edit and search fields in Level 1 Dashboard %>
    <div class="container1" style="border:.6rem solid #e3e5e8; margin: .75rem .75rem .75rem .75rem; padding: 1.25rem;">
    <div class="change_buttons">
        	<input onclick="togglePopup()" class="add_button" type="submit" value="ADD" > &nbsp; &nbsp;
        	<button onclick="togglePopup_edit()" id="buttons1" class="edit_button" type="submit"  disabled="disabled" >EDIT</button>
        	<div class="search-wrapper">
	 			<img src="images/magnifying-glass.svg" class="search-icon"/>
     			<input type="text" id="myinput" class="search-input" placeholder="Search" onkeyup="search()" />
    		</div>
	</div>
	<%//Using table tag to display the dashboard of level 1 %>
	<table id="mytable" >
			<tr class="tr0"><%//table header %>  
				<th >&nbsp;</th>
				<th >Order_Date</th>
				<th >Order_Id</th>
				<th >Customer_Name</th>
				<th >Customer_ID</th>
				<th >Order_Amount</th>
				<th >Approval_Status</th>
				<th >Approved_By</th>
				<th >Notes</th>
    		</tr>
    		
    	<%//count the records
    	Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","1431");
    	Statement st= con.createStatement();
    	ResultSet rs=st.executeQuery("select count(*) from order_details");
    	String s="";
    	if(rs.next()) 
    	{
    		  s = rs.getString(1);
    	}
    	
		
		
    	  
    	int pageid=Integer.parseInt(spageid);  
    	int store_pageid=pageid;
    	int total=10;
    	int row_count=0;
    	
			row_count=Integer.parseInt(rs.getString(1));
			
			String row1=Integer.toString(row_count);
			
    		
    	if(pageid==1){}  
    	else{  
    	    pageid=pageid-1;  
    		pageid=pageid*total+1;  
    	} 
		List<pojo> list=AddData.getRecords(pageid,total,level_name);
    		int index=0;
		for(pojo e:list){%>
			
    		<tr class="rows" >
    			<td><input class="chb" type="checkbox" onClick="enableButton(<%= index%>)"></td>
    			<td style="text-align: center;"><%= e.getOrder_Date() %></td>
    			<td style="text-align: center;"><%= e.getOrder_ID() %></td>
    			<td style="text-align: center;"><%= e.getCustomer_Name() %></td>
    			<td style="text-align: center;"><%= e.getCustomer_ID() %></td>
    			<td style="text-align: center;"><%= e.getOrder_Amount() %></td>
    			<td style="text-align: center;"><%= e.getApproval_Status() %></td>
    			<td style="text-align: center;"><%= e.getApproved_By() %></td>
    			<td style="text-align: center;"><%= e.getNotes() %></td>
    		</tr>
    		<% index++; %>
   
    	<%}
		//int newpage=lim;
		int lim;
		if(row_count%total==0)
		{
			lim=row_count/total;
		}
		else
		{
			lim=row_count/total;
			lim++;
		}
		int next=store_pageid;
		int prev=store_pageid;
		//condition for first page and prev button
		if(store_pageid==1)
		{
			prev=1;
		}
		else
		{
			prev=prev-1;
		}
		//condition for last page and next button
		if(store_pageid==lim)
		{
			next=lim;
		}
		else
		{
			next=next+1;
		}
		int s1=(total*store_pageid)-(total-1);
		int s2=(total*store_pageid);
		if(s2>row_count)
		{
			s2=row_count;
		}//pagination div%>
	
  	</table>  		
    <div class="bottom">
    	<button  onclick="window.location.href='level1_dashboard.jsp?page=1&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-double-left" ></i></button> &nbsp;
    	<button onclick="window.location.href='level1_dashboard.jsp?page=<%=prev %>&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-left" ></i></button> &nbsp;
    	<span style="font-size:16px;">page</span>&nbsp;
    	<span style="font-size:16px;background-color: #AED6F1;"><%=store_pageid%></span>&nbsp;
    	<span style="font-size:16px;">of <%=lim%></span>&nbsp;
		<button  onclick="window.location.href='level1_dashboard.jsp?page=<%=next %>&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-right" ></i></button> &nbsp;
    	<button  onclick="window.location.href='level1_dashboard.jsp?page=<%=lim%>&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-double-right" ></i></button> &nbsp; &nbsp;
		
		<p style="font-size:16px;">Customers <%=s1 %>-<%=s2 %> of <%=row_count %></p>
		
	</div>
</div>	
	<%//Add popup disabled%>
	<div class="popup1" id="popup-1">
 		<div class="overlay1"></div>
  		<div class="content1">
  			<form action="add.jsp?page=<%=store_pageid %>&level=<%=level_name%>" method="post">
    <div class="modal-header">
	    <div class="title"><span style="font-size:30px;border-bottom:4px solid orange;">ADD ORDER</span></div>
	    <div class="close-btn1" onclick="togglePopup()">&times;</div>
    </div>
    <div class="modal-body">
    <table class="pop_table">
	   <tr style="background-color:white;" >
		<td>Order Id </td>
		<td><input  id="order_id" name="order_id" type="text" required></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Order Date </td>
		<td><input  id="order_date" name="order_date" type="text" placeholder="YYYY-MM-DD" required></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Customer Name </td>
		<td><input id="c_name" name="c_name" type="text" required></td>
	   </tr >
	   <tr style="background-color:white;" >
		<td>Customer Number </td>
		<td><input id="c_number" name="c_number" type="text" required></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Order Amount </td>
		<td><input id="o_amount" name="o_amount" type="text" required></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Notes </td>
		<td><input  id="notes_add" name="notes_add" type="text" required></td>
	   </tr>
	  </table>
	  <br>
	  <input id="submit_b" type="submit" value="ADD"> 
    </div>
    </form>
  </div>
</div>

<%//Edit popup disabled%>
<div class="popup1" id="popup-2">
  <div class="overlay1"></div>
  <div class="content1">
   <form action="edit.jsp?page=<%=store_pageid %>&level=<%=level_name %>" method="post">
    <div class="modal-header">
	    <div class="title"><span style="font-size:30px;border-bottom:4px solid orange;">EDIT ORDER</span></div>
	    <div class="close-btn1" onclick="togglePopup_edit()">&times;</div>
    </div>
    <div class="modal-body">
    <table class="pop_table">
	   <tr style="background-color:white;" >
		<td>Order Id </td>
		<td><input style="background-color:none;" class="oid" id="order_id_edit" name="order_id_edit" type="text" readonly></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Order Amount </td>
		<td><input class="oid" id="o_amount_edit" name="o_amount_edit" type="text" onKeyup="approvedBy()" required></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Notes </td>
		<td><input class="oid" id="notes_edit" name="notes_edit" type="text" required></td>
	   </tr>
	   <tr style="background-color:white;" >
		<td>Approved By </td>
		<td><input class="oid" name="a_by" id="a_by" type="text" required></td>
	   </tr>
	  </table>
	  <br>
	  <input id="submit_b" name="submit_b" type="submit" value="SUBMIT"> 
    </div>
    </form>
  </div>
</div>
	
</body>
</html>